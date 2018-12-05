using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;
using System.IO;

public partial class Admin_ProductCategoryList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.HideAll();
            ShowPreviousMessage();
            LoadMainCategoryData();
            LoadCategoryData();
            LoadData();
        }
    }

    private void ShowPreviousMessage()
    {
        string messagetype = Request.QueryString["messagetype"].ToSafetyString();
        string message = Request.QueryString["message"].ToSafetyString();

        if (messagetype == "success")
        {
            ucMessage.ShowSuccess(message);
        }
        else if (messagetype == "warning")
        {
            ucMessage.ShowWarning(message);
        }
        else if (messagetype == "info")
        {
            ucMessage.ShowInfo(message);
        }
        else if (messagetype == "error")
        {
            ucMessage.ShowError(message);
        }
    }

    public void LoadMainCategoryData()
    {
        DBEntities db = new DBEntities();
        var query = db.ProductMainCategory.OrderBy(x => x.Position).Select(x => new { x.ProductMainCategoryID, x.Title });

        var data = query.ToList();

        DropDownList_MainCategory.DataValueField = "ProductMainCategoryID";
        DropDownList_MainCategory.DataTextField = "Title";

        DropDownList_MainCategoryLeft.DataValueField = "ProductMainCategoryID";
        DropDownList_MainCategoryLeft.DataTextField = "Title";

        DropDownList_MainCategory.DataSource = data;
        DropDownList_MainCategory.DataBind();

        DropDownList_MainCategoryLeft.DataSource = data;
        DropDownList_MainCategoryLeft.DataBind();

        //Tô sáng phần tử đã click trước đó
        int mID = Request.QueryString["mid"].ToInt();
        if (mID > 0)
        {
            DropDownList_MainCategoryLeft.SelectedValue = mID.ToSafetyString();
            DropDownList_MainCategory.SelectedValue = mID.ToSafetyString();
        }
    }

    public void LoadCategoryData()
    {
        int mID = DropDownList_MainCategoryLeft.SelectedValue.ToInt(); ;


        //Kết nối db
        DBEntities db = new DBEntities();

        //Query dữ liệu
        var query = db.ProductCategory.OrderBy(x => x.Position)
                                      .Where(x => x.ProductMainCategoryID == mID)
                                      .Select(x => new { x.ProductCategoryID, x.Title });

        //Lấy danh sách dữ liệu theo câu query
        var data = query.ToList();

        //Cấu hình hiển thị
        ListBox_Category.DataValueField = "ProductCategoryID";
        ListBox_Category.DataTextField = "Title";

        //Đỗ dữ liệu
        ListBox_Category.DataSource = data;

        //Hiện thị
        ListBox_Category.DataBind();

        //Tạo thêm item mặc định
        ListItem item = new ListItem();
        item.Value = string.Empty;
        item.Text = ".:Chọn loại sản phẩm :.";

        //Chèn item mặc định vào đầu danh sách Dropdown
        ListBox_Category.Items.Insert(0, item);

    }

    public void LoadData()
    {
        //LấyID từ url
        int ID = Request.QueryString["id"].ToInt();
        int mID = Request.QueryString["mid"].ToInt();

        //Chọn lại item đang xem trước đó
        if (ID > 0)
        {
            ListBox_Category.SelectedValue = ID.ToSafetyString();
        }

        //Vào DB tìm 1 item phù hợp
        DBEntities db = new DBEntities();
        var item = db.ProductCategory.Where(x => x.ProductCategoryID == ID).FirstOrDefault();


        //Nếu ko có thì báo lỗi, kết thúc
        if (item == null)
        {
            return;
        }

        //Hiển thị từ giá trị len các control
        DropDownList_MainCategory.SelectedValue = item.ProductMainCategoryID.ToSafetyString();
        input_ID.Value = item.ProductCategoryID.ToSafetyString();

        input_Code.Value = item.Code;
        input_Title.Value = item.Title;
        textarea_Description.Value = item.Description;
        input_Position.Value = item.Position.ToSafetyString();

        a_Avatar.HRef = item.Avatar;
        img_Avatar.Src = item.Avatar;

        if (item.Status == true)
        {
            radio_Lock.Checked = false;
            radio_Active.Checked = true;
        }
        else
        {
            radio_Active.Checked = false;
            radio_Lock.Checked = true;
        }

    }

    public void SearchData(string type = "", string message = "")
    {
        //Lấy các giá trị tìm kiếm
        int ID = ListBox_Category.SelectedValue.ToInt();
        int mID = DropDownList_MainCategoryLeft.SelectedValue.ToInt();

        //Tạo url trang hiện tại kèm theo điều kiện search
        string url = "~/Admin/ProductCategoryList.aspx?mid={0}&id={1}&messagetype={2}&message={3}";
        url = url.StringFormat(mID, ID, type, message);

        //Chuyển về trang đích'
        Response.Redirect(url);
    }

    protected void ListBox_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void LinkButton_Add_Click(object sender, EventArgs e)
    {
        ListBox_Category.SelectedIndex = 0;
        SearchData();
    }

    protected void LinkButton_Delete_Click(object sender, EventArgs e)
    {
        int ID = Request.QueryString["id"].ToInt();

        if (ID <= 0)
        {
            ucMessage.ShowError("Vui lòng chọn 1 dữ liệu để xóa");
            return;
        }

        //Kết nối DB
        DBEntities db = new DBEntities();

        //Tìm 1 item phù hợp
        var item = db.ProductCategory.Where(x => x.ProductCategoryID == ID).FirstOrDefault();

        //kiểm tra item không tồn tại thì báo lỗi
        if (item == null)
        {
            SearchData("error", "Dữ liệu này đã không còn tồn tại");
            return;
        }

        //xóa khỏi db
        db.ProductCategory.Remove(item);

        try
        {
            //Lưu DB
            db.SaveChanges();
        }
        catch (Exception ex)
        {
            ucMessage.ShowError("Không thể xóa dữ liệu." + "Vui lòng xóa dữ liệu có liên quan trước.");
            return;
        }

        //Load lại danh sách
        LoadCategoryData();

        //Load lại trang
        SearchData("success", "Đã xóa dữ liệu");
        return;


    }

    protected void DropDownList_MainCategoryLeft_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadCategoryData();
        SearchData();
    }

    protected void LinkButton_Save_Click(object sender, EventArgs e)
    {
        ucMessage.HideAll();

        //Lấy ID từ Url xuống
        int ID = Request.QueryString["id"].ToInt();

        //Lấy giá trị các ô nhập
        int mainCatID = DropDownList_MainCategory.SelectedValue.ToInt();
        int position = input_Position.Value.ToInt();
        string code = input_Code.Value.Trim();
        string title = input_Title.Value.Trim();
        string description = textarea_Description.Value.Trim();
        bool status = radio_Active.Checked;

        ////Upload hình
        string avatar = string.Empty;
        string thumb = string.Empty;
        if (FileUpload_Avatar.FileName != string.Empty)
        {
            //Kiểm tra đuôi hình hợp lệ
            string validExtension = ".jpg.jpeg.png.gif.bmp.ico";
            string fileExtension = Path.GetExtension(FileUpload_Avatar.FileName.ToLower());
            if (!validExtension.Contains(fileExtension))
            {
                ucMessage.ShowError("Hình không hợp lệ, loại hình hổ trợ: .jpg, .jpeg, .png, .gif, .bmp, .ico");
                return;
            }

            //Kiểm tra dung lượng file <= 3MB
            int validSize = 1024 * 1024 * 3;
            int fileSize = FileUpload_Avatar.FileBytes.Length;
            if (fileSize > validSize)
            {
                ucMessage.ShowError("Dung lượng hình <= 3MB");
                return;
            }

            Exception error = null;
            UploadUtility UploadUtility = new UploadUtility();
            UploadUtility.FileUpload = FileUpload_Avatar;
            UploadUtility.FolderSave = "~/FileUploads/ProductCategory";
            UploadUtility.FullMaxWidth = 1000;
            UploadUtility.ThumbMaxWidth = 400;
            UploadUtility.MaxFileSize = 1024 * 1024 * 3;
            UploadUtility.AutoGenerateFileName = true;
            UploadUtility.UploadImage(ref avatar, ref thumb, ref error);
        }

        //Kiểm tra title hợp lệ
        if (title == string.Empty)
        {
            ucMessage.ShowError("Vui lòng nhập tiêu đề hình");
            return;
        }

        //nếu như có ID, thì Update (Save)
        if (ID > 0)
        {
            //tìm 1 item thích hợp
            DBEntities db = new DBEntities();
            var item = db.ProductCategory.Where(x => x.ProductCategoryID == ID).FirstOrDefault();

            //Nếu k có, thì báo lỗi, kết thúc
            if (item == null)
            {
                ucMessage.ShowError("Dữ liệu không còn tồn tại");
                return;
            }
            //Cập nhật giá trị mới
            item.ProductMainCategoryID = mainCatID;
            item.Code = code;
            item.Title = title;
            item.Description = description;
            item.Status = status;
            item.CreateBy = SessionUtility.AdminUsername;
            item.CreateTime = DateTime.Now;

            //Nếu có nhập vị trí, thì lưu vị trí
            if (position > 0)
                item.Position = position;

            //Nếu có up hình, thì mới cập nhật hình mới
            if (avatar != string.Empty)
            {
                item.Avatar = avatar;
                item.Thumb = thumb;
            }
            //Lưu lại
            db.SaveChanges();

            //Tạo url trang hiện tại kèm theo điều kiện search
            string url = "~/Admin/ProductCategoryList.aspx?mid={0}&id={1}&messagetype={2}&message={3}";
            url = url.StringFormat(item.ProductMainCategoryID, item.ProductCategoryID, "success", "Đã cập nhật dữ liệu");

            //Chuyển về trang đích'
            Response.Redirect(url);
        }

        //Ngược lại thì Insert (add)
        else
        {
            //Tạo 1 item mới có kiểu là bảng cần thêm
            ProductCategory item = new ProductCategory();

            //Lần lượt gán từng giá trị vào mõi ô của item
            item.ProductMainCategoryID = mainCatID;
            item.Code = code;
            item.Title = title;
            item.Description = description;
            item.Status = status;
            item.CreateBy = SessionUtility.AdminUsername;
            item.CreateTime = DateTime.Now;

            //Nếu có nhập vị trí, thì lưu vị trí
            if (position > 0)
                item.Position = position;

            //Nếu có up hình, thì mới cập nhật hình mới
            if (avatar != string.Empty)
            {
                item.Avatar = avatar;
                item.Thumb = thumb;
            }

            //Thêm vào bảng
            DBEntities db = new DBEntities();
            db.ProductCategory.Add(item);

            //Lưu DB
            db.SaveChanges();

            // Tạo url trang hiện tại kèm theo điều kiện search
            string url = "~/Admin/ProductCategoryList.aspx?mid={0}&id={1}&messagetype={2}&message={3}";
            url = url.StringFormat(item.ProductMainCategoryID, item.ProductCategoryID, "success", "Đã thêm mới dữ liệu");

            //Chuyển về trang đích'
            Response.Redirect(url);
        }
    }
}