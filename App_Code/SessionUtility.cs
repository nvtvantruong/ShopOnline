using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CodeUtility;

public class SessionUtility
{
    public static Client Client
    {
        get
        {
            return HttpContext.Current.Session["Client"] as Client;
        }
        set
        {
            HttpContext.Current.Session["Client"] = value;
        }
    }

    public static Cart Cart
    {
        get
        {
            //Lazzy load giỏ hàng
            if (HttpContext.Current.Session["Cart"] == null)
                HttpContext.Current.Session["Cart"] = new Cart();

            return HttpContext.Current.Session["Cart"] as Cart;
        }
    }

    public static string AdminUsername
    {
        get
        {
            return HttpContext.Current.Session["AdminUsername"].ToSafetyString();
        }
        set
        {
            HttpContext.Current.Session["AdminUsername"] = value;
        }
    }

    public static string AdminFullname
    {
        get
        {
            return HttpContext.Current.Session["AdminFullName"].ToSafetyString();
        }
        set
        {
            HttpContext.Current.Session["AdminFullName"] = value;
        }
    }

    public static string AdminAvatar
    {
        get
        {
            return HttpContext.Current.Session["AdminAvatar"].ToSafetyString();
        }
        set
        {
            HttpContext.Current.Session["AdminAvatar"] = value;
        }
    }

    public static string AdminCategoryID
    {
        get
        {
            return HttpContext.Current.Session["AdminCategoryID"].ToSafetyString();
        }
        set
        {
            HttpContext.Current.Session["AdminCategoryID"] = value;
        }
    }
}