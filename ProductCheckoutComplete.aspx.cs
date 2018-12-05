using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ProductCheckoutComplete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Lấy mã đơn hàng
            int orderID = Request.QueryString["order_code"].ToInt();
            //Lấy hình thức thanh toán
            int paymentMethod = Request.QueryString["payment_type"].ToInt();
            //Cho tình trạng thanh toán mặc định là chưa trả tiền
            bool isCheckoutOK = false;
            //Nếu khách chọn trả tiền tại nhà
            if (paymentMethod == 0)
            {
                ucMessage.ShowSuccess("Xin chúc mừng, đơn hàng của bạn đã được lập. Bạn có thể thanh toán sau khi nhận được hàng tại nhà");
            }
            else //Thanh toán trực tuyến tại ngân lượng
            {
                isCheckoutOK = ValidateCheckout();
            }

            //Cập nhật lại tình trạng thanh toán của đơn hàng
            if(isCheckoutOK) //Nếu thanh toán OL thành công
            {
                //Vào DB, tìm đơn hàng theo mã đơn hàng trả về
                DBEntities db = new DBEntities();
                var order = db.Order.Where(q => q.OrderID == orderID).FirstOrDefault();

                //Nếu có đơn hàng và đươn hàng chưa cập nhật trạng thái trả tiền,
                //Thì cập nhật
                if(order != null && order.ChargeStatus != true)
                {
                    order.ChargeStatus = true;
                    db.SaveChanges();
                }

                //Gửi một email xác nhận đơn hàng đã thanh toán cho khách
                return;
            }
        }
    }
    public bool ValidateCheckout()
    {
        string transaction_info = Request.QueryString["transaction_info"].ToSafetyString();
        string order_code       = Request.QueryString["order_code"].ToSafetyString();
        string payment_id       = Request.QueryString["payment_id"].ToSafetyString();
        string payment_type     = Request.QueryString["payment_type"].ToSafetyString();
        string secure_code      = Request.QueryString["secure_code"].ToSafetyString();
        string price            = Request.QueryString["price"].ToSafetyString();
        string error_text       = Request.QueryString["error_text"].ToSafetyString();

        NL_Checkout nl          = new NL_Checkout();
        bool isCheckoutOk       = nl.verifyPaymentUrl(transaction_info, order_code, price, payment_id, payment_type, error_text, secure_code);

        // (String transaction_info, String order_code, String price, String payment_id, String payment_type, String error_text, String secure_code)
        if (isCheckoutOk && error_text == string.Empty)
        {
            isCheckoutOk = true;
            ucMessage.ShowSuccess("Xin chúc mừng, đơn hàng đã được thanh toán thanh công. Chúng tôi sẽ giao hàng trong thời gian sớm nhất. <a href='/'>Về trang chủ</a>");
        }
        else
        {
            isCheckoutOk = false;
            ucMessage.ShowError("Rất tiếc, đơn hàng chưa được thanh toán thanh công. Vui lòng kiểm tra lại hoặc <a href='/'>Về trang chủ</a>");
        }
        return isCheckoutOk;
    }
}