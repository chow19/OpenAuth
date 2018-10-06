<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QMS_WebSite.Default" %>

<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
        <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.min.css"/>
        <link rel="stylesheet" href="Scripts/jquery-weui-1-2-min.css" /> 
         <script src="scripts/jquery-weui/lib/jquery-2.1.4.js"></script>
		<script src="scripts/jquery-weui/lib/fastclick.js"></script>
        <script src="scripts/template.js"></script>
        <script src="scripts/mobilebridge.js?1"></script>
        <script src="Scripts/jquery1-2-weui.js"></script>
        <link rel="stylesheet" href="css/page.css"/>
        <style>
	    .spName
	    {
	        width:80px;
	        height:20px;
		    margin:0px 10px;
		    font-weight:bold;
		    float:left;
	    }

    	
	    .spDetails
	    {
		    width:180px;
		    height:20px;
		    margin:0px 10px;
		    float:left;
	    }
	    </style>
       
        <script>
            var loading = false;  //状态标记
            var curpage = 1;

            $(function() {
                FastClick.attach(document.body);

                //下拉刷新
                $(document.body).pullToRefresh(function() {
                    location.href = location.href;
                });

                //滚动加载                
                $(document.body).infinite().on("infinite", function() {
                    if (loading) return;
                    loading = true;

                    curpage++;
                    getData(curpage);

                });

                getData(curpage);

                
            })

            function getData(curPage) {
                $.ajax({
                    url: "SendQCReportList.aspx?curPage=" + curPage,
                    type: "Get",
                    cache: false,
                    success: function(data) {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tpl', jsonData); //套模版出html
                        $("#list").append(html); //填充到目标div

                        $(document.body).pullToRefreshDone();
                        loading = false;
                        if (jsonData.data.length == 0) {
                            $(document.body).destroyInfinite();
                            $(".weui-loadmore").remove();
                            $(".all_shown").show();
                        } 
                    }
                });
            }

            function showDetail(SendQCReportId) {
                 $M.open("GetSQDetails.aspx?SendQCReportId=" + SendQCReportId, "送检单检验");
               // $M.open("RawMaterialIQC_Check.aspx?SendQCReportId=" + SendQCReportId, "送检单检验");
            }

            function CheckSpecimen(SendQCReportId) {
                 $M.open("GetSpecimens.aspx?SendQCReportId=" + SendQCReportId, "来料送检抽样");
                 
                //$M.open("SendReportCheck.aspx");  (送检单：{{value.SendQCReportNumber}})
            }


        </script>
        <script id="row_tpl" type="text/html">
                {{each data as value i}}
                     <div class="weui-cell" >
                     <div class="weui-cell__bd">
                       <div>
                          <span class="weui-form-preview__value" style="color:blue" > 采购单：{{value.POName}}  </span>
                          <span class="weui-form-preview__value">供应商：{{value.VendorName}}</span>
                          <span class="weui-form-preview__value">物料代码：{{value.ProductShortName}}</span>
                      </div>
                      <div>
                          <span class="weui-form-preview__value">物料描述：{{value.ProductDescription}}</span>
                          <span class="weui-form-preview__value">送检数量：{{value.SendQCQty}}</span> 
                      </div>
                      <div >
                            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="CheckSpecimen('{{value.SendQCReportId}}');" >抽样</a>

                            <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary"  onclick="showDetail('{{value.SendQCReportId}}');">检验</a>
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
            <a class="weui-navbar__item weui-bar__item--on" href="#tab1">
                 IQC待检
            </a>
            <a class="weui-navbar__item" href="#tab2">
                 已检
             </a>
            <a class="weui-navbar__item" href="#tab3">
                明日计划
            </a>
        </div>
        <div class="weui-tab__bd">
            <div id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
                <div id="list" class="weui-cells" style="margin-top:0;">
                
                </div>
            </div>
            <div id="tab2" class="weui-tab__bd-item">
                <h1>已检列表</h1>
            </div>
            <div id="tab3" class="weui-tab__bd-item">
                <h1>明日计划</h1>
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
