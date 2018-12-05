﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ucProductSearch : System.Web.UI.UserControl
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
        string keyword = input_Search.Value.Trim();

        keyword = keyword.ToUrlEncode();

        //Khai báo Link trang đích
        string url = "~/danh-sach-san-pham/m0c0p1s/{0}";

        //Định dạng link trang đích
        url = url.StringFormat(keyword);

        //Chuyển đến trang đích
        Response.Redirect(url);
    }
}