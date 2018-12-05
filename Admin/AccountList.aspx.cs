using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CodeUtility;
using System.IO;

public partial class Admin_AccountList : System.Web.UI.Page
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
        //////var query = from a in db.Account
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
        //////                a.AccountCategoryID,
        //////                a.Address,
        //////                a.Status
        //////            };

        var query = db.Account.OrderBy(x => x.Username).Select(x => new
        {
            ID = x.Username,
            x.Avatar,
            x.FullName,
            x.Email,
            x.CreateTime,
            x.Mobi,
            x.Gender,
            x.AccountCategoryID,
            x.Address,
            x.Status
        });

        //Lấy các tiêu trí search
        ////Lấy catid
        string catID = Request.QueryString["catid"].ToSafetyString();

        //Nếu có lọc theo catid
        if (catID != string.Empty)
        {
            DropDownList_Category.SelectedValue = catID;
            query = query.Where(x => x.AccountCategoryID == catID);
        }

        ////Lấy title
        string title = Request.QueryString["title"].ToSafetyString();

        //Nếu có lọc theo title
        if (title != string.Empty)
        {

            input_Title.Value = title;
            query = query.Where(x => x.ID.Contains(title) || x.Mobi.Contains(title) || x.FullName.Contains(title) || x.Email.Contains(title));
        }


        //Phân trang dữ liệu
        int totalItems = query.Count();
        int maxPage = 10;
        int pageSize = 2;
        int currentPage = Request.QueryString["page"].ToInt();
        if (currentPage == 0)
            currentPage = 1;
        string url = "~/Admin/AccountList.aspx?page={0}&catid={1}&title={2}";
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
        var query = db.AccountCategory.Select(x => new { x.AccountCategoryID, x.Title });

        //Lấy danh sách dữ liệu theo câu query
        var data = query.ToList();

        //Cấu hình hiển thị
        DropDownList_Category.DataValueField = "AccountCategoryID";
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
        string url = "~/Admin/AccountList.aspx?catid={0}&title={1}&messagetype={2}&message={3}";
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

    protected void LinkButton_SaveAvatar_Click(object sender, EventArgs e)
    {
        //Ép kiểu sender về dạng LinkButton
        LinkButton LinkButton_SaveAvatar = sender as LinkButton;

        //Lấy id của tài khoản cần đổi hình
        string ID = LinkButton_SaveAvatar.CommandArgument.ToSafetyString();

        //Tìm 1 tài khoản có id như trên
        DBEntities db = new DBEntities();
        var item = db.Account.Where(x => x.Username == ID).FirstOrDefault();

        //Nếu không tìm thấy, thì load lạis dữ liệu
        if (item == null)
        {
            SearchData("error", "Tài khoản đổi hình không còn tồn tại");
            return;
        }

        //Upload hình ảnh lên Server
        FileUpload fileUpload_Avatar = LinkButton_SaveAvatar.NamingContainer.FindControl("FileUpload_Avatar") as FileUpload;

        //Kiểm tra đuôi hình hợp lệ
        string validExtension = ".jpg.jpeg.png.gif.bmp.ico";
        string fileExtension = Path.GetExtension(fileUpload_Avatar.FileName.ToLower());
        if (!validExtension.Contains(fileExtension))
        {
            ucMessage.ShowError("Hình không hợp lệ, loại hình hổ trợ: .jpg, .jpeg, .png, .gif, .bmp, .ico");
            return;
        }


        //Kiểm tra dung lượng file <= 3MB
        int validSize = 1024 * 1024 * 3;
        int fileSize = fileUpload_Avatar.FileBytes.Length;
        if (fileSize > validSize)
        {
            ucMessage.ShowError("Dung lượng hình <= 3MB");
            return;
        }

        Exception error = null;
        string avatar = string.Empty;
        string thumb = string.Empty;
        UploadUtility UploadUtility = new UploadUtility();
        UploadUtility.FileUpload = fileUpload_Avatar;
        UploadUtility.FolderSave = "~/FileUploads/Account";
        UploadUtility.FullMaxWidth = 1000;
        UploadUtility.ThumbMaxWidth = 400;
        UploadUtility.MaxFileSize = 1024 * 1024 * 3;
        UploadUtility.AutoGenerateFileName = true;
        UploadUtility.UploadImage(ref avatar, ref thumb, ref error);

        //Kiểm tra , nếu có khi upload thì kết thúc
        if (error != null || avatar == string.Empty)
        {
            SearchData("error", "Chưa upload được hình");
            return;
        }

        //Cập nhật link mới vào tài khoản kể trên
        item.Avatar = avatar;
        item.Thumb = thumb;

        //Lưu lại
        db.SaveChanges();

        //Load lại dữ liệu để thấy hình được thay mới.
        SearchData("success", "Đã đổi hình thành công");
        return;
    }

    protected void LinkButton_Delete_Click(object sender, EventArgs e)
    {
        //Ép kiểu seder thành linkButton
        LinkButton LinkButton_Delete = sender as LinkButton;

        //Bóc tách lấy ID của nó
        string ID = LinkButton_Delete.CommandArgument.ToSafetyString();

        //Kiểm tra không cho phép xóa chính admin hiện tại
        if (ID == SessionUtility.AdminUsername)
        {
            ucMessage.ShowWarning("Bạn không thể xóa chính mình");
            return;
        }

        //Kết nối DB
        DBEntities db = new DBEntities();

        //Tìm 1 item phù hợp
        var item = db.Account.Where(x => x.Username == ID).FirstOrDefault();

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
        db.Account.Remove(item);

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
        String ID = linkButton_Active.CommandArgument.ToSafetyString();

        //Kết nối db
        DBEntities db = new DBEntities();

        //Kiểm tra không cho phép khóa chính admin hiện tại
        if (ID == SessionUtility.AdminUsername)
        {
            ucMessage.ShowWarning("Bạn không thể khóa chính mình");
            return;
        }

        //Vào bảng account, tìm 1 ID phù hợp
        var item = db.Account.Where(x => x.Username == ID).FirstOrDefault();

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