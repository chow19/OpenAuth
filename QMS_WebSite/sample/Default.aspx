<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="sample_Default" %>
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>开发示例</title>
        <script src="../scripts/mobilebridge.js?2"></script>
    </head>
    <body>
        <input type="button" value="js sdk" onclick="$M.open('jssdk.aspx', 'JSSDK')"/>
        <br /><br />
        <input type="button" value="jqweui" onclick="$M.open('http://jqweui.com/dist/demos/', 'jqweui')"/>
        <br /><br />
        <input type="button" value="weui" onclick="$M.open('https://weui.io/', 'weui')"/>
        <br />
    </body>
</html>
