<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ArticleList.aspx.cs" Inherits="ArticleList" %>

<%@ Register Src="~/UserControls/ucPagging.ascx" TagPrefix="uc1" TagName="ucPagging" %>
<%@ Register Src="~/UserControls/ucRightProduct.ascx" TagPrefix="uc1" TagName="ucRightProduct" %>
<%@ Register Src="~/UserControls/ucArticleSearch.ascx" TagPrefix="uc1" TagName="ucArticle" %>




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
                    <h3>Danh Sách Tin Tức</h3>
                </div>
                <uc1:ucArticle runat="server" id="ucArticle" />

                <article class="blog-article">
                    <asp:Repeater runat="server" ID="Repeater_blog">
                        <ItemTemplate>
                            <div class="row">
                                <div class="span4">
                                    <div class="blog-img">
                                        <a runat="server" href='<%#Eval("ID", "~/ArticleDetail.aspx?id={0}") %>'>
                                            <img width="294" height="216" runat="server" src='<%#Eval("Thumb") %>' />
                                        </a>
                                    </div>
                                </div>
                                <div class="span5">
                                    <div class="blog-content">
                                        <div class="blog-content-title">
                                            <h2>
                                                <a runat="server" href='<%#Eval("ID", "~/ArticleDetail.aspx?id={0}") %>' class="invarseColor">
                                                    <%# Eval("Title") %>
                                                </a>
                                            </h2>
                                        </div>
                                        <div class="clearfix">
                                            <ul class="unstyled blog-content-date">
                                                <li class="pull-right">
                                                    <i class="icon-comments"></i>
                                                    <%# Eval("ViewTime") %>
                                                </li>
                                                <li class="pull-left">
                                                    <i class="icon-calendar"></i>
                                                    <%# Eval("CreateTime","{0:dd/MM/yyy}") %>
                                                </li>
                                                <li class="pull-left">
                                                    <i class="icon-pencil"></i>
                                                    <b><%# Eval("CreateBy") %></b>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="blog-content-entry">
                                            <p>
                                                <%# Eval("Description") %>
                                            </p>
                                            <a runat="server" href='<%#Eval("ID", "~/ArticleDetail.aspx?id={0}") %>'>
                                                Xem Thêm &rarr;
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </article>

                <uc1:ucPagging runat="server" ID="ucPagging" />

            </div>


            <aside class="span3">

                <uc1:ucRightProduct runat="server" ID="ucRightProduct" />

                <div class="blog-adds">
                    <div class="titleHeader clearfix">
                        <h3>Quảng Cáo</h3>
                    </div>
                    <div class="item">
                        <a href="#">
                            <img src="/css/images/214x136.jpg" />
                        </a>
                        <a href="#">
                            <img src="/css/images/214x136.jpg" />
                        </a>
                        <a href="#">
                            <img src="/css/images/214x136.jpg" />
                        </a>
                        <a href="#">
                            <img src="/css/images/214x136.jpg" />
                        </a>
                    </div>
                </div>

            </aside>
        </div>
    </div>

</asp:Content>

