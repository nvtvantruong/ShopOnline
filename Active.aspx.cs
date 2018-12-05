using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Active : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ActiveClient();
        }
    }

    public void ActiveClient()
    {
        string passwordEncript = "haha";
        string email = Request.QueryString["id"].ToSafetyString();

        email = email.AES256Decrypt(passwordEncript);

        if (email.IsEmpty() || !email.IsEmailFormat())
        {
            ucMessage.ShowError("Liên kết không tồn tại vui lòng về trang chủ");
            return;
        }

        //Vào DB để ktra sự tồn tại
        DBEntities db = new DBEntities();
        var item = db.Client.Where(q => q.Email == email).FirstOrDefault();

        if(item == null)
        {
            ucMessage.ShowError("Tài khoản không tồn tại, vui lòng đăng ký");
            return;
        }

        if(item.Status == true)
        {
            ucMessage.ShowError("Tài khoản đã được khích hoạt trước đó. Vui lòng đăng nhập");
            return;
        }

        //Kích hoạt tài khoản
        item.Status = true;
        db.SaveChanges();

        //Thông báo thành công
        ucMessage.ShowSuccess("Xin chúc mừng đã kích hoạt tài khoản. vui lòng đăng nhập");
        return;
    }
}