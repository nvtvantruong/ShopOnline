<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyUpload.aspx.cs" Inherits="TinymceMyUpload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TinyUpload</title>
    <link href="skins/lightgray/skin.min.css" rel="stylesheet" type="text/css" />
    <script src="0.jquery.1.9.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .mce-btn input.button {
            font-size: 14px;
            line-height: 20px;
            cursor: pointer;
            color: #fff;
            text-shadow: 1px 1px #333;
            text-align: center;
            overflow: visible;
            height: 100%;
            width: 100%;
            -webkit-appearance: none;
        }
    </style>
    <script type="text/javascript">
        function InsertImage() {
            var _url = $(".img-preview").attr("src");
            var _width = $(".input-width").val();
            var _height = $(".input-height").val();
            var _align = $(".select-align").val();

            var imgtag = "<img style='max-width:100%; max-height: 100%;' hspace='5px' src='" + _url + "' alt='" + _url + "'";

            if (_width != "" && _width != "0")
                imgtag += " width='" + _width + "'";

            if (_height != "" && _height != "0")
                imgtag += " height='" + _height + "'";

            if (_align != "" && _align != "0")
                imgtag += " align='" + _align + "'";

            imgtag += " />";

            parent.tinyMCE.activeEditor.selection.setContent(imgtag);
            parent.tinyMCE.activeEditor.windowManager.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--Body--%>
            <div id="mce_84-body" class="mce-container-body mce-abs-layout" style="width: 442px; height: 300px;">
                <div id="mce_84-absend" class="mce-abs-end"></div>
                <div id="mce_85" class="mce-container mce-form mce-first mce-last mce-abs-layout-item"
                    role="undefined" style="left: 0px; top: 0px; width: 442px; height: 150px;">
                    <div id="mce_85-body" class="mce-container-body mce-abs-layout" style="width: 442px; height: 300px;">
                        <div id="mce_85-absend" class="mce-abs-end"></div>
                        <%--1--%>
                        <div class="mce-container mce-first mce-abs-layout-item mce-formitem"
                            hidefocus="1" tabindex="-1" style="left: 20px; top: 20px; width: 402px; height: 30px;">
                            <div id="mce_92-body" class="mce-container-body mce-abs-layout" style="width: 402px; height: 30px;">
                                <div id="mce_92-absend" class="mce-abs-end">
                                </div>
                                <label id="mce_93"
                                    class="mce-widget mce-label mce-first mce-abs-layout-item" for="mce_86"
                                    style="line-height: 16px; left: 0px; top: 7px; width: 121px; height: 16px;">
                                    File
                                </label>
                                <div id="mce_86"
                                    class="mce-combobox mce-last mce-abs-layout-item"
                                    style="left: 121px; top: 0px; width: 281px; height: 30px;">
                                    <asp:FileUpload runat="server" ID="file_Upload" onchange="this.form.submit();" type="file" CssClass="mce-textbox mce-placeholder" Style="width: 271px;" />
                                </div>
                            </div>
                        </div>
                        <%--2--%>
                        <div class="mce-container mce-first mce-abs-layout-item mce-formitem"
                            hidefocus="1" tabindex="-1" style="left: 20px; top: 60px; width: 402px; height: 30px;">
                            <div class="mce-container-body mce-abs-layout" style="width: 402px; height: 30px;">
                                <div class="mce-abs-end">
                                </div>
                                <label class="mce-widget mce-label mce-first mce-abs-layout-item" for="mce_86"
                                    style="line-height: 16px; left: 0px; top: 7px; width: 121px; height: 16px;">
                                    Width x Height
                                </label>
                                <div class="mce-combobox mce-last mce-abs-layout-item"
                                    style="left: 121px; top: 0px; width: 60px; height: 30px;">
                                    <input runat="server" id="input_width" class="input-width mce-textbox mce-placeholder" style="width: 50px;">
                                </div>
                                <label class="mce-widget mce-label mce-first mce-abs-layout-item" for="mce_86"
                                    style="line-height: 16px; left: 190px; top: 7px; width: 20px; height: 16px;">
                                    x
                                </label>
                                <div class="mce-combobox mce-last mce-abs-layout-item"
                                    style="left: 210px; top: 0px; width: 60px; height: 30px;">
                                    <input runat="server" id="input_height" class="input-height mce-textbox mce-placeholder" style="width: 50px;">
                                </div>
                                <div class="mce-combobox mce-last mce-abs-layout-item"
                                    style="right: 22px; top: 0px; width: 60px; height: 30px;">
                                    <select runat="server" id="select_Align" class="select-align mce-textbox mce-placeholder" hidefocus="true" style="width: 80px; padding: 0">
                                        <option value="">--Align--</option>
                                        <option value="">none</option>
                                        <option value="left">left</option>
                                        <option value="right">right</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <%--3--%>
                        <div class="mce-container mce-first mce-abs-layout-item mce-formitem"
                            hidefocus="1" tabindex="-1" style="left: 20px; top: 100px; width: 402px; height: 190px;">
                            <div id="Div6" class="mce-container-body mce-abs-layout" style="width: 402px; height: 190px;">
                                <div id="Div7" class="mce-abs-end">
                                </div>
                                <label id="Label2"
                                    class="mce-widget mce-label mce-first mce-abs-layout-item" for="mce_86"
                                    style="line-height: 16px; left: 0px; top: 7px; width: 121px; height: 16px;">
                                    Preview
                                </label>
                                <div id="Div8"
                                    class="mce-combobox mce-last mce-abs-layout-item"
                                    style="left: 121px; top: 0px; width: 200px; height: 185px;">
                                    <img class="img-preview" runat="server" id="img_Preview" alt="Chưa chọn hình" style="border: 0px solid; width: 279px; height: 185px;" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--Footer--%>
            <div id="mce_89" class="mce-container mce-panel mce-foot" hidefocus="1" tabindex="-1"
                style="border-width: 1px 0px 0px; left: 0px; top: 0px; width: 442px; height: 50px;">
                <div id="mce_89-body" class="mce-container-body mce-abs-layout" style="width: 442px; height: 50px;">
                    <div id="mce_89-absend" class="mce-abs-end">
                    </div>
                    <div id="mce_90" class="mce-widget mce-btn mce-primary mce-first mce-abs-layout-item"
                        tabindex="-1" role="button" style="left: 311px; top: 10px; width: 50px; height: 28px;">
                        <asp:Button runat="server" role="presentation" CssClass="button" TabIndex="-1"
                            Style="height: 100%; width: 100%;" Text="OK" ID="Button_OK"
                            OnClientClick="InsertImage(); return false;" />
                    </div>
                    <div id="mce_91" class="mce-widget mce-btn mce-last mce-abs-layout-item" tabindex="-1"
                        role="button" style="left: 366px; top: 10px; width: 64px; height: 28px;">
                        <asp:Button Text="Cancel" runat="server" role="presentation" TabIndex="-1"
                            Style="height: 100%; width: 100%; padding-left: 10px;" ID="Button_Cancel"
                            OnClientClick="parent.tinyMCEClose();return false;" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
