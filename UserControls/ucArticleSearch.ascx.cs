using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ucArticle : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Lấy keyword trên Url xuống
            string keywword = Request.QueryString["keyword"].ToSafetyString();

            //Đổ vào ô search
            input_Search.Value = keywword;
        }

    }

    protected void button_Search_Click(object sender, EventArgs e)
    {
        //Lấy giá trị trong ô search
        string keyword = input_Search.Value.Trim().ToUrlEncode();

        //Khai báo Link trang đích
        string url = "~/tim-kiem-tin/{0}-phan-{1}";

        //Định dạng link trang đích
        url = url.StringFormat(keyword, 1);

        //Chuyển đến trang đích
        Response.Redirect(url);
    }
}