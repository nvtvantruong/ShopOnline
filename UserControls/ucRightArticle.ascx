<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRightArticle.ascx.cs" Inherits="ucRightArticle" %>

<div class="special">
    <div class="titleHeader clearfix">
        <h3>Tin Hot Nhất</h3>
    </div>
    <ul class="varticle-ItemsTiny">
        <asp:Repeater runat="server" ID="Repeater_Article">
            <ItemTemplate>
                <li class="span4 clearfix">
                    <div class="thumbImage">
                        <a runat="server" href='<%# Eval("ID","~/ArticleDetail.aspx?id={0}") %>'>
                            <img runat="server" src='<%# Eval("Thumb") %>' alt="" />
                        </a>
                    </div>
                    <div class="thumbSetting">
                        <div class="thumbTitle">
                            <a runat="server" href='<%# Eval("ID","~/ArticleDetail.aspx?id={0}") %>' class="invarseColor">
                                <%# Eval("Title").Left(30,true,true) %>
                            </a>
                        </div>
                        <ul class="unstyled blog-content-date">
                            <li class="pull-right">
                                <i class="icon-comments"></i><%#Eval("ViewTime") %>
                            </li>
                            <li class="pull-left">
                                <i class="icon-calendar"></i><%# Eval("CreateTime", "{0:dd/MM/yy}") %>
                            </li>
                        </ul>
                    </div>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
