using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class ServiceUtility : System.Web.Services.WebService
{
    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    public List<ProductSearchData> SearchProduct(string keyword)
    {
        DBEntities db = new DBEntities();
        var query = from p in db.Product
                    where p.Status == true
                    && p.Title.Contains(keyword)
                    orderby p.CreateTime descending
                    select new ProductSearchData
                    {
                        ID = p.ProductID,
                        Title = p.Title,
                        Thumb = p.Thumb
                    };

        return query.Take(10).ToList();
    }

}
