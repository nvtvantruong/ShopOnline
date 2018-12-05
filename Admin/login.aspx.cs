using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.ShowInfo("Xin mời nhập thông tin đăng nhập");
        }
    }


    protected void Button_Login_Click(object sender, EventArgs e)
    {
        //Lấy thông tin từ form
        string username = input_Username.Value.Trim();
        string password = input_Password.Value.Trim();

        //Mã hóa password với salt
        //password = password.MD5Hash(Commons.AdminSalt);


        //Kết nối DB
        DBEntities db = new DBEntities();

        //Query lấy dữ liệu theo điều kiện
        var query = from x in db.Account
                    where x.Username == username
                    && x.Password == password
                    && x.Status == true
                    select x;

        //lấy item đầu tiên thỏa điều kiện
        Account item = query.FirstOrDefault();

        //Kiểm tra nếu hợp lệ, thì lưu session và chuỷen đến trang Admin Default
        if (item != null)
        {
            SessionUtility.AdminUsername   = item.Username;
            SessionUtility.AdminFullname   = item.FullName;
            SessionUtility.AdminAvatar     = item.Avatar;
            SessionUtility.AdminCategoryID = item.AccountCategoryID;

            //Lấy url trang trước đó
            string gobackUrl = Request.QueryString["backurl"].ToSafetyString().ToUrlDecode();

            //Nếu không có thì về trang chủ
            if (gobackUrl == string.Empty)
                gobackUrl = "~/Admin/Default.aspx";

            //Chuyển đến trang kế tiếp
            Response.Redirect(gobackUrl);
            return;
        }

        //Ngược lại, thì báo lỗi
        ucMessage.ShowError("Tài khoản không hợp lệ, kiểm tra lại");
    }
}