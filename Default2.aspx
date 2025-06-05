<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ajaxToolkit:ToolkitScriptManager ID="toolkitScriptManager1" runat="server"></ajaxToolkit:ToolkitScriptManager> 
                       <asp:DropDownList ID="ddlbu" runat="server" CssClass="form-control"></asp:DropDownList>
<asp:CascadingDropDown ID="CFYear" runat="server" Category="BU" TargetControlID="ddlbu"
    BehaviorID="cddlY" LoadingText="Loading Unit..." PromptText="Select Business Unit" ServiceMethod="BindBUdropdown"
    ServicePath="~/DropdownWebservice.asmx">
</asp:CascadingDropDown>
        </div>
    </form>
</body>
</html>
