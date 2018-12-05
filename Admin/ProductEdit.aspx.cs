using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;
using System.IO;

public partial class Admin_ProductEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.ShowInfo("Xin mời nhập thông tin sau đó nhấn lưu!");
            LoadCategory();
            int ID = Request.QueryString["id"].ToInt();
            if (ID > 0)
            {
                LoadData();
            }
        }
    }

    public void LoadData()
    {
        //LấyID từ url
        int ID = Request.QueryString["id"].ToInt();

        //Vào DB tìm 1 item phù hợp
        DBEntities db = new DBEntities();
        var item = db.Product.Where(x => x.ProductID == ID).FirstOrDefault();

        //Nếu ko có thì báo lỗi, kết thúc
        if (item == null)
        {
            ucMessage.ShowError("Dữ liệu này không tồn tại");
            return;
        }

        //Hiển thị từ giá trị lên các control
        DropDownList_Category.SelectedValue = item.ProductCategoryID.ToSafetyString();
        input_ID.Value = item.ProductID.ToSafetyString();

        input_Code.Value = item.Code;
        input_Title.Value = item.Title;
        textarea_Description.Value = item.Description;
        input_Possition.Value = item.Position.ToSafetyString();

        input_ViewTime.Value = item.ViewTime.ToSafetyString();
        input_CreateTime.Value = item.CreateTime.ToSafetyString("dd/MM/yyyy");
        input_CreateBy.Value = item.CreateBy;

        textarea_Specifitions.Value = item.Specifications;
        input_Quantity.Value = item.Quantity.ToSafetyString();
        input_Price.Value = item.Price.ToSafetyString();
        input_Oldprice.Value = item.OldPrice.ToSafetyString();
        input_Promotion.Value = item.Promotions;
        input_WarrantyPolicy.Value = item.WarrantyPolicy;
        input_Accessories.Value = item.Accessories;
        input_SourcePage.Value = item.SourcePage;
        input_SourceLink.Value = item.SourceLink;


        a_Avatar.HRef = item.Avatar;
        img_Avatar.Src = item.Avatar;

        //Load danh sách hình ImageList
        Repeater_ImageList.DataSource = GetImageListArray(item.ImageList);
        Repeater_ImageList.DataBind();

        input_SourcePage.Value = item.SourcePage;
        input_SourceLink.Value = item.SourceLink;

        textarea_Content.Value = item.Content.ToSafetyString().Replace("~/", "/");

        input_Keyword.Value = item.Keyword;

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

    public void LoadCategory()
    {
        DBEntities db = new DBEntities();
        var query = db.ProductCategory.Select(x => new
        {
            ID = x.ProductCategoryID,
            x.Title
        });
        DropDownList_Category.DataValueField = "ID";
        DropDownList_Category.DataTextField = "Title";
        DropDownList_Category.DataTextFormatString = "- {0} -";

        DropDownList_Category.DataSource = query.ToList();
        DropDownList_Category.DataBind();
    }

    protected void LinkButton_Save_Click(object sender, EventArgs e)
    {
        ucMessage.HideAll();

        //Lấy ID từ Url xuống
        int ID = Request.QueryString["id"].ToInt();

        //Lấy giá trị các ô nhập
        int catID = DropDownList_Category.SelectedValue.ToInt();
        int position = input_Possition.Value.ToInt();
        string code = input_Code.Value.Trim();
        string title = input_Title.Value.Trim();
        string description = textarea_Description.Value.Trim();
        string sourcePage = input_SourcePage.Value.Trim();
        string sourceLink = input_SourceLink.Value.Trim();
        bool status = radio_Active.Checked;
        string content = textarea_Content.Value;
        string keyword = input_Keyword.Value.Trim();

        string specifications = textarea_Specifitions.Value.Trim();
        int quantity = input_Quantity.Value.ToInt();
        double price = input_Price.Value.ToDouble();
        double oldPrice = input_Oldprice.Value.ToDouble();
        string promotion = input_Promotion.Value.Trim();
        string warrantyPolicy = input_WarrantyPolicy.Value.Trim();
        string accessories = input_Accessories.Value.Trim();

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
            UploadUtility.FolderSave = "~/FileUploads/Product";
            UploadUtility.FullMaxWidth = 1000;
            UploadUtility.ThumbMaxWidth = 400;
            UploadUtility.MaxFileSize = 1024 * 1024 * 3;
            UploadUtility.AutoGenerateFileName = true;
            UploadUtility.UploadImage(ref avatar, ref thumb, ref error);
        }

        //Kiểm tra title hợp lệ
        if (title == string.Empty)
        {
            ucMessage.ShowError("Vui lòng nhập tiêu đề");
            return;
        }

        //nếu như có ID, thì Update (Save)
        if (ID > 0)
        {
            //tìm 1 item thích hợp
            DBEntities db = new DBEntities();
            var item = db.Product.Where(x => x.ProductID == ID).FirstOrDefault();

            //Nếu k có, thì báo lỗi, kết thúc
            if (item == null)
            {
                ucMessage.ShowError("Dữ liệu không còn tồn tại");
                return;
            }
            //Cập nhật giá trị mới
            item.ProductCategoryID = catID;
            item.Code = code;
            item.Title = title;
            item.Description = description;
            item.SourcePage = sourcePage;
            item.SourceLink = sourceLink;
            item.Status = status;
            item.Content = content;
            item.Keyword = keyword;
            item.CreateBy = SessionUtility.AdminUsername;
            item.CreateTime = DateTime.Now;
            //Khi cập nhật, không thay đổi viewTime

            item.Specifications = specifications;
            item.Promotions = promotion;
            item.WarrantyPolicy = warrantyPolicy;
            item.Accessories = accessories;

            item.ImageList = hidden_ImageLists.Value;

            if (quantity > 0)
                item.Quantity = quantity;
            else if (input_Quantity.Value == string.Empty)
                item.Quantity = null;

            if (price > 0)
                item.Price = price;
            else if (input_Price.Value == string.Empty)
                item.Price = null;

            if (oldPrice > 0)
                item.OldPrice = oldPrice;
            else if (input_Oldprice.Value == string.Empty)
                item.OldPrice = null;

            //Nếu có nhập vị trí, thì lưu vị trí
            if (position > 0)
                item.Position = position;
            else if (input_Possition.Value == string.Empty)
                item.Position = null;

            //Nếu có up hình, thì mới cập nhật hình mới
            if (avatar != string.Empty)
            {
                item.Avatar = avatar;
                item.Thumb = thumb;
            }
            //Lưu lại
            db.SaveChanges();

            //Tạo url trang hiện tại kèm theo điều kiện search
            string url = "~/Admin/ProductList.aspx?messagetype={0}&message={1}";
            url = url.StringFormat("success", "Đã cập nhật dữ liệu");

            //Chuyển về trang đích'
            Response.Redirect(url);
        }

        //Ngược lại thì Insert (add)
        else
        {
            //Tạo 1 item mới có kiểu là bảng cần thêm
            Product item = new Product();

            //Lần lượt gán từng giá trị vào mõi ô của item
            item.ProductCategoryID = catID;
            item.Code = code;
            item.Title = title;
            item.Description = description;
            item.SourcePage = sourcePage;
            item.SourceLink = sourceLink;
            item.Status = status;
            item.Content = content;
            item.Keyword = keyword;
            item.CreateBy = SessionUtility.AdminUsername;
            item.CreateTime = DateTime.Now;
            item.ViewTime = RandomUtility.RandomInt(50, 100);

            item.Specifications = specifications;
            item.Promotions = promotion;
            item.WarrantyPolicy = warrantyPolicy;
            item.Accessories = accessories;

            item.ImageList = hidden_ImageLists.Value;

            if (quantity > 0)
                item.Quantity = quantity;
            else if (input_Quantity.Value == string.Empty)
                item.Quantity = null;

            if (price > 0)
                item.Price = price;
            else if (input_Price.Value == string.Empty)
                item.Price = null;

            if (oldPrice > 0)
                item.OldPrice = oldPrice;
            else if (input_Oldprice.Value == string.Empty)
                item.OldPrice = null;

            //Nếu có nhập vị trí, thì lưu vị trí
            if (position > 0)
                item.Position = position;
            else if (input_Possition.Value == string.Empty)
                item.Position = null;

            //Nếu có up hình, thì mới cập nhật hình mới
            if (avatar != string.Empty)
            {
                item.Avatar = avatar;
                item.Thumb = thumb;
            }

            //Thêm vào bảng
            DBEntities db = new DBEntities();
            db.Product.Add(item);

            //Lưu DB
            db.SaveChanges();

            // Tạo url trang hiện tại kèm theo điều kiện search
            string url = "~/Admin/ProductList.aspx?messagetype={0}&message={1}";
            url = url.StringFormat("success", "Đã thêm mới dữ liệu");

            //Chuyển về trang đích'
            Response.Redirect(url);
        }
    }


    protected string[] GetImageListArray(object ImageList)
    {
        return ImageList.ToSafetyString().Split(';', StringSplitOptions.RemoveEmptyEntries);
    }
}
