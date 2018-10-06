<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IQCReport.aspx.cs" Inherits="QMS_WebSite.IQCReport" %>

<!DOCTYPE html>

<html >
<head >
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>IQCReport</title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css" />
    <script src="scripts/jquery-2.1.4.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>

    <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.min.css" />
    <link rel="stylesheet" href="scripts/jquery-weui-1-2-min.css" />
    <link href="CSS/demos.css" rel="stylesheet" />


    <script src="scripts/jquery-weui/lib/jquery-2.1.4.js"></script>
    <script src="scripts/jquery-weui/lib/fastclick.js"></script>
    <script src="scripts/template.js"></script>

    <script src="scripts/jquery1-2-weui.js"></script>
    <link rel="stylesheet" href="css/page.css" />
    <script src="scripts/mobilebridge.js?1"></script>


    <style>
        .spName {
            width: 80px;
            height: 20px;
            margin: 0px 10px;
            font-weight: bold;
            float: left;
        }

        .spDetails {
            width: 180px;
            height: 20px;
            margin: 0px 10px;
            float: left;
        }
    </style>
    <script>
        var loading = false;  //状态标记
        var curpage = 1;
        var curpage2 = 1;
        var curpage3 = 1;
        $(function () {

            FastClick.attach(document.body);
            //下拉刷新
            $(document.body).pullToRefresh(
                function () {
                    location.href = location.href;
                }
              );
            $(document.body).pullToRefreshDone();

            ////滚动加载                
            //$(".infinite").infinite().on("infinite", function () {

            //    var self = this;

            //    if (self.loading) return;
            //    self.loading = true;

            //    //setTimeout(function () {
            //    curpage++;
            //    getData(curpage);
            //    self.loading = false;
            //    //}, 1000);   //模拟延迟
            //});

            getData(curpage);
        })

        function getData(curPage) {
            $.ajax({
                url: "Handler/SendQCReportList.ashx?ResultType=3&curPage=" + curPage,
                type: "Get",
                cache: false,
                success: function (data) {

                    if (data.result = "0") {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tpl', jsonData); //套模版出html
                        $(".tr").after(html); //填充到目标div
                        $("#IQCReportTable").addClass("table table-striped table-bordered")

                        $(document.body).pullToRefreshDone();

                        if (jsonData.data.length == 0) {
                            $(document.body).destroyInfinite();
                        }
                    } else {
                        $.toast(data.msg, "forbidden");
                    }
                    $(".weui-loadmore").remove();
                    $(".all_shown").show();
                }
            });
        }
    </script>

     <script id="row_tpl" type="text/html">
        {{each data}}
                     <tr class="tr">
                         <td class="td">{{$value.SendQCReportId}}</td>
                         <td class="td">{{$value.CreateDate}}</td>
                         <td class="td">{{$value.VendorName}}</td>
                         <td class="td">{{$value.ProductName}}</td>
                         <td class="td">{{$value.ProductDescription}}</td>
                         <td class="td">{{$value.POName}}</td>
                         <td class="td">{{$value.DeliveryQty}}</td>
                         <%--<td class="td">{{value.IQCShortStatus}}</td>--%>
                         <td class="td">{{include 'cell_IQCShortStatus' $value}}</td>
                         <td class="td">{{$value.QCResult}}</td>
                     </tr>
<%--                     <tr >
                         <td class="warning">{{value.SendQCReportId}}</td>
                         <td>{{value.CreateDate}}</td>
                         <td>{{value.VendorName}}</td>
                        <td>{{value.ProductName}}</td>
                         <td>{{value.ProductDescription}}</td>
                         <td>{{value.POName}}</td>
                         <td>{{value.DeliveryQty}}</td>
                         <td>{{value.IQCStatus}}</td>
                         <td>{{value.IQCResult}}</td>
                         <td>{{value.QCResult}}</td>
                     </tr>--%>
        {{/each}}	
    </script>
    <script id="cell_IQCShortStatus" type="text/html">
        {{each IQCShortStatus}}
                            <a>{{$value.SendQCReportResultId}}  {{if $value.CheckNo=="0"}}首{{else}}第{{$value.CheckNo}}{{/if}}抽  数量：{{$value.CQty}}  结果：{{if $value.CheckResult=="1"}}全部接收{{else if $value.CheckResult=="2"}}让步接受{{else if $value.CheckResult=="3"}}挑选接受{{else if $value.CheckResult=="4"}}免检{{else if $value.CheckResult=="5"}}全部拒收{{else}}{{$value.CheckResult}}{{/if}}</a>
        {{/each}}
    </script>
<%--    <script>
        var $table = $("#IQCReportTable");
        $(function(){
            refFlushChart();
        });

        function refFlushChart(){
            $.ajax({
                url : "${pageContext.request.contextPath}/system/course!selectPage.action",
                type : "get",
                dataType : "json",
                success : function(data) {
                    //var dataObj = eval("(" + JSON.stringify(data.dataGrid) + ")");
                    var dataObj = data.data;
                    alert(dataObj.length);
                    //$table.bootstrapTable('load', jQuery.parseJSON(data.dataGrid));
                    $.each(dataObj,function(index,item){
                        var $tr = $('<tr>');
                        $.each(item,function(name,val){
                            var $td = $('<td>').html(val);
                            $tr.append($td);
                        });
                        $table.append($tr);
                    });
                }
            });
    </script>--%>
</head>
<body>
    <!-- body 顶部加上如下代码 -->
    <div class="weui-pull-to-refresh__layer">
        <div class='weui-pull-to-refresh__arrow'></div>
        <div class='weui-pull-to-refresh__preloader'></div>
        <div class="down">下拉刷新</div>
        <div class="up">释放刷新</div>
        <div class="refresh">正在刷新</div>
    </div>

    <div class="table-responsive" >
        <table  id ="IQCReportTable">
            <tr class="tr">
                <th class="th" data-field="SendQCReportId">Id</th>
                <th class="th" data-field="CreateDate">时间</th>
                <th class="th" data-field="VendorName">供应商</th>
                <th class="th" data-field="ProductName">物料代码</th>
                <th class="th" data-field="ProductDescription">物料名称</th>
                <th class="th" data-field="POName">采购订单</th>
                <th class="th" data-field="DeliveryQty">来料数量</th>
                <th class="th" data-field="IQCStatus">检验详细</th>
                <th class="th" data-field="QCResult">处理结果</th>
            </tr>              
        </table>
      </div>
</body>
</html>
