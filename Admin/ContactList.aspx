<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ContactList.aspx.cs" Inherits="Admin_ContactList" %>

<%@ Register Src="~/Admin/UserControl/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>
<%@ Register Src="~/Admin/UserControl/ucPagging.ascx" TagPrefix="uc1" TagName="ucPagging" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                    <a href="Default.html">Bàn Làm Việc</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="#">Danh sách thư liên hệ</a>
                </li>
            </ul>
        </div>

        <div class="workplace">
            <div class="page-header">
                <h1>Danh sách thư liên hệ
                </h1>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <uc1:ucMessage runat="server" ID="ucMessage" />
                    <div class="head clearfix">
                        <div class="isw-grid">
                        </div>
                        <h1>Danh sách thư liên hệ
                        </h1>
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
                        <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tPagging">
                            <thead>
                                <tr>
                                    <th width="25px" class="center">
                                        <input type="checkbox" name="checkall" />
                                    </th>
                                    <th width="60px" class="center">Trạng thái
                                    </th>
                                    <th>Nội dung liên hệ / Địa chỉ người liên hệ
                                    </th>
                                    <th width="70px" class="center">Ngày liên hệ
                                    </th>
                                    <th width="100px" class="center">Thông tin liên hệ
                                    </th>
                                    <th width="70px" class="center">Người duyệt
                                    </th>
                                    <th width="200px" class="center">Cập nhật trạng thái / Xóa
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
                                            <td class="center middle">
                                                <img runat="server" src='<%# Eval("Status").ToBool() == true ? "/admin/css/img/read-mail.png" : "/admin/css/img/new-mail.png" %>'>
                                            </td>
                                            <td class="middle">Mã thư liên hệ: <b>
                                                <%# Eval("ID") %></b>
                                                <br>
                                                Nội dung liên hệ:
                                                <b><%# Eval("Content") %></b>
                                                <br>
                                                Địa chỉ khách liên hệ: <b>
                                                    <%# Eval("Address") %></b>
                                            </td>
                                            <td class="center middle">
                                                <%# Eval("CreateTime", "{0:dd/MM/yyyy <br /> HH:mm:ss}") %>
                                            </td>
                                            <td class="center middle"><%# Eval("FullName") %>
                                                <br />
                                                <%#Eval("Mobi") %>
                                                <br />
                                                <%# Eval("Email") %>
                                            </td>
                                            <td class="center middle">
                                                <%# Eval("ApproveBy") %></td>
                                            <td width="200" class="center middle function">
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
                                                       <%# Eval("Status").ToBool() == true ? "Thư đã duyệt, đánh dấu lại" : "Thư chưa duyệt, đánh dấu lại" %>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <!--Chưa có dữ liệu-->
                                <tr runat="server" id="tr_DataEmpty" visible="false">
                                    <td colspan="7">
                                        <center>Chưa có dữ liệu</center>
                                    </td>
                                </tr>

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

