using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ucMiniShoppingCart : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        LoadData();
    }

    public void LoadData()
    {
        //Load thông tin thống kê
        b_Count.InnerHtml = SessionUtility.Cart.CountItems.ToString();
        span_Amount.InnerHtml = SessionUtility.Cart.Amount.ToString("0,00");

        //Load danh sách giỏ hàng
        Repeater_Cart.DataSource = SessionUtility.Cart.CartItems.Values.ToList();
        Repeater_Cart.DataBind();
    }

    protected void LinkButton_Remove_Click(object sender, EventArgs e)
    {
        // Xác định link đang được nhấn
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
}