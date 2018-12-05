<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductCheckout.aspx.cs" Inherits="ProductCheckout" %>

<%@ Register Src="~/UserControls/ucShoppingCart.ascx" TagPrefix="uc1" TagName="ucShoppingCart" %>
<%@ Register Src="~/UserControls/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function checkoutButtonClick() {
            $(".checkout-button").click();
            return false;
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="titleHeader clearfix">
            <h3>Thanh Toán Đơn Hàng</h3>
        </div>
        <div class="row">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="span12">
                        <div class="checkout-outer">
                            <div class="checkout-header">
                                <h4>
                                    <i class="icon-caret-down"></i>
                                    Thông Tin Giao - Nhận Hàng
                                </h4>
                            </div>
                            <div class="checkout-content">
                                <div class="form-inline">
                                    <label class="radio inline">
                                        <asp:RadioButton Text="Sử dụng thông tin tài khoản"
                                            runat="server" ID="RadioButton_AccountInfo"
                                            GroupName="info" AutoPostBack="true"
                                            OnCheckedChanged="RadioButton_AccountInfo_CheckedChanged" />
                                    </label>
                                    &nbsp;&nbsp;
                            <label class="radio inline">
                                <asp:RadioButton Text="Nhập thông tin mới"
                                    runat="server" ID="RadioButton_NewInfo"
                                    GroupName="info" AutoPostBack="true"
                                    OnCheckedChanged="RadioButton_NewInfo_CheckedChanged" />
                            </label>
                                </div>
                                <uc1:ucMessage runat="server" ID="ucMessage_Top" />
                                <hr />
                                <div class="form-horizontal">
                                    <div class="control-group">
                                        <label class="control-label" for="inputFirstName">
                                            Email:
                                    <span class="text-error">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" runat="server" id="input_Email" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="inputFirstName">
                                            Họ tên:
                                    <span class="text-error">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" runat="server" id="input_FullName" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="inputFirstName">
                                            Số điện thoại:
                                    <span class="text-error">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" runat="server" id="input_Mobil" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="inputFirstName">
                                            Số điện thoại 2:
                                    <span class="text-error">*</span>
                                        </label>
                                        <div class="controls">
                                            <input type="text" runat="server" id="input_Mobil2" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="inputConPass">
                                            Phái:
                                    <span class="text-error">*</span>
                                        </label>
                                        <div class="controls">
                                            <label class="radio inline">
                                                <input type="radio" runat="server" id="input_Gender_Male" name="gender" checked="true" />
                                                Nam
                                            </label>
                                            <label class="radio inline">
                                                <input type="radio" runat="server" id="input_Gender_Female" name="gender" />
                                                Nữ
                                            </label>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="inputFirstName">
                                            Địa chỉ:
                                    <span class="text-error">*</span>
                                        </label>
                                        <div class="controls">
                                            <textarea runat="server" id="textarea_Address"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="checkout-outer">
                            <div class="checkout-header">
                                <h4>
                                    <i class="icon-caret-right"></i>Hình Thức Thanh Toán
                                </h4>
                            </div>
                            <div class="checkout-content">
                                <div class="controls">
                                    <label class="radio inline">
                                        <input type="radio" name="checkout-option" runat="server" id="input_Checkout_Online" checked="true" />
                                        Thanh toán trực tuyến qua Ngân Lượng
                                    </label>
                                </div>
                                <div class="controls">
                                    <label class="radio inline">
                                        <input type="radio" name="checkout-option" runat="server" id="input_Checkout_Offline" />
                                        Thanh toán tại nhà ngay khi nhận được hàng
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="checkout-outer">
                            <div class="checkout-header">
                                <h4>
                                    <i class="icon-caret-right"></i>
                                    Chi tiết đơn hàng
                                </h4>
                            </div>
                            <div class="checkout-content clearfix">
                                <uc1:ucShoppingCart runat="server" ID="ucShoppingCart" />
                            </div>
                        </div>

                        <asp:Button Text="Lập đơn hàng"
                            runat="server" ID="Button_Checkout"
                            OnClick="Button_Checkout_Click"
                            class="btn btn-primary checkout-button hidden" />

                        <%--ucMessage--%>
                        <uc1:ucMessage runat="server" ID="ucMessage_Bottom" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
