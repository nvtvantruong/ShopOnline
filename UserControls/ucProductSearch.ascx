<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucProductSearch.ascx.cs" Inherits="ucProductSearch" %>

<div class="blog-search">
    <div class="form-search">
        <asp:Panel runat="server" DefaultButton="button_Search" class="input-append">
            <input runat="server" id="input_Search" type="text" class="span8 search-query" placeholder="Tìm sản phẩm theo tên ..." />
            <asp:Button Text="Search" class="btn"
                runat="server" ID="button_Search" OnClick="button_Search_Click" />
        </asp:Panel>
    </div>
</div>
