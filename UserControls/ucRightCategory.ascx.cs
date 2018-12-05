using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ucRightCategory : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        DBEntities db = new DBEntities();
        var query = from m in db.ProductMainCategory
                    where m.Status == true
                    orderby m.Position
                    select new
                    {
                        ID = m.ProductMainCategoryID,
                        m.Title,
                        Cat = (from c in m.ProductCategory
                               where c.Status == true
                               orderby c.Position
                               select new
                               {
                                   ID = c.ProductCategoryID,
                                   c.Title
                               })
                    };

        Repeater_Main.DataSource = query.ToList();
        Repeater_Main.DataBind();
    }
}