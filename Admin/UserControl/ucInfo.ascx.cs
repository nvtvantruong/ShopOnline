using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ucInfo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Kiểm tra session Username, nếu chưa có thì chuyển về trang Login
            if (SessionUtility.AdminUsername == string.Empty)
            {
                //Lấy url cyả trang hiện tại
                string goBackUrl = Request.Url.ToString().ToUrlEncode();

                //Tạo link loging với trang quay về là trang hiện tại
                string loginUrl = "~/Admin/Login.aspx?backurl="+ goBackUrl;

                //Chuyển đến trang login
                Response.Redirect(loginUrl);
            }

            //Ngược lại, thì show thông tin các control
            b_Username.InnerHtml = SessionUtility.AdminUsername;
            img_Avatar.Src = SessionUtility.AdminAvatar;
            a_FullName.InnerHtml = SessionUtility.AdminFullname;
        }
    }

    protected void LinkButton_Logout_Click(object sender, EventArgs e)
    {
        //Xóa sạch các session
        Session.Abandon();

        //Chuyển về trang Login
        Response.Redirect("~/Admin/Login.aspx");
    }
}