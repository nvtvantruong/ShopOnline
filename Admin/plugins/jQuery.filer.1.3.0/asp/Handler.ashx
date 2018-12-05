<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using CodeUtility;
using System.IO;
public class Handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.Clear();
        context.Response.ContentType = "text/plain";

        if (context.Request.Files.Count == 0)
        {
            return;
        }

        HttpPostedFile PostedFile = context.Request.Files[0];
        string folder = context.Request.QueryString["folder"].ToSafetyString();
        if (folder == string.Empty)
            folder = "/fileuploads/ImageList/";

        if (!folder.EndsWith("/"))
            folder += "/";

        FolderUtility.CreateFolder(context.Server.MapPath(folder));

        string FileName = folder + Guid.NewGuid().Replace("-", string.Empty, SensitiveCaseMode.IgnoreCase) + Path.GetExtension(PostedFile.FileName);
        try
        {
            PostedFile.SaveAs(context.Server.MapPath(FileName));
            context.Response.Write(FileName);
            return;
        }
        catch (Exception error)
        {
            string mess = error.Message;
            context.Response.ContentType = "text/plain";
            context.Response.Write("error");
            throw error;
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}