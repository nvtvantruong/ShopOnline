using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class usArticleMenu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        DBEntities db = new DBEntities();

        var query = from a in db.ArticleMainCategory
                    where a.Status == true
                    orderby a.Position
                    select new
                    {
                        ID = a.ArticleMainCategoryID,
                        a.Title
                    };

        Repeater_ArticleMenu.DataSource = query.ToList();

        Repeater_ArticleMenu.DataBind();
    }
}