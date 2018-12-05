<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Admin_login" %>

<%@ Register Src="~/Admin/UserControl/ucCSS.ascx" TagPrefix="uc1" TagName="ucCSS" %>
<%@ Register Src="~/Admin/UserControl/ucJS.ascx" TagPrefix="uc1" TagName="ucJS" %>
<%@ Register Src="~/Admin/UserControl/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>




<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Nhập Hệ Thống</title>
    <%--ucCSS--%>
    <uc1:ucCSS runat="server" ID="ucCSS" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="loginBlock" style="display: block;">
            <h1 style="text-align: center">Đăng nhập hệ thống</h1>
            <div class="loginForm">
                <!--Username-->
                <div class="control-group">
                    <div class="input-prepend">
                        <span class="add-on"><span class="icon-user"></span></span>
                        <input runat="server" id="input_Username" type="text" placeholder="Username" />
                    </div>
                </div>

                <!--Password-->
                <div class="control-group">
                    <div class="input-prepend">
                        <span class="add-on"><span class="icon-lock"></span></span>
                        <input runat="server" id="input_Password" type="password" placeholder="Password" />
                    </div>
                </div>

                <!--Remember + Login button-->
                <div class="row-fluid">
                    <!--Lưu mật khẩu-->
                    <div class="span8">
                        <div class="control-group" style="margin-top: 5px;">
                            <label class="checkbox">
                                <input type="checkbox" />
                                Lưu mật khẩu trên máy này
                            </label>
                        </div>
                    </div>
                    <!--Nút đăng nhập-->
                    <div class="span4">
                        <asp:Button Text="Đăng nhập" runat="server" ID="Button_Login" OnClick="Button_Login_Click" class="btn btn-block" />
                    </div>
                </div>

                <!--Thông báo-->
                <uc1:ucMessage runat="server" ID="ucMessage" />

                <!--Đường phân cách-->
                <div class="dr"><span></span></div>

                <!--Quên mật khẩu-->
                <div class="controls hidden">
                    <div class="row-fluid">
                        <div class="span12">
                            <button class="btn btn-link btn-block">
                                Quên mật khẩu?
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--ucJS--%>
        <uc1:ucJS runat="server" ID="ucJS" />
    </form>
</body>
</html>
