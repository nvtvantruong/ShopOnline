using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Hosting;
using System.Drawing;
using CodeUtility;

public partial class TinymceMyUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            SaveFile();
        }
    }

    public static bool UploadImage(FileUpload fileUpload, string folderUpload, ref string avatar, ref int width, ref int height, ref Exception error)
    {
        //1. Lấy tên file đã chọn
        string fileName = fileUpload.FileName;

        //2. Nếu tên file = rỗng, thì trả về false
        if (fileName == string.Empty)
        {
            return false;
        }

        //3. Kiểm tra đuôi hình, nếu không hợp lệ thì báo lỗi
        if (!fileName.IsImageFileUrl())
        {
            error = new Exception("Vui lòng chọn hình có đuôi trong danh sách: .jpg.jpeg.gif.bmp.png");
            return false;
        }

        //4. Kiểm tra dung lượng file, nếu vượt quá 3Mb thì báo lỗi
        if (fileUpload.PostedFile.ContentLength > 3 * 1024 * 1024)
        {
            error = new Exception("Vui lòng chọn file <= 3Mb");
            return false;
        }

        //Cấu hình upload
        UploadUtility upload = new UploadUtility();
        upload.FileUpload = fileUpload;
        upload.FolderSave = folderUpload;
        upload.FullMaxWidth = 1000;
        upload.ThumbMaxWidth = 400;
        upload.MaxFileSize = 3 * 1024 * 1024;
        upload.AutoGenerateFileName = true;

        string thumb = string.Empty;

        //Upload và bắt lỗi nếu có
        upload.UploadImage(ref avatar, ref thumb, ref error);

        //Nếu có lỗi upload, thì trả về false
        if (error != null)
            return false;

        //9 Convert url sang đường dẫn vật lý
        string physicalUrl = HostingEnvironment.MapPath(avatar);

        //10. Save hình lên Server
        try
        {
            //10.1 Tạo hình từ FileUpload
            Bitmap bitmap = new Bitmap(physicalUrl);

            //10.4 Trả thông số ra ngoài
            width = bitmap.Width;
            height = bitmap.Height;

        }
        //Bắt lỗi lưu vào ex (nếu có)
        catch (Exception ex)
        {
            //Xuất lỗi bắt được (ex) ra ngoài theo biến (error)
            error = ex;
            return false;
        }

        //11. Trả về true sau khi đã upload hình thành công
        return true;
    }

    private void SaveFile()
    {
        Exception error = null;
        string folder = Request.QueryString["folder"].ToSafetyString().ToUrlDecode();
        if (folder == string.Empty)
            folder = "~/FileUploads/Commons";

        string avatar = string.Empty;
        string thumb = string.Empty;
        int fileWidth = 0;
        int fileHeight = 0;

        UploadImage(file_Upload, folder, ref avatar, ref fileWidth, ref fileHeight, ref error);

        //3.4 Nếu có lỗi trong quá trình upload hình thì báo lỗi + kết thúc
        if (error != null)
        {
            string script = string.Format("<script>alert('{0}')</script>", error.Message);
            Page.ClientScript.RegisterStartupScript(this.GetType(), DateTime.Now.ToString("dd/MM/yyyyHHmmss"), script);
            return;
        }

        input_width.Value = fileWidth.ToString();
        input_height.Value = fileHeight.ToString();
        img_Preview.Src = avatar.Replace("../", string.Empty);
     }
}