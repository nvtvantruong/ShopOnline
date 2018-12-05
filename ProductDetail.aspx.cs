using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ProductDetail : System.Web.UI.Page
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
        var query = from p in db.Product
                    from c in db.ProductCategory
                    from m in db.ProductMainCategory
                    where p.Status == true
                    && p.ProductID == ID
                    && p.ProductCategoryID == c.ProductCategoryID
                    && c.ProductMainCategoryID == m.ProductMainCategoryID
                    select new
                    {
                        ID = p.ProductID,
                        p.Title,
                        p.Avatar,
                        p.Thumb,
                        p.ImageList,
                        p.Price,
                        p.OldPrice,
                        p.Quantity,
                        p.Accessories,
                        p.WarrantyPolicy,
                        p.Promotions,
                        p.Description,
                        p.Content,
                        p.Specifications,

                        CatID = p.ProductCategoryID,
                        MainCatID = c.ProductMainCategoryID,

                        CatTitle = c.Title,
                        MainCatTitle = m.Title
                    };
        Repeater_Product.DataSource = query.ToList();
        Repeater_Product.DataBind();

        //Lấy dòng đầu tiên tìm được
        var data = query.FirstOrDefault();
        //Kiểm tra, nếu có thì load những bài liên quan
        if (data != null)
        {
            //Lấy khóa ngoại
            int catID = data.CatID.Value;
            //Load những bài có cùng khóa ngoại
            LoadRelated(catID);

            //Load active
            int mid = data.MainCatID.Value;
            Page.ClientScript.RegisterStartupScript(this.GetType(),
                DateTime.Now.ToString("ddMMyyyHHmmss"),
                "activeProductMainMenu({0});".StringFormat(mid), true);

            //SEO meta Tag
            MetaTagUtility meta = new MetaTagUtility();
            meta.Title          = data.Title;
            meta.Description    = data.Description;
            meta.ImageUrl       = data.Avatar;

            meta.SetMetaTags();
        }
    }

    public void LoadRelated(int catID)
    {
        int ID = Request.QueryString["id"].ToInt();

        DBEntities db = new DBEntities();
        var query = from p in db.Product
                    from c in db.ProductCategory
                    where p.Status == true
                    && p.ProductCategoryID == catID
                    && p.ProductID != ID
                    orderby Guid.NewGuid()
                    select new
                    {
                        ID = p.ProductID,
                        p.Thumb,
                        p.Title,
                        p.Price,
                        p.OldPrice,
                        p.ProductCategoryID
                    };
        Repeater_Related.DataSource = query.Take(3).ToList();
        Repeater_Related.DataBind();

    }

    protected void LinkButton_AddToCart_Click(object sender, EventArgs e)
    {
        //Khai báo link button hiện tại đã được nhấn
        LinkButton linkButton_AddToCart = sender as LinkButton;

        //Lấy ID đamg lưu trữ trong thuộc tính CommandArgument
        int ID = linkButton_AddToCart.CommandArgument.ToInt();

        //Vào DB, để lấy thông tin món hàng theo ID
        DBEntities db = new DBEntities();
        var item = db.Product.Where(q => q.ProductID == ID).FirstOrDefault();

        //Nếu không có sản phẩm phù hợp
        if (item == null)
            LoadData();

        //Khai báo 1 món hàng
        CartItem cartItem;

        //Kiểm tra món hàng hiện tại đã có trong giỏ chưa, nếu chưa có thì add món mới
        if (!SessionUtility.Cart.CartItems.ContainsKey(ID))
        {
            //Món hàng được add mới
            cartItem = new CartItem();

            //Số lượng là: 1
            cartItem.Quantity = 1;

            //Gắn thông tin khác
            cartItem.ID = ID;
            cartItem.Title = item.Title;
            cartItem.Avatar = item.Avatar;
            cartItem.Price = item.Price.Value;
            cartItem.OldPrice = item.OldPrice.Value;

            //Cho vào giỏ
            SessionUtility.Cart.CartItems.Add(ID, cartItem);
        }
        else
        {
            //Món hàng là món đã có sẳn trong giỏ
            cartItem = SessionUtility.Cart.CartItems[ID];
            cartItem.Quantity += 1;
        }
    }
}