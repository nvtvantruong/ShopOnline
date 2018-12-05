using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ucRightArticle : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        var minDay = DateTime.Now.AddYears(-3);

        DBEntities db = new DBEntities();
        var query = from a in db.Article
                    where a.Status == true
                    && a.CreateTime.Value >= minDay
                    orderby a.ViewTime descending
                    select new
                    {
                        ID = a.ArticleID,
                        a.Thumb,
                        a.Title,
                        a.CreateTime,
                        a.ViewTime
                    };
        Repeater_Article.DataSource = query.Take(5).ToList();
        Repeater_Article.DataBind();
    }
}