<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ArticleDetail.aspx.cs" Inherits="Admin_ArticleDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="div_Content" style="text-align: justify; max-width: 100%">
            <asp:Repeater runat="server" ID="Repeater_Main">
                <ItemTemplate>
                    <%# Eval("Content").ToSafetyString().Replace("~/","/")%>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
