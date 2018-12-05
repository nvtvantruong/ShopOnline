using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.ShowInfo("Mời nhập mật khẩu mới 2 lần giống nhau");
            string id = Request.QueryString["id"].ToSafetyString();
            if (id == string.Empty)
                id = SessionUtility.AdminUsername;

            input_Username.Value = id;
        }
    }

    protected void LinkButton_Save_Click(object sender, EventArgs e)
    {
        //Lấy mật khẩy đã nhập
        string password = input_Password.Value.Trim();
        string repassword = input_Repassword.Value.Trim();

        //Lấy id cần đổi mật khẩu
        string ID = Request.QueryString["id"].ToSafetyString();
        if (ID == string.Empty)
            ID = SessionUtility.AdminUsername;

        //lấy link quay về
        string gobackUrl = Request.QueryString["backurl"].ToSafetyString();
        if (gobackUrl == string.Empty)
            gobackUrl = "~/Admin/Defaul.aspx";

        //Nếu id không hợp lệ thì về trang trước đó
        if (ID == string.Empty)
            Response.Redirect(gobackUrl);

        //Nếu mật khẩu không hợp lệ thì báo lỗi
        if (password == string.Empty || password != repassword)
        {
            ucMessage.ShowError("Vui lòng nhậo mật khẩu 2 lần giống nhau");
            return;
        }

        //Tìm 1 account có username là user đăng login
        DBEntities db = new DBEntities();
        Account item = db.Account.Where(x => x.Username == ID).FirstOrDefault();

        //Nếu tài khoản hiện tại không còn tồn tại, thì thoát và về trang login
        if (item == null)
        {
            Session.Abandon();
            Response.Redirect("~/Admin/Loging.aspx");
        }

        //MÃ hóa password với salt
        password = password.MD5Hash(Commons.AdminSalt);

        //Cập nhật mật khẩu mới
        item.Password = password;
        db.SaveChanges();

        //Nếu có trang trước đó thì quay về
        if (gobackUrl != "~/Admin/Defaul.aspx")
        {
            Response.Redirect(gobackUrl);
        }

        //Thông báo thành công
        ucMessage.ShowSuccess("Đã đổi mật khẩu thành công");
    }
}