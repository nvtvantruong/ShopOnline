<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AccountInformation.aspx.cs" Inherits="AccountInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">




            <div class="span9">
                <div class="register">
                    <div class="titleHeader clearfix">
                        <h3>Cập Nhật Thông Tin Tài Khoản</h3>
                    </div>
                    <div class="form-horizontal">
                        <h4>1. Thông tin đăng nhập</h4>
                        <div class="control-group success">
                            <label class="control-label" for="inputFirstName">
                                Email:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" disabled="disabled" />
                                <span class="help-inline"><i class="icon-ok"></i>Email không được phép thay đổi!</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputFirstName">
                                Mật khẩu hiện tại:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputFirstName">
                                Mật khẩu mới:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputFirstName">
                                Nhập lại mật khẩu mới:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" />
                            </div>
                        </div>
                        <div class="control-group success">
                            <label class="control-label">&nbsp;</label>

                            <div class="controls">
                                <a href="#">Đổi mật khẩu</a>
                            </div>
                            <div class="controls">
                                <a href="#">Lưu mật khẩu mới</a> |
                                        <a href="#">Hủy</a>
                            </div>
                            <div class="controls">


                                <div class="alert alert-error no-margin">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    Vui lòng nhập mật khẩu mới 2 lần giống nhau.
                                </div>
                                <div class="alert alert-success no-margin">
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                    Đã lưu mật khẩu mới.
                                </div>

                            </div>
                        </div>
                        <h4>2. Thông tin cá nhân</h4>
                        <div class="control-group">
                            <div class="control-label">
                                Kiểu khách hàng:<span class="text-error">*</span>
                            </div>
                            <div class="controls">
                                <select>
                                    <option value="#">-- Chọn Kiểu Khách Hàng --</option>
                                    <option value="#">Khách hàng cá nhân</option>
                                    <option value="#">Khách hàng tổ chức</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputFirstName">
                                Họ tên:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputFirstName">
                                Số điện thoại:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputConPass">
                                Phái:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" value="1" />
                                    Nam
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="0" />
                                    Nữ
                                </label>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputFirstName">
                                Địa chỉ:<span class="text-error">*</span>
                            </label>
                            <div class="controls">
                                <textarea></textarea>
                            </div>
                        </div>
                        <hr />
                        <div class="control-group">
                            <div class="controls">
                                <button type="submit" class="btn btn-primary">Đăng Ký</button>
                                <div class="margin-top10px">



                                    <div class="alert alert-error no-margin">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        Vui lòng nhập mật khẩu mới 2 lần giống nhau.
                                    </div>
                                    <div class="alert alert-success no-margin">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        Đã lưu mật khẩu mới.
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
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

