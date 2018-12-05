using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;
using System.IO;

public partial class ucShoppingCart : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
            SetButtonCheckoutText();
            this.BackUrl = Request.UrlReferrer.ToSafetyString();

        }
    }

    public string BackUrl
    {
        get
        {
            return ViewState["BackUrl"].ToSafetyString();
        }
        set
        {
            ViewState["BackUrl"] = value;
        }
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        //Lấy URL của trang trước
        string url = this.BackUrl.ToLower(); //Request.UrlReferrer.ToSafetyString();

        //Nếu không có trang trước về trang chủ
        if (url.IsEmpty())
            url = "~/";
        else if ((!url.Contains("default.aspx")
                  && !url.Contains("productlist.aspx")
                  && !url.Contains("productetail.aspx")))
            url = "~/";

        //Chuyển đến trang trước
        Response.Redirect(url);

    }

    public void LoadData()
    {
        td_Total.InnerHtml = SessionUtility.Cart.Total.ToString("0,00 đ");
        td_Bonus.InnerHtml = SessionUtility.Cart.Bonus.ToString("0,00 đ");
        h2_Amount.InnerHtml = SessionUtility.Cart.Amount.ToString("0,00 đ");

        Repeater_Cart.DataSource = SessionUtility.Cart.CartItems.Values.ToList();
        Repeater_Cart.DataBind();
    }

    protected void LinkButton_Decrease_Click(object sender, EventArgs e)
    {
        //Xác định link đang được nhấn
        LinkButton LinkButton_Decrease = sender as LinkButton;

        //Xác định ID của SP sẽ giảm số lượng
        int ID = LinkButton_Decrease.CommandArgument.ToInt();

        //Tìm SP có ID phù hợp trong giỏ
        CartItem item = SessionUtility.Cart.CartItems[ID];

        //Nếu thì thấy và SL > 1, thì:
        //Giảm số lượng đi 1
        if (item != null && item.Quantity > 1)
            item.Quantity -= 1;

        //Load lại trang
        LoadData();
    }

    protected void LinkButton_Increase_Click(object sender, EventArgs e)
    {
        //Xác định link đang được nhấn
        LinkButton linkButton_Increase = sender as LinkButton;

        //Xác định ID của SP sẽ tăng số lượng
        int ID = linkButton_Increase.CommandArgument.ToInt();

        //Tìm SP có ID phù hợp trong giỏ
        CartItem item = SessionUtility.Cart.CartItems[ID];

        //nếu tìm thấy, thì Tăng số lượng đi 1
        if (item != null)
            item.Quantity += 1;

        //Load lại trang
        LoadData();
    }

    protected void LinkButton_Remove_Click(object sender, EventArgs e)
    {
        //Xác định link đang được nhấn
        LinkButton LinkButton_Remove = sender as LinkButton;

        //Xác định ID của SP sẽ gỡ
        int ID = LinkButton_Remove.CommandArgument.ToInt();

        //Tìm SP có ID phù hợp trong giỏ
        CartItem item = SessionUtility.Cart.CartItems[ID];

        //Nếu có:
        //thì gở bỏ
        if (item != null)
            SessionUtility.Cart.CartItems.Remove(ID);

        //Load lại trang
        LoadData();
    }

    protected void UpdatePanel_Main_PreRender(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void LinkButton_Checkout_Click(object sender, EventArgs e)
    {
        //Lấy Url trang hiện tại
        string url = Request.Url.ToString();

        //Bóc tách tên trang hiện tại
        string fileName = Path.GetFileNameWithoutExtension(url).ToLower();

        //Kiểm tra, nếu là trang ProductShoppingCart, thì chuyển đến trang thanh toán ProductCheckout
        if(fileName == "ProductShoppingCart".ToLower())
        {
            Response.Redirect("~/ProductCheckout.aspx");
        }

        //Ngược lại gọi lệnh thanh toán
        else
        {

        }
    }

    protected void SetButtonCheckoutText()
    {
        //Lấy Url trang hiện tại
        string url = Request.Url.ToString();

        //Bóc tách tên trang hiện tại
        string fileName = Path.GetFileNameWithoutExtension(url).ToLower();

        //Kiểm tra, nếu là trang ProductShoppingCart, thì chuyển đến trang thanh toán ProductCheckout
        if (fileName == "ProductShoppingCart".ToLower())
        {
            LinkButton_Checkout.Text = "Đến trang thanh toán";
        }

        //Ngược lại gọi lệnh thanh toán
        else
        {
            LinkButton_Checkout.Text = "Lập đơn hàng";
        }
    }
}