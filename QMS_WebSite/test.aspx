<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="QMS_WebSite.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" Height="21px" />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </div>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />
        <br />
        <br />
        <br />
        <br />
    </form>
</body>
</html>
