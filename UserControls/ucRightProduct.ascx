<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRightProduct.ascx.cs" Inherits="ucRightProduct" %>

<div>
    <div class="titleHeader clearfix">
        <h3>Sản Phẩm Siêu Hot</h3>
    </div>
    <ul class="vProductItemsTiny">
        <asp:Repeater runat="server" ID="Repeater_Product">
            <ItemTemplate>
                <li class="span4 clearfix">
                    <div class="thumbImage">
                        <a runat="server" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>' >
                            <img runat="server" src='<%# Eval("Thumb") %>' alt="" />
                        </a>
                    </div>
                    <div class="thumbSetting">
                        <ul class="unstyled blog-content-date clearfix">
                            <li class="pull-left">
                                $<%# Eval("Price","{0:0,00đ}") %>
                                                <br />
                                <s>$<%# Eval("OldPrice","{0:0,00đ}") %></s>
                            </li>
                        </ul>
                        <div class="thumbTitle">
                            <a runat="server" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>' class="invarseColor">
                                <%# Eval("Title").Left(15,true,true) %>
                            </a>
                        </div>
                    </div>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
