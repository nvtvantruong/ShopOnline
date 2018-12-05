<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderDetail.aspx.cs" Inherits="Admin_OrderDetail" %>

<%@ Register Src="~/Admin/UserControl/ucCSS.ascx" TagPrefix="uc1" TagName="ucCSS" %>
<%@ Register Src="~/Admin/UserControl/ucJS.ascx" TagPrefix="uc1" TagName="ucJS" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi tiết đơn hàng</title>
    <uc1:ucCSS runat="server" ID="ucCSS" />
    <style>
        .order-from input[type=text]{
            border: 2px dotted #808080;
            border-width: 0 0 2px 0;
            box-shadow: none;
            background-color: transparent!important;
            border-radius: 0;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="workplace">
            <!--Tiêu đề-->
            <div class="page-header">
                <h1>Thông tin hóa đơn
                </h1>
            </div>

            <div class="row-fluid">
                <div class="block-fluid customize accordion">
                    <h3>Thông tin hóa đơn
                    </h3>
                    <div class="article-basic-info order-from">
                        <!--Số hóa đơn-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                Số hóa đơn:
                            </div>
                            <div class="span10">
                                <input runat="server" id="input_ID" readonly="true" type="text" />
                            </div>
                        </div>
                        <!--Họ tên khách-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                Họ tên khách:
                            </div>
                            <div class="span10">
                                <input runat="server" id="input_FullName" readonly="true" type="text" />
                            </div>
                        </div>
                        <!--Email khách-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                Email khách:
                            </div>
                            <div class="span10">
                                <input runat="server" id="input_Email" readonly="true" type="text" />
                            </div>
                        </div>
                        <!--SĐT 2 khách hàng-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                SĐT 1 khách hàng:
                            </div>
                            <div class="span10">
                                <input runat="server" id="input_Mobi1" readonly="true" type="text" />
                            </div>
                        </div>
                        <!--SĐT 2 khách hàng-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                SĐT 2 khách hàng:
                            </div>
                            <div class="span10">
                                <input runat="server" id="input_Mobi2" readonly="true" type="text" />
                            </div>
                        </div>
                        <!--Địa chỉ-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                Địa chỉ:
                            </div>
                            <div class="span10">
                                <input runat="server" id="input_Address" readonly="true" type="text" />
                            </div>
                        </div>
                        <!--Trạng thái-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                Trạng thái:
                            </div>
                            <div class="span10">
                                <label class="checkbox inline">
                                    <input runat="server" id="radio_Order" disabled type="radio" />
                                    Đặt hàng
                                </label>
                                <label class="checkbox inline">
                                    <input runat="server" id="radio_Deliver" disabled type="radio" />
                                    Giao hàng
                                </label>
                                <label class="checkbox inline">
                                    <input runat="server" id="radio_Charge" disabled type="radio" />
                                    Thanh toán
                                </label>
                            </div>
                        </div>

                        <!--Chi tiết đơn hàng-->
                        <div class="row-form clearfix">
                            <div class="span2">
                                Chi tiết đơn hàng
                            </div>
                            <div class="span10">
                                <table cellpadding="0" cellspacing="0" width="100%" class="table" id="tPagging">
                                    <thead>
                                        <tr>
                                            <th class="center middle">STT
                                            </th>
                                            <th class="center middle">Tên hàng hóa
                                            </th>
                                            <th class="center middle">
                                                Hình ảnh
                                            </th>
                                            <th class="center middle">Đơn vị
                                            </th>
                                            <th class="center middle">Số lượng
                                            </th>
                                            <th class="center middle">Đơn giá
                                            </th>
                                            <th class="center middle">Thành tiền
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater runat="server" ID="Repeater_Detail">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center middle">
                                                        <%# Container.ItemIndex + 1 %>
                                                    </td>
                                                    <td class="center middle">
                                                        <%# Eval("Title") %>
                                                    </td>
                                                    <td>
                                                        <img runat="server" src='<%# Eval("Avatar") %>' width="100" />
                                                    </td>
                                                    <td class="center middle">Sản phẩm
                                                    </td>
                                                    <td class="center middle">
                                                        <%# Eval("Quantity") %>
                                                    </td>
                                                    <td class="center middle">
                                                        <%# Eval("Price") %>
                                                    </td>
                                                    <td class="center middle">
                                                        <%# (Eval("Quantity").ToInt()* Eval("Price").ToDouble()).ToSafetyString("0,00 đ") %>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!--Tổng cộng-->
                        <div class="row-form clearfix">
                            <div class="span2">
                            </div>
                            <div class="span10" style="text-align: right; font-weight: bold;">
                                Tổng cộng: <span runat="server" id="span_Amount"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <uc1:ucJS runat="server" ID="ucJS" />
    </form>
</body>
</html>
