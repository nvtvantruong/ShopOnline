<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucMessage.ascx.cs" Inherits="ucMessage" %>

<div runat="server" id="SuccessBox" class="alert alert-success inline-msg">
    <b runat="server" id="SuccessTitle"></b>
    <span runat="server" id="SuccessMessage" class="message">Đăng nhập thành công</span>
    <span class="close" title="Ẩn thông báo">X</span>
</div>

<div runat="server" id="InfoBox" class="alert alert-info inline-msg">
    <b runat="server" id="InfoTitle"></b>
    <span runat="server" id="InfoMessage" class="message">Xin mời đăng nhập</span>
    <span class="close" title="Ẩn thông báo">X</span>
</div>

<div runat="server" id="WarningBox" class="alert alert-warning inline-msg">
    <b runat="server" id="WarningTitle"></b>
    <span runat="server" id="WarningMessage" class="message">Xin mời nhập đầy đủ thông tin</span>
    <span class="close" title="Ẩn thông báo">X</span>
</div>

<div runat="server" id="ErrorBox" class="alert alert-danger inline-msg">
    <b runat="server" id="ErrorTitle"></b>
    <span runat="server" id="ErrorMessage" class="message">Tài khoản không hợp lệ</span>
    <span class="close" title="Ẩn thông báo">X</span>
</div>
