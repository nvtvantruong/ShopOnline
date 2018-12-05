using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;
using System.Threading;

public partial class ucContactForm : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategory();
            ucMessage.HideAll();
        }
    }

    protected void Button_Send_Click(object sender, EventArgs e)
    {

        Thread.Sleep(200);

        //Lấu các giá trị nhập
        string fullName = input_FullName.Value.Trim();
        string email = input_Email.Value.Trim();
        string mobi = input_Mobi.Value.Trim();
        string content = textarea_content.Value.Trim();
        int category = DropDownList_Category.SelectedValue.ToInt();

        //Kiểm tra tính hợp lệ
        if (fullName.IsEmpty())
        {
            ucMessage.ShowError("Vui lòng nhập tên");
            return;
        }
        if (email.IsEmpty() && mobi.IsEmpty())
        {
            return;
        }
        if (!email.IsEmpty() && !email.IsEmailFormat())
        {
            ucMessage.ShowError("Vui lòng nhập email đúng định dạng hoặc bỏ trống nếu chưa có email");
            return;
        }
        if (content.IsEmpty())
        {
            ucMessage.ShowError("Vui lòng nhập nội dung");
            return;
        }

        //Tạo 1 item mới có kiểu là contact chứa các thông tin cần lưu
        Contact item = new Contact();
        item.FullName = fullName;
        item.Email = email;
        item.Mobi = mobi;
        item.Content = content;
        item.ContactCategoryID = category;

        item.CreateTime = DateTime.Now;
        item.Status = false;

        //Lưu vào DB
        DBEntities db = new DBEntities();
        db.Contact.Add(item);
        db.SaveChanges();

        //Gửi mail thông báo cho admin biết
        MailUtility mail = new MailUtility();
        mail.Host = "smtp.gmail.com";
        mail.Port = 587;
        mail.EnableSSL = true;
        mail.IsBodyHtml = true;

        mail.From = "laptrinhvien2015@gmail.com";
        mail.Password = "2015@VienLapTrinh";
        mail.To = "nvtvantruong@gmail.com";
        mail.Subject = "Thư liên hệ";

        string url = Server.MapPath("~/MailTemplate/Default.html");

        mail.Body = FileUtility.ReadFile(url);

        mail.Body = mail.Body.Replace("{admin}", "sếp");
        mail.Body = mail.Body.Replace("{date}", DateTime.Now.ToSafetyString("dd/MM/yyyy HH:mm:ss"));

        mail.Body = mail.Body.Replace("{name}", fullName);
        mail.Body = mail.Body.Replace("{email}", email);
        mail.Body = mail.Body.Replace("{mobil}", mobi);
        mail.Body = mail.Body.Replace("{content}", content);

        Exception error = null;
        mail.SendMail(ref error);

        //Thông báo thành công
        ucMessage.ShowSuccess("Đã kiểm tra dữ liệu ok");
    }

    public void LoadCategory()
    {
        DBEntities db = new DBEntities();
        var query = from c in db.ContactCategory
                    where c.Status == true
                    orderby c.Position
                    select new
                    {
                        ID = c.ContactCategoryID,
                        c.Title
                    };
        DropDownList_Category.DataValueField = "ID";
        DropDownList_Category.DataTextField = "Title";

        DropDownList_Category.DataSource = query.ToList();
        DropDownList_Category.DataBind();
    }

}