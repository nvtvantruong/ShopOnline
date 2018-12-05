<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ArticleDetail.aspx.cs" Inherits="ArticleDetail" %>

<%@ Register Src="~/UserControls/ucRightProduct.ascx" TagPrefix="uc1" TagName="ucRightProduct" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">

            <div class="span9">
                <div class="titleHeader clearfix">
                    <h3>Nội Dung Tin Tức</h3>
                </div>
                <asp:Repeater runat="server" ID="Repeater_Blog">
                    <ItemTemplate>
                        <article class="blog-article">
                            <div class="blog-img">
                                <img runat="server" src='<%# Eval("Avatar") %>' />
                            </div>
                            <div class="blog-content">
                                <div class="clearfix">
                                    <ul class="unstyled blog-content-date">
                                        <li class="pull-right">
                                            <i class="icon-comments"></i>
                                            <%# Eval("ViewTime") %>
                                        </li>
                                        <li class="pull-left">
                                            <i class="icon-calendar"></i>
                                            <%# Eval("CreateTime") %>
                                        </li>
                                        <li class="pull-left">
                                            <i class="icon-pencil"></i>
                                            <b><%# Eval("CreateBy") %></b>
                                        </li>
                                    </ul>
                                </div>
                                <div class="blog-content-entry">
                                    <blockquote id="blog-item-desc">
                                        <%# Eval("Description") %>
                                    </blockquote>
                                    <p id="blog-item-content" >
                                        <%# Eval("Content") %>
                                    </p>
                                </div>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="titleHeader margin-top10px clearfix">
                    <h3>Các Bài Khác</h3>
                </div>
                <div class="row">
                    <ul class="hProductItems clearfix">
                        <asp:Repeater runat="server" ID="Repeater_Related">
                            <ItemTemplate>
                                <li class="span3 clearfix">
                                    <div class="thumbnail">
                                        <a runat="server" href='<%#Eval("ID","~/ArticleDetail.aspx?id={0}") %>'>
                                            <img runat="server" src='<%# Eval("Thumb") %>' alt="">
                                        </a>
                                    </div>
                                    <div class="thumbSetting">
                                        <div class="thumbTitle">
                                            <a runat="server" href='<%#Eval("ID","~/ArticleDetail.aspx?id={0}") %>'>
                                                <%# Eval("Title") %></a>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                    </ul>
                </div>
                <div class="user-comments">
                    <div class="titleHeader clearfix">
                        <h3>Danh Sách Bình Luận</h3>
                    </div>
                    <ul class="media-list">
                        <li class="media">
                            <a class="pull-left" href="#">
                                <img class="media-object" src="/css/images/64x64.jpg" />
                            </a>
                            <div class="media-body">
                                <div class="pull-right">
                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Reply" data-placment="top"><i class="icon-refresh"></i></button>
                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Remove" data-placment="top"><i class="icon-trash"></i></button>
                                </div>
                                <h4 class="media-heading">
                                    <a href="#" class="invarseColor">John Doe1</a>
                                </h4>
                                <p>consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit. consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit.</p>
                            </div>
                        </li>
                        <li class="media">
                            <a class="pull-left" href="#">
                                <img class="media-object" src="/css/images/64x64.jpg" />
                            </a>
                            <div class="media-body">
                                <div class="pull-right">
                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Reply" data-placment="top"><i class="icon-refresh"></i></button>
                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Remove" data-placment="top"><i class="icon-trash"></i></button>
                                </div>
                                <h4 class="media-heading">
                                    <a href="#" class="invarseColor">John Doe1</a>
                                </h4>
                                <p>consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit. consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit.</p>
                                <div class="media">
                                    <ul>
                                        <li class="media">
                                            <a class="pull-left" href="#">
                                                <img class="media-object" src="/css/images/64x64.jpg" />
                                            </a>
                                            <div class="media-body">
                                                <div class="pull-right">
                                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Reply" data-placment="top"><i class="icon-refresh"></i></button>
                                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Remove" data-placment="top"><i class="icon-trash"></i></button>
                                                </div>
                                                <h4 class="media-heading">
                                                    <a href="#" class="invarseColor">John Doe1</a>
                                                </h4>
                                                <p>consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit. consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit.</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li class="media">
                            <a class="pull-left" href="#">
                                <img class="media-object" src="/css/images/64x64.jpg" />
                            </a>
                            <div class="media-body">
                                <div class="pull-right">
                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Reply" data-placment="top"><i class="icon-refresh"></i></button>
                                    <button class="btn btn-mini" data-toggle="tooltip" data-title="Remove" data-placment="top"><i class="icon-trash"></i></button>
                                </div>
                                <h4 class="media-heading">
                                    <a href="#" class="invarseColor">John Doe1</a>
                                </h4>
                                <p>consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit. consectetur adipiscing eli. Nulla tristique posuere felis vel pretium. Sed sit amet nisi elit.</p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="make-comment">
                    <div class="titleHeader clearfix">
                        <h3>Ý Kiến Của Bạn</h3>
                    </div>
                    <div class="clearfix">
                        <div class="controls controls-row">
                            <input type="text" placeholder="Your Name...*" class="span3" />
                            <input type="text" placeholder="E-Mail...*" class="span3" />
                            <input type="text" placeholder="URL..." class="span3" />
                        </div>
                        <div class="controls">
                            <textarea class="span9" placeholder="Your Message...*"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary pull-right">Gửi ý kiến</button>
                    </div>
                </div>
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

