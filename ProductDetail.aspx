<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductDetail.aspx.cs" Inherits="ProductDetail" %>

<%@ Register Src="~/UserControls/ucRightArticle.ascx" TagPrefix="uc1" TagName="ucRightArticle" %>
<%@ Register Src="~/UserControls/ucRightProduct.ascx" TagPrefix="uc1" TagName="ucRightProduct" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">

            <div class="span9">

                <asp:Repeater runat="server" ID="Repeater_Product">
                    <ItemTemplate>
                        <div class="titleHeader clearfix">
                            <h3>
                                <a runat="server" href='<%# Eval("MainCatID","ProductList.aspx?mid={0}") %>'>
                                    <%# Eval("MainCatTitle") %>
                                </a>
                                <i class="icon-chevron-right">&nbsp;</i>
                            </h3>
                            <h3>
                                <a runat="server" href='<%# Eval("CatID","ProductList.aspx?cid={0}") %>'>
                                    <%# Eval("CatTitle") %>
                                </a>
                                <i class="icon-chevron-right">&nbsp;</i>
                            </h3>
                            <h1>
                                <a runat="server" href='<%# Eval("ID","ProductDetail.aspx?id={0}") %>'>
                                    <%# Eval("Title") %>
                                </a>
                            </h1>
                        </div>
                        <div class="row">
                            <div class="product-details clearfix">
                                <div class="span5">
                                    <div class="product-img">
                                        <a runat="server" class="fancybox" href='<%# Eval("Avatar") %>'>
                                            <img runat="server" src='<%# Eval("Thumb") %>' alt="" />
                                        </a>
                                    </div>
                                    <div class="product-img-thumb">
                                        <asp:Repeater runat="server" ID="Repeater_ImageList" DataSource='<%# Eval("ImageList").SplitToKeywordsArray(";", StringSplitOptions.RemoveEmptyEntries) %>'>
                                            <ItemTemplate>
                                                <a runat="server" class="fancybox" href='<%# Eval("Text") %>'>
                                                    <img runat="server" src='<%# Eval("Text") %>' alt="" />
                                                </a>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                                <div class="span4">
                                    <div class="product-set">
                                        <div class="product-price">
                                            <span><%# Eval("Price","{0:0,00đ}") %>
                                                <span class="strike-through"><%# Eval("OldPrice","{0:0,00đ}") %></span>
                                            </span>
                                        </div>
                                        <div class="product-info">
                                            <dl class="dl-horizontal">
                                                <dt>Tình trạng:</dt>
                                                <dd>
                                                    <%# Eval("Quantity").ToInt() > 0 ? "Còn hàng" : "Hết hàng" %>
                                                </dd>

                                                <dt>Phụ kiện:</dt>
                                                <dd><%# Eval("Accessories") %></dd>

                                                <dt>Bảo hành:</dt>
                                                <dd><%# Eval("WarrantyPolicy") %></dd>

                                                <dt>Khuyến mãi:</dt>
                                                <dd><%# Eval("Promotions") %></dd>

                                                <dt>Cấu hình:</dt>
                                                <dd style="width: 100%">
                                                    <ul>
                                                        <asp:Repeater runat="server" ID="Repeater_Description" DataSource='<%# Eval("Description").SplitToKeywordsArray(";", StringSplitOptions.RemoveEmptyEntries) %>'>
                                                            <ItemTemplate>
                                                                <li>
                                                                    <%# Eval("Text") %>
                                                                </li>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </ul>
                                                </dd>
                                            </dl>
                                            <table runat="server" visible="false" class="table table-compare">
                                                <tr>
                                                    <td class="aligned-color">CPU</td>
                                                    <td>2.5Ghz lõi tứ</td>
                                                </tr>
                                                <tr>
                                                    <td class="aligned-color">Ram</td>
                                                    <td>2Gb</td>
                                                </tr>
                                                <tr>
                                                    <td class="aligned-color">Màn hình</td>
                                                    <td>5.0 inch. Full HD</td>
                                                </tr>
                                                <tr>
                                                    <td class="aligned-color">Pin</td>
                                                    <td>2800 mAH</td>
                                                </tr>
                                                <tr>
                                                    <td class="aligned-color">Bộ nhớ trong</td>
                                                    <td>16 Gb</td>
                                                </tr>
                                                <tr>
                                                    <td class="aligned-color">Camera trước</td>
                                                    <td>5 MGP</td>
                                                </tr>
                                                <tr>
                                                    <td class="aligned-color">Camera sau</td>
                                                    <td>8 MGP</td>
                                                </tr>
                                            </table>
                                        </div>

                                        <%--Nút thêm vào giỏ--%>
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:LinkButton runat="server" ID="LinkButton_AddToCart"
                                                    ClientIDMode="AutoID"
                                                    class="btn btn-success btn-small fr margin-top10px"
                                                    CommandArgument='<%# Eval("ID") %>'
                                                    OnClick="LinkButton_AddToCart_Click"
                                                    OnClientClick="alert('Đã thêm vào giỏ')">
                                                    <i class="icon-shopping-cart"></i>
                                                    &nbsp;Thêm vào giỏ hàng
                                                </asp:LinkButton>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="product-tab">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                    <a href="#descraption" data-toggle="tab">Bài giới thiệu sản phẩm</a>
                                </li>
                                <li>
                                    <a href="#specfications" data-toggle="tab">Cấu hình chi tiết</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active justify" id="descraption">
                                    <%# Eval("Content") %>
                                </div>
                                <div class="tab-pane" id="specfications">

                                    <ul>
                                        <asp:Repeater runat="server" ID="Repeater_Specifications" DataSource='<%# Eval("Specifications").SplitToKeywordsArray(";", StringSplitOptions.RemoveEmptyEntries) %>'>
                                            <ItemTemplate>
                                                <li>
                                                    <%# Eval("Text") %>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>

                                    <table runat="server" visible="false" class="table table-compare">
                                        <tr>
                                            <td class="aligned-color">CPU</td>
                                            <td>2.5Ghz lõi tứ</td>
                                        </tr>
                                        <tr>
                                            <td class="aligned-color">Ram</td>
                                            <td>2Gb</td>
                                        </tr>
                                        <tr>
                                            <td class="aligned-color">Màn hình</td>
                                            <td>5.0 inch. Full HD</td>
                                        </tr>
                                        <tr>
                                            <td class="aligned-color">Pin</td>
                                            <td>2800 mAH</td>
                                        </tr>
                                        <tr>
                                            <td class="aligned-color">Bộ nhớ trong</td>
                                            <td>16 Gb</td>
                                        </tr>
                                        <tr>
                                            <td class="aligned-color">Camera trước</td>
                                            <td>5 MGP</td>
                                        </tr>
                                        <tr>
                                            <td class="aligned-color">Camera sau</td>
                                            <td>8 MGP</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <div class="related-product">
                    <div class="titleHeader clearfix">
                        <h3>CÁC SẢN PHẨM CÙNG THƯƠNG HIỆU
                        </h3>
                    </div>
                    <div class="row">
                        <ul class="hProductItems clearfix">
                            <asp:Repeater runat="server" ID="Repeater_Related">
                                <ItemTemplate>
                                    <li class="span3 clearfix">
                                        <div class="thumbnail">
                                            <a runat="server" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>'>
                                                <img runat="server" src='<%# Eval("Thumb") %>' alt="">
                                            </a>
                                        </div>
                                        <div class="thumbSetting">
                                            <div class="thumbTitle">
                                                <a runat="server" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>' class="invarseColor">
                                                    <%# Eval("Title") %>
                                                </a>
                                            </div>
                                            <div class="thumbPrice">
                                                <span><%# Eval("Price","{0:0,00đ}" ) %>
                                                    <span class="strike-through fr">$<%# Eval("OldPrice","{0:0,00đ}" ) %></span>
                                                </span>
                                            </div>
                                            <div class="thumbButtons">
                                                <button class="btn btn-primary btn-small">
                                                    <i class="icon-shopping-cart"></i>
                                                    &nbsp;Thêm vào giỏ hàng
                                                </button>
                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>

            </div>

            <aside class="span3">



                <uc1:ucRightProduct runat="server" ID="ucRightProduct" />


                <uc1:ucRightArticle runat="server" ID="ucRightArticle" />

            </aside>
        </div>
    </div>
</asp:Content>

