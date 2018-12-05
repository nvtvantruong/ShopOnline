<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucShoppingCart.ascx.cs" Inherits="ucShoppingCart" %>

<asp:UpdatePanel runat="server" ID="UpdatePanel_Main" OnPreRender="UpdatePanel_Main_PreRender">
    <ContentTemplate>
            <table class="table">
                <thead>
                    <tr>
                        <th>Minh họa</th>
                        <th class="desc">Tên sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater runat="server" ID="Repeater_Cart">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <a class="fancybox" runat="server" href='<%# Eval("Avatar") %>'>
                                        <img runat="server" src='<%# Eval("Avatar") %>' alt="" class="thumb-cart" />
                                    </a>
                                </td>
                                <td class="desc">
                                    <h4>
                                        <a runat="server" href='<%# Eval("ID","~/ProductDetail.aspx?id={0}") %>' class="invarseColor"><%# Eval("Title") %></a>
                                    </h4>
                                </td>
                                <td class="total-price">
                                    <s><%# Eval("OldPrice", "{0:0,00 đ}") %></s>
                                    <h2><%# Eval("Price", "{0:0,00 đ}") %></h2>
                                </td>
                                <td class="quantity">
                                    <div class="input-prepend input-append">
                                        <asp:LinkButton class="btn" ID="LinkButton_Decrease" runat="server"
                                            OnClick="LinkButton_Decrease_Click"
                                            CommandArgument='<%# Eval("ID") %>' ClientIDMode="AutoID">
                                                <i class="icon-chevron-left"></i>
                                        </asp:LinkButton>

                                        <input readonly="readonly" type="text" value='<%# Eval("Quantity") %>' />

                                        <asp:LinkButton class="btn" ID="LinkButton_Increase" runat="server"
                                            OnClick="LinkButton_Increase_Click"
                                            CommandArgument='<%# Eval("ID") %>' ClientIDMode="AutoID">
                                                <i class="icon-chevron-right"></i>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td>
                                    <asp:LinkButton ID="LinkButton_Remove" runat="server"
                                        class="btn btn-small btn-danger" data-title="Loại khỏi giỏ hàng"
                                        data-placement="top" data-toggle="tooltip"
                                        OnClick="LinkButton_Remove_Click"
                                        OnClientClick="return confirm('Bạn có muốn loại sản phẩm này không?')"
                                        CommandArgument='<%# Eval("ID") %>' ClientIDMode="AutoID">
                                            <i class="icon-trash"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <div class="span5 fr">
                <div class="cart-receipt">
                    <table class="table table-receipt no-border">
                        <tr>
                            <td class="alignRight">Tổng cộng</td>
                            <td class="alignLeft" runat="server" id="td_Total">$450.00</td>
                        </tr>
                        <tr>
                            <td class="alignRight">Được giảm</td>
                            <td class="alignLeft" runat="server" id="td_Bonus">$50.00</td>
                        </tr>
                        <tr>
                            <td class="alignRight">
                                <h2>Cần thanh toán</h2>
                            </td>
                            <td class="alignLeft">
                                <h2 runat="server" id="h2_Amount">$400.00</h2>
                            </td>
                        </tr>
                        <tr>
                            <td class="alignRight">
                                <asp:Button Text="Chọn thêm sản phẩm khác" class="btn" runat="server" OnClick="Unnamed_Click" />
                            </td>
                            <td class="alignLeft">
                                <asp:LinkButton Text="Lập đơn hàng"
                                    class="btn btn-primary" runat="server"
                                    ID="LinkButton_Checkout"
                                    OnClientClick="return checkoutButtonClick();"
                                    OnClick="LinkButton_Checkout_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
