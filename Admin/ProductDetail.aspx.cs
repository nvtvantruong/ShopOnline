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
        if (!IsPostBack)
            LoadData();
    }

    private void LoadData()
    {

        int ID = Request.QueryString["id"].ToInt();

        DBEntities db = new DBEntities();

        var item = db.Product.Where(x => x.ProductID == ID).FirstOrDefault();

        if (item != null)
            div_Content.InnerHtml = item.Content.ToSafetyString().Replace("~/", "/");
    }
}