<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ArticleEdit.aspx.cs" Inherits="Admin_ArticleEdit" %>

<%@ Register Src="~/Admin/UserControl/ucMessage.ascx" TagPrefix="uc1" TagName="ucMessage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="content">

        <div class="breadLine">
            <ul class="breadcrumb">
                <!--Nút ẩn/hiện menu bên góc trái-->
                <li>
                    <a href="#" title="Ẩn thanh menu" class="sidebarControl menu-arrow">
                        <span class="icon-arrow-left"></span>
                    </a>
                </li>
                <!--Thanh breadcrumb-->
                <li>
                    <a href="Default.aspx">Bàn Làm Việc</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="ArticleList.aspx">Danh sách tin tức</a>
                    <span class="divider">&gt;</span>
                </li>
                <li>
                    <a href="ArticleEdit.aspx">Thêm mới / Chỉnh sửa tin tức</a>
                </li>
            </ul>
        </div>

        <div class="workplace">
            <!--Tiêu đề-->
            <div class="page-header">
                <h1>Thêm / Chỉnh sửa bản tin
                </h1>
            </div>
            <!--Nội dung-->
            <div class="row-fluid">
                <div class="span12">
                    <div class="head clearfix">
                        <div class="isw-list">
                        </div>
                        <h1>Đăng / cập nhật tin tức
                        </h1>
                    </div>
                    <div class="block-fluid customize accordion">
                        <h3>Thông tin cơ bản
                        </h3>
                        <div class="article-basic-info">
                            <div>
                                <!-- Danh mục -->
                                <div class="row-form clearfix">
                                    <div class="span2">
                                        Loại danh mục:
                                    </div>
                                    <div class="span10">
                                        <asp:DropDownList ID="DropDownList_Category" runat="server" />
                                    </div>
                                </div>
                                <!--Mã số + vị trí-->
                                <div class="row-form clearfix">
                                    <div class="span2">
                                        Mã số:
                                    </div>
                                    <div class="span2">
                                        <input runat="server" id="input_ID" type="text" class="tipb" readonly="readonly" title="Mã số tự động (không cần nhập)" />
                                    </div>
                                    <div class="span1">
                                        Vị trí:
                                    </div>
                                    <div class="span1" style="margin-left: 2px;">
                                        <input runat="server" id="input_Possition" type="text" class="tipb" title="Dùng để sắp xếp thứ tự" />
                                    </div>
                                    <div class="span1">
                                        Code:
                                    </div>
                                    <div class="span2">
                                        <input runat="server" id="input_Code" type="text" class="tipb" title="Dùng để tìm kiếm hoặc phân loại" />
                                    </div>
                                    <div class="span3">
                                        <span>(Vị trí và Code: được phép để trống)</span>
                                    </div>
                                </div>
                                <!--Tiêu đề-->
                                <div class="row-form clearfix">
                                    <div class="span2">
                                        Tiêu đề:
                                    </div>
                                    <div class="span10">
                                        <input runat="server" id="input_Title" type="text" />
                                        <span>Tiêu đề của bài báo. Nhập ngắn gọn, thể hiện đúng nội dung chính.</span>
                                    </div>
                                </div>
                                <!--Mô tả-->
                                <div class="row-form clearfix">
                                    <div class="span2">
                                        Mô tả:
                                    </div>
                                    <div class="span10">
                                        <textarea runat="server" id="textarea_Description" style="min-height: 100px; width: 100%;"></textarea>
                                        <span>Tóm tắt ngắn gọn nội dung của bài báo.</span>
                                    </div>
                                </div>
                                <!--Hình đại diện-->
                                <div class="row-form clearfix">
                                    <div class="span2">
                                        Hình đại diện:
                                    </div>
                                    <div class="span10">
                                        <a runat="server" id="a_Avatar" href="../css/img/no_image.jpg" class="fancybox lightbox-preview" rel="group">
                                            <img runat="server" id="img_Avatar" src="../css/img/no_image.jpg" alt="avatar" class="default-image img-polaroid avatar-preview" style="width: 180px; height: 135px;" />
                                        </a>
                                        <br />
                                        <asp:FileUpload runat="server" ID="FileUpload_Avatar" class="skip" preview="avatar-preview" />
                                        <br />
                                        <span>Hình đại diện cho bài báo. Bạn có thể upload hình mới nếu muốn.
                                                    Các Loại file hỗ trợ: *.jpg, *.jpeg, *.gif, *.png
                                        </span>
                                    </div>
                                </div>
                                <!--Trích nguồn-->
                                        <div class="row-form clearfix">
                                            <div class="span2">
                                                Trích nguồn:
                                            </div>
                                            <div class="span2">
                                                <input runat="server" id="input_SourcePage" type="text" />
                                                <span>Tên trang nguồn. VD: Dân Trí</span>
                                            </div>
                                            <div class="span2" style="text-align: right">
                                                Link nguồn:
                                            </div>
                                            <div class="span6">
                                                <input runat="server" id="input_SourceLink" type="text" />
                                                <span>Liên kết trỏ đến bài ở trang nguồn nào? VD: http://dantri.com/tinmoi/index.html?id=1</span>
                                            </div>
                                        </div>
                                <!--Trạng thái-->
                                <div class="row-form clearfix">
                                    <div class="span2">
                                        Trạng thái:
                                    </div>
                                    <div class="span10">
                                        <label class="checkbox inline">
                                            <input runat="server" id="radio_Active" type="radio" checked />
                                            Cho phép hiển thị
                                        </label>
                                        <label class="checkbox inline">
                                            <input runat="server" id="radio_Lock" type="radio" />
                                            Tạm ẩn
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <h3>Nội dung chi tiết
                        </h3>
                        <div class="block-fluid article-detail-content" style="overflow: hidden;">
                            <textarea runat="server" id="textarea_Content" style="height: 100%; width: 100%" class="tinyeditor"></textarea>
                        </div>
                        <h3>SEO Tag
                        </h3>
                        <div class="article-seotag-info">
                            <div class="row-form clearfix">
                                <div class="span2">
                                    Từ khóa:
                                </div>
                                <div class="span10">
                                    <input runat="server" id="input_Keyword" type="text" />
                                    <span>- Nhập các từ khóa chính của bài báo này. Điều này sẽ giúp trang tin có vị trí tốt trên google.com.vn.
                                                <br />
                                        - VD: bất động sản, bảng giá đất HCM, ...
                                                <br />
                                        - Phân cách các từ khóa bằng dấu phảy. Nên sử dụng tiếng Việt có dấu
                                    </span>
                                </div>
                            </div>
                        </div>
                        <h3>Thông tin khác
                        </h3>
                        <div class="article-other-info">
                            <div class="row-form clearfix">
                                <div class="span2">
                                    Người đăng:
                                </div>
                                <div class="span10">
                                    <input runat="server" id="input_CreateBy" type="text" readonly="readonly" />
                                    <span>Tự động Lưu của người đăng. Không cho phép chỉnh sửa.
                                    </span>
                                </div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span2">
                                    Ngày giờ đăng:
                                </div>
                                <div class="span10">
                                    <input runat="server" id="input_CreateTime" type="text" readonly="readonly" />
                                    <span>Tự động lưu ngày giờ đăng bài theo giờ hệ thống. Không cho phép chỉnh sửa
                                    </span>
                                </div>
                            </div>
                            <div class="row-form clearfix">
                                <div class="span2">
                                    Tổng lượt xem:
                                </div>
                                <div class="span10">
                                    <input runat="server" id="input_ViewTime" type="text" readonly="readonly" />
                                    <span>Mỗi lần khách truy cập vào bài này, lượt xem sẽ tăng lên 1. Không cho phép chỉnh sửa.
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Button-->
            <div class="row-fluid">
                <div class="span12" style="margin-top: -20px; background-color: #F2F2F2;">
                    <div class="block-fluid  customize">
                        <div class="row-form clearfix">
                            <div class="span2">
                                <asp:LinkButton runat="server" ID="LinkButton_Save" class="btn mybtn" OnClick="LinkButton_Save_Click">
                                    <i class="isw-save"></i>Lưu
                                </asp:LinkButton>
                            </div>
                            <div class="span10">

                                <!--Thông báo-->
                                <uc1:ucMessage runat="server" ID="ucMessage" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Link trở về-->
            <div class="tar">
                <a href="ArticleList.aspx" type="button" class="btn active">
                    <i class="icon-arrow-left"></i>Trở về trang tin tức
                </a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="Server">
</asp:Content>

