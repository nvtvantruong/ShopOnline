<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucMiniShoppingCart.ascx.cs" Inherits="ucMiniShoppingCart" %>

<div class="pull-right">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="btn-group">
                <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-shopping-cart"></i>
                    &nbsp;Bạn đã chọn
            <b runat="server" id="b_Count">3</b>
                    sản phẩm&nbsp;
            <span class="caret"></span>
                </a>
                <div class="dropdown-menu cart-content pull-right">
                    <table class="table-cart">
                        <tbody>
                            <asp:Repeater runat="server" ID="Repeater_Cart">
                                <ItemTemplate>
                                    <tr>
                                        <td class="cart-product-info">
                                            <a runat="server" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>'>
                                                <img runat="server" src='<%# Eval("Avatar") %>' />
                                            </a>
                                            <div class="cart-product-desc">
                                                <p>
                                                    <a runat="server" class="invarseColor" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>'>
                                                        <%# Eval("Title") %></a>
                                                </p>
                                                <ul class="unstyled">
                                                    <li>
                                                        Số lượng:
                                                <b><%#Eval("Quantity") %> </b>
                                                    </li>
                                                    <li>
                                                        Giá bán:
                                                <b><%# Eval("Price", "{0:000 đ}") %></b>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                        <td class="cart-product-setting">
                                            <asp:LinkButton runat="server" ID="LinkButton_Remove" class="remove-pro"
                                                data-toggle="tooltip" data-title="Xóa khỏi giỏ hàng"
                                                OnClick="LinkButton_Remove_Click" OnClientClick="return confirm('Bạn có muốn loại sản phẩm này không?')"
                                                CommandArgument='<%# Eval("ID") %>' ClientIDMode="AutoID">
                                        <i class="icon-trash"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td class="cart-product-info">
                                    <a runat="server" href="~/ProductShoppingCart.aspx" class="btn btn-small">Xem giỏ hàng</a>
                                    <a runat="server" href="~/ProductCheckout.aspx" class="btn btn-small btn-primary">Thanh toán</a>
                                </td>
                                <td align="center">
                                    <h3>Tổng Cộng
                                <br />
                                        <span runat="server" id="span_Amount">$1,598.30</span>
                                    </h3>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
