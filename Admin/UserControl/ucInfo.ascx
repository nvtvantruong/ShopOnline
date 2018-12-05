<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucInfo.ascx.cs" Inherits="ucInfo" %>

<div class="breadLine">
    <div class="arrow"></div>
    <div class="adminControl active">
        Xin chào, <b runat="server" id="b_Username">Khách</b>
    </div>
</div>

<div class="admin">
    <div class="image">
        <img runat="server" id="img_Avatar" src="../img/no-avatar.png"  class="use-avatar" />
    </div>
    <ul class="control">
        <li>
            <span class="icon-user"></span>
            <a runat="server" id="a_FullName" >No Name</a>
        </li>
        <li>
            <span class="icon-cog"></span>
            <a runat="server" href="~/Admin/ChangePassword.aspx">Đổi mật khẩu</a>
        </li>
        <li>
            <span class="icon-off"></span>
            <asp:LinkButton Text="Thoát" runat="server" ID="LinkButton_Logout" OnClick="LinkButton_Logout_Click" />
        </li>
    </ul>
</div>
