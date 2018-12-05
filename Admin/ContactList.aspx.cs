using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;

public partial class Admin_ContactList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ucMessage.HideAll();
            LoadCategoryData();
            LoadData();
        }
    }

    public void LoadData()
    {
        // Kết nối DB
        DBEntities db = new DBEntities();

        //Query dữ liệu
        //////var query = from a in db.Contact
        //////            orderby a.Username ascending
        //////            select new
        //////            {
        //////                ID = a.Username,
        //////                a.Avatar,
        //////                a.FullName,
        //////                a.Email,
        //////                a.CreateTime,
        //////                a.Mobi,
        //////                a.Gender,
        //////                a.ContactCategoryID,
        //////                a.Address,
        //////                a.Status
        //////            };

        var query = db.Contact.OrderByDescending(x => x.CreateTime).Select(x => new
        {
            ID = x.ContactID,
            x.Content,
            x.FullName,
            x.Email,
            x.CreateTime,
            x.Mobi,
            x.ContactCategoryID,
            x.Address,
            x.Status,
            x.ApproveBy
        });

        //Lấy các tiêu trí search
        ////Lấy catid
        int catID = Request.QueryString["catid"].ToInt();

        //Nếu có lọc theo catid
        if (catID > 0)
        {
            DropDownList_Category.SelectedValue = catID.ToSafetyString();
            query = query.Where(x => x.ContactCategoryID == catID);
        }

        ////Lấy title
        string title = Request.QueryString["title"].ToSafetyString();

        //Nếu có lọc theo title
        if (title != string.Empty)
        {
            input_Title.Value = title;
            query = query.Where(x => x.FullName.Contains(title) || x.Email.Contains(title));
        }


        //Phân trang dữ liệu
        int totalItems = query.Count();
        int maxPage = 10;
        int pageSize = 10;
        int currentPage = Request.QueryString["page"].ToInt();
        if (currentPage == 0)
            currentPage = 1;
        string url = "~/Admin/ContactList.aspx?page={0}&catid={1}&title={2}";
        url = url.StringFormat("{0}", catID, title);

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

        //Nếu không có dữ liệu, thì hiện thông báo rỗng
        if (totalItems <= 0)
            tr_DataEmpty.Visible = true;

        //Hiện thị thông báo từ lần trước
        ShowPreviousMessage();
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

    public void LoadCategoryData()
    {
        //Kết nối db
        DBEntities db = new DBEntities();

        //Query dữ liệu
        var query = db.ContactCategory.Select(x => new { x.ContactCategoryID, x.Title });

        //Lấy danh sách dữ liệu theo câu query
        var data = query.ToList();

        //Cấu hình hiển thị
        DropDownList_Category.DataValueField = "ContactCategoryID";
        DropDownList_Category.DataTextField = "Title";

        //Đỗ dữ liệu
        DropDownList_Category.DataSource = data;

        //Hiện thị
        DropDownList_Category.DataBind();

        //Tạo thêm item mặc định
        ListItem item = new ListItem();
        item.Value = string.Empty;
        item.Text = ".:Chọn loại tài khoản :.";

        //Chèn item mặc định vào đầu danh sách Dropdown
        DropDownList_Category.Items.Insert(0, item);
    }

    public void SearchData(string type = "", string message = "")
    {
        //Lấy các giá trị tìm kiếm
        string catID = DropDownList_Category.SelectedValue;
        string title = input_Title.Value.Trim();

        //Tạo url trang hiện tại kèm theo điều kiện search
        string url = "~/Admin/ContactList.aspx?catid={0}&title={1}&messagetype={2}&message={3}";
        url = url.StringFormat(catID, title, type, message);

        //Chuyển về trang đích'
        Response.Redirect(url);
    }

    protected void DropDownList_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void LinkButton_Search_Click(object sender, EventArgs e)
    {
        SearchData();
    }

    protected void LinkButton_ClearSearch_Click(object sender, EventArgs e)
    {
        //Xóa ạch các tiêu chí search
        DropDownList_Category.SelectedIndex = 0;
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
        var item = db.Contact.Where(x => x.ContactID == ID).FirstOrDefault();

        //kiểm tra item không tồn tại thì báo lỗi
        if (item == null)
        {
            SearchData("error", "Dữ liệu này đã không còn tồn tại");
            return;
        }

        //Kiểm tra quyền có đủ để thự hiện hay không
        if (SessionUtility.AdminCategoryID != "SupperAdmin")
        {
            ucMessage.ShowError("Bạn không đủ quyền để xóa tài khoản. hãy liện hệ Administrator");
            return;
        }

        //xóa khỏi db
        db.Contact.Remove(item);

        //Lưu DB
        db.SaveChanges();

        //Load lại trang
        SearchData("success", "Đã xóa dữ liệu");
        return;


    }

    protected void LinkButton_Active_Click(object sender, EventArgs e)
    {
        //Ép kiểu sender thành linkbutton
        LinkButton linkButton_Active = sender as LinkButton;

        //Bóc tách ID từ LinhButton  ra
        int ID = linkButton_Active.CommandArgument.ToInt();

        //Kết nối db
        DBEntities db = new DBEntities();

        //Kiểm tra không cho phép khóa chính admin hiện tại

        //Vào bảng Contact, tìm 1 ID phù hợp
        var item = db.Contact.Where(x => x.ContactID == ID).FirstOrDefault();

        //Nếu như k có item phù hợp, thì kết thúc
        if (item == null)
        {
            SearchData("error", "Tài khoản không còn tồn tại");
            return;
        }

        //Cập nhật giá trị status mới

        //////if (item.Status == true)
        //////    item.Status = false;
        //////else
        //////    item.Status = true;

        ////item.Status = (item.Status == true ? false : true);

        item.Status = !item.Status;
        item.ApproveBy = SessionUtility.AdminUsername;
        //Lưu DB, nếu Lưu không thì báo lỗi rồi kết thúc
        try
        {
            db.SaveChanges();
        }
        catch (Exception ex)
        {
            ucMessage.ShowError("Chưa lưu được, vui lòng thử lại");
            return;
        }

        //Load lại dữ liệu với các tiêu chí search
        SearchData("success", "Đã cập nhật trạng thái");
        return;

    }
}