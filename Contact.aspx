<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<%@ Register Src="~/UserControls/ucContactForm.ascx" TagPrefix="uc1" TagName="ucContactForm" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">
            <div class="span8">

                <div class="titleHeader clearfix">
                    <h3>Hướng Dẫn Đường Đi</h3>
                </div>
                <div class="google-map">
                    <iframe height="246" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1262.7704976609532!2d106.99127821105918!3d11.62522120861912!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x53811cc9378aa5a6!2zVOG6oXAgSMOzYSBOaOG7jw!5e1!3m2!1svi!2sus!4v1511876091427"></iframe>
                </div>

                <%--ucContactForm--%>
                <uc1:ucContactForm runat="server" ID="ucContactForm" />

            </div>

            <div class="span4">
                <div class="contact-info">
                    <div class="titleHeader clearfix">
                        <h3>Thông Tin Liên Hệ</h3>
                    </div>
                    <address>
                        <strong><i class="icon-pushpin"></i>Địa chỉ liên hệ:</strong><br />
                        88 Đại Lộ Bình Dương, P.Phú Thọ, TP.Thủ Dầu Một, T.Bình Dương
                    </address>
                    <address>
                        <strong><i class="icon-volume-up"></i>Điện thoại:</strong><br />
                        <abbr title="Phone">Phòng kinh doanh:</abbr>
                        083.876.678<br />
                        <abbr title="Phone">Phòng kỹ thuật:</abbr>
                        083.876.333<br />
                        <abbr title="Phone">Phòng bảo hành:</abbr>
                        083.876.444<br />
                        <abbr title="Phone">Fax:</abbr>
                        083.876.678
                    </address>
                    <address>
                        <strong><i class="icon-envelope-alt"></i>EMail:</strong><br />
                        <abbr title="Phone">Phòng kinh doanh:</abbr>
                        <a href="#">kinhdoanh@ishop.vn</a><br />
                        <abbr title="Phone">Phòng kỹ thuật:</abbr>
                        <a href="#">kythuat@ishop.vn</a><br />
                        <abbr title="Phone">Phòng bảo hành:</abbr>
                        <a href="#">baohanh@ishop.vn</a>
                    </address>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

