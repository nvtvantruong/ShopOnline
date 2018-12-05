using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ucHotProduct : System.Web.UI.UserControl
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
                        id = p.ProductID,
                        p.Avatar,
                        p.Thumb,
                        p.Title,
                        p. Price,
                        p.OldPrice
                    };

        var data = query.Take(5).ToList();

        Repeater_Full.DataSource = data;
        Repeater_Full.DataBind();


        Repeater_Thumb.DataSource = data;
        Repeater_Thumb.DataBind();
    }
}