<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AccountLogin.aspx.cs" Inherits="AccountLogin" %>

<%@ Register Src="~/UserControls/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">

            <div class="span9">
                <div class="login">
                    <table>
                        <tr>
                            <td>
                                <h3>Khách Hàng Mới</h3>
                                <p>
                                    Hãy đăng ký làm thành viên để nhận được nhiều ưu đãi hơn khi mua sắm tại đây.
                                </p>
                                <a runat="server" href="~/AccountRegister.aspx" class="btn">Đăng ký thành viên</a>
                            </td>
                            <td>
                                <h3>Khách Hàng Thành Viên</h3>
                                <p>
                                    Xin mời đăng nhập bằng tài khoản thành viên của bạn.
                                </p>
                                <div>
                                    <div class="controls">
                                        <input runat="server" id="input_Email" type="text" placeholder="email" />
                                        <span class="text-error">*</span>
                                    </div>
                                    <div class="controls">
                                        <input runat="server" id="input_Password" type="password" placeholder="password" />
                                        <span class="text-error">*</span>
                                    </div>
                                    <div class="controls">
                                        <uc1:ucMessage runat="server" ID="ucMessage" />
                                    </div>

                                    <div class="controls">
                                        <label class="checkbox">
                                            <input type="checkbox" />
                                            Lưu mật khẩu trên máy này
                                        </label>
                                        <asp:Button Text="Đăng nhập" class="btn btn-primary"  runat="server" ID="Button_Login" OnClick="Button_Login_Click" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="span3">
                <div class="titleHeader clearfix">
                    <h3>Trợ giúp</h3>
                </div>
                <ul class="unstyled my-account">
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn đăng ký</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn đăng nhập</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Khôi phục mật khẩu bị mất</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Liên hệ với ban quản trị website</a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
</asp:Content>

