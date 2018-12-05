<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucMenu.ascx.cs" Inherits="ucMenu" %>
<%@ Register Src="~/Admin/UserControl/ucInfo.ascx" TagPrefix="uc1" TagName="ucInfo" %>


<div class="menu">
    <%--ucInfo--%>
    <uc1:ucInfo runat="server" ID="ucInfo" />

    <ul class="navigation">
        <!--Dasboard-->
        <li class="active">
            <a runat="server" href="~/Admin/Default.aspx">
                <span class="isw-grid"></span>
                <span class="text">Bàn Làm Việc</span>
            </a>
            <div class="dr"><span></span></div>
        </li>

        <!--AccountCategory-->
        <li>
            <a runat="server" href="~/Admin/AccountCategoryList.aspx">
                <span class="isw-archive"></span>
                <span class="text">Loại Tài Khoản</span>
            </a>
        </li>

        <!--Account-->
        <li>
            <a runat="server" href="~/Admin/AccountList.aspx">
                <span class="isw-users"></span>
                <span class="text">Tài Khoản</span>
            </a>
            <div class="dr"><span></span></div>
        </li>

        <!--ArticleMainCategory-->
        <li>
            <a runat="server" href="~/Admin/ProductMainCategoryList.aspx">
                <span class="isw-folder"></span>
                <span class="text">Loại Sản Phẩm - Cấp Cha</span>
            </a>
        </li>
        <!--ProductCategory-->
        <li>
            <a runat="server" href="~/Admin/ProductCategoryList.aspx">
                <span class="isw-archive"></span>
                <span class="text">Loại Sản Phẩm - Cấp Con</span>
            </a>
        </li>
        <!--Product-->
        <li>
            <a runat="server" href="~/Admin/ProductList.aspx">
                <span class="isw-documents"></span>
                <span class="text">Sản Phẩm</span>
            </a>
            <div class="dr"><span></span></div>
        </li>

        <!--ArticleMainCategory-->
        <li>
            <a runat="server" href="~/Admin/ArticleMainCategoryList.aspx">
                <span class="isw-folder"></span>
                <span class="text">Loại Tin Tức - Cấp Cha</span>
            </a>
        </li>
        <!--ArticleCategory-->
        <li>
            <a runat="server" href="~/Admin/ArticleCategoryList.aspx">
                <span class="isw-archive"></span>
                <span class="text">Loại Tin Tức - Cấp Con</span>
            </a>
        </li>
        <!--Article-->
        <li>
            <a runat="server" href="~/Admin/ArticleList.aspx">
                <span class="isw-documents"></span>
                <span class="text">Tin Tức</span>
            </a>
            <div class="dr"><span></span></div>
        </li>

        <!--PictureMainCategory-->
        <li>
            <a runat="server" href="~/Admin/PictureMainCategoryList.aspx">
                <span class="isw-folder"></span>
                <span class="text">Loại Hình Ảnh - Cấp Cha</span>
            </a>
        </li>
        <!--PictureCategory-->
        <li>
            <a runat="server" href="~/Admin/PictureCategoryList.aspx">
                <span class="isw-archive"></span>
                <span class="text">Loại Hình Ảnh - Cấp Con</span>
            </a>
        </li>

        <!--Picture-->
        <li>
            <a runat="server" href="~/Admin/PictureList.aspx">
                <span class="isw-picture"></span>
                <span class="text">Hình Ảnh</span>
            </a>
            <div class="dr"><span></span></div>
        </li>

        <!--ContactCategory-->
        <li>
            <a runat="server" href="~/Admin/ContactCategoryList.aspx">
                <span class="isw-archive"></span>
                <span class="text">Loại Thư Liên Hệ</span>
            </a>
        </li>

        <!--Contact-->
        <li>
            <a runat="server" href="~/Admin/ContactList.aspx">
                <span class="isw-mail"></span>
                <span class="text">Thư Liên Hệ</span>
            </a>
            <div class="dr"><span></span></div>
        </li>
    </ul>
</div>
