<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Diecut_Check.aspx.cs" Inherits="QMS_WebSite.IPQC.add.Diecut_Check" %>



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
            var SteptID = $("#SteptID").val();
            if (SteptID == "") {
                $M.alert("数据异常");
            }

            var $form = $("#form1").formSerialize();
            $form["ScanProductDesc"] = $("#ScanProductDesc").val();
            $form["ModualNo"] = $("#ModualNo").val();

            var postData = {
                WFSteptId: SteptID,
                IPQCData: JSON.stringify($form),
                Describe: $form["Describe"]
            };
            $.ajax({
                url: "../../Handler/IPQCFirstCheck.ashx?FunType=checkResultTempSubmit&MFPlansId=" + SteptID,
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
            var SteptID = $("#SteptID").val();
            ////if (SQCId == "") {
            ////    $M.alert("数据异常");
            ////}
            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = $("#form1").formSerialize();
            var CheckResult = $form["CheckResult"];
            $form["ScanProductDesc"] = $("#ScanProductDesc").val();
            $form["ModualNo"] = $("#ModualNo").val();

            var postData = {
                WFSteptId: SteptID,
                IPQCData: JSON.stringify($form),
                QCResult: CheckResult,
                Describe: $form["Describe"]
            };
             
            $.ajax({
                url: "../../Handler/IPQCFirstCheck.ashx?FunType=checkResultSubmit&MFPlansId=" + SteptID,
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
        function CheckSubmit() {
            var $form = $("#form1").formSerialize();

            var ScanProductName = $("#lb_ScanProductDesc").text();
            if (ScanProductName == "") {
                $.toptip('请先扫描材料', 'error');
                return false;
            }
            var lb_ModualNo = $("#lb_ModualNo").text();
            if (lb_ModualNo == "") {
                $.toptip('请先扫描模具', 'error');
                return false;
            }

            var UV = $form["UV"];
            if (isNotANumber(UV)) {
                $.toptip('请填写UV', 'error');
                return false;
            }
            var VL = $form["VL"];
            if (isNotANumber(VL)) {
                $.toptip('请填写VL', 'error');
                return false;
            }
            var IR = $form["IR"];
            if (isNotANumber(IR)) {
                $.toptip('请填写IR', 'error');
                return false;
            }

            var WBBGH = $form["WBBGH"];
            if (WBBGH == "0") {
                $.toptip('请选择无暴边、刮花', 'error');
                return false;
            }

            var CD = $form["CD"];
            if (isNotANumber(CD)) {
                $.toptip('请填写长度', 'error');
                return false;
            }
            var KD = $form["KD"];
            if (isNotANumber(KD)) {
                $.toptip('请填写宽度', 'error');
                return false;
            }
            var ZH = $form["ZH"];
            if (isNotANumber(ZH)) {
                $.toptip('请填写总厚', 'error');
                return false;
            }
            var SYCH = $form["SYCH"];
            if (isNotANumber(SYCH)) {
                $.toptip('请填写使用层厚', 'error');
                return false;
            }
            var BHCH = $form["BHCH"];
            if (isNotANumber(BHCH)) {
                $.toptip('请填写保护层厚', 'error');
                return false;
            }
            var LXCH = $form["LXCH"];
            if (isNotANumber(BHCH)) {
                $.toptip('请填写离型层厚', 'error');
                return false;
            }
            var STXG = $form["STXG"];
            if (STXG == "0") {
                $.toptip('请选择试贴效果', 'error');
                return false;
            }

            var PQXG = $form["PQXG"];
            if (PQXG == "0") {
                $.toptip('请选择排气效果', 'error');
                return false;
            }
            var QMLL = $form["QMLL"];
            if (QMLL == "0") {
                $.toptip('请选择贴膜拉力', 'error');
                return false;
            }
            var FKSJ = $form["FKSJ"];
            if (FKSJ == "0") {
                $.toptip('请选择防窥最佳视角', 'error');
                return false;
            }

            var BDQSYC = $form["BDQSYC"];
            if (BDQSYC == "0") {
                $.toptip('请选择撕Ⅱ面不带起使用层', 'error');
                return false;
            }

            var CheckResult = $form["CheckResult"];
            if (CheckResult == "0") {
                $.toptip('请选择检验结果', 'error');
                return false;
            }

            return true;
        }
 
        //页面加载事件
        function pageLoad() {
            var SteptID = $("#SteptID").val();
            if (SteptID == "") {
                $M.alert("数据异常");
                return;
            }
            $.ajax({
                url: "../../Handler/IPQCFirstCheck.ashx?FunType=getStepInfo&MFPlansId=" + SteptID,
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
                                }else if ($("#" + o).length > 0) {
                                    if ($("#" + o).prop("tagName").toLowerCase() == "input" || $("#" + o).prop("tagName").toLowerCase() == "textarea") {
                                        $("#" + o).val(setMsg)
                                    } else if ($("#" + o).prop("tagName").toLowerCase() == "select") {
                                        $("#" + o).val(setMsg)
                                    }
                                }

                                if (o=="IsDone") {
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

        function openCheckStd() {
            var psn = $("#lb_ProductShortName").text();
            var pid = $("#lb_ProductId").text();
            $M.open("../../IQC/Show/ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
        }

        //扫描物料 
        function scanProduct() {
            //var qrcode = 'A.01.01.G3-IPHONE61GL';
            $M.scanQrcode(function (qrcode) {
                $.ajax({
                    url: "../../Handler/IPQCFirstCheck.ashx?FunType=getProductDetail&ProductId=" + qrcode,
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

        function scanModual() {
            $M.scanQrcode(function (qrcode) {
                $.ajax({
                    url: "../../Handler/IPQCFirstCheck.ashx?FunType=getMouldInfo&MouldId=" + qrcode,
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
                                $("#lb_ModualNo").text(jsonData.data.MouldDescription);
                                $("#ModualNo").val(jsonData.data.MouldDescription);
                            }
                            else {
                                $("#lb_ModualNo").text("");
                                $.toast(jsonData.msg, 'forbidden');
                            }
                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });
            });
        }

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
                <tr  >
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
            <div class="weui-panel__hd">
                <h1>检验结果↓↓<a href="javascript:" onclick="openCheckStd()" style="font-size: small">查看检验标准</a></h1>
            </div>
            <div class="weui-panel__bd">

                <div class="weui-cells__tips tltles">材质</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">原料</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ScanProductDesc"></label>
                            <input type="hidden" id="ScanProductDesc" />
                            <a id="scanbtn" class="weui-btn_primary" onclick="scanProduct()">扫描</a>
                        </div>
                    </div>
                </div>
                <div class="weui-cells__tips tltles">模具编码</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">模具</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ModualNo"></label>
                            <input type="hidden" id="ModualNo" />
                            <a class="weui-btn_primary" onclick="scanModual()">扫描</a>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">透光/外观</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">UV</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" id="UV" name="UV" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">VL</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" id="VL" name="VL" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                        </div>
                    </div>

                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">IR</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" id="IR" name="IR" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">无暴边、<br/>刮花</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="WBBGH" class="weui-select" name="WBBGH">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>

                    <div class="weui-cells__tips tltles">平面尺寸</div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">长</label>
                            </div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" id="CD" name="CD" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">宽度</label>
                            </div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" id="KD" name="KD" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">二次元测试</label>
                            </div>
                            <div class="weui-cell__bd">
                            </div>
                        </div>

                    </div>

                    <div class="weui-cells__tips tltles">厚度尺寸</div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">总厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" id="ZH" name="ZH" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                            </div>
                        </div>
                    </div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">使用层厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" id="SYCH" name="SYCH" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                            </div>
                        </div>
                    </div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">保护层厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" id="BHCH" name="BHCH" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                            </div>
                        </div>
                    </div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">离型层厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" id="LXCH" name="LXCH" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                            </div>
                        </div>
                    </div>

                </div>

                <div class="weui-cells__title">性能/试贴 </div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">试贴效果</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="STXG" class="weui-select" name="STXG">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>

                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">排气效果</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="PQXG" class="weui-select" name="PQXG">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>

                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">贴膜拉力≤20牛顿</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="QMLL" class="weui-select" name="QMLL">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">防窥最佳视角</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="FKSJ" class="weui-select" name="FKSJ">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>

                </div>

                <div class="weui-cells__title">粘力测试 </div>
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">撕Ⅱ面不带起使用层</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select id="BDQSYC" class="weui-select" name="BDQSYC">
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

    </form>

    <div class="weui-btn-area">   
        <a class="weui-btn weui-btn_primary" href="javascript:" id="Submit">提交</a>
    </div>
    <a href="javascript:;" id='show-loading' class="weui-btn weui-btn_primary" style="display: none">提交中</a>
    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SteptID" runat="server" />
    </form>
</body>
</html>

