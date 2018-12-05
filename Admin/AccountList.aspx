<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="AccountList.aspx.cs" Inherits="Admin_AccountList" %>

<%@ Register Src="~/Admin/UserControl/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>
<%@ Register Src="~/Admin/UserControl/ucPagging.ascx" TagPrefix="uc1" TagName="ucPagging" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Quản lí danh sách tài khoản
    </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="content">
        <div class="breadLine">
            <ul class="breadcrumb">
                <!--Nút ẩn/hiện menu bên góc trái-->
                <li>
                    <a href="#" title="Ẩn thanh menu" class="sidebarControl menu-arrow">
                        <span class="icon-arrow-left"></span>
                    </a>
                </li>
                <!--Thanh breadcrumb-->
                <li>
                    <a runat="server" href="Default.aspx">Bàn Làm Việc</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a runat="server" href="AccountCategoryList.aspx">Loại Tài Khoản</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a runat="server" href="AccountList.aspx">Danh Sách Tài Khoản</a>
                </li>
            </ul>
        </div>
        <div class="workplace">
            <div class="page-header">
                <h1>Quản lý tài khoản
                </h1>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <uc1:ucMessage runat="server" ID="ucMessage" />
                    <div class="head clearfix">
                        <div class="isw-users">
                        </div>
                        <h1>Danh sách tài khoản
                        </h1>
                        <ul class="buttons">
                            <li>
                                <a runat="server" href="AccountEdit.aspx" class="isw-plus tip" title="Thêm mới"></a>
                            </li>
                            <li>
                                <a href="javascript:alert('Tính Năng đang được phát triển')" class="isw-delete tip" title="Xóa chọn"></a>
                            </li>
                        </ul>
                    </div>
                    <div class="block-fluid table-sorting clearfix">
                        <!--Filter-->
                        <div class="dataTables_filter">
                            <asp:Panel runat="server" ID="Panel_Search" DefaultButton="LinkButton_Search" class="input-append">
                                <asp:DropDownList runat="server" ID="DropDownList_Category"
                                    OnSelectedIndexChanged="DropDownList_Category_SelectedIndexChanged"
                                    AutoPostBack="true"
                                    Style="margin-right: 10px; border-radius: 4px;" />

                                <input runat="server" id="input_Title"
                                    type="text" placeholder="Lọc theo: tên đăng nhập, họ tên, email hoặc SĐT" style="width: 350px" />

                                <asp:LinkButton runat="server" ID="LinkButton_Search" OnClick="LinkButton_Search_Click"
                                    class="btn mybtn input-icon link-search" Style="width: 16px;">
                                     <i class="isw-zoom"></i>&nbsp;
                                </asp:LinkButton>
                            </asp:Panel>
                        </div>

                        <div class="dataTables_length">
                            <asp:LinkButton runat="server" ID="LinkButton_ClearSearch" OnClick="LinkButton_ClearSearch_Click"
                                class="btn input-icon" Style="width: 80px;">
                                <i class="isw-cancel"></i>Hủy bộ lọc
                            </asp:LinkButton>
                        </div>
                        <!--Content-->
                        <table cellpadding="0" cellspacing="0" width="100%" class="table listAccounts">
                            <tbody>
                                <asp:Repeater runat="server" ID="Repeater_Main">
                                    <ItemTemplate>
                                        <tr>
                                            <td width="102">
                                                <a runat="server" href='<%# Eval("Avatar") %>' class="fancybox lightbox-preview" rel="group" title=<%# Eval("FullName") %>>
                                                    <img runat="server" src='<%# Eval("Avatar") %>' alt="avatar" style="width: 92px; height: 92px; margin-bottom: 2px;" class='<%#Eval("ID", "default-image img-polaroid avatar-preview-{0}") %>' title='<%# Eval("FullName") %>' />
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
                                            <td width="250">
                                                <a href="#" class="account">
                                                    <%# Eval("FullName") %>
                                                </a>
                                                <p class="about">
                                                    <span class="tip icon-user" title="Username"></span>
                                                    <%#Eval("ID") %>
                                                    <br />
                                                    <span class="tip icon-envelope" title="Email"></span>
                                                    <%#Eval("Email") %>
                                                    <br />
                                                    <span class="tip icon-time" title="Ngày khởi tạo tài khoản"></span>
                                                    <%#Eval("CreateTime") %>
                                                    <br />
                                                    <span class="tip icon-bell" title="Số điện thoại"></span>
                                                    <%#Eval("Mobi") %>
                                                    <br />
                                                    <span class="tip icon-adjust" title="Phái"></span>
                                                    <%#Eval("Gender").ToBool()== true ? "Nam":"Nữ" %>
                                                    <br />
                                                </p>
                                            </td>
                                            <td>
                                                <p class="about">
                                                    <span class="tip icon-warning-sign" title="Vai trò"></span>
                                                    <%#Eval("AccountCategoryID") %>
                                                    <br />
                                                    <span class="tip icon-home" title="Địa chỉ"></span>
                                                    <%#Eval("Address") %>
                                                </p>
                                            </td>
                                            <td width="200" class="function">
                                                <p class="info">
                                                    <a class="btn btn-small btn-block block tip" runat="server" href='<%# Eval("ID","ChangePassword.aspx?id={0}&backurl=AccountList.aspx") %>'>
                                                        <span class="icon-refresh icon-white"></span>Đổi mật khẩu mới
                                                    </a>

                                                    <a class="btn btn-small btn-block block tip" runat="server"
                                                        href='<%# Eval("ID","AccountEdit.aspx?id={0}") %>'>
                                                        <span class="icon-edit icon-white"></span>Chỉnh sửa thông tin
                                                    </a>

                                                    <asp:LinkButton runat="server" ID="LinkButton_Delete" OnClick="LinkButton_Delete_Click"
                                                        CommandArgument='<%# Eval("ID") %>'
                                                        OnClientClick="return confirm('Bạn có chắc muốn xóa không?');"
                                                        class="btn btn-small btn-block block tip">
                                                         <span class="icon-trash icon-white"></span>
                                                            Xóa dữ liệu này
                                                    </asp:LinkButton>

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

