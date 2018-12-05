using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class ProductCheckout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage_Top.HideAll();
            ucMessage_Bottom.HideAll();

            LoadData();
        }
    }

    public void LoadData()
    {
        //Nếu khách đã đăng nhập, thì load thông tin tài khoản
        if (SessionUtility.Client != null)
        {
            RadioButton_AccountInfo.Checked = true;
            ucMessage_Top.HideAll();

            LoadAccountInfo();
        }

        //Ngược lại, cho nhập thông tin mới
        else
        {
            RadioButton_NewInfo.Checked = true;
            ucMessage_Top.ShowInfo("<a href='/AccountLogin.aspx'>Đăng nhập</a> để có thể quản lý đơn hàng thuận tiện hơn");

            LoadNewInfo();
        }
    }

    private void LoadNewInfo()
    {
        //Xóa trắng Form
        input_Email.Value = string.Empty;
        input_FullName.Value = string.Empty;
        input_Mobil.Value = string.Empty;
        input_Mobil2.Value = string.Empty;
        textarea_Address.Value = string.Empty;

        input_Gender_Female.Checked = false;
        input_Gender_Male.Checked = true;
    }

    private void LoadAccountInfo()
    {
        //Hiện thông tin tài khoản
        input_Email.Value = SessionUtility.Client.Email;
        input_FullName.Value = SessionUtility.Client.FullName;
        input_Mobil.Value = SessionUtility.Client.Mobi;
        input_Mobil2.Value = string.Empty;
        textarea_Address.Value = SessionUtility.Client.Address;

        if (SessionUtility.Client.Gender == true)
        {
            input_Gender_Female.Checked = false;
            input_Gender_Male.Checked = true;
        }
        else
        {
            input_Gender_Male.Checked = false;
            input_Gender_Female.Checked = true;
        }
    }

    private bool IsValid()
    {
        //Lấy giá trị trên from
        string email = input_Email.Value.Trim();
        string fullName = input_FullName.Value.Trim();
        string mobil = input_Mobil.Value.Trim();
        string mobil2 = input_Mobil2.Value.Trim();
        string address = textarea_Address.Value.Trim();

        bool gender = false;
        if (input_Gender_Male.Checked)
            gender = true;

        int paymentMethod = 0; //Tại nhà
        if (input_Checkout_Online.Checked)
            paymentMethod = 1; //Online


        //kiểm tra hợp lệ
        if (!email.IsEmailFormat())
        {
            ucMessage_Bottom.ShowError("Vui lòng nhập email đúng định dạng");
            return false;
        }
        if(fullName.IsEmpty())
        {
            ucMessage_Bottom.ShowError("Vui lòng nhập họ tên người nhận hàng");
            return false;
        }
        if (mobil.IsEmpty())
        {
            ucMessage_Bottom.ShowError("Vui lòng nhập nhập số điện thoại người nhận hàng");
            return false;
        }

        if (address.IsEmpty())
        {
            ucMessage_Bottom.ShowError("Vui lòng nhập nhập địa chỉ người nhận hàng");
            return false;
        }


        //Lưu thông tin nhận hàng vào Session
        Cart cart = SessionUtility.Cart;
        cart.Email = email;
        cart.FullName = fullName;
        cart.Mobi1 = mobil;
        cart.Mobi2 = mobil2;
        cart.Address = address;
        cart.PaymentMethod = paymentMethod;
        cart.Gender = gender;

        return true;
    }

    protected void RadioButton_AccountInfo_CheckedChanged(object sender, EventArgs e)
    {
        if (SessionUtility.Client != null)
            LoadAccountInfo();
        else
        {
            ucMessage_Top.ShowWarning("Để sử dụng chức năng này vui lòng <a href='/AccountLogin.aspx'>đăng nhập</a>");

            RadioButton_AccountInfo.Checked = false;
            RadioButton_NewInfo.Checked     = true;
        }
    }

    protected void RadioButton_NewInfo_CheckedChanged(object sender, EventArgs e)
    {
        LoadNewInfo();
    }

    protected void Button_Checkout_Click(object sender, EventArgs e)
    {
        //Kiểm tra tính hợp lệ
        if (!IsValid())
            return;

        //lấy giỏ hàng hiện tại
        Cart cart = SessionUtility.Cart;

        // Tạo 1 đơn hàng mới
        Order order         = new Order();
        order.Total         = cart.Amount;
        order.Email         = cart.Email;
        order.FullName      = cart.FullName;
        order.Mobi          = cart.Mobi1;
        order.Mobi2         = cart.Mobi2;
        order.Address       = cart.Address;
        order.Gender        = cart.Gender;
        order.PaymentMethod = cart.PaymentMethod;

        order.OrderStatus   = true; //Trạng thái đặt hàng: rồi
        order.DeliverStatus = false; //Trạng thái giao hàng: chưa
        order.ChargeStatus  = false;// Trạng thái trả tiền: chưa

        order.CreateTime    = DateTime.Now;

        //Nếu khách đã đăng nhập thì lưu mã khác hàng
        if (SessionUtility.Client != null)
            order.ClientID = SessionUtility.Client.ClientID;

        //Thêm danh sách sản phẩm vào đơn hàng đó
        foreach (var item in cart.CartItems.Values)
        {
            //Ứng với mỗi item có trong giỏ hàng,
            //Tiến hành tạo 1 chi tiết đơn hàng tương iwnsg trong DB
            //Rời nhập giá trị cho chi tiết đó
            OrderDetail detail = new OrderDetail();
            detail.ProductID   = item.ID;
            detail.Quantity    = item.Quantity;
            detail.Price       = item.Price;

            //Thêm chi tiết đơn hàng vào đơn hàng mới (bước trên)
            order.OrderDetail.Add(detail);
            //Lệnh trên sẽ tự động lấy khóa chính của cha, làm khóa ngoại cho nó
        }

        //Lưu vào DB
        DBEntities db = new DBEntities();
        //Thêm đơn hàng mới (bước trên) vào bảng trong DB
        db.Order.Add(order);
        //Lưu thanh đổi (Lưu đơn hàng)
        db.SaveChanges();

        //Clear giỏ hàng
        cart.CartItems.Clear();

        //chuyển đến trang thanh toán
        //Lấy url của website
        string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);

        //Kiểm tra phương thức thanh toán
        if (order.PaymentMethod == 0)
        {
            //Thanh toán tại nhà
            string returnUrl = "{0}/ProductCheckoutComplete.aspx?payment_type={1}&order_code={2}".StringFormat(baseUrl, order.PaymentMethod, order.OrderID);
            Response.Redirect(returnUrl);
            return;
        }
        else
        {
            //Thanh toán tại nganluong
            string returnUrl = "{0}/ProductCheckoutComplete.aspx".StringFormat(baseUrl);
            string transaction_info = "{0} thanh toán đơn hàng có mã số {1}".StringFormat(SessionUtility.Client.FullName, order.OrderID);
            string order_code = order.OrderID.ToString();
            string receiver = "mrhieuit@gmail.com";
            string price = "2000"; //Giá demo tối thiểu
            NL_Checkout nl = new NL_Checkout();
            string url = nl.buildCheckoutUrl(returnUrl, receiver, transaction_info, order_code, price);
            Response.Redirect(url);
        }
    }
}