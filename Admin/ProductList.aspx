<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ProductList.aspx.cs" Inherits="Admin_ProductList" %>

<%@ Register Src="~/Admin/UserControl/ucPagging.ascx" TagPrefix="uc1" TagName="ucPagging" %>
<%@ Register Src="~/Admin/UserControl/ucMenu.ascx" TagPrefix="uc1" TagName="ucMenu" %>
<%@ Register Src="~/Admin/UserControl/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Quản Lý danh sách Sản Phẩm</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="content">

        <div class="breadLine">
            <ul class="breadcrumb">
                <!--Nút ẩn/hiện menmu bên góc trái-->
                <li>
                    <a href="#" title="Ẩn thanh menu" class="sidebarControl menu-arrow">
                        <span class="icon-arrow-left"></span>
                    </a>
                </li>
                <!--Thanh breadcrumb-->
                <li>
                    <a href="Default.aspx">Bàn Làm Việc</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="ProductMainCategoryList.aspx">Danh mục sản phẩm (cấp cha)</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="ProductCategoryList.aspx">Danh mục sản phẩm (cấp con)</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="ProductList.aspx">Danh Sách Sản Phẩm</a>
                </li>
            </ul>
        </div>

        <div class="workplace">
            <div class="page-header">
                <h1>Danh sách sản phẩm
                </h1>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <uc1:ucMessage runat="server" ID="ucMessage" />
                    <div class="head clearfix">
                        <div class="isw-grid">
                        </div>
                        <h1>Danh sách sản phẩm
                        </h1>
                        <ul class="buttons">
                            <li><a href="ProductEdit.aspx" class="isw-plus tip" title="Thêm mới"></a></li>
                            <li><a href="#" class="isw-delete tip" title="Xóa chọn" onclick="alert('Chức năng xóa hàng loạt này hiện chưa có.')"></a></li>
                        </ul>
                    </div>
                    <div class="block-fluid table-sorting clearfix">
                        <!--Filter-->
                        <div class="dataTables_filter">
                            <asp:Panel runat="server" DefaultButton="LinkButton_Search" class="input-append">
                                <asp:DropDownList runat="server" ID="DropDownList_Category"
                                    AutoPostBack="true"
                                    OnSelectedIndexChanged="DropDownList_Category_SelectedIndexChanged"
                                    Style="margin-right: 10px; border-radius: 4px;">
                                </asp:DropDownList>
                                <input runat="server" id="input_Title" type="text" placeholder="Lọc theo tiêu đề (tiếng Việt có dấu)" style="width: 250px" />

                                <asp:LinkButton runat="server" ID="LinkButton_Search" OnClick="LinkButton_Search_Click" class="btn mybtn input-icon link-search" Style="width: 16px;">
                                    <i class="isw-zoom"></i>&nbsp;
                                </asp:LinkButton>

                            </asp:Panel>
                        </div>

                        <div class="dataTables_length">
                            <asp:LinkButton runat="server" ID="LinkButton_ClearSearch" OnClick="LinkButton_ClearSearch_Click" class="btn input-icon" Style="width: 80px;">
                                <i class="isw-cancel"></i>
                                Hủy bộ lọc
                            </asp:LinkButton>
                        </div>

                        <!--Content-->
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tPagging">
                            <thead>
                                <tr>
                                    <th width="25px" class="center">
                                        <input type="checkbox" name="checkall" />
                                    </th>
                                    <th width="50px" class="center">Hình
                                    </th>
                                    <th width="50px" class="center">Mã số
                                    </th>
                                    <th>Tiêu đề / Lượt xem / Loại / Mô tả
                                    </th>
                                    <th width="100px" class="center">Người đăng /Ngày
                                    </th>
                                    <th width="200px" class="center">Xem / Xóa / Sửa
                                    </th>
                                </tr>
                            </thead>
                            <tbody>

                                <asp:Repeater ID="Repeater_Main" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="center middle">
                                                <input type="checkbox" name="checkbox" />
                                            </td>
                                            <td width="102" class="center middle avatar">
                                                <a runat="server" href='<%# Eval("Avatar") %>' class="fancybox lightbox-preview" rel="group" title='<%# Eval("Title") %>'>
                                                    <img runat="server" src='<%# Eval("Avatar") %>' alt="avatar" style="width: 92px; height: 92px; margin-bottom: 2px;" class='<%#Eval("ID", "default-image img-polaroid avatar-preview-{0}") %>' title='<%# Eval("Title") %>' />
                                                </a>
                                                <div class="btn-group">
                                                    <button class="btn btn-small btn-success btn-file" style="width: 102px; cursor: pointer;">
                                                        <span class="icon-camera icon-white"></span>Thay hình
                                                        <asp:FileUpload runat="server" ID="FileUpload_Avatar"
                                                            class="skip" preview='<%#Eval("ID", "avatar-preview-{0}") %>' />
                                                    </button>
                                                </div>
                                                <div class="btn-group none-margin hide save-cancel-function">
                                                    <asp:LinkButton runat="server" ID="LinkButton_SaveAvatar"
                                                        OnClick="LinkButton_SaveAvatar_Click"
                                                        CommandArgument='<%# Eval("ID") %>'
                                                        title="Lưu hình" class="btn btn-warning tip save">
                                                        <i class="isw-save"></i>
                                                    </asp:LinkButton>

                                                    <button class="btn btn-inverse tip cancel" title="Hủy lệnh">
                                                        <i class="isw-cancel"></i>
                                                    </button>
                                                </div>
                                            </td>
                                            <td class="center middle"><%# Eval("ID") %>
                                            </td>
                                            <td class="middle">
                                                <h4><%#Eval("Title") %>
                                                    (<%#Eval("ViewTime") %> lượt xem)
                                                </h4>
                                                <p>Loại: <b><%# Eval("CatTitle") %></b></p>
                                                <p align="justify">
                                                    <%# Eval("Description") %>
                                                </p>
                                            </td>
                                            <td class="center middle"><%# Eval("CreateBy") %><br />
                                                <br />
                                                <%# Eval("CreateTime","{0:dd/MM/yyyy <br /> HH:mm:ss}") %>
                                            </td>
                                            <td class="center middle function">
                                                <p class="info">
                                                    <%--Xem chi tiết--%>
                                                    <a  runat="server" title='<%# Eval("Title") %>' class="btn btn-small btn-block block tip fancybox-iframe" href='<%#Eval("ID","ProductDetail.aspx?id={0}") %>'>
                                                        <span class="icon-zoom-in icon-white"></span>Hiển thị chi tiết
                                                    </a>
                                                    <%-- Chỉnh sửa --%>
                                                    <a class="btn btn-small btn-block block tip" runat="server"
                                                        href='<%# Eval("ID","ProductEdit.aspx?id={0}") %>'>
                                                        <span class="icon-edit icon-white"></span>Chỉnh sửa thông tin
                                                    </a>
                                                    <%-- xóa --%>
                                                    <asp:LinkButton runat="server" ID="LinkButton_Delete" OnClick="LinkButton_Delete_Click"
                                                        CommandArgument='<%# Eval("ID") %>'
                                                        OnClientClick="return confirm('Bạn có chắc muốn xóa không?');"
                                                        class="btn btn-small btn-block block tip">
                                                         <span class="icon-trash icon-white"></span>
                                                            Xóa dữ liệu này
                                                    </asp:LinkButton>
                                                    <%-- Kích hoạt --%>
                                                    <asp:LinkButton runat="server" ID="LinkButton_Active"
                                                        OnClick="LinkButton_Active_Click"
                                                        CommandArgument='<%# Eval("ID") %>'
                                                        class='<%# Eval("Status").ToBool() == true ? "btn btn-small btn-success tip" : "btn btn-small btn-warning tip" %>'>
                                                        <span class='<%# Eval("Status").ToBool() == true ? "icon-ok icon-white" : "icon-lock icon-white" %>'></span>
                                                       <%# Eval("Status").ToBool() == true ? " Đang kích hoạt, Tạm khóa lại" : "Đang tạm khóa, kích hoạt lại" %>
                                                    </asp:LinkButton>
                                                </p>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <!--Pagging-->
                        <uc1:ucPagging runat="server" ID="ucPagging" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="Server">
</asp:Content>

