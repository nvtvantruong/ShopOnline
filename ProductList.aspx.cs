using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ProductList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.HideAll();
            LoadData();
        }
    }

    public void LoadData()
    {
        //Lấy mid và cid trên URL (query string)
        int mid = Request.QueryString["mid"].ToInt();
        int cid = Request.QueryString["cid"].ToInt();
        string keyword = Request.QueryString["keyword"].ToSafetyString(); //search

        if (mid <= 0 && cid <= 0 && keyword == string.Empty)
            Response.Redirect("/");

        DBEntities db = new DBEntities();
        var query = from p in db.Product
                    from c in db.ProductCategory
                    from m in db.ProductMainCategory
                    where p.Status == true
                    && p.ProductCategoryID == c.ProductCategoryID
                    && c.ProductMainCategoryID == m.ProductMainCategoryID
                    orderby p.CreateTime descending
                    select new
                    {
                        ID = p.ProductID,
                        p.Thumb,
                        p.Title,
                        p.Price,
                        p.OldPrice,
                        p.Description,

                        CatID = c.ProductCategoryID,
                        MainCatID = m.ProductMainCategoryID,
                        CatTitle = c.Title,
                        MainCatTitle = m.Title,

                        CatDescription = c.Description,
                        MainCatDescription = m.Description,

                        CatAvatar = c.Avatar,
                        MainCatAvatar = m.Avatar
                    };

        //Nếu mid > 0, thì câu query để load theo danh mục cấp cha
        if (mid > 0)
        {
            query = query.Where(q => q.MainCatID == mid);
            a_CatTitle.Visible = false;
            i_CatTitle.Visible = false;
        }

        //Ngược lại, nếu cid lớn hơn 0, thì sửa câu query để load theo danh mục cấp con
        else if (cid > 0)
        {
            query = query.Where(q => q.CatID == cid);
            a_CatTitle.Visible = true;
            i_CatTitle.Visible = true;
        }

        if (keyword != string.Empty)
            query = query.Where(q => q.Title.Contains(keyword) || q.Description.Contains(keyword));

        //Đổ vào Repeater

        int pageSize = 10; //10 là số phần tử trên mỗi trang
        int maxPage = 5; //5 là số trang tối đã sẽ hiển thị, còn lại là ...
        int totalItems = query.Count();

        if(totalItems == 0)
        {
            ucMessage.ShowError("Không tìm thấy sản phẩm");
            ucPagging.Visible = false;
            return;
        }

        //if (keyword !=string.Empty && totalItems == 0)
        //    Response.Redirect("~/");


        int page = Request.QueryString["page"].ToInt();
        if (page <= 0)
            page = 1;

        var data = query.Pagging(page, pageSize).ToList();

        var firstItem = data.FirstOrDefault();

        // .: Lưu ý sửa lại link cho đúng với trang và điều kiện thực tế của mỗi trang :. \\
        string url = string.Empty;
        if (keyword == string.Empty && mid > 0)
            url = "~/danh-sach-san-pham/m{0}c{1}p{2}/{3}".StringFormat(mid, cid, "{0}", firstItem.MainCatTitle.ToUrlFormat());
        else if (keyword == string.Empty && cid > 0)
            url = "~/danh-sach-san-pham/m{0}c{1}p{2}/{3}".StringFormat(mid, cid, "{0}", firstItem.CatTitle.ToUrlFormat());
        else if (keyword != string.Empty)
            url = "~/danh-sach-san-pham/m{0}c{1}p{2}s/{3}".StringFormat(0, 0, "{0}", keyword.ToUrlEncode());

        ucPagging.TotalItems = totalItems;
        ucPagging.CurrentPage = page;
        ucPagging.PageSize = pageSize;
        ucPagging.MaxPage = maxPage;
        ucPagging.URL = url;
        ucPagging.DataBind();
        Repeater_Product.DataSource = data;
        Repeater_Product.DataBind();


        if (firstItem != null)
        {
            mid = firstItem.MainCatID;
            Page.ClientScript.RegisterStartupScript(this.GetType(),
                DateTime.Now.ToString("ddMMyyyHHmmss"),
                "activeProductMainMenu({0});".StringFormat(mid), true);

            a_MainTitle.InnerHtml = firstItem.MainCatTitle;
            a_MainTitle.HRef = "/ProductList.aspx?mid={0}".StringFormat(firstItem.MainCatID);

            a_CatTitle.InnerHtml = firstItem.CatTitle;
            a_CatTitle.HRef = "/ProductList.aspx?cid={0}".StringFormat(firstItem.CatID);


            //SEO Meta tag
            if (mid > 0)
            {
                MetaTagUtility meta = new MetaTagUtility();
                meta.Title          = firstItem.MainCatTitle + " - ShopOnline.com";
                meta.Description    = firstItem.MainCatDescription;
                meta.ImageUrl       = firstItem.MainCatAvatar;

                meta.SetMetaTags();
            }
            if (cid > 0)
            {
                MetaTagUtility meta = new MetaTagUtility();
                meta.Title          = firstItem.CatTitle + " - ShopOnline.com";
                meta.Description    = firstItem.CatDescription;
                meta.ImageUrl       = firstItem.CatAvatar;

                meta.SetMetaTags();
            }

        }

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