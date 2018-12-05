<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="OrderList.aspx.cs" Inherits="Admin_OrdertList" %>

<%@ Register Src="~/Admin/UserControl/ucPagging.ascx" TagPrefix="uc1" TagName="ucPagging" %>
<%@ Register Src="~/Admin/UserControl/ucMenu.ascx" TagPrefix="uc1" TagName="ucMenu" %>
<%@ Register Src="~/Admin/UserControl/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>
<%@ Register Src="~/Admin/UserControl/ucInfo.ascx" TagPrefix="uc1" TagName="ucInfo" %>


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
                <h1>Quản lý danh sách đơn hàng
                </h1>
            </div>

            <div class="row-fluid">
                <div class="span12">
                    <uc1:ucMessage runat="server" ID="ucMessage" />
                    <div class="head clearfix">
                        <div class="isw-grid">
                        </div>
                        <h1>Quản lý danh sách đơn hàng
                        </h1>
                        <ul class="buttons">
                            <li>
                                <a href="ProductEdit.aspx" class="isw-plus tip" title="Thêm mới"></a>
                            </li>
                            <li>
                                <a href="#" class="isw-delete tip" title="Xóa chọn" onclick="alert('Chức năng xóa hàng loạt này hiện chưa có.')"></a>
                            </li>
                        </ul>
                    </div>
                    <div class="block-fluid table-sorting clearfix">
                        <!--Filter-->
                        <div class="dataTables_filter">
                            <asp:Panel runat="server" DefaultButton="LinkButton_Search" class="input-append">
                                <input type="text" runat="server" id="input_ID" placeholder="Lọc theo mã đơn hàng..."/>
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
                                    <th width="50px" class="center">Mã đơn hàng
                                    </th>
                                    <th>Thông tin khách mua hàng
                                    </th>
                                    <th class="center">Tổng tiền
                                    </th>
                                    <th>Trạng thái đơn hàng
                                    </th>
                                    <th class="center">Ngày lập
                                    </th>
                                    <th width="200px" class="center">Xem / Xóa
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
                                                <%# Eval("ID") %>
                                            </td>
                                            <td class="middle">
                                                Họ tên khách:  <%# Eval("FullName") %>
                                                <br />
                                                Email khách:  <%# Eval("Email") %>
                                                <br />
                                                SĐT khách:  <%# Eval("Mobi") %>
                                                <br />
                                                SĐT 2 khách:  <%# Eval("Mobi2") %>
                                                <br />
                                                Phái:  <%# Eval("Gender").ToBool() == true ? "Nam" : "Nữ" %>
                                                <br />
                                                Địa chỉ:  <%# Eval("Address") %>
                                                <br />
                                            </td>
                                            <td class="center middle">
                                                <%# Eval("Total", "{0:0,00đ}") %>
                                            </td>
                                            <td class="middle">
                                                Trạng thái đơn hàng:  <%# Eval("OrderStatus").ToBool() == true ? "Đã lập" : "Chưa lập" %>
                                                <br />
                                                Trạng thái giao hàng:  <%# Eval("DeliverStatus").ToBool() == true ? "Đã giao" : "Chưa giao" %>
                                                <br />
                                                Trạng thái thanh toán:  <%# Eval("ChargeStatus").ToBool() == true ? "Đã thanh toán" : "Chưa thanh toán" %>
                                            </td>
                                            <td class="center middle">
                                                <%# Eval("CreateTime", "{0:dd/MM/yyyy HH:mm:ss}") %>
                                            </td>
                                            <td class="center middle function">
                                                <p class="info">
                                                    <%--Xem chi tiết--%>
                                                    <a runat="server" title='<%# Eval("ID") %>' class="btn btn-small btn-block block tip fancybox-iframe" href='<%#Eval("ID","OrderDetail.aspx?id={0}") %>'>
                                                        <span class="icon-zoom-in icon-white"></span>Hiển thị chi tiết
                                                    </a>
                                                    <%-- xóa --%>
                                                    <asp:LinkButton runat="server" ID="LinkButton_Delete" OnClick="LinkButton_Delete_Click"
                                                        CommandArgument='<%# Eval("ID") %>'
                                                        OnClientClick="return confirm('Bạn có chắc muốn xóa không?');"
                                                        class="btn btn-small btn-block block tip">
                                                         <span class="icon-trash icon-white"></span>
                                                            Xóa dữ liệu này
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

