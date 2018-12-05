<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/UserControls/ucHotProduct.ascx" TagPrefix="uc1" TagName="ucHotProduct" %>
<%@ Register Src="~/UserControls/ucPartner.ascx" TagPrefix="uc1" TagName="ucPartner" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Trang Chủ</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <!--Trang riêng-->
    <div class="container">

        <%--HotProduct--%>
        <uc1:ucHotProduct runat="server" ID="ucHotProduct" />


        <asp:Repeater runat="server" ID="Repeater_Main">
            <ItemTemplate>
                <div class="row">
                    <div class="span12">
                        <div id="featuredItems">
                            <div class="titleHeader clearfix">
                                <h3 class="no-margin">
                                    <a runat="server" href='<%# Eval("id","~/ProductList.aspx?mid={0}") %>'><%# Eval("Title") %></a>
                                </h3>
                                <div class="pagers">
                                    <div class="btn-toolbar">
                                        <asp:Repeater runat="server" ID="Repeater_Cat" DataSource='<%# Eval("Cat") %>'>
                                            <ItemTemplate>
                                                <a runat="server" href='<%# Eval("id","~/ProductList.aspx?cid={0}") %>' class="btn btn-mini">
                                                    <%# Eval("Title") %>
                                                </a>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <a runat="server" href='<%# Eval("ID","~/ProductList.aspx?mid={0}") %>'
                                            class="btn btn-mini">
                                            Xem Tất Cả</a>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <ul class="hProductItems clearfix">
                                    <asp:Repeater runat="server" ID="Repeater_Product" DataSource='<%# Eval("Product") %>'>
                                        <ItemTemplate>
                                            <li class="span3 clearfix">
                                                <div class="thumbnail">
                                                    <a runat="server" href='<%# Eval("id","~/ProductDetail.aspx?id={0}") %>'>
                                                        <img runat="server" src='<%# Eval("Thumb") %>' alt="" />
                                                    </a>
                                                </div>
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <div class="thumbSetting">
                                                            <div class="thumbTitle">
                                                                <a runat="server" href='<%# Eval("id","~/ProductDetail.aspx?id={0}") %>' class="invarseColor">
                                                                    <%#Eval("Title") %>
                                                                </a>
                                                            </div>
                                                            <div class="thumbPrice">
                                                                <span><%# Eval("Price","{0:0,00đ}") %>
                                                                    <span class="strike-through fr">$<%# Eval("OldPrice","{0:0,00đ}") %></span>
                                                                </span>
                                                            </div>
                                                            <div class="thumbButtons">
                                                                <asp:LinkButton runat="server" ID="LinkButton_AddToCart"
                                                                    ClientIDMode="AutoID"
                                                                    class="btn btn-primary btn-small"
                                                                    CommandArgument='<%# Eval("ID") %>'
                                                                    OnClick="LinkButton_AddToCart_Click"
                                                                    OnClientClick="alert('Đã thêm vào giỏ')">
                                                                    <i class="icon-shopping-cart"></i>
                                                                    &nbsp;Thêm vào giỏ hàng
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <%--partner--%>
        <uc1:ucPartner runat="server" ID="ucPartner" />


    </div>
</asp:Content>

