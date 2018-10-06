﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FQCPack_Portal.aspx.cs" Inherits="QMS_WebSite.FQCPack_Portal" %>

<!doctype html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FQC</title>
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
                        curpage3++;
                        getDoneData(curpage3);
                } 
                else {
                    curpage++;
                    getPackData(curpage, "");
                }
                self.loading = false;
                //}, 1000);   //模拟延迟
            });

            getPackData(curpage, "");
             
            getDoneData(curpage3,"");

        })

        //ios设备就绪的方法
        function onDeviceReady() {
            $M.setButton("[{\"function\":\"Search\",\"title\":\"搜索\"}]");
            // $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        };
        function Search() {
            var tabid = $(".weui-tab__bd-item--active").eq(0).attr("id");
            var isQ = 0;
            if (tabid == "tab1") {
                isQ = 0;
            } else if (tabid == "tab2") {
                isQ = 1;
            }
            $.prompt({
                title: '搜索',
                text: '请输入搜索关键词',
                input: '',
                empty: false, // 是否允许为空
                buttons: [
                               {
                                   text: '取消',
                                   className: "default",
                                   onClick: function () {
                                   }
                               },
                               {
                                   text: '确定',
                                   className: "primary",
                                   onClick: function (input) {
                                       if (isQ == 0) {
                                           $("#list").html("");
                                           getPackData(1, input);
                                       } else {
                                           $("#listDone").html("");
                                           getDoneData(1, input);
                                       }
                                   }
                               }
                ]
            });

            $(".weui-dialog__btn").eq(0).html("取消");
            $(".weui-dialog__btn").eq(1).html("确定");

        }

        function getPackData(curPage, keyWork) {
            $.ajax({
                url: "Handler/FQCPack.ashx?FunType=getFQCPakeData&curPage=" + curPage + "&keyWork=" + keyWork,
                type: "Get",
                cache: false,
                success: function (data) {
                 
                    if (data.result = "0") {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tpl', jsonData); //套模版出html

                        $("#list").append(html); //填充到目标div s
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
 

        function getDoneData(curPage, keyWork) {
            $.ajax({
                url: "Handler/FQCPack.ashx?FunType=getFQCCheckDone&curPage=" + curPage + "&keyWork=" + keyWork,
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

        function AddCheckDetail(MFPlansId) {
          $M.scanQrcode(function (qrcode) { 
                $.ajax({
                    url: "Handler/FQCPack.ashx?FunType=getFQCCheckDataByScanSN&MFPlansId=" + MFPlansId + "&ScanLotSN=" + qrcode,
                    type: "Get",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) {
                        $M.alert("error");
                    },
                    success: function (data) {
                       
                        try { 
                            var jsonData = JSON.parse(data); 
                            if (jsonData.result == 0) { 
                                var ProductShortName = jsonData.data.ProductShortName;
                                var FQCCheckId = jsonData.data.FQCCheckId;
                                var checkType = jsonData.data.CheckType;
                                openNewWindow(FQCCheckId, checkType);
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

         

        function PrintLabel(MFPlansId, PackType) { 
                $.modal({
                    title: "确认",
                    text: "确认要打印标签?",
                    buttons: [
                      {
                          text: "确定", onClick: function () {  //点击确认
                              $.ajax({
                                  url: "Handler/FQCPack.ashx?FunType=packPrintLabel&MFPlansId=" + MFPlansId + "&PackType=" + PackType,
                                  type: "Get",
                                  cache: false,
                                  success: function (data) {
                                      if (JSON.parse(data).result == "0") { 
                                          runPrint(JSON.parse(data).msg);
                                      } else { 
                                          $.toast(JSON.parse(data).msg, "forbidden");
                                      }
                                      $(".weui-loadmore").remove();
                                      $(".all_shown").show();
                                  }
                              });
                          }
                      },

                      { text: "取消", className: "default", onClick: function () { } },
                    ]
                });
            
        }
         
        function runPrint(YBBQ) {

            $.ajax({
                url: "Handler/FQCPack.ashx?FunType=getPrintContentCode&YBBQ=" + YBBQ,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert("Errors");
                },
                success: function (data) {
                    var resJson = JSON.parse(data);
                    if (resJson.result == "0") { 
                        $M.openPrint(resJson.msg);
                    } else {
                        $.toast(resJson.msg, "forbidden");
                    }
                }
            });
        }

        function showCheckDetail(FQCCheckId, type) {
            if (type.length <= 0) {
                $M.alert("数据错误");
                return;
            }
            switch (type) {
                case "1":
                    $M.open("FQCPack/Show/PackFirstCheckShow.aspx?FQCCheckPackId=" + FQCCheckId, "包装首检检验结果");
                    break;
                case "2":
                    $M.open("FQCPack/Show/PackRountCheckShow.aspx?FQCCheckPackId=" + FQCCheckId, "包装巡检检验结果");
                    break;
                
            }
        }

        function openNewWindow(FQCCheckId, type) {

            if (type == 1) {
                $M.open("FQCPack/add/PackFirstCheckAdd.aspx?FQCCheckPackId=" + FQCCheckId, "包装首检");
            } else if (type == 2) {
                $M.open("FQCPack/add/PackRountCheckAdd.aspx?FQCCheckPackId=" + FQCCheckId, "包装巡检");
            } else {
                $M.alert("未知检验类型");
            }
        }
    </script>
    <script id="row_tpl" type="text/html">
        {{each data as value i}}
                     <div class="weui-cell">
                         <div class="weui-cell__bd">
                             <div>
                                 <span class="weui-form-preview__value" style="color: blue">工单：{{value.MOName}}  </span>
                                 <span class="weui-form-preview__value">物料代码：{{value.ProductShortName}}</span>
                                 <span class="weui-form-preview__value">物料描述：{{value.ProductDescription}}</span>
                             </div>
                             <div>
                                 <span class="weui-form-preview__value">工单数量：{{value.MOQtyRequired}}</span>
                                 <span class="weui-form-preview__value">客    户：{{value.CustomerName}}</span>
                                 <span class="weui-form-preview__value">销售订单：{{value.BillNo}}</span>
                                 <span class="weui-form-preview__value">销售行：{{value.SOEntry}}</span>
                             </div>
                             <div>
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="PrintLabel('{{value.MFPlansId}}',1);">首检标签</a>
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="PrintLabel('{{value.MFPlansId}}',2);">巡检标签</a>

                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn" onclick="AddCheckDetail({{value.MFPlansId}});">检验</a>
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
                                 <span class="weui-form-preview__value" style="color: blue">工单：{{value.MOName}}  </span>
                                 <span class="weui-form-preview__value">物料代码：{{value.ProductShortName}}</span>
                                 <span class="weui-form-preview__value">物料描述：{{value.ProductDescription}}</span>
                             </div>
                             <div>
                                 <span class="weui-form-preview__value">工单数量：{{value.MOQtyRequired}}</span>
                                 <span class="weui-form-preview__value">客    户：{{value.CustomerName}}</span>
                                 <span class="weui-form-preview__value">销售订单：{{value.BillNo}}</span>
                                 <span class="weui-form-preview__value">销售行：{{value.SOEntry}}</span>

                                 {{if value.CheckType=='1'}} 
                                  <span class="weui-form-preview__value">检验类型：包装首检</span>
                                 {{else if value.CheckType=='2'}} 
                                   <span class="weui-form-preview__value">检验类型：包装巡检</span> 
                                 {{/if}}
                             </div>
                             <div>
                                 {{if value.QCResult=='1'}} 
                                       <span class="weui-form-preview__value" style="color: forestgreen">检验结果：合格</span>
                                 {{else}}
                                         <span class="weui-form-preview__value" style="color: red">检验结果：不合格</span>
                                 {{/if}}
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="showCheckDetail('{{value.FQCCheckId}}','{{value.CheckType}}');">查看详细</a>

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
            <a class="weui-navbar__item weui-bar__item--on" href="#tab1">包装首检/巡检
            </a>
        <%--    <a class="weui-navbar__item weui-bar__item--on" href="#tab1">FQC抽检
            </a>--%>
            <a class="weui-navbar__item" href="#tab2">已检
            </a>

        </div>

        <div class="weui-tab__bd">
            <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active infinite">
                <div id="list" class="weui-cells" style="margin-top: 0;">
                </div>
            </div>
            <div id="tab2" class="weui-tab__bd-item infinite">

                <div id="listDone" class="weui-cells" style="margin-top: 0;">
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

