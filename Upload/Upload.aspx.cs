using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && FileUpload1.HasFile && CheckFileType(FileUpload1.FileName))
        {
            string fileName = "images/" +DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") +FileUpload1.FileName;
            string filePath = MapPath(fileName);
            FileUpload1.SaveAs(filePath);
            Image1.ImageUrl = fileName;
        }
    }
    bool CheckFileType(string fileName)
    {

        string ext = Path.GetExtension(fileName);
        switch (ext.ToLower())
        {
            case ".gif":
                return true;
            case ".png":
                return true;
            case ".jpg":
                return true;
            case ".jpeg":
                return true;
            default:
                return false;
        }
    }
}