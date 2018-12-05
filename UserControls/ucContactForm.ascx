<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucContactForm.ascx.cs" Inherits="ucContactForm" %>
<%@ Register Src="~/UserControls/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>


<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <div class="contact-us-form">
            <div class="titleHeader clearfix">
                <h3>Gửi Thư Trực Tuyến</h3>
            </div>
            <div>
                <div class="controls controls-row">
                    <input runat="server" id="input_FullName" class="span4" type="text" placeholder="Họ tên..." />
                    <input runat="server" id="input_Email" class="span4" type="text" placeholder="Email..." />
                </div>
                <div class="controls controls-row">
                    <input runat="server" id="input_Mobi" class="span4" type="text" placeholder="Số điện thoại..." />
                    <asp:DropDownList class="span4" runat="server" ID="DropDownList_Category" />

                </div>
                <div class="controls">
                    <textarea runat="server" id="textarea_content" class="span8" placeholder="Nội dung liên hệ..."></textarea>
                </div>
                <div class="controls">

                    <%--ucMessage--%>
                    <uc1:ucMessage runat="server" ID="ucMessage" />
                    <asp:Button Text="Gửi thư" runat="server" class="btn btn-primary pull-right margin-top10px"
                        ID="Button_Send" OnClick="Button_Send_Click" />
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
