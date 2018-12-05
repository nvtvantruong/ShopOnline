<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductList.aspx.cs" Inherits="ProductList" %>

<%@ Register Src="~/UserControls/ucPagging.ascx" TagPrefix="uc1" TagName="ucPagging" %>
<%@ Register Src="~/UserControls/ucRightCategory.ascx" TagPrefix="uc1" TagName="ucRightCategory" %>
<%@ Register Src="~/UserControls/ucRightArticle.ascx" TagPrefix="uc1" TagName="ucRightArticle" %>
<%@ Register Src="~/UserControls/ucProductSearch.ascx" TagPrefix="uc1" TagName="ucProductSearch" %>
<%@ Register Src="~/UserControls/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="js/jquery-search.js"></script>
    <script>
        $(function () {
            InitAutoSearch(".search-query", "/ServiceUtility.asmx/SearchArticle", "/ArticleList.aspx?keyword={0}")
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">
            <div class="span9">
                <div class="titleHeader clearfix">
                    <h3>
                        <a runat="server" id="a_MainTitle" href="#">Điện thoại</a>
                        <i runat="server" id="i_CatTitle" class="icon-chevron-right">&nbsp;</i>
                    </h3>
                    <h3>
                        <a runat="server" id="a_CatTitle" href="#">Apple</a>
                    </h3>
                </div>

                <%--ucProductSearch--%>
                <uc1:ucProductSearch runat="server" ID="ucProductSearch" />

                <uc1:ucMessage runat="server" ID="ucMessage" />

                <div class="row">
                    <ul class="listProductItems clearfix">
                        <asp:Repeater runat="server" ID="Repeater_Product">
                            <ItemTemplate>
                                <li class="clearfix">
                                    <div class="span3">
                                        <div class="thumbnail">
                                            <a runat="server" title='<%# Eval("Title") %>' href='<%#Eval("ID","~/ProductDetail.aspx?id={0}") %>'>
                                                <img runat="server" title='<%# Eval("Title") %>' alt='<%# Eval("Title").ToNoSignFormat() %>' src='<%# Eval("Thumb") %>'/>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="thumbSetting">
                                            <div class="thumbTitle">
                                                <a runat="server" href='<%#Eval("ID","~/ProductDetail.aspx?id={0}") %>'>
                                                    <%# Eval("Title") %>
                                                </a>
                                            </div>
                                            <div class="thumbPriceRate clearfix">
                                                <span>$<%# Eval("Price", "{0:0,00đ}") %></span>
                                                <span class="strike-through fr">$<%# Eval("OldPrice","{0:0,00đ}") %></span>

                                            </div>
                                            <div class="thumbDesc">
                                                <p><%# Eval("Description") %></p>
                                            </div>
                                            <div class="thumbButtons">
                                                <asp:UpdatePanel runat="server" Class="pull-left" style="margin-right: 5px;">
                                                    <ContentTemplate>
                                                        <asp:LinkButton runat="server" ID="LinkButton_AddToCart"
                                                            ClientIDMode="AutoID"
                                                            class="btn btn-success btn-small"
                                                            CommandArgument='<%# Eval("ID") %>'
                                                            OnClick="LinkButton_AddToCart_Click"
                                                            OnClientClick="alert('Đã thêm vào giỏ')">
                                                    <i class="icon-shopping-cart"></i>
                                                    &nbsp;Thêm vào giỏ hàng
                                                        </asp:LinkButton>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <a runat="server" href='<%#Eval("ID","~/ProductDetail.aspx?id={0}") %>' class="btn btn-primary btn-small">
                                                    <i class="icon-eye-open"></i>
                                                    Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>

                <%-- ucPagging --%>
                <uc1:ucPagging runat="server" ID="ucPagging" />

            </div>

            <aside class="span3">
                <%--RightCategory--%>
                <uc1:ucRightCategory runat="server" ID="ucRightCategory" />


                <uc1:ucRightArticle runat="server" ID="ucRightArticle" />


            </aside>
        </div>
    </div>
</asp:Content>