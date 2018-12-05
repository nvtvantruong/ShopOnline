<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucUpperHeader.ascx.cs" Inherits="ucUpperHeader" %>

<div class="upperHeader">
    <div class="container">
        <p class="pull-left">
            Chào mừng
            <b runat="server" id="b_FullName"></b>
            đến với Shop Online,
            <span runat="server" id="span_Account">
                <a runat="server" href="~/AccountLogin.aspx">Đăng nhập</a>
                hoặc
                <a runat="server" href="~/AccountRegister.aspx">Đăng ký</a>
            </span>
            <asp:LinkButton Text="Thoát" runat="server" ID="LinkButton_Logout" Visible="false" OnClick="LinkButton_Logout_Click" />
        </p>

        <ul class="pull-right inline">
            <li>
                <a href="/Account.aspx" class="invarseColor">Tài Khoản</a>
            </li>
            <li class="divider-vertical"></li>
            <li>
                <a href="/ProductShoppingCart.aspx" class="invarseColor">Giỏ Hàng</a>
            </li>
            <li class="divider-vertical"></li>
            <li>
                <a href="/ProductCheckout.aspx" class="invarseColor">Thanh Toán</a>
            </li>
        </ul>
    </div>
</div>
