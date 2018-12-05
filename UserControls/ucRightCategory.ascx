<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRightCategory.ascx.cs" Inherits="ucRightCategory" %>
<div class="categories">
    <div class="titleHeader clearfix">
        <h3>Hãng Sản Xuất</h3>
    </div>
    <ul class="unstyled">
        <asp:Repeater runat="server" ID="Repeater_Main">
            <ItemTemplate>
                <li>
                    <a runat="server" class="btn-primary category" href='<%# Eval("ID","~/ProductList.aspx?mid={0}") %>'>
                        <i class="icon-caret-right"></i>
                        <%# Eval("Title") %>
                    </a>
                    <ul class="submenu">
                        <asp:Repeater runat="server" ID="Repeater_Cat" DataSource='<%# Eval("Cat") %>'>
                            <ItemTemplate>
                                <li>
                                    <a class="invarseColor" href='<%# Eval("ID", "../ProductList.aspx?cid={0}") %>'>
                                        <%#Eval("Title") %>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                    </ul>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
