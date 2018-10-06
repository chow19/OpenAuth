<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Diecut_Check.aspx.cs" Inherits="QMS_WebSite.IPQCRoute.add.Diecut_Check" %>


<!DOCTYPE html>
<html>
<head>
    <title>模切</title>
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
                return true;
            } else {
                return false;
            }
        }
        //ios设备就绪的方法
        function onDeviceReady() {
            $M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
            // $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        };

        function save() {

            saveTempData();
        };

        function saveTempData() {
            if (!confirm("该操作只是保存编剧数据，并不会提交检验结果，确认保存吗？")) {
                return false;
            }
            $.showLoading();
            var RouteId = $("#RouteId").val();
            if (RouteId == "") {
                $M.alert("数据异常");
            }
            var $form = $("#form1").formSerialize();
            $form["ScanProductDesc"] = $("#ScanProductDesc").val();
            $form["ModualNo"] = $("#ModualNo").val();

            var postData = {
                IPQCData: JSON.stringify($form),
                Describe: $form["Describe"]
            };
            $.ajax({
                url: "../../Handler/IPQCRountCheck.ashx?FunType=checkResultTempSubmit&RouteId=" + RouteId,
                type: "post",
                cache: false,
                data: postData,
                error: function (XMLHttpRequest, textStatus, e) {
                    $.hideLoading();
                    $M.alert("提交数据异常");
                },
                success: function (data) {
                    $.hideLoading();
                    try {
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 1) {
                            $M.alert("保存成功");
                        }
                        else {
                            $.toast(jsonData.msg, 'forbidden');
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
            $.hideLoading();
        }

        window.onbeforeunload = function () {
            if (!confirm("是否退出???")) {
                return false;
            }
        };

        function dataSubmt() {
            $.showLoading();
            var RouteId = $("#RouteId").val();
            if (RouteId == "") {
                $M.alert("数据异常");
            }
            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = $("#form1").formSerialize();
            var CheckResult = $form["CheckResult"];
            $form["ScanProductDesc"] = $("#ScanProductDesc").val();
            $form["ModualNo"] = $("#ModualNo").val();

            var postData = {
                IPQCData: JSON.stringify($form),
                QCResult: CheckResult,
                Describe: $form["Describe"]
            };

            $.ajax({
                url: "../../Handler/IPQCRountCheck.ashx?FunType=checkResultSubmit&RouteId=" + RouteId,
                type: "post",
                cache: false,
                data: postData,
                error: function (XMLHttpRequest, textStatus, e) {
                    $.hideLoading();
                    $M.alert("提交数据异常");
                },
                success: function (data) {
                    $.hideLoading();
                    try {

                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            $M.alert("提交成功");
                            $M.closeAndReload();
                        }
                        else {
                            $.toast(jsonData.msg, 'forbidden');
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
            $.hideLoading();
        }
       

       

        function openCheckStd() {
            var psn = $("#lb_ProductShortName").text();
            var pid = $("#lb_ProductId").text();
            $M.open("../../IQC/Show/ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
        }

        function CheckSubmit() {
            var $form = $("#form1").formSerialize();

            var ScanProductName = $("#lb_ScanProductDesc").text();
            if (ScanProductName == "") {
                $.toptip('请先扫描产品', 'error');
                return false;
            }

            var check1 = $form["check1"];
            if (check1 == "0") {
                $.toptip('请选择检验项目结果', 'error');
                return false;
            }

            var check2 = $form["check2"];
            if (check2 == "0") {
                $.toptip('请选择检验项目结果', 'error');
                return false;
            }
            var check3 = $form["check3"];
            if (check3 == "0") {
                $.toptip('请选择检验项目结果', 'error');
                return false;
            }
            var check4 = $form["check4"];
            if (check4 == "0") {
                $.toptip('请选择检验项目结果', 'error');
                return false;
            }
            var check5 = $form["check5"];
            if (check5 == "0") {
                $.toptip('请选择检验项目结果', 'error');
                return false;
            }
            var check6 = $form["check6"];
            if (check6 == "0") {
                $.toptip('请选择检验项目结果', 'error');
                return false;
            }

            var CheckResult = $form["CheckResult"];
            if (CheckResult == "0") {
                $.toptip('请选择检验结果', 'error');
                return false;
            }

            return true;
        }
        //扫描物料 
        function scanProduct() {
            //var qrcode = 'A.01.01.G3-IPHONE61GL';
            $M.scanQrcode(function (qrcode) {
                $.ajax({
                    url: "../../Handler/IPQCRountCheck.ashx?FunType=getProductDetail&ProductId=" + qrcode,
                    type: "post",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) {
                        $.hideLoading();
                        $M.alert("提交数据异常");
                    },
                    success: function (data) {
                        try {
                            var jsonData = eval("(" + data + ")");
                            if (jsonData.result == 0) {
                                $("#lb_ScanProductDesc").text(jsonData.data.ProductDescription);
                                $("#ScanProductDesc").val(jsonData.data.ProductDescription);
                            }
                            else {
                                $("#lb_ScanProductDesc").text("");
                                $.toast(jsonData.msg, 'forbidden');
                            }
                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });
            });
        }
 
        //页面加载事件
        function pageLoad() {

            var RouteId = $("#RouteId").val();
            if (RouteId == "") {
                $M.alert("数据异常");
            }

            $.ajax({
                url: "../../Handler/IPQCRountCheck.ashx?FunType=getRountInfo&RouteId=" + RouteId,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                    alert("Errors");
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
                                } else if ($("#" + o).length > 0) {
                                    if ($("#" + o).prop("tagName").toLowerCase() == "input" || $("#" + o).prop("tagName").toLowerCase() == "textarea") {
                                        $("#" + o).val(setMsg)
                                    } else if ($("#" + o).prop("tagName").toLowerCase() == "select") {
                                        $("#" + o).val(setMsg)
                                    }
                                }

                                if (o == "IsDone") {
                                    if (retdata[o] != 0) {
                                        alert("数据异常");
                                        $M.closeAndReload();
                                    }
                                }
                            }
                        }
                        else {
                            $("lable").text("");

                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }
    </script>
    <style>
        .myweuilabel {
            word-wrap:break-word; 
            width:400px;
            color:brown
        }
    </style>
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
                    <td class="auto-style1">客户</td>
                    <td>
                        <label id="lb_CustomerName"></label>
                    </td>
                    <td>物料代码</td>
                    <td>
                        <label id="lb_ProductName"></label>
                        <label id="lb_ProductId" style="display: none"></label>
                    </td>
                </tr>
                <tr>
                    <td>物料描述</td>
                    <td colspan="5">
                        <label id="lb_ProductDescription"></label>
                    </td>

                </tr>
                <tr>
                    <td>工单</td>
                    <td>
                        <label id="lb_MOName"></label>
                    </td>
                    <td>工序</td>
                    <td>
                        <label id="lb_SpecificationName"></label>
                    </td>
                    <td>工单数量</td>
                    <td>
                        <label id="lb_MOQtyRequired"></label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!--******************************送检单详细 结束**********************************-->

    <!--********************************填写检验结果 开始**************************************-->
    <form id="form1">

        <div class="weui-panel weui-panel_access">
  
            <div class="weui-panel__bd">
                  <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">产品</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ScanProductDesc"></label>
                            <input type="hidden" id="ScanProductDesc" />
                            <a class="weui-btn_primary" onclick="scanProduct()">扫描</a>
                        </div>
                    </div>


                <div class="weui-cells__tips tltles">检验项目</div>
                
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label myweuilabel">1.检查生产的产品与销售订单/生产投料单的要求的规格相一致；</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="check1" class="weui-select" name="check1">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label myweuilabel">2.检查在生产的产品，5PCS外观质量:符合质量要求；3PCS尺寸：测量值（二次元）在公差范围内；</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="check2" class="weui-select" name="check2">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label myweuilabel">3.检查机台环境：需清洁干净，不可放置与生产无关的物品在于机台上;</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="check3" class="weui-select" name="check3">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label myweuilabel">4.不可放置非本销售订单、生产投料单的产品于机台上；</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="check4" class="weui-select" name="check4">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label myweuilabel">5.定时送2pcs离型膜拉力测试，测量值在可控值内：离型膜重叠处负重500克，拉力≤15N；离型膜折线处，负重500克，平均拉力≤30N；</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="check5" class="weui-select" name="check5">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label myweuilabel">6.抽检1pc进行贴膜机测试，确认拉力均匀，位置准确，边缘无气泡，排气效果好。</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="check6" class="weui-select" name="check6">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                

                <div class="weui-cells__title">品质检验结果</div>
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">检验结果</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select id="CheckResult" class="weui-select" name="CheckResult">
                            <option value="0">请选择</option>
                            <option value="1">合格</option>
                            <option value="2">不合格</option>

                        </select>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">备注</label>
                    </div>
                    <div class="weui-cell__bd">
                        <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe" ></textarea>
                    </div>

                </div>
        </div>
            </div>
            </div>
    </form>

    <div class="weui-btn-area"> 
        <a class="weui-btn weui-btn_primary" href="javascript:" id="Submit">提交</a>
    </div>
    <a href="javascript:;" id='show-loading' class="weui-btn weui-btn_primary" style="display: none">提交中</a>
    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SteptID" runat="server" />
        <asp:HiddenField ID="RouteId" runat="server" />
    </form>
</body>
</html>

