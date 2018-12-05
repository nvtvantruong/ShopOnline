using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
            LoadData();
    }

    public void LoadData()
    {
        DBEntities db = new DBEntities();
        var query = from m in db.ProductMainCategory
                    where m.Status == true
                    orderby m.Position
                    select new
                    {
                        ID = m.ProductMainCategoryID,
                        m.Title,
                        Cat = (from c in db.ProductCategory
                               where c.ProductMainCategoryID == m.ProductMainCategoryID
                               && c.Status == true
                               orderby c.Position
                               select new
                               {
                                   ID = c.ProductCategoryID,
                                   c.Title
                               }).Take(5),
                        Product = (from p in db.Product
                                   from c in db.ProductCategory
                                   where p.ProductCategoryID == c.ProductCategoryID
                                   && c.ProductMainCategoryID == m.ProductMainCategoryID
                                   && p.Status == true
                                   orderby Guid.NewGuid()
                                   select new
                                   {
                                       ID = p.ProductID,
                                       p.Thumb,
                                       p.Title,
                                       p.Price,
                                       p.OldPrice
                                   }).Take(8)
                    };

        Repeater_Main.DataSource = query.ToList();
        Repeater_Main.DataBind();
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
            cartItem.ID       = ID;
            cartItem.Title    = item.Title;
            cartItem.Avatar   = item.Avatar;
            cartItem.Price    = item.Price.Value;
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