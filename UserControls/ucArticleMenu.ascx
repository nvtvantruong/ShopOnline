<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucArticleMenu.ascx.cs" Inherits="usArticleMenu" %>

<a runat="server" href="~/danh-sach-tin-phan-1">
    Tin Tức
    <i class="icon-caret-down"></i>
</a>

<div>
    <ul>
        <asp:Repeater runat="server" ID="Repeater_ArticleMenu">
            <ItemTemplate>
                <li>
                    <a runat="server" href='<%# "~/danh-sach-tin/{0}/{1}-phan-{2}".StringFormat(Eval("ID"),Eval("Title").ToUrlFormat(), 1) %>'>
                        <span>-</span>
                        <%# Eval("Title") %>
                    </a>
                </li>
            </ItemTemplate>
        </asp:Repeater>

    </ul>
</div>
