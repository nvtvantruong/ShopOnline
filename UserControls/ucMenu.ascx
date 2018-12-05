<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucMenu.ascx.cs" Inherits="ucMenu" %>
<%@ Register Src="~/UserControls/ucArticleMenu.ascx" TagPrefix="uc1" TagName="ucArticleMenu" %>

<script>
    function activeProductMainMenu(mid) {
        $("li[data-mid=" + mid + "]").attr("class", "active");
    }
</script>

<div class="mainNav">
    <div class="container">
        <div class="navbar">
            <ul class="nav">
                <li class='<%= GetActiveClass("default") %>'>
                    <a runat="server" href="~/Default.aspx"><i class="icon-home"></i></a>
                </li>
                <li>
                    <a href="#">Các Trang<i class="icon-caret-down"></i></a>
                    <div>
                        <ul>
                            <li>
                                <a href="/"><span>-</span> Default</a>
                            </li>
                            <li>
                                <a href="Account.aspx"><span>-</span> Account</a>
                            </li>
                            <li>
                                <a href="AccountInformation.aspx"><span>-</span> Account Information</a>
                            </li>
                            <li>
                                <a href="AccountLogin.aspx"><span>-</span> Account Login</a>
                            </li>
                            <li>
                                <a href="AccountRegister.aspx"><span>-</span> Account Register</a>
                            </li>
                            <li>
                                <a href="AccountWishlist.aspx"><span>-</span> Account Wish list</a>
                            </li>
                            <li>
                                <a href="ProductList.aspx"><span>-</span> Product List</a>
                            </li>
                            <li>
                                <a href="ProductGrid.aspx"><span>-</span> Product Grid</a>
                            </li>
                            <li>
                                <a href="ProductDetail.aspx"><span>-</span> Product Detail</a>
                            </li>
                            <li>
                                <a href="ProductSearch.aspx"><span>-</span> Product Search</a>
                            </li>
                            <li>
                                <a href="ProductShoppingCart.aspx"><span>-</span> Product Shopping Cart</a>
                            </li>
                            <li>
                                <a href="ProductCheckout.aspx"><span>-</span> Product Checkout</a>
                            </li>
                            <li>
                                <a href="ProductCompare.aspx"><span>-</span> Product Compare</a>
                            </li>
                            <li>
                                <a href="ArticleList.aspx"><span>-</span> Article List</a>
                            </li>
                            <li>
                                <a href="ArticleDetail.aspx"><span>-</span> Article Detail</a>
                            </li>
                            <li>
                                <a href="Contact.aspx"><span>-</span> Contact</a>
                            </li>
                        </ul>
                    </div>
                </li>

                <asp:Repeater runat="server" ID="Repeater_Menu">
                    <ItemTemplate>
                        <li data-mid='<%# Eval("ID") %>'>
                            <a runat="server" title='<%#"{0} chính hãng".StringFormat(Eval("title")) %> ' href='<%# "~/danh-sach-san-pham/m{0}c{1}p{2}/{3}".StringFormat(Eval("ID"),0,1, Eval("Title").ToUrlFormat()) %>'>
                                <%# Eval("Title") %>
                                <i class="icon-caret-down"></i>
                            </a>
                            <div>
                                <ul>
                                    <asp:Repeater runat="server" DataSource='<%# Eval("SubMenu") %>'>
                                        <ItemTemplate>
                                            <li>
                                                <a runat="server" href='<%# "~/danh-sach-san-pham/m{0}c{1}p{2}/{3}".StringFormat(0,Eval("ID"),1, Eval("Title").ToUrlFormat()) %>'>
                                                    <span>-</span>
                                                    <%# Eval("Title") %>
                                                </a>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>

                <li class='<%= GetActiveClass("article") %>'>
                    <%-- ucArticleMenu --%>
                    <uc1:ucArticleMenu runat="server" ID="ucArticleMenu" />

                </li>
                <li class='<%= GetActiveClass("contact") %>'>
                    <a runat="server" href="~/Contact.aspx">Liên Hệ</a>
                </li>
                <li class='<%= GetActiveClass("account") %>'>
                    <a runat="server" href="~/Account.aspx"><span>-</span>Tài Khoản</a>
                </li>
            </ul>
        </div>
    </div>
</div>
