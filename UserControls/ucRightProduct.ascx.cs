using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ucRightProduct : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        DBEntities db = new DBEntities();
        var query = from p in db.Product
                    where p.Status == true
                    orderby (p.OldPrice - p.Price) descending
                    select new
                    {
                        ID = p.ProductID,
                        p.Title,
                        p.Thumb,
                        p.Price,
                        p.OldPrice
                    };

        Repeater_Product.DataSource = query.Take(5).ToList();
        Repeater_Product.DataBind();
    }
}