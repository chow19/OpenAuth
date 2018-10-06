<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FQC_Portal.aspx.cs" Inherits="QMS_WebSite.FQC_Portal" %>
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

    <script src="Scripts/jquery1-2-weui.js" charset="UTF-8"></script>
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
                    getFQCData(curpage2, "");
                }   else {
                    curpage++;
                    getFQCData(curpage, "");
                }
                self.loading = false;
                //}, 1000);   //模拟延迟
            }); 
            getFQCData(curpage, "");

            getDoneData(curpage2,"");

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
         
        function getFQCData(curPage,keyWork ) {
            $.ajax({
                url: "Handler/FQC.ashx?FunType=getFQCData&curPage=" + curPage + "&keyWork=" + keyWork,
                type: "Get",
                cache: false,
                success: function (data) {

                    if (data.result = "0") {
                        var jsonData = eval("(" + data + ")"); 
                        var html = template('row_tplFQC', jsonData); //套模版出html

                        $("#FQCList").append(html); //填充到目标div 
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

        function getDoneData(curPage, keyWork) {
            $.ajax({
                url: "Handler/FQC.ashx?FunType=getFQCCheckDone&curPage=" + curPage + "&keyWork=" + keyWork,
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
         
        function AddCheckDetail(YBSN) {
            $M.scanQrcode(function (qrcode) {
                if (YBSN != qrcode) {
                    $M.alert("样本标签不匹配");
                    return;
                }
                $.ajax({
                    url: "Handler/FQC.ashx?FunType=getFQCCheckDataByScanSN&ScanLotSN=" + qrcode,
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
                                var FQCCheckId = jsonData.data[0].FQCCheckId;
                                var checkType = jsonData.data[0].checkType;
                                $M.open("FQC/add/FQCSpecimentCheckAdd.aspx?FQCCheckId=" + FQCCheckId, "FQC抽检");
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
         
        function FQCPrintLabel(SpecimentId, IsDone) {
           // var qrcode='A.05.F8M873BT 打包'
            $M.scanQrcode(function (qrcode) { 
                $.modal({
                    title: "确认",
                    text: "确认要打印标签?",
                    buttons: [
                      {
                          text: "确定", onClick: function () {  //点击确认
                              $.ajax({
                                  url: "Handler/FQC.ashx?FunType=specimentPrintLabel&SpecimentId=" + SpecimentId + "&ScanLotSN=" + qrcode,
                                  type: "Get",
                                  cache: false,
                                  success: function (data) {
                                      if (data.result == "0") { 
                                          runPrint(JSON.parse(data).msg);
                                      } else {
                                         // $M.alert(data.msg);
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
            });
        }

        function runPrint(YBBQ) { 
            $.ajax({
                url: "Handler/IPQCRountCheck.ashx?FunType=getPrintContentCode&YBBQ=" + YBBQ,
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

        function showCheckDetail(FQCCheckId) { 
            $M.open("FQC/Show/FQCSpecimentCheckShow.aspx?FQCCheckId=" + FQCCheckId, "FQC抽检检验结果");
        }

 
    </script>
    
    <script id="row_tplFQC" type="text/html">
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
                                 {{if value.YBSN==''}}
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="FQCPrintLabel('{{value.SpecimentId}}',0);">抽样</a> 
                                 {{ else}}
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_warn" onclick="AddCheckDetail('{{value.YBSN}}');">检验</a>
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
                                 {{else if value.CheckType=='3'}} 
                                   <span class="weui-form-preview__value">检验类型：抽检</span>
                                 {{/if}}
                             </div>
                             <div>
                                 {{if value.FQCQCResult=='1'}} 
                                       <span class="weui-form-preview__value" style="color: forestgreen">检验结果：合格</span>
                                 {{else}}
                                         <span class="weui-form-preview__value" style="color: red">检验结果：不合格</span>
                                 {{/if}}
                                 <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="showCheckDetail('{{value.FQCCheckId}}');">查看详细</a>

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
            
            <a class="weui-navbar__item weui-bar__item--on" href="#tab1">FQC抽检
            </a>
            <a class="weui-navbar__item" href="#tab2">已检
            </a>

        </div>

        <div class="weui-tab__bd">
            <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active infinite">
                <div id="FQCList" class="weui-cells" style="margin-top: 0;">
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

