<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductShoppingCart.aspx.cs" Inherits="ProductShoppingCart" %>

<%@ Register Src="~/UserControls/ucShoppingCart.ascx" TagPrefix="uc1" TagName="ucShoppingCart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="titleHeader clearfix">
            <h3>Giỏ Hàng Của Tôi</h3>
        </div>

        <div class="row">
            <div class="span12">
                <uc1:ucShoppingCart runat="server" ID="ucShoppingCart" />
            </div>
        </div>
    </div>
</asp:Content>

