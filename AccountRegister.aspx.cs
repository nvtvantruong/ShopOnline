using CodeUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AccountRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategory();
            input_GenderMale.Checked = true;
            ucMessage.HideAll();
        }
    }

    protected void Button_OK_Click(object sender, EventArgs e)
    {
        //Lấy các giá trị nhập
        string email = input_Email.Value.Trim();
        string password = input_Password.Value.Trim();
        string rePassword = input_Repassword.Value.Trim();
        string fullName = input_Fullname.Value.Trim();
        string mobil = input_Mobil.Value.Trim();
        string address = textarea_Address.Value.Trim();

        bool gerder = input_GenderMale.Checked ? true : false;
        bool rule = input_Rule.Checked ? true : false;

        int category = DropDownList_Category.SelectedValue.ToInt();

        //Kiểm tra tính hợp lệ
        bool isValid = ValidateData(email, password, rePassword, fullName, mobil, address, rule);
        if (!isValid)
            return;

        //Kiểm tra email có hay chưa
        DBEntities db = new DBEntities();

        if (db.Client.Where(q => q.Email == email).FirstOrDefault() != null)
        {
            ucMessage.ShowError("Email đã được đăng ký. vui lòng kiểm tra lại");
            return;
        }

        //Tạo tài khoản
        Client item = new Client();
        item.Email = email;

        string passwordEncript = "haha";
        item.Password = password.SHA256Hash(passwordEncript);

        item.FullName = fullName;
        item.Mobi = mobil;
        item.Address = address;

        item.Gender = gerder;
        item.Status = false;

        item.CreateTime = DateTime.Now;
        item.ClientCategoryID = category;


        //Gửi email thông báo và yêu cầu kích hoạt
        MailUtility mail = new MailUtility();
        mail.Host = "smtp.gmail.com";
        mail.Port = 587;
        mail.EnableSSL = true;
        mail.IsBodyHtml = true;

        mail.From = "laptrinhvien2015@gmail.com";
        mail.Password = "2015@VienLapTrinh";
        mail.To = email;
        mail.Subject = "Kích hoạt tài khoản";

        string template = Server.MapPath("~/MailTemplate/active.html");

        mail.Body = FileUtility.ReadFile(template);

        string domain = Request.Url.GetLeftPart(UriPartial.Authority);

        string emailEncript = string.Empty;
        emailEncript = email.AES256Encrypt(passwordEncript);

        string url = "{0}/Active.aspx?id={1}".StringFormat(domain, emailEncript);
        mail.Body = mail.Body.Replace("{name}", fullName);
        mail.Body = mail.Body.Replace("{url}", url);

        //Exception error = null;
        //mail.SendMail(ref error);
        //if (error != null)
        //{
        //    ucMessage.ShowError("Vui lòng thử lại");
        //    return;
        //}

        db.Client.Add(item);
        db.SaveChanges();

        //Xóa trắnng From
        ClearFrom();

        //Báo thành công
        string message = "xin chúc mừng {0} đã đăng ký tài khoản thành công. vui lòng kiểm tra mail để kích hoạt. Sau đó <a href='{1}'>đăng nhập</a>";
        message = message.StringFormat(item.FullName, "/AccountLogin.aspx");
        ucMessage.ShowSuccess(message);

    }

    private bool ValidateData(string email, string password, string rePassword, string fullName, string mobil, string address, bool rule)
    {
        if (email.IsEmpty() || !email.IsEmailFormat())
        {
            ucMessage.ShowError("Vui Lòng nhập email đúng định dạng");
            return false;
        }
        if (password.IsEmpty())
        {
            ucMessage.ShowError("Vui Lòng nhập password");
            return false;
        }

        if (rePassword != password)
        {
            ucMessage.ShowError("vui lòng nhập mật khẩu giống nhau");
            return false;
        }

        if (fullName.IsEmpty())
        {
            ucMessage.ShowError("Vui Lòng nhập họ tên");
            return false;
        }

        if (mobil.IsEmpty())
        {
            ucMessage.ShowError("Vui Lòng nhập điện thoại");
            return false;
        }

        if (address.IsEmpty())
        {
            ucMessage.ShowError("Vui Lòng nhập địa chỉ");
            return false;
        }



        if (!rule)
        {
            ucMessage.ShowError("vui lòng đánh dấu đồng ý với nội quy");
            return false;
        }

        return true;
    }


    public void LoadCategory()
    {
        DBEntities db = new DBEntities();
        var query = from c in db.ClientCategory
                    where c.Status == true
                    orderby c.Position
                    select new
                    {
                        ID = c.ClientCategoryID,
                        c.Title
                    };
        DropDownList_Category.DataValueField = "ID";
        DropDownList_Category.DataTextField = "Title";

        DropDownList_Category.DataSource = query.ToList();
        DropDownList_Category.DataBind();

    }

    private void ClearFrom()
    {
        input_Email.Value        = string.Empty;
        input_Password.Value     = string.Empty;
        input_Repassword.Value   = string.Empty;

        input_Fullname.Value     = string.Empty;
        input_Mobil.Value        = string.Empty;
        input_GenderMale.Checked = true;

        textarea_Address.Value   = string.Empty;
        input_Rule.Checked       = false;
    }
}