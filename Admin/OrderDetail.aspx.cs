using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_OrderDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadData();
    }

    public void LoadData()
    {
        int ID = Request.QueryString["id"].ToInt();

        if (ID <= 0)
            return;

        DBEntities db = new DBEntities();
        var item = db.Order.Where(x => x.OrderID == ID).FirstOrDefault();

        if (item == null)
            return;

        input_ID.Value = item.OrderID.ToSafetyString();
        input_FullName.Value = item.FullName;
        input_Email.Value = item.Email;
        input_Mobi1.Value = item.Mobi;
        input_Mobi2.Value = item.Mobi2;
        input_Address.Value = item.Address;

        if (item.OrderStatus == true)
            radio_Order.Checked = true;
        else
            radio_Order.Checked = false;

        if (item.DeliverStatus == true)
            radio_Deliver.Checked = true;
        else
            radio_Deliver.Checked = false;

        if (item.ChargeStatus == true)
            radio_Charge.Checked = true;
        else
            radio_Charge.Checked = false;

        span_Amount.InnerHtml = item.Total.Value.ToString("0,00 đ");

        //Xử lý lấy thêm thông tin sản phẩm nằm trong đơn hàng
        var fullInfo = from x in item.OrderDetail
                       select new
                       {
                           ID       = x.OrderID,
                           Title    = x.Product.Title,
                           Avatar   = x.Product.Avatar,
                           Quantity = x.Quantity,
                           Price    = x.Price
                       };


        Repeater_Detail.DataSource = fullInfo.ToList();
        Repeater_Detail.DataBind();
    }
}