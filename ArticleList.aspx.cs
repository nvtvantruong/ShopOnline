using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ArticleList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        int aid = Request.QueryString["aid"].ToInt();
        string keyword = Request.QueryString["keyword"].ToSafetyString(); //Lấy trên đường dẫn




        DBEntities db = new DBEntities();
        var query = from a in db.Article
                    from c in db.ArticleCategory
                    from m in db.ArticleMainCategory
                    where a.Status == true
                    && a.ArticleCategoryID == c.ArticleCategoryID
                    && c.ArticleMainCategoryID == m.ArticleMainCategoryID
                    orderby a.CreateTime descending
                    select new
                    {
                        ID = a.ArticleID,
                        a.Thumb,
                        a.Title,
                        a.CreateTime,
                        a.CreateBy,
                        a.ViewTime,
                        a.Description,

                        c.ArticleMainCategoryID,

                        MainCatTitle = m.Title
                    };

        string url = string.Empty;

        if (keyword != string.Empty)
        {
            query = query.Where(q => q.Title.Contains(keyword));
        }
        else if (aid > 0)
        {
            query = query.Where(a => a.ArticleMainCategoryID == aid);
        }

        int pageSize = 10; //10 là số phần tử trên mỗi trang
        int maxPage = 5; //5 là số trang tối đã sẽ hiển thị, còn lại là ...
        int totalItems = query.Count();

        //if(totalItems == 0)
        //    Response.Redirect("/");


        // .: Lưu ý sửa lại link cho đúng với trang và điều kiện thực tế của mỗi trang :. \\
        //string url = "~/ArticleList.aspx?aid={0}&keyword={1}&page={2}".StringFormat(aid, keyword, "{0}");

        int page = Request.QueryString["page"].ToInt();
        if (page <= 0)
            page = 1;


        var data = query.Pagging(page, pageSize).ToList();
        Repeater_blog.DataSource = data;
        Repeater_blog.DataBind();

        var firstItem = data.FirstOrDefault();
        if (keyword != string.Empty)
        {
            url = "~/tim-kiem-tin/{0}-phan-{1}".StringFormat(keyword,"{0}");
        }
        else if (aid > 0)
        {
            url = "~/danh-sach-tin/{0}/{1}-phan-{2}".StringFormat(aid, firstItem.MainCatTitle.ToUrlFormat(), "{0}");
        }
        else
        {
            url = "~/danh-sach-tin-phan-{0}".StringFormat("{0}");
        }

        ucPagging.TotalItems = totalItems;
        ucPagging.CurrentPage = page;
        ucPagging.PageSize = pageSize;
        ucPagging.MaxPage = maxPage;
        ucPagging.URL = url;
        ucPagging.DataBind();
    }
}