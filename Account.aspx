<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Account.aspx.cs" Inherits="Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Trang Quản Lí Tài Khoản</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">



            <div class="span9">
                <div class="account-list-outer">
                    <div class="titleHeader clearfix">
                        <h3>Tài Khoản Của Tôi</h3>
                    </div>
                    <ul class="account-list">
                        <li>
                            <a href="#" class="invarseColor"><i class="icon-caret-right"></i>Đổi mật khẩu mới</a>
                        </li>
                        <li>
                            <a href="#" class="invarseColor"><i class="icon-caret-right"></i>Cập nhật thông tin liên lạc</a>
                        </li>
                    </ul>
                    <div class="titleHeader clearfix">
                        <h3>Đơn Hàng Của Tôi</h3>
                    </div>
                    <ul class="account-list">
                        <li>
                            <a href="#" class="invarseColor"><i class="icon-caret-right"></i>Danh Sách Đơn Hàng</a>
                        </li>
                        <li>
                            <a href="#" class="invarseColor"><i class="icon-caret-right"></i>Danh Sách Sản Phẩm Yêu Thích</a>
                        </li>
                    </ul>
                </div>
            </div>




            <div class="span3">
                <div class="titleHeader clearfix">
                    <h3>Trợ Giúp</h3>
                </div>
                <ul class="unstyled my-account">
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn đổi mật khẩu.</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn cập nhật thông tin.</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn quản lý đơn hàng.</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn lưu sản phẩm yêu thích.</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Hướng dẫn hủy đơn hàng đã đặt.</a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
</asp:Content>

