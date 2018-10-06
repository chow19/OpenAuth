<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QMS_WebSite.Default" %>

<!doctype html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Index</title>
    <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.min.css" />
    <link rel="stylesheet" href="Scripts/jquery-weui-1-2-min.css" />
    <link href="CSS/demos.css" rel="stylesheet" />

    <script src="scripts/jquery-weui/lib/jquery-2.1.4.js"></script>
    <script src="scripts/jquery-weui/lib/fastclick.js"></script>
    <script src="scripts/template.js"></script>

    <script src="Scripts/jquery1-2-weui.js"></script>
    <link rel="stylesheet" href="css/page.css" />
    <script src="scripts/mobilebridge.js?1"></script>

    <script>

        $(function () {
            $("#IQCJump").on("click", function () {
                $M.open("IQC_Portal.ASPX", "IQC");
            });
            
            $("#IPQCJump").on("click", function () {
                $M.open("IPQC_FirstCheck.aspx", "IPQC-首检");
            });

            $("#IPQCRJump").on("click", function () {
                $M.open("IPQC_Route.aspx", "IPQC-巡检");
            });
            $("#FQCPackJump").on("click", function () {
                $M.open("FQCPack_Portal.aspx", "FQC-包装");
            });

            $("#FQCJump").on("click", function () {
                $M.open("FQC_Portal.aspx", "FQC");
            });

            $("#OQCJump").on("click", function () {
                $M.open("OQC_Portal.aspx", "OQC");
            });

            $("#IQCReportJump").on("click", function() {
               $Mopen("IQC_Report.aspx","IQCReport");
            });
        })
    </script>

</head>
<body>
    <header class='demos-header'>
        <h1 class="demos-title">欢迎您</h1>
    </header>
    <div class="weui-grids">
       
        <a href="javascript:" class="weui-grid js_grid" id="IQCJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_cell.png" alt="">
            </div>
            <p class="weui-grid__label">
                 IQC
            </p>
        </a> 
        <a href="javascript:" class="weui-grid js_grid" id="IPQCJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_cell.png" alt="">
            </div>
            <p class="weui-grid__label">
               IPQC-首检
            </p>
        </a> 
        <a href="javascript:" class="weui-grid js_grid" id="IPQCRJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_toast.png" alt="">
            </div>
            <p class="weui-grid__label">
                IPQC-巡检
            </p>
        </a>
        <a href="javascript:" class="weui-grid js_grid" id="FQCPackJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_dialog.png" alt="">
            </div>
            <p class="weui-grid__label">
              包装-首捡/巡检
            </p>
        </a>
        <a href="javascript:" class="weui-grid js_grid" id="FQCJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_dialog.png" alt="">
            </div>
            <p class="weui-grid__label">
              FQC
            </p>
        </a>
     
        <a href="javascript:" class="weui-grid js_grid" id="OQCJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_msg.png" alt="">
            </div>
            <p class="weui-grid__label">
                OQC 
            </p>
        </a>

        <a href="javascript:" class="weui-grid js_grid" id="IQCReportJump">
            <div class="weui-grid__icon">
                <img src="images/icon_nav_article.png" alt="">
            </div>
            <p class="weui-grid__label">
                IQCReport 
            </p>
        </a>
       
    </div>
</body>
</html>
