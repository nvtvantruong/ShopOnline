using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_ProductList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.HideAll();
            LoadCategoryData();
            LoadData();
        }
    }

    public void LoadData()
    {
        // Kết nối DB
        DBEntities db = new DBEntities();


        var query = db.Product.OrderByDescending(x => x.CreateTime).Select(x => new
        {
            ID = x.ProductID,
            x.Avatar,
            x.Title,
            x.Description,
            x.ViewTime,
            x.CreateTime,
            x.CreateBy,
            x.Status,
            x.ProductCategoryID,
            CatTitle = x.ProductCategory.Title
        });

        //Lấy các tiêu trí search
        ////Lấy catid
        int catID = Request.QueryString["catid"].ToInt();

        //Nếu có lọc theo catid
        if (catID != 0)
        {
            DropDownList_Category.SelectedValue = catID.ToString();
            query = query.Where(x => x.ProductCategoryID == catID);
        }

        ////Lấy title
        string title = Request.QueryString["title"].ToSafetyString();

        //Nếu có lọc theo title
        if (title != string.Empty)
        {

            input_Title.Value = title;
            query = query.Where(x => x.Title.Contains(title));
        }


        //Phân trang dữ liệu
        int totalItems = query.Count();
        int maxPage = 10;
        int pageSize = 10;
        int currentPage = Request.QueryString["page"].ToInt();
        if (currentPage == 0)
            currentPage = 1;
        string url = "/Admin/ProductList.aspx?page={0}&catid={1}&title={2}";
        url = url.StringFormat("{0}", catID, title);

        //Đổ vào ucPaging
        ucPagging.CurrentPage = currentPage;
        ucPagging.PageSize = pageSize;
        ucPagging.MaxPage = maxPage;
        ucPagging.URL = url;
        ucPagging.TotalItems = totalItems;
        ucPagging.DataBind();

        //lấy dữ liệu
        var data = query.Pagging(currentPage, pageSize).ToList();

        //Đổ vào bộ lặp
        Repeater_Main.DataSource = data;

        //Hiển thị Lên
        Repeater_Main.DataBind();

        //Hiện thị thông báo từ lần trước
        ShowPreviousMessage();
    }

    protected void LinkButton_Search_Click(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void DropDownList_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void LinkButton_ClearSearch_Click(object sender, EventArgs e)
    {
        //Xóa sạch các tiêu chí search
        DropDownList_Category.SelectedIndex = 0;
        input_Title.Value = string.Empty;

        //Search lại
        SearchData();
    }

    protected void LinkButton_SaveAvatar_Click(object sender, EventArgs e)
    {
        //Ép kiểu sender về dạng LinkButton
        LinkButton LinkButton_SaveAvatar = sender as LinkButton;

        //Lấy id của tài khoản cần đổi hình
        int ID = LinkButton_SaveAvatar.CommandArgument.ToInt();

        //Tìm 1 sản phẩm có id như trên
        DBEntities db = new DBEntities();
        var item = db.Product.Where(x => x.ProductID == ID).FirstOrDefault();

        //Nếu không tìm thấy, thì load lạis dữ liệu
        if (item == null)
        {
            SearchData("error", "Hình ảnh cần đổi không còn tồn tại");
            return;
        }

        //Upload sản phẩm lên Server
        FileUpload fileUpload_Avatar = LinkButton_SaveAvatar.NamingContainer.FindControl("FileUpload_Avatar") as FileUpload;

        //Kiểm tra đuôi hình hợp lệ
        string validExtension = ".jpg.jpeg.png.gif.bmp.ico";
        string fileExtension = Path.GetExtension(fileUpload_Avatar.FileName.ToLower());
        if (!validExtension.Contains(fileExtension))
        {
            ucMessage.ShowError("Hình không hợp lệ, loại hình hổ trợ: .jpg, .jpeg, .png, .gif, .bmp, .ico");
            return;
        }


        //Kiểm tra dung lượng file <= 3MB
        int validSize = 1024 * 1024 * 3;
        int fileSize = fileUpload_Avatar.FileBytes.Length;
        if (fileSize > validSize)
        {
            ucMessage.ShowError("Dung lượng hình <= 3MB");
            return;
        }

        Exception error = null;
        string avatar = string.Empty;
        string thumb = string.Empty;
        UploadUtility UploadUtility = new UploadUtility();
        UploadUtility.FileUpload = fileUpload_Avatar;
        UploadUtility.FolderSave = "~/FileUploads/Product";
        UploadUtility.FullMaxWidth = 1000;
        UploadUtility.ThumbMaxWidth = 400;
        UploadUtility.MaxFileSize = 1024 * 1024 * 3;
        UploadUtility.AutoGenerateFileName = true;
        UploadUtility.UploadImage(ref avatar, ref thumb, ref error);

        //Kiểm tra , nếu có khi upload thì kết thúc
        if (error != null || avatar == string.Empty)
        {
            SearchData("error", "Chưa upload được hình");
            return;
        }

        //Cập nhật link mới vào tài khoản kể trên
        item.Avatar = avatar;
        item.Thumb = thumb;

        //Lưu lại
        db.SaveChanges();

        //Load lại dữ liệu để thấy hình được thay mới.
        SearchData("success", "Đã đổi hình thành công", true);
        return;
    }

    protected void LinkButton_Delete_Click(object sender, EventArgs e)
    {
        //Ép kiểu seder thành linkButton
        LinkButton LinkButton_Delete = sender as LinkButton;

        //Bóc tách lấy ID của nó
        int ID = LinkButton_Delete.CommandArgument.ToInt();

        //Kết nối DB
        DBEntities db = new DBEntities();

        //Tìm 1 item phù hợp
        var item = db.Product.Where(x => x.ProductID == ID).FirstOrDefault();

        //kiểm tra item không tồn tại thì báo lỗi
        if (item == null)
        {
            SearchData("error", "Dữ liệu này đã không còn tồn tại");
            return;
        }

        //xóa khỏi db
        db.Product.Remove(item);

        //Lưu DB
        db.SaveChanges();

        //Load lại trang
        SearchData("success", "Đã xóa dữ liệu", true);
        return;


    }

    protected void LinkButton_Active_Click(object sender, EventArgs e)
    {
        //Ép kiểu sender thành linkbutton
        LinkButton linkButton_Active = sender as LinkButton;

        //Bóc tách ID từ LinhButton  ra
        int ID = linkButton_Active.CommandArgument.ToInt();

        //Kết nối db
        DBEntities db = new DBEntities();

        //Vào bảng account, tìm 1 ID phù hợp
        var item = db.Product.Where(x => x.ProductID == ID).FirstOrDefault();

        //Nếu như k có item phù hợp, thì kết thúc
        if (item == null)
        {
            SearchData("error", "Hình ảnh không còn tồn tại");
            return;
        }

        //Cập nhật giá trị status mới

        //////if (item.Status == true)
        //////    item.Status = false;
        //////else
        //////    item.Status = true;

        ////item.Status = (item.Status == true ? false : true);

        item.Status = !item.Status;
        //Lưu DB, nếu Lưu không thì báo lỗi rồi kết thúc
        try
        {
            db.SaveChanges();
        }
        catch (Exception ex)
        {
            ucMessage.ShowError("Chưa lưu được, vui lòng thử lại");
            return;
        }

        //Load lại dữ liệu với các tiêu chí search
        SearchData("success", "Đã cập nhật trạng thái", true);
        return;

    }

    public void LoadCategoryData()
    {
        //Kết nối db
        DBEntities db = new DBEntities();

        //Query dữ liệu
        var query = db.ProductCategory.OrderBy(x => new
        {
            MainPosition = x.ProductMainCategory.Position,
            Position = x.Position
        })
                                      .Select(x => new
                                      {
                                          ID = x.ProductCategoryID,
                                          Title = x.ProductMainCategory.Title + " - " + x.Title
                                      });

        //Lấy danh sách dữ liệu theo câu query
        var data = query.ToList();

        //Cấu hình hiển thị
        DropDownList_Category.DataValueField = "ID";
        DropDownList_Category.DataTextField = "Title";

        //Đỗ dữ liệu
        DropDownList_Category.DataSource = data;

        //Hiện thị
        DropDownList_Category.DataBind();

        //Tạo thêm item mặc định
        ListItem item = new ListItem();
        item.Value = string.Empty;
        item.Text = ".:Chọn loại sản phẩm :.";

        //Chèn item mặc định vào đầu danh sách Dropdown
        DropDownList_Category.Items.Insert(0, item);

        //Xử lý phần dữ liệu man-sub
        //Lưu trữ giá trị ban đầu của từ group
        string firstItemTextInGrop = string.Empty;

        //Chạy từ lần thứ 1 trở đi, bỏ qua lần 0
        for (int i = 1; i < DropDownList_Category.Items.Count; i++)
        {
            //Lấy phần tử hiện tại
            var currentItem = DropDownList_Category.Items[i];

            //Lấy phần tử trước nó 1 bước
            var beforeItem = DropDownList_Category.Items[i - 1];

            //Lấy text của phần tử hiện tại
            string currentText = currentItem.Text;

            //Lấy text của phần tử trước đó
            string beforeText = beforeItem.Text;

            //Phân chia text của phần tử hiện tại thành 2 phần,Lưu phần đầu vào firstItemTextInGroup
            if (firstItemTextInGrop != currentText.Split('-')[0])
            {
                firstItemTextInGrop = currentText.Split('-')[0];
                continue;
            }

            //Tạo 1 danh sách dấu - có chiều dài đúng bằng chiều dài của firstItemTextInGrop
            string emptyCharList = "-";
            for (int j = 0; j < firstItemTextInGrop.Length; j++)
            {
                emptyCharList += "-";
            }

            //Cập nhật giá trị text mới cho currentItem
            currentItem.Text = currentItem.Text.Replace(firstItemTextInGrop, emptyCharList);
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

    public void SearchData(string type = "", string message = "", bool isKeepPage = false)
    {
        //Lấy các giá trị tìm kiếm
        string catID = DropDownList_Category.SelectedValue;
        string title = input_Title.Value.Trim();

        int page = 1;
        if (isKeepPage == true)
        {
            page = Request.QueryString["page"].ToInt();
            if (page <= 0)
                page = 1;
        }

        //Tạo url trang hiện tại kèm theo điều kiện search
        string url = "~/Admin/ProductList.aspx?catid={0}&title={1}&messagetype={2}&message={3}&page={4}";
        url = url.StringFormat(catID, title, type, message, page);

        //Chuyển về trang đích'
        Response.Redirect(url);
    }


}