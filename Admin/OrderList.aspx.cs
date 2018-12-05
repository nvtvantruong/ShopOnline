using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_OrdertList : System.Web.UI.Page
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
        // Kết nối DB
        DBEntities db = new DBEntities();


        var query = db.Order.OrderByDescending(x => x.CreateTime).Select(x => new
        {
            ID = x.OrderID,
            x.Total,
            x.Email,
            x.FullName,
            x.Mobi,
            x.Mobi2,
            x.Address,
            x.Gender,
            x.OrderStatus,
            x.DeliverStatus,
            x.ChargeStatus,
            x.CreateTime
        });

        //Lấy các tiêu trí search
        ////Lấy catid
        int ID = Request.QueryString["id"].ToInt();

        //Nếu có lọc theo catid
        if (ID != 0)
        {
            query = query.Where(x => x.ID == ID);
            input_ID.Value = ID.ToSafetyString();
        }

        ////Lấy title
        string title = Request.QueryString["title"].ToSafetyString();

        //Nếu có lọc theo title
        if (title != string.Empty)
        {

            input_Title.Value = title;
            query = query.Where(x => x.FullName.Contains(title)
                                    || x.Email.Contains(title)
                                    || x.Mobi.Contains(title)
                                    || x.Mobi2.Contains(title));
        }


        //Phân trang dữ liệu
        int totalItems = query.Count();
        int maxPage = 10;
        int pageSize = 10;
        int currentPage = Request.QueryString["page"].ToInt();
        if (currentPage == 0)
            currentPage = 1;
        string url = "/Admin/OrderList.aspx?page={0}&id={1}&title={2}";
        url = url.StringFormat("{0}", ID, title);

        //Đổ vào ucPaging
        ucPagging.CurrentPage = currentPage;
        ucPagging.PageSize = pageSize;
        ucPagging.MaxPage = maxPage;
        ucPagging.URL = url;
        ucPagging.TotalItems = totalItems;
        ucPagging.DataBind();

        //lấy dữ liệu
        var data = query.Pagging(currentPage, pageSize).ToList();

        //Đổ vào bộ lặp
        Repeater_Main.DataSource = data;

        //Hiển thị Lên
        Repeater_Main.DataBind();

        //Hiện thị thông báo từ lần trước
        ShowPreviousMessage();
    }

    protected void LinkButton_Search_Click(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void LinkButton_ClearSearch_Click(object sender, EventArgs e)
    {
        //Xóa ạch các tiêu chí search
        input_ID.Value = string.Empty;
        input_Title.Value = string.Empty;

        //Search lại
        SearchData();
    }

    protected void LinkButton_Delete_Click(object sender, EventArgs e)
    {
        //Ép kiểu seder thành linkButton
        LinkButton LinkButton_Delete = sender as LinkButton;

        //Bóc tách lấy ID của nó
        int ID = LinkButton_Delete.CommandArgument.ToInt();

        //Kết nối DB
        DBEntities db = new DBEntities();

        //Tìm 1 item phù hợp
        var item = db.Order.Where(x => x.OrderID == ID).FirstOrDefault();

        //kiểm tra item không tồn tại thì báo lỗi
        if (item == null)
        {
            SearchData("error", "Dữ liệu này đã không còn tồn tại");
            return;
        }

        //Xóa những OrderDetail liên quan
        foreach (var childItem in item.OrderDetail.ToList())
        {
            db.OrderDetail.Remove(childItem);
        }

        //xóa khỏi db
        db.Order.Remove(item);

        //Lưu DB
        try {
        db.SaveChanges();
        }
        catch(Exception ex)
        {
            ucMessage.ShowError("Không thể xóa dữ liệu này. Do có dữ liệu tham chiếu");
            return;
        }
        //Load lại trang
        SearchData("success", "Đã xóa dữ liệu", true);
        return;


    }

    private void ShowPreviousMessage()
    {
        string messagetype = Request.QueryString["messagetype"].ToSafetyString();
        string message = Request.QueryString["message"].ToSafetyString();

        if (messagetype == "success")
        {
            ucMessage.ShowSuccess(message);
        }
        else if (messagetype == "warning")
        {
            ucMessage.ShowWarning(message);
        }
        else if (messagetype == "info")
        {
            ucMessage.ShowInfo(message);
        }
        else if (messagetype == "error")
        {
            ucMessage.ShowError(message);
        }
    }

    public void SearchData(string type = "", string message = "", bool isKeepPage = false)
    {
        //Lấy các giá trị tìm kiếm
        int ID = input_ID.Value.ToInt();
        string title = input_Title.Value.Trim();

        int page = 1;
        if (isKeepPage == true)
        {
            page = Request.QueryString["page"].ToInt();
            if (page <= 0)
                page = 1;
        }

        //Tạo url trang hiện tại kèm theo điều kiện search
        string url = "~/Admin/OrderList.aspx?id={0}&title={1}&messagetype={2}&message={3}&page={4}";
        url = url.StringFormat(ID, title, type, message, page);

        //Chuyển về trang đích'
        Response.Redirect(url);
    }


}