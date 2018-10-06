<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackFirstCheckShow.aspx.cs" Inherits="QMS_WebSite.FQCPack.show.PackFirstCheckShow" %>


<!DOCTYPE html>
<html>
<head>
    <title>包装首捡</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

    <link rel="stylesheet" href="../../css/page.css" />
    <link rel="stylesheet" href="../../scripts/jquery-weui/lib/weui.min.css" />
    <link rel="stylesheet" href="../../scripts/jquery-weui/lib/weui.css" />
    <link rel="stylesheet" href="../../css/page.css" />
    <link href="../../CSS/comm.css" rel="stylesheet" />

    <script src="../../scripts/jquery_1.6.3.js"></script>
    <script src="../../scripts/jquery.lazyload.min.js"></script>
    <script src="../../scripts/comm.js"></script>
    <script src="../../scripts/mobilebridge.js?1"></script>
    <script src="../../scripts/template.js"></script>
    <script src="../../Scripts/jquery-2.1.4.js"></script>
    <link rel="stylesheet" href="../../Scripts/jquery-weui.css">
    <script src="../../Scripts/jquery-weui.js"></script>
    <script src="../../Scripts/comm.js"></script>

    <script>
        var checkResultList = [];
        $(function () {
            pageLoad();
            //提交按钮  
            $("#Submit").click(function () {
                dataSubmt();
            });

            $("input[type='number']").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ''))

            }).bind("paste", function () {  //CTR+V事件处理    
                $(this).val($(this).val().replace(/[^0-9]/g, ''))
            });
        });


        function isNotANumber(inputData) {
            //isNaN(inputData)不能判断空串或一个空格 
            //如果是一个空串或是一个空格，而isNaN是做为数字0进行处理的，而parseInt与parseFloat是返回一个错误消息，这个isNaN检查不严密而导致的。 
            if (parseFloat(inputData).toString() == "NaN") {
                return false;
            } else {
                return true;
            }
        }
         
        //页面加载事件
        function pageLoad() {
            var FID = $("#FID").val();
            if (FID == "") {
                $M.alert("数据异常");
            }
            $.ajax({
                url: "../../Handler/FQCPack.ashx?FunType=getFQCCheckDataByFQCCheckId&FQCCheckPackId=" + FID,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert("Ajax Errors");
                },
                success: function (data) {
                    try {
                        var objArray = JSON.parse(data);
                        if (objArray.result == 0) {
                            var retdata = JSON.parse(JSON.stringify(objArray.data));

                            for (var o in retdata) {
                                var setMsg = retdata[o];
                                if ($("#lb_" + o).length > 0) {
                                    $("#lb_" + o).text(setMsg)
                                    if (o == "CheckResult") {
                                        if (setMsg=="1") {
                                            $("#lb_" + o).text("合格")
                                        } else if (setMsg == "2") {
                                            $("#lb_" + o).text("不合格")
                                        } 
                                    }
                                } else if ($("#" + o).length > 0) {
                                    if ($("#" + o).prop("tagName").toLowerCase() == "input" || $("#" + o).prop("tagName").toLowerCase() == "textarea") {
                                        $("#" + o).val(setMsg)
                                    } else if ($("#" + o).prop("tagName").toLowerCase() == "select") {
                                        $("#" + o).val(setMsg)
                                    }
                                }
                            } 
                            //根据销售订单和销售行加载数据
                            ShowFeedSheet($("#lb_BillNo").text(), $("#lb_SOEntry").text());
                            var s = setTimeout(function () {

                                for (var o in retdata) {
                                    var setMsg = retdata[o];
                                    if (o.indexOf("CheckResult_") > -1) {
                                        if ($("#" + o).length > 0) {
                                            if (setMsg == "1") {
                                                $("#" + o).text("合格")
                                            } else if (setMsg == "2") {
                                                $("#" + o).text("不合格")
                                            }
                                        }
                                    }
                                }
                            },1000)
                           
                        }
                        else {
                            $("lable").text("");
                            alert("数据错误");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }

        function ShowFeedSheet(BillNo, SOEntry) {
            $.ajax({
                url: "../../Handler/FQCPack.ashx?FunType=getFeedSheet&BillNo=" + BillNo + "&SOEntry=" + SOEntry,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                    alert("Errors");
                },
                success: function (data) { 
                    try {
                        var jsonData = eval("(" + data + ")"); 
                        if (jsonData.result == "0") {
                            var html = template('row_tb', jsonData); //套模版出html 
                            $("#totalRow").val(jsonData.data.length);
                            $("#showTable").append(html); //填充到目标div  
                        } else {
                            $.toast(data.msg, "forbidden");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }
    </script>
    <script id="row_tb" type="text/html">
        {{if msg!='没有数据'}}
        <table class="weui-table weui-border-tb weui-table-2n">
            <thead>
                <tr>
                    <th>行号</th>
                    <th>子项物料编号</th>
                    <th>子项物料名称</th>
                    <th>总需求数量</th>
                    <%-- <th>投单号</th>--%>
                    <th>单位</th>
                    <th>进料检验记录</th>
                    <%--   <th>总览图</th>--%>
                    <th>确认结果</th>
                </tr>
            </thead>
            <tbody>
                {{each data as value i}} 
                       <tr>
                           <td>
                               <label id="RowNo_{{value.RowNo}}">{{value.RowNo}}</label>
                           </td>
                           <td>
                               <label id="ProductShortName_{{value.RowNo}}">{{value.ProductShortName}}</label>
                           </td>
                           <td>
                               <label id="ProductDescribe_{{value.RowNo}}">{{value.ProductDescribe}}</label>
                           </td>
                           <td>
                               <label id="Total_{{value.RowNo}}">{{value.Total}}</label>
                           </td>
                           <td>
                               <label id="UOM_{{value.RowNo}}">{{value.UOM}}</label>
                           </td>
                           <td>
                               <a href="javascript:">
                                   <label id="BillNo_{{value.RowNo}}">IQC检验记录</label></a>
                           </td>

                           <%-- <td>{{if value.imageShow!=''}}
                                     <img src="data:image/png;base64,{{value.imageShow}}" id="{{value.RowNo}}_imageShow" />
                               {{/if}}
                           </td>--%>
                           <td> 
                               <label id="CheckResult_{{value.RowNo}}"></label>
                           </td>

                       </tr>
                {{/each}}	
            </tbody>
        </table>
        {{else}}
           <p style="color: red">暂无数据</p>
        {{/if}} 
    </script>
</head>
<body>

    <div class="weui-gallery" id="gallery" style="display: none">
        <span class="weui-gallery__img" id="galleryImg" style="background-image: url(../../images/pic_article.png);"></span>
        <div class="weui-gallery__opr">
            <a href="javascript:" class="weui-gallery__del">
                <i class="weui-icon-delete weui-icon_gallery-delete"></i>
            </a>
        </div>
    </div>
    <!--*******************************检单详细 开始**********************************-->
    <div class="weui-panel weui-panel_access">
        <div class="weui-panel__hd">
            <h1>检验单↓↓</h1>
        </div>
        <div class="weui-panel__bd">
            <table id="detailsTable">
                <tr>
                    <td>销售订单</td>

                    <td>
                        <label id="lb_BillNo"></label>
                    </td>
                    <td>销售行号</td>
                    <td>
                        <label id="lb_SOEntry"></label>
                    </td>
                    <td class="auto-style1">客户</td>
                    <td>
                        <label id="lb_CustomerName"></label>
                    </td> 

                </tr>
                <tr>
                    <td>物料代码</td>
                    <td>
                        <label id="lb_ProductName"></label>
                        <label id="lb_ProductId" style="display: none"></label>
                    </td>
                    <td>物料描述</td>
                    <td colspan="3">
                        <label id="lb_ProductDescription"></label>
                    </td>

                </tr>
                <tr>
                    <td>工单</td>
                    <td>
                        <label id="lb_MOName"></label>
                    </td>
                    <td>工单数量</td>
                    <td>
                        <label id="lb_MOQtyRequired"></label>
                    </td>
                    <td>检验类型</td>
                    <td>
                        <label id="lb_CheckType"></label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!--******************************送检单详细 结束**********************************-->

    <!--********************************填写检验结果 开始**************************************-->
    <form id="form1">

        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <h1>检验结果↓↓</h1>
            </div>

            <div class="weui-cells weui-cells_form" style="margin-top: 0">
                <div class="weui-cell">
                    <div id="showTable" style="width: 100%">
                    </div>
                </div>
            </div>

            <div class="weui-cell ">
                <%--weui-cell_select weui-cell_select-after--%>
                <div class="weui-cell__hd">
                    <label for="" class="weui-label">检验结果</label>
                </div>
                <div class="weui-cell__bd"> 
                    <label id="lb_CheckResult"></label>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd  ">
                    <label class="weui-label">备注</label>
                </div>
                <div class="weui-cell__bd">
                    <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe"></textarea>
                </div>

            </div>
        </div>
        <input type="hidden" id="totalRow" value="0" />
    </form>

    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="FID" runat="server" />
    </form>
</body>
</html>

