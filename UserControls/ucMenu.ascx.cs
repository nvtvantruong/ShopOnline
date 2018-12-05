using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using CodeUtility;


public partial class ucMenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        //1. kết nối DB
        DBEntities db = new DBEntities();

        //2.Truy vấn lấy dữ liệu
        var query = from p in db.ProductMainCategory
                    where p.Status == true
                    orderby p.Position ascending
                    select new
                    {
                        ID = p.ProductMainCategoryID,
                        p.Title,
                        SubMenu = (from c in db.ProductCategory
                                   where c.Status == true
                                   && c.ProductMainCategoryID == p.ProductMainCategoryID
                                   orderby c.Position
                                   select new
                                   {
                                       ID = c.ProductCategoryID,
                                       c.Title
                                   })
                    };

        //3.Đổ vào Repeater (bộ lặp)
        Repeater_Menu.DataSource = query.ToList();

        //4.Hiển thị lên
        Repeater_Menu.DataBind();

    }

    public string GetActiveClass(String pageName)
    {
        //Lấy URL hiện tại
        string url = Request.Url.AbsolutePath;

        //Tách lấy tên trang, chuyển về chữ thường
        string currentPageName = Path.GetFileNameWithoutExtension(url).ToLower();

        //So sáng với pageName
        if (currentPageName.Contains(pageName))
            return "active";
        else
            return string.Empty;
    }

}