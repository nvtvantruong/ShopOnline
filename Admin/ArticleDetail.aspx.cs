using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_ArticleDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    private void LoadData()
    {

        int ID = Request.QueryString["id"].ToInt();

        DBEntities db = new DBEntities();

        var query = db.Article.Where(x => x.ArticleID == ID ).Select(x => new
        {
            ID = x.ArticleID,
            x.Content
        });

        Repeater_Main.DataSource = query.ToList();
        Repeater_Main.DataBind();
    }
}