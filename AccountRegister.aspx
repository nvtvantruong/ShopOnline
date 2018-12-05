<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AccountRegister.aspx.cs" Inherits="AccountRegister" %>

<%@ Register Src="~/UserControls/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">

            <div class="span9">
                <div class="register">
                    <div class="titleHeader clearfix">
                        <h3>Đăng Ký Thành Viên</h3>
                    </div>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="form-horizontal">
                                <h4>1. Thông tin đăng nhập</h4>
                                <div class="control-group success">
                                    <label class="control-label" for="inputFirstName">
                                        Email:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" runat="server" id="input_Email" />
                                        <span class="help-inline"><i class="icon-ok"></i>Email sẽ được sử dụng như tên đăng nhập.</span>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputFirstName">
                                        Mật khẩu:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="password" runat="server" id="input_Password" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputFirstName">
                                        Nhập lại mật khẩu:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="password" runat="server" id="input_Repassword" />
                                    </div>
                                </div>
                                <h4>2. Thông tin cá nhân</h4>
                                <div class="control-group">
                                    <div class="control-label">
                                        Kiểu khách hàng:
                                        <span class="text-error">*</span>
                                    </div>
                                    <div class="controls">
                                        <asp:DropDownList runat="server" ID="DropDownList_Category" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputFirstName">
                                        Họ tên:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" runat="server" id="input_Fullname" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputFirstName">
                                        Số điện thoại:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" runat="server" id="input_Mobil" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputConPass">
                                        Phái:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <label class="radio inline">
                                            <input type="radio" name="render" runat="server" id="input_GenderMale" />
                                            Nam
                                        </label>
                                        <label class="radio inline">
                                            <input type="radio" name="render" runat="server" id="input_GenderFemale" />
                                            Nữ
                                        </label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputFirstName">
                                        Địa chỉ:
                                        <span class="text-error">*</span>
                                    </label>
                                    <div class="controls">
                                        <textarea runat="server" id="textarea_Address"></textarea>
                                    </div>
                                </div>
                                <hr />
                                <div class="control-group">
                                    <div class="controls">
                                        <label class="checkbox">
                                            <input type="checkbox" runat="server" id="input_Rule" />
                                            Tôi đã đọc và đồng ý với
                                    <a href="#">nội quy</a>
                                            do website quy định.
                                        </label>

                                        <uc1:ucMessage runat="server" ID="ucMessage" />
                                        <asp:Button Text="Đăng Ký" class="btn btn-primary margin-top10px" runat="server" ID="Button_OK" OnClick="Button_OK_Click" />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div class="span3">
                <div class="titleHeader clearfix">
                    <h3>Trợ Giúp</h3>
                </div>
                <ul class="unstyled my-account">
                    <li>
                        <a class="invarseColor" href="#">
                            <i class="icon-caret-right"></i>
                            Đăng nhập
                        </a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#">
                            <i class="icon-caret-right"></i>
                            Khôi phục mật khẩu bị mất
                        </a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#">
                            <i class="icon-caret-right"></i>
                            Liên hệ với ban quản trị
                        </a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#">
                            <i class="icon-caret-right"></i>
                            Quay lại trang trước
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
</asp:Content>

