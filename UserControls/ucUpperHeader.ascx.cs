using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ucUpperHeader : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionUtility.Client != null)
        {
            b_FullName.InnerHtml = SessionUtility.Client.FullName;
            LinkButton_Logout.Visible = true;
            span_Account.Visible = false;
        }
        else
        {
            span_Account.Visible = true;
            LinkButton_Logout.Visible = false;
        }
    }

    protected void LinkButton_Logout_Click(object sender, EventArgs e)
    {
        //Empty Session(làm sạch)
        Session.Abandon();

        //Chuyển về trang chủ
        Response.Redirect("~/");

    }

}