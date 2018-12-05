<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucHotProduct.ascx.cs" Inherits="ucHotProduct" %>

<div class="row margin-top10px">
    <div class="span8">
        <div class="flexslider">
            <ul class="slides">
                <asp:Repeater runat="server" ID="Repeater_Full">
                    <ItemTemplate>
                        <li>
                            <a runat="server" href='<%# Eval("id","~/ProductDetail.aspx?id={0}") %>'>
                                <img runat="server" src='<%# Eval("Avatar") %>' /></a>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <div class="span4">
        <div id="homeSpecial">
            <div class="titleHeader clearfix">
                <h3 class="no-margin">Giá Sock</h3>
                <div class="pagers">
                    <div class="btn-toolbar">
                        <div class="btn-group">
                            <button class="btn btn-mini vNext"><i class="icon-caret-down"></i></button>
                            <button class="btn btn-mini vPrev"><i class="icon-caret-up"></i></button>
                        </div>
                        <button class="btn btn-mini">Xem Tất Cả</button>
                    </div>
                </div>
            </div>
            <ul class="vProductItems cycle-slideshow vertical clearfix" data-cycle-fx="carousel" data-cycle-timeout="0" data-cycle-slides=">li" data-cycle-next=".vPrev" data-cycle-prev=".vNext" data-cycle-carousel-visible="2" data-cycle-carousel-vertical="true">
                <asp:Repeater runat="server" ID="Repeater_Thumb">
                    <ItemTemplate>
                        <li class="span4 clearfix">
                            <div class="thumbImage">
                                <a runat="server" href='<%# Eval("id","~/ProductDetail.aspx?id={0}") %>'>
                                    <img width="92" runat="server" src='<%# Eval("Thumb") %>' alt="" />
                                </a>
                            </div>
                            <div class="thumbSetting">
                                <div class="thumbTitle">
                                    <a runat="server" href='<%# Eval("id","~/ProductDetail.aspx?id={0}") %>' class="invarseColor">
                                        <%# Eval("Title").Left(30, true,true) %>
                                    </a>
                                </div>
                                <div class="thumbPrice">
                                    <span><%# Eval("Price","{0:0,00đ}") %></span>
                                </div>
                                <div class="thumbPrice">
                                    <span class="strike-through">$<%# Eval("OldPrice","{0:0,00đ}") %></span>
                                </div>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
</div>
