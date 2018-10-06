<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IQC_Portal.aspx.cs" Inherits="QMS_WebSite.IQC_Portal" %>

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

            //滚动加载                
            $(".infinite").infinite().on("infinite", function () {

                var self = this;
                var data_toggle = $(this).attr("id");

                if (self.loading) return;
                self.loading = true;

                //setTimeout(function () { 
                if (data_toggle == "tab2") {
                    curpage2++;
                    getDoneData(curpage2);
                } else if (data_toggle == "tab3") {
                    curpage3++;
                    getPlanDoneData(curpage3);
                } else {
                    curpage++;
                    getData(curpage);
                }
                self.loading = false;
                //}, 1000);   //模拟延迟
            });

            getData(curpage);

            getDoneData(curpage2);

            getPlanDoneData(curpage3);
            Scan();
        })


        //ios设备就绪的方法
        function onDeviceReady() {
            $M.setButton("[{\"function\":\"Scan\",\"title\":\"扫描抽样\"}]");
            // $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        };

        function Scan() {
            var tabid = $(".weui-tab__bd-item--active").eq(0).attr("id");
            var isQ = 0;
            if (tabid == "tab1") {
                isQ = 0;
            } else if (tabid == "tab2") {
                isQ = 1;
            }
            //var qrcode = "RB08900000001";
            $M.scanQrcode(function (qrcode) {

                $.ajax({
                    url: "Handler/IQC.ashx?FunType=getScanInfo&IsQ=" + isQ + "&ScanLotSN=" + qrcode,
                    type: "Get",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) {
                        $M.alert("error");
                    },
                    success: function (data) {
                        try {

                            var jsonData = eval("(" + data + ")");

                            if (jsonData.result == 0) {
                                var ProductShortName = jsonData.data[0].ProductShortName;
                                var SendQCReportId = jsonData.data[0].SendQCReportId;

                                if (isQ == 0) {
                                    var JYID = $("#JY" + SendQCReportId);
                                    if (JYID.length > 0) {
                                        switch (ProductShortName.substring(0, 1)) {
                                            case "B"://玻璃 
                                                $M.open("IQC/add/GlassIQC_Check.aspx?SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "送检单检验");
                                                break;
                                            case "C"://原材料
                                                $M.open("IQC/add/RawMaterialIQC_Check.aspx?SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "送检单检验");
                                                break;
                                            case "F"://辅料
                                            case "E"://辅料
                                            case "D"://辅料
                                                $M.open("IQC/add/AuxIQC_Check.aspx?SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "送检单检验");//"&ScanProductDesc=" + ScanProductDesc + 
                                                break;
                                        }
                                    } else {
                                        $M.open("GetSpecimens.aspx?IsDone=0&SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "来料送检抽样");
                                    }
                                } else {
                                    showCheckDetail(SendQCReportId, ProductShortName);
                                }
                            }
                            else {
                                $M.alert(jsonData.msg);
                            }
                        } catch (e) {
                            $M.alert("AJAX错误:" + e.message);
                        }
                    }
                });
            });
            return;

        }
        function getData(curPage) {
            $.ajax({
                url: "Handler/SendQCReportList.ashx?ResultType=1&curPage=" + curPage,
                type: "Get",
                cache: false,
                success: function (data) {
                    if (data.result = "0") {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tpl', jsonData); //套模版出html
                        $("#list").append(html); //填充到目标div 
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

        function getPlanDoneData(curPage) {

            //$.ajax({
            //    url: "Handler/SendQCReportList.ashx?ResultType=--&curPage=" + curPage,
            //    type: "Get",
            //    cache: false,
            //    success: function (data) {
            //        if (data.result = "0") {
            //            var jsonData = eval("(" + data + ")");
            //            var html = template('row_tpl', jsonData); //套模版出html
            //            $("#listPlan").append(html); //填充到目标div

            //            $(document.body).pullToRefreshDone();
            //            loading = false;
            //            if (jsonData.data.length == 0) {
            //                $(".infinite").destroyInfinite();
            //            }
            //        } else {
            //            $.toast(data.msg, "forbidden");
            //        }
            //        $(".weui-loadmore").remove();
            //        $(".all_shown").show();
            //    }
            //});
        }

        function getDoneData(curPage) {
            $.ajax({
                url: "Handler/SendQCReportList.ashx?ResultType=2&curPage=" + curPage,
                type: "Get",
                cache: false,
                success: function (data) {

                    if (data.result = "0") {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tplDone', jsonData); //套模版出html

                        $("#listDone").append(html); //填充到目标div 
                        $(document.body).pullToRefreshDone();

                        if (jsonData.data.length == 0) {
                            $(".infinite").destroyInfinite();

                        }
                    } else {
                        $.toast(data.msg, "forbidden");
                    }
                    $(".weui-loadmore").remove();
                    $(".all_shown").show();
                }
            });
        }

        function AddCheckDetail(SendQCReportId, ProductShortName) {

            switch (ProductShortName.substring(0, 1)) {
                case "F"://辅料
                case "E"://辅料
                case "D"://辅料
                    $M.open("IQC/add/AuxIQC_Check.aspx?SendQCReportId=" + SendQCReportId, "送检单检验");//"&ScanProductDesc=" + ScanProductDesc + 
                    return;
            }

            //var qrcode = "YB1808140001N";
            //验证是否已经抽样 
            $M.scanBarcode(function (qrcode) {
                $.ajax({
                    url: "Handler/IQC.ashx?FunType=getInfoByYBSN&SendQCReportId=" + SendQCReportId + "&" + "ScanLotSN=" + qrcode,
                    type: "Get",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) {
                        $M.alert("error");
                    },
                    success: function (data) {
                        try {
                            var jsonData = eval("(" + data + ")");
                            if (jsonData.result == 0) {
                                var ProductShortName = jsonData.data[0].ProductShortName;
                                //var ScanProductDesc = jsonData.data[0].ProductDescription;
                                switch (ProductShortName.substring(0, 1)) {
                                    case "B"://玻璃 
                                        $M.open("IQC/add/GlassIQC_Check.aspx?SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "送检单检验");
                                        break;
                                    case "C"://原材料
                                        $M.open("IQC/add/RawMaterialIQC_Check.aspx?SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "送检单检验");
                                        break;
                                }
                            }
                            else {
                                $M.alert(jsonData.msg);
                            }
                        } catch (e) {
                            $M.alert("AJAX错误:" + e.message);
                        }
                    }
                });

            })
            // $M.open("RawMaterialIQC_Check.aspx?SendQCReportId=" + SendQCReportId, "送检单检验");
        }

        function CheckSpecimen(SendQCReportId, IsDone) {

            if (IsDone == 1) {
                $M.open("GetSpecimens.aspx?IsDone=" + IsDone + "&SendQCReportId=" + SendQCReportId + "&qrcode=", "来料送检抽样");
                return;
            } else {
                $M.scanQrcode(function (qrcode) {
                    $.ajax({
                        url: "Handler/IQC.ashx?SendQCReportId=" + SendQCReportId + "&" + "ScanLotSN=" + qrcode,
                        type: "Get",
                        cache: false,
                        error: function (XMLHttpRequest, textStatus, e) {
                            $M.alert("AJAX数据异常");
                        },
                        success: function (data) {
                            try {
                                var jsonData = eval("(" + data + ")");
                                if (jsonData.result == 0) {
                                    //var ScanProductDesc = jsonData.data[0].ProductDescription;
                                    $M.open("GetSpecimens.aspx?IsDone=" + IsDone + "&SendQCReportId=" + SendQCReportId + "&qrcode=" + qrcode, "来料送检抽样");
                                }
                                else {
                                    $M.alert(jsonData.msg);
                                }

                            } catch (e) {
                                $M.alert(e.message);
                            }
                        }
                    });

                })
            }
        }

        function showCheckDetail(SendQCReportId, ProductShortName) {
            if (ProductShortName.length <= 0) {
                $M.alert("数据错误");
                return;
            }
            switch (ProductShortName.substring(0, 1)) {
                case "B"://玻璃 
                    $M.open("IQC/Show/ShowCheckResultBInfo.aspx?SendQCReportId=" + SendQCReportId, "抽样检验结果");
                    break;
                case "C"://原材料
                    $M.open("IQC/Show/ShowCheckResultRMInfo.aspx?SendQCReportId=" + SendQCReportId, "抽样检验结果");
                    break;
                case "E"://辅料
                case "F"://辅料
                case "D"://辅料
                    $M.open("IQC/Show/ShowCheckResultDFInfo.aspx?SendQCReportId=" + SendQCReportId, "抽样检验结果");
                    break;
            }
        }

    </script>
    <script id="row_tpl" type="text/html">
        {{each data as value i}}
                     <div class="weui-cell">
                         <div class="weui-cell__bd">
                             <div>
                       
                                 {{if value.pcName=='B'}}
                                 <span class="weui-form-preview__value" style="color: blue">采购单：{{value.POName}}  </span>
                                 <span class="weui-form-preview__value" style="color: blue">供应商：{{value.VendorName}}</span>
                                 <span class="weui-form-preview__value" style="color: blue">物料代码：{{value.ProductShortName}}</span>
                                 {{else if value.pcName=='C'}}
                                  <span class="weui-form-preview__value" style="color: red">采购单：{{value.POName}}  </span>
                                 <span class="weui-form-preview__value"  style="color: red">供应商：{{value.VendorName}}</span>
                                  <span class="weui-form-preview__value" style="color: red">物料代码：{{value.ProductShortName}}</span>
                                 {{else }}
                               <span class="weui-form-preview__value" >采购单：{{value.POName}}  </span>
                                 <span class="weui-form-preview__value">供应商：{{value.VendorName}}</span>
                                 <span class="weui-form-preview__value">物料代码：{{value.ProductShortName}}</span>
                                 {{/if}}
                             </div>
                             <div>
                                 {{if value.pcName=='B'}}
                                 <span class="weui-form-preview__value" style="color: blue">物料描述：{{value.ProductDescription}}</span>
                                 <span class="weui-form-preview__value" style="color: blue">送货数量：{{value.SendQCQty}}</span>
                                 <span class="weui-form-preview__value" style="color: blue">送检时间：{{value.SendDate}}</span> 
                                 {{else if value.pcName=='C'}}
                                 <span class="weui-form-preview__value" style="color: red">物料描述：{{value.ProductDescription}}</span>
                                 <span class="weui-form-preview__value" style="color: red">送货数量：{{value.SendQCQty}}</span>
                                 <span class="weui-form-preview__value" style="color: red">送检时间：{{value.SendDate}}</span> 
                                 {{else }}
                                 <span class="weui-form-preview__value" >物料描述：{{value.ProductDescription}}</span>
                                 <span class="weui-form-preview__value" >送货数量：{{value.SendQCQty}}</span>
                                 <span class="weui-form-preview__value" >送检时间：{{value.SendDate}}</span> 
                                 {{/if}}
                                
                             </div>
                             <div>
                                 {{if value.IsCYDone!="" }}
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn" onclick="CheckSpecimen('{{value.SendQCReportId}}',1);">已抽样</a>
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="AddCheckDetail('{{value.SendQCReportId}}','{{value.ProductShortName}}');" id="JY{{value.SendQCReportId}}">检验</a>
                                 {{else}}
                                  <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="CheckSpecimen('{{value.SendQCReportId}}',0);" id="DC{{value.SendQCReportId}}">待抽样</a>
                                 {{/if}}
                  
                             </div>
                         </div>

                     </div>
        {{/each}}	
    </script>
    <script id="row_tplDone" type="text/html">
        {{each data as value i}} 
                     <div class="weui-cell">
                         <div class="weui-cell__bd">
                             <div>
                                 <span class="weui-form-preview__value" style="color: blue">采购单：{{value.POName}}  </span>
                                 <span class="weui-form-preview__value">供应商：{{value.VendorName}}</span>
                                 <span class="weui-form-preview__value">物料代码：{{value.ProductShortName}}</span>
                             </div>
                             <div>
                                 <span class="weui-form-preview__value">物料描述：{{value.ProductDescription}}</span>
                                 <span class="weui-form-preview__value">送货数量：{{value.SendQCQty}}</span>
                                 <span class="weui-form-preview__value">检验时间：{{value.CreateDate}}</span>
                             </div>
                             <div>
                                 {{if value.QCResult=='全部接受'}}
                                       <span class="weui-form-preview__value" style="color: forestgreen">检验结果：{{ value.QCResult}}</span>
                                 {{else}}
                                         <span class="weui-form-preview__value" style="color: red">检验结果：{{ value.QCResult}}</span>
                                 {{if value.IsB=="1"}}
                                            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn" onclick="CheckSpecimen('{{value.SendQCReportId}}',2);">加抽</a>
                                 {{/if}}
                                 {{/if}}
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="showCheckDetail('{{value.SendQCReportId}}','{{value.ProductShortName}}');">查看详细</a>

                             </div>
                         </div>
                     </div>
        {{/each}}	
    </script>
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

    <div class="weui-tab">
        <div class="weui-navbar">
            <a class="weui-navbar__item weui-bar__item--on" href="#tab1">IQC待检
            </a>
            <a class="weui-navbar__item" href="#tab2">已检
            </a>
            <a class="weui-navbar__item" href="#tab3">明日计划
            </a>
        </div>

        <div class="weui-tab__bd">
            <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active infinite">
                <%--    <div class="weui-search-bar" id="searchBar1">
                    <form class="weui-search-bar__form" action="#">
                        <div class="weui-search-bar__box">
                            <i class="weui-icon-search"></i>
                            <input type="search" class="weui-search-bar__input" id="searchInput1" placeholder="搜索" required="">
                            <a href="javascript:" class="weui-icon-clear" id="searchClear1"></a>
                        </div>
                        <label class="weui-search-bar__label" id="searchText1" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
                            <i class="weui-icon-search"></i>
                            <span>搜索</span>
                        </label>
                    </form>
                    <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel1">取消</a>
                </div>--%>
                <div id="list" class="weui-cells" style="margin-top: 0;">
                </div>
            </div>
            <div id="tab2" class="weui-tab__bd-item infinite">
                <%--<div class="weui-search-bar" id="searchBar2">
                    <form class="weui-search-bar__form" action="#">
                        <div class="weui-search-bar__box">
                            <i class="weui-icon-search"></i>
                            <input type="search" class="weui-search-bar__input" id="searchInput2" placeholder="搜索" required="">
                            <a href="javascript:" class="weui-icon-clear" id="searchClear2"></a>
                        </div>
                        <label class="weui-search-bar__label" id="searchText2" style="transform-origin: 0px 0px 0px; opacity: 1; transform: scale(1, 1);">
                            <i class="weui-icon-search"></i>
                            <span>搜索</span>
                        </label>
                    </form>
                    <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel2">取消</a>
                </div>--%>

                <div id="listDone" class="weui-cells" style="margin-top: 0;">
                </div>
            </div>
            <div id="tab3" class="weui-tab__bd-item infinite">
                <div id="listPlan" class="weui-cells" style="margin-top: 0;">
                </div>

            </div>
        </div>
    </div>
    <div class="weui-loadmore">
        <i class="weui-loading"></i>
        <span class="weui-loadmore__tips">正在加载</span>
    </div>
    <div class="all_shown">
        已显示全部内容
    </div>

</body>
</html>
