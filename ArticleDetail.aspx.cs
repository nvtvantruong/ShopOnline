using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ArticleDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();

    }

    public void LoadData()
    {
        int ID = Request.QueryString["id"].ToInt();

        if (ID <= 0)
            Response.Redirect("/");

        DBEntities db = new DBEntities();
        var query = from a in db.Article
                    where a.Status == true
                    && a.ArticleID == ID
                    select new
                    {
                        ID = a.ArticleID,
                        a.Title,
                        a.Avatar,
                        a.CreateTime,
                        a.CreateBy,
                        a.ViewTime,
                        a.Description,
                        a.Content,
                        a.Keyword,
                        a.ArticleCategoryID
                    };
        Repeater_Blog.DataSource = query.ToList();
        Repeater_Blog.DataBind();

        //Lấy dòng đầu tiên tìm được
        var data = query.FirstOrDefault();
        //Kiểm tra, nếu có thì load những bài liên quan
        if(data != null)
        {
            //Lấy khóa ngoại
            int catID = data.ArticleCategoryID.Value;
            //Load những bài có cùng khóa ngoại
            LoadRelated(catID);

            //SEO meta Tag
            MetaTagUtility meta = new MetaTagUtility();
            meta.Title          = data.Title;
            meta.Description    = data.Description.Left(30, true, true);
            meta.Keywords       = data.Keyword.ToNoSignFormat();
            meta.ImageUrl       = data.Avatar;

            meta.SetMetaTags();
        }
    }

    public void LoadRelated(int catID)
    {
        //Lấy bài hiện tại
        int id = Request.QueryString["id"].ToInt();

        DBEntities db = new DBEntities();
        var query = from a in db.Article
                    where a.Status == true
                    && a.ArticleCategoryID == catID
                    && a.ArticleID != id
                    orderby Guid.NewGuid()
                    select new
                    {
                        ID = a.ArticleID,
                        a.Title,
                        a.Thumb
                    };

        Repeater_Related.DataSource = query.Take(6).ToList();
        Repeater_Related.DataBind();
    }
}