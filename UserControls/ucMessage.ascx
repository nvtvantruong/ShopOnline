<%@ Control Language="C#" AutoEventWireup="true" Inherits="CodeUtility.MessageUtility" %>

<div runat="server" id="ErrorBox" class="alert alert-error no-margin">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <span runat="server" id="ErrorMessage"></span>
</div>

<div runat="server" id="SuccessBox" class="alert alert-success no-margin">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <span runat="server" id="SuccessMessage"></span>
</div>

<div runat="server" id="InfoBox" class="alert alert-info no-margin">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <span runat="server" id="InfoMessage"></span>
</div>

<div runat="server" id="WarningBox" class="alert alert-warning no-margin">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <span runat="server" id="WarningMessage"></span>
</div>