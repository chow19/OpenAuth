<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bonded_Check.aspx.cs" Inherits="QMS_WebSite.IPQC.add.Bonded_Check" %>

<!DOCTYPE html>
<html>
<head>
    <title>分条</title>
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
                return false;
            } else {
                return true;
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
            $form["ModualNo"] = $("#ModualNo").val();
            $form["ABRW"] = $("#ABRW").val();
            $form["ABMJ"] = $("#ABMJ").val();

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
                        $.parseJSON(data);
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
            $form["ModualNo"] = $("#ModualNo").val();
            $form["ABRW"] = $("#ABRW").val();
            $form["ABMJ"] = $("#ABMJ").val();

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

            var lb_ModualNo = $("#lb_ModualNo").text();
            if (lb_ModualNo == "") {
                $.toptip('请先扫描玻璃具号', 'error');
                return false;
            }
            var lb_ABRW = $("#lb_ABRW").text();
            if (lb_ABRW == "") {
                $.toptip('请先扫描AB胶原材料', 'error');
                return false;
            }

            var lb_ABMJH = $("#lb_ABMJH").text();
            if (lb_ABMJH == "") {
                $.toptip('请先扫描AB胶模具号', 'error');
                return false;
            }

            var MGD = $form["MGD"];
            if (MGD == "0") {
                $.toptip('请选择吻合度', 'error');
                return false;
            }
            var WG = $form["WG"];
            if (WG == "0") {
                $.toptip('请选择外观', 'error');
                return false;
            }
            var PQXG = $form["PQXG"];
            if (PQXG == "0") {
                $.toptip('请选择排气效果', 'error');
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

        function openCheckStd() {
            var psn = $("#lb_ProductShortName").text();
            var pid = $("#lb_ProductId").text();
            $M.open("../../IQC/Show/ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
        }

        //扫描磨具 
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
        //扫描AB胶原料
        function scanABRW() {
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
                                $("#lb_ABRW").text(jsonData.data.MouldDescription);
                                $("#ABRW").val(jsonData.data.MouldDescription);
                            }
                            else {
                                $("#lb_ABRW").text("");
                                $.toast(jsonData.msg, 'forbidden');
                            }
                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });
            });
        }
        //扫描AB模具
        function scanABMJ() {
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
                                $("#lb_ABMJ").text(jsonData.data.MouldDescription);
                                $("#ABMJ").val(jsonData.data.MouldDescription);
                            }
                            else {
                                $("#lb_ABMJ").text("");
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
                            <label class="weui-label">玻璃具号</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ModualNo"></label>
                            <input type="hidden" id="ModualNo" />
                            <a class="weui-btn_primary" onclick="scanModual()">扫描</a>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">AB胶原料</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ABRW"></label>
                            <input type="hidden" id="ABRW" />
                            <a class="weui-btn_primary" onclick="scanABRW()">扫描</a>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">AB胶模具号</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ABMJH"></label>
                            <input type="hidden" id="ABMJH" />
                            <a class="weui-btn_primary" onclick="scanABMJ()">扫描</a>
                        </div>
                    </div>

                </div>

                <div class="weui-cells__tips tltles">平面尺寸</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">待定</label>
                        </div>
                        <div class="weui-cell__bd">
                            todo
                        </div>
                    </div>

                </div>

                <div class="weui-cells__tips tltles">外观</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">吻合度</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="MGD" class="weui-select" name="MGD">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">试贴</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">外观</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select id="WG" class="weui-select" name="WG">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                    </div>

                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
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
                        <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe"  ></textarea>
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

