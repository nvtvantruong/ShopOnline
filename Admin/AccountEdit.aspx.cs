using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_AccountEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.ShowInfo("Xin mời nhập thông tin sau đó nhấn lưu!");
            LoadCategory();
            string ID = Request.QueryString["id"].ToSafetyString();
            if (ID != string.Empty)
            {
                LoadData();

                //Khóa ô khóa chính lại
                input_Username.Attributes.Add("readonly", "readonly");

                //Thêm thuộc tính giải thích
                input_Username.Attributes.Add("Title", "thuộc tính khóa, không được sửa");

                //Khóa radio trạng thái khi ID là của tài khoản hiện tại
                if (ID == SessionUtility.AdminUsername)
                {
                    radio_Active.Attributes.Add("disabled", "disabled");
                    radio_Lock.Attributes.Add("disabled", "disabled");

                    radio_Active.Attributes.Add("Title", "Không khả dụng");
                    radio_Lock.Attributes.Add("Title", "Không khả dụng");
                }
            }
        }
    }

    public void LoadData()
    {
        //LấyID từ url
        string ID = Request.QueryString["id"].ToSafetyString();

        //Vào DB tìm 1 item phù hợp
        DBEntities db = new DBEntities();
        var item = db.Account.Where(x => x.Username == ID).FirstOrDefault();

        //Nếu ko có thì báo lỗi, kết thúc
        if (item == null)
        {
            ucMessage.ShowError("Dữ liệu này không tồn tại");
            return;
        }

        //Hiển thị từ giá trị len các control
        DropDownList_Category.SelectedValue = item.AccountCategoryID.ToSafetyString();
        input_Username.Value = item.Username;

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

        input_Fullname.Value = item.FullName;
        input_Email.Value = item.Email;
        input_Mobi.Value = item.Mobi;
        textarea_Address.Value = item.Address;
        a_Avatar.HRef = item.Avatar;
        img_Avatar.Src = item.Avatar;

        if (item.Gender == true)
        {
            radio_Female.Checked = false;
            radio_Male.Checked = true;
        }
        else
        {
            radio_Male.Checked = false;
            radio_Female.Checked = true;
        }
        input_CreateTime.Value = item.CreateTime.ToSafetyString("dd/MM/yyyy");
    }

    public void LoadCategory()
    {
        DBEntities db = new DBEntities();
        var query = db.AccountCategory.Select(x => new
        {
            ID = x.AccountCategoryID,
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
        string ID = Request.QueryString["id"].ToSafetyString();

        //Lấy giá trị các ô nhập
        string catID = DropDownList_Category.SelectedValue;
        string password = input_Password.Value;
        string repassword = input_Repassword.Value;
        bool status = radio_Active.Checked;
        string fullName = input_Fullname.Value.Trim();
        string email = input_Email.Value.Trim();

        string mobi = input_Mobi.Value.Trim();
        string address = textarea_Address.Value.Trim();


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
            UploadUtility.FolderSave = "~/FileUploads/Account";
            UploadUtility.FullMaxWidth = 1000;
            UploadUtility.ThumbMaxWidth = 400;
            UploadUtility.MaxFileSize = 1024 * 1024 * 3;
            UploadUtility.AutoGenerateFileName = true;
            UploadUtility.UploadImage(ref avatar, ref thumb, ref error);
        }

        bool gender = radio_Male.Checked == true ? true : false;

        ///////Kiểm tra tính hợp lệ\\\\\\\\\
        //Kiểm tra mật khẩu hợp lệ
        if (password != repassword)
        {
            ucMessage.ShowError("Vui lòng nhập mật khẩu 2 lần giống nhau");
            return;
        }

        if (fullName == string.Empty)
        {
            ucMessage.ShowError("Vui lòng nhập họ tên");
            return;
        }
        if (email == string.Empty || !email.IsEmailFormat())
        {
            ucMessage.ShowError("Vui lòng nhập email đúng định dạng");
            return;
        }

        //nếu như có ID, thì Update (Save)
        if (ID != string.Empty)
        {
            //tìm 1 item thích hợp
            DBEntities db = new DBEntities();
            var item = db.Account.Where(x => x.Username == ID).FirstOrDefault();

            //Nếu k có, thì báo lỗi, kết thúc
            if (item == null)
                ucMessage.ShowError("Dữ liệu không còn tồn tại");
            //Cập nhật giá trị mới
            item.Username = ID;
            item.FullName = fullName;
            item.Email = email;
            item.Status = status;
            item.Status = status;
            item.Mobi = mobi;
            item.Address = address;
            item.Gender = gender;
            item.CreateTime = DateTime.Now;
            item.AccountCategoryID = catID;

            //Nếu có nhập mk, thì mới cập nhật mật khẩu
            if (password != string.Empty)
                item.Password = password.MD5Hash(Commons.AdminSalt);

            //Nếu có up hình, thì mới cập nhật hình mới
            if (avatar != string.Empty)
            {
                item.Avatar = avatar;
                item.Thumb = thumb;
            }
            //Lưu lại
            db.SaveChanges();

            //Tạo url trang hiện tại kèm theo điều kiện search
            string url = "~/Admin/AccountList.aspx?messagetype={0}&message={1}";
            url = url.StringFormat("success", "Đã cập nhật dữ liệu");

            //Chuyển về trang đích'
            Response.Redirect(url);
        }

        //Ngược lại thì Insert (add)
        else
        {
            if (password == string.Empty)
            {
                ucMessage.ShowError("Vui lòng nhập mật khẩu");
                return;
            }

            ID = input_Username.Value.Trim();

            //Kiểm tra ID trùng lắp
            DBEntities db = new DBEntities();
            var validateItem = db.Account.Where(x => x.Username == ID).FirstOrDefault();
            if (validateItem != null)
            {
                ucMessage.ShowError("Username bạn nhập đã tồn tại. Vui lòng thử lại với Username khác!");
                return;
            }

            //Tạo 1 item mới có kiểu là bảng cần thêm
            Account item = new Account();

            //Lần lượt gán từng giá trị vào mõi ô của item
            item.Username = ID;
            item.Password = password.MD5Hash(Commons.AdminSalt);
            item.FullName = fullName;
            item.Email = email;
            item.Status = status;
            item.Status = status;
            item.Mobi = mobi;
            item.Address = address;
            item.Avatar = avatar;
            item.Thumb = thumb;
            item.Gender = gender;
            item.CreateTime = DateTime.Now;
            item.AccountCategoryID = catID;

            //Thêm vào bảng
            db.Account.Add(item);

            //Lưu DB
            db.SaveChanges();

            // Tạo url trang hiện tại kèm theo điều kiện search
            string url = "~/Admin/AccountList.aspx?messagetype={0}&message={1}";
            url = url.StringFormat("success", "Đã thêm mới dữ liệus");

            //Chuyển về trang đích'
            Response.Redirect(url);
        }
    }
}