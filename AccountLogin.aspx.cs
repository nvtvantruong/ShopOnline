using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class AccountLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.HideAll();
            this.BackUrl = Request.UrlReferrer.ToSafetyString();
        }
    }

    public string BackUrl
    {
        get
        {
            return ViewState["BackUrl"].ToSafetyString();
        }
        set
        {
            ViewState["BackUrl"] = value;
        }
    }

    protected void Button_Login_Click(object sender, EventArgs e)
    {
        string url = this.BackUrl.ToLower();
        string email = input_Email.Value.Trim();
        string password = input_Password.Value.Trim();

        if (email.IsEmpty() || !email.IsEmailFormat())
        {
            ucMessage.ShowError("Vui lòng nhập email đúng định dạng");
            return;
        }

        if (password.IsEmpty())
        {
            ucMessage.ShowError("Vui lòng nhập nhật khẩu");
            return;
        }
        string passwordEncript = "haha";
        string securePassword = password.SHA256Hash(passwordEncript);
        DBEntities db = new DBEntities();
        var item = db.Client.Where(q => q.Email == email && q.Password == securePassword).FirstOrDefault();

        if (item == null)
        {
            ucMessage.ShowError("Tài khoản không hợp lệ. vui lòng kiểm tra lại");
            return;
        }

        if (item.Status != true)
        {
            ucMessage.ShowError("Vui lòng kích hoạt tài khoản trước khi đăng nhập");
            return;
        }

        //Lưu thông tin đăng nhập vào Session

        SessionUtility.Client = item;

        if (url.IsEmpty())
            url = "~/";
        //Chuyển về trang chủ
        Response.Redirect(url);

    }
}