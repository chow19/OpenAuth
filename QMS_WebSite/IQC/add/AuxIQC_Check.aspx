<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AuxIQC_Check.aspx.cs" Inherits="QMS_WebSite.IQC.add.AuxIQC_Check" %>

<!DOCTYPE html>
<html > 
<head>
    <title>辅料检验</title>
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

            setTotal();
            //合计计算
            $("input").change(function () {
                setTotal();
            });
            //提交按钮  
            $("#Submit").click(function () { 
                dataSubmt();
            });

            $("#AcceptQty").on("keyup", function () {
                var AcceptQty = $("#AcceptQty").val();
                var SendQty = $("#lb_SendQCQty").text();

                var NGQty = SendQty - AcceptQty;
                $("#NGQty").val(NGQty)
            });

            $("input[type='number']").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ''))

            }).bind("paste", function () {  //CTR+V事件处理    
                $(this).val($(this).val().replace(/[^0-9]/g, ''))
            });


        });

        function setTotal() {

            var pageMA = 0;
            var pageMI = 0;

            var outlookMA = 0;
            var outlookMI = 0;

            var sizeMA = 0;
            var sizeMI = 0;

            var functionMA = 0;
            var functionMI = 0;


            if (isNotANumber($("#PackegeMAReNum").val())) {
                pageMA = parseFloat($("#PackegeMAReNum").val());
            }
            if (isNotANumber($("#PackegeMIReNum").val())) {
                pageMI = parseFloat($("#PackegeMAReNum").val());
            }


            if (isNotANumber($("#OutLookMAReNum").val())) {
                outlookMA = parseFloat($("#OutLookMAReNum").val());
            }
            if (isNotANumber($("#OutLookMIReNum").val())) {
                outlookMI = parseFloat($("#OutLookMIReNum").val());
            }


            if (isNotANumber($("#SizeMAReNum").val())) {
                sizeMA = parseFloat($("#SizeMAReNum").val());
            }
            if (isNotANumber($("#SizeMIReNum").val())) {
                sizeMI = parseFloat($("#SizeMAReNum").val());
            }


            if (isNotANumber($("#FunctionMAReNum").val())) {
                functionMA = parseFloat($("#FunctionMAReNum").val());
            }
            if (isNotANumber($("#FunctionMIReNum").val())) {
                functionMI = parseFloat($("#FunctionMIReNum").val());
            }

            var matotal = pageMA + outlookMA + sizeMA + functionMA;
            var mitotal = pageMI + outlookMI + sizeMI + functionMI;

            $("#lb_MATotal").text(matotal.toString())

            $("#lb_MITotal").text(mitotal.toString())
        }
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
            //$M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
           // $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        };

        function save() {
            if (!confirm("确认提交？")) {
                return false;
            }
            dataSubmt();
            //$M.open("Upload_Pics.aspx", "送检单检验"); 
        };

        function onselected() {
            var result = 1;
            document.getElementsByName()
        };

        window.onbeforeunload = function () {
            if (!confirm("是否退出???")) {
                return false;
            }
        };

        function dataSubmt() {
            $.showLoading();
            var SQCId = $("#SQCID").val();
            ////if (SQCId == "") {
            ////    $M.alert("数据异常");
            ////}
            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = $("#form1").formSerialize();


            var CheckResult = $form["CheckResult"];
            var AcceptQty = $("#AcceptQty").val();
            var NGQty = $("#NGQty").val();
            var Describe = "包装:"+ $("#PackegeDes").val()+";"+
                "外观:"+ $("#OutLookDes").val()+";        "+
                "尺寸:" + $("#SizeMAReNum").val() + ";       " +
                "功能适配:" + $("#FunctionDes").val() + ";       "
            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                CheckResult: CheckResult,
                AcceptQty: AcceptQty,
                NGQty: NGQty,
                CheckType: 3,
                Describe: Describe
            };

            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=CheckResultSubmit&SendQCReportId=" + SQCId,
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

            //var PackegeDes = $form["PackegeDes"];
            //if (PackegeDes == "") {
            //    $.toptip('请填写包装描述', 'error');
            //    return false;
            //}
            var PackegeMAReNum = $form["PackegeMAReNum"];
            if (PackegeMAReNum == "") {
                $.toptip('请填写包装MA不良数', 'error');
                return false;
            }
            var PackegeMIReNum = $form["PackegeMIReNum"];
            if (PackegeMIReNum == "") {
                $.toptip('请填写包装MI不良数', 'error');
                return false;
            }

          
            var OutLookMAReNum = $form["OutLookMAReNum"];
            if (OutLookMAReNum == "") {
                $.toptip('请填写外观MA不良数', 'error');
                return false;
            }
            var OutLookMIReNum = $form["OutLookMIReNum"];
            if (OutLookMIReNum == "") {
                $.toptip('请填写外观MI不良数', 'error');
                return false;
            }
             
            var SizeMAReNum = $form["SizeMAReNum"];
            if (SizeMAReNum == "") {
                $.toptip('请填写尺寸MA不良数', 'error');
                return false;
            }
            var SizeMIReNum = $form["SizeMIReNum"];
            if (SizeMIReNum == "") {
                $.toptip('请填写尺寸MI不良数', 'error');
                return false;
            }

            //var OutLookDes = $form["OutLookDes"];
            //if (OutLookDes == "") {
            //    $.toptip('请填写外观描述', 'error');
            //    return false;
            //}
            //var SizeDes = $form["SizeDes"];
            //if (SizeDes == "") {
            //    $.toptip('请填写尺寸描述', 'error');
            //    return false;
            //}
            //var FunctionDes = $form["FunctionDes"];
            //if (FunctionDes == "") {
            //    $.toptip('请填写功能实配描述', 'error');
            //    return false;
            //}
            var FunctionMAReNum = $form["FunctionMAReNum"];
            if (FunctionMAReNum == "") {
                $.toptip('请填写功能实配MA不良数', 'error');
                return false;
            }
            var FunctionMIReNum = $form["FunctionMIReNum"];
            if (FunctionMIReNum == "") {
                $.toptip('请填写功能实配MI不良数', 'error');
                return false;
            }

            var CheckResult = $form["CheckResult"];
            if (CheckResult == "0") {
                $.toptip('请选择检验结果', 'error');
                return false;
            }

            var AcceptQty = $("#AcceptQty").val();
            var NGQty = $("#NGQty").val();
            var SendQty = $("#lb_SendQCQty").text();
            //if (parseFloat(SendQty) != parseFloat(AcceptQty) + parseFloat(NGQty)) {
            //    $.toptip('接收数量与不良数量之和应与送货数量一致', 'error');
            //    return false;
            //}
            //if (CheckResult == "1" && NGQty != 0) {
            //    $.toptip('全部接受时不良数量应该为0', 'error');
            //    return false;
            //}
            //if (CheckResult == "5" && AcceptQty != 0) {
            //    $.toptip('全部拒绝时接收数量应该为0', 'error');
            //    return false;
            //}

            return true;
        }

        $.weui = {};
        $.weui.alert = function (options) {
            options = $.extend({
                title: '警告',
                text: '警告内容'
            }, options);
            var $alert = $('.weui_dialog_alert');
            $alert.find('.weui_dialog_title').text(options.title);
            $alert.find('.weui_dialog_bd').text(options.text);
            $alert.on('touchend click', '.weui_btn_dialog', function () {
                $alert.hide();
            });
            $alert.show();
        };

        //页面加载事件
        function pageLoad() {
            var SQCId = $("#SQCID").val();
            if (SQCId == "") {
                $M.alert("数据异常");
            }
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=checkPageLoad&SendQCReportId=" + SQCId,
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
                                }
                            }
                            $("#AcceptQty").val($("#lb_SendQCQty").text());
                            $("#NGQty").val("0");
                            //setAQLParam(jsonData.data[0].CYFS);
                            GetAQLinfoMA("1.正常", $("#lb_CYSP").text(), $("#lb_CYBZ").text());
                            GetAQLinfoMI("2.加严", $("#lb_CYSP").text(), $("#lb_CYBZ2").text());
                            if ($("#lb_TCQ_Qty").text() == "") {
                                $M.alert("请先抽样");
                                $M.closeAndReload();
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

        function setAQLParam(cyfs) {

            var v_cysf = "1";
            switch (cyfs) {
                case "1":
                    v_cysf = "1.正常";
                    break;
                case "2":
                    v_cysf = "2.加严";
                    break;
                case "3":
                    v_cysf = "3.放宽";
                    break;
                case "4":
                    v_cysf = "4.免检";
                    break;
                default:
                    v_cysf = "1";
                    break;
            }

            $("#lb_CYFS").text(v_cysf);

        }

        //用户选择后的处理事件
        function GetAQLinfoMA(cyfs, jcsp, jybz) {
            if (jybz == "") {
                $("#lb_ACQty2").text("--");
                $("#lb_ReQty2").text("--");
                return;
            }
            var SQCId = $("#SQCID").val();
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=selAQL&CYFS=" + cyfs + "&" + "JCSP=" + jcsp + "&JYBZ=" + jybz + "&SendQCReportId=" + SQCId,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                    alert("Errors");
                },
                success: function (data) {
                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            //$("#lb_RequireQty").text(jsonData.data[0].SampleQty);
                            $("#lb_ACQty").text(jsonData.data[0].ACQty);
                            $("#lb_ReQty").text(jsonData.data[0].ReQty);
                        }
                        else {
                            //$("#lb_RequireQty").text("");
                            $("#lb_ACQty").text("");
                            $("#lb_ReQty").text("");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });



        };

        //用户选择后的处理事件
        function GetAQLinfoMI(cyfs, jcsp, jybz) {
            var SQCId = $("#SQCID").val();
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=selAQL&CYFS=" + cyfs + "&" + "JCSP=" + jcsp + "&JYBZ=" + jybz + "&SendQCReportId=" + SQCId,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                    alert("Errors");
                },
                success: function (data) {
                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            //$("#lb_RequireQty2").text(jsonData.data[0].SampleQty);
                            $("#lb_ACQty2").text(jsonData.data[0].ACQty);
                            $("#lb_ReQty2").text(jsonData.data[0].ReQty);
                        }
                        else {
                            //$("#lb_RequireQty2").text("");
                            $("#lb_ACQty2").text("");
                            $("#lb_ReQty2").text("");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });

        };

        function openCheckStd() {
            var psn = $("#lb_ProductShortName").text();
            var pid = $("#lb_ProductId").text();
            $M.open("../Show/ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
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
    <!--*******************************送检单详细 开始**********************************-->
    <div class="weui-panel weui-panel_access">
        <div class="weui-panel__hd">
            <h1>检验单↓↓</h1>
        </div>
        <div class="weui-panel__bd">
            <table id="detailsTable">
                <tr style="display: none">
                    <td>采购单</td> 
                    <td>
                        <label id="lb_POName"></label>
                    </td>
                    <td class="auto-style1">供应商</td>
                    <td>
                        <label id="lb_VendorName"></label>
                    </td>
                    <td>物料代码</td>
                    <td>
                        <label id="lb_ProductShortName"></label>
                        <label id="lb_ProductId" style="display: none"></label>
                    </td>
                </tr>
                <tr>
                    <td>物料描述</td>
                    <td colspan="3">
                        <label id="lb_ProductDescription"></label>
                    </td>
                    <td>送货数量</td>
                    <td>
                        <label id="lb_SendQCQty"></label>
                    </td>
                </tr>
                <tr>
                    <td style="color: blue" class="auto-style1">检查水平</td>
                    <td colspan="5">
                        <label id="lb_CYSP"></label>
                        <label id="lb_CYBZ" style="display: none"></label>
                        <label id="lb_CYBZ2" style="display: none"></label>
                    </td>


                </tr>
                <tr>
                    <td colspan="6">
                        <table style="width: 100%">
                            <tr>
                                <td rowspan="4">一般ⅡAQL</td>
                                <td rowspan="2">MA1.5</td>
                                <td>允收AC:</td>
                                <td>
                                    <label id="lb_ACQty" style="color: blueviolet"></label>
                                </td>
                                <td>MA合计: </td>
                            </tr>
                            <tr>
                                <td>拒收RE:</td>
                                <td>
                                    <label id="lb_ReQty" style="color: red"></label>
                                </td>
                                <td>
                                    <label id="lb_MATotal"></label>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="2">MI2.5</td>
                                <td>允收AC:</td>
                                <td>
                                    <label id="lb_ACQty2" style="color: blueviolet"></label>
                                </td>
                                <td>MI合计:</td>
                            </tr>
                            <tr>
                                <td>拒收RE:</td>
                                <td>
                                    <label id="lb_ReQty2" style="color: red"></label>
                                </td>
                                <td>
                                    <label id="lb_MITotal"></label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">累计扫描数量:</td>
                    <td colspan="5">
                        <label id="lb_TCQ_Qty" runat="server"></label>
                    </td>

                </tr>

            </table>
        </div>
    </div>
    <!--******************************送检单详细 结束**********************************-->

    <!--********************************填写检验结果 开始**************************************-->
    <form id="form1">
        <%-- <div class="weui-cells__tips"></div>--%>
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <h1>检验结果↓↓<a href="javascript:" onclick="openCheckStd()" style="font-size: small">查看检验标准</a></h1>
            </div>
            <div class="weui-panel__bd">

                <div class="weui-cells__tips tltles">包装</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">包装</label>
                        </div>

                        <div class="weui-cell__bd">

                            <table class="detailsTable">
                                <tr>
                                    <td colspan="2" style="width: 40%">
                                        <textarea class="weui-textarea" rows="3" placeholder="描述:" id="PackegeDes" name="PackegeDes"></textarea>
                                    <td>MA不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="PackegeMAReNum" name="PackegeMAReNum" value="0">
                                    </td>

                                    <td>MI不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="PackegeMIReNum" name="PackegeMIReNum" value="0"></td>
                                </tr>
                            </table>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">外观</label>
                        </div>

                        <div class="weui-cell__bd">

                            <table class="detailsTable">
                                <tr>
                                    <td colspan="2" style="width: 40%">
                                        <textarea class="weui-textarea" rows="3" placeholder="描述:" id="OutLookDes" name="OutLookDes"  ></textarea>
                                    <td>MA不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="OutLookMAReNum" name="OutLookMAReNum" value="0">
                                    </td>

                                    <td>MI不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="OutLookMIReNum" name="OutLookMIReNum" value="0"></td>
                                </tr>
                            </table>

                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">尺寸</label>
                        </div>

                        <div class="weui-cell__bd">

                            <table class="detailsTable">
                                <tr>
                                    <td colspan="2" style="width: 40%">
                                        <textarea class="weui-textarea" rows="3" placeholder="描述:" id="SizeDes" name="SizeDes"></textarea>
                                    <td>MA不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="SizeMAReNum" name="SizeMAReNum" value="0">
                                    </td>

                                    <td>MI不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="SizeMIReNum" name="SizeMIReNum" value="0"></td>
                                </tr>
                            </table>

                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">功能实配</label>
                        </div>

                        <div class="weui-cell__bd">
                            <table class="detailsTable">
                                <tr>
                                    <td colspan="2" style="width: 40%">
                                        <%--           <textarea cols="30" rows="3" placeholder="描述:" id="FunctionDes" name="FunctionDes"></textarea>--%>
                                        <textarea class="weui-textarea" placeholder="描述" rows="3" id="FunctionDes" name="FunctionDes"></textarea>

                                    </td>
                                    <td>MA不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="FunctionMAReNum" name="FunctionMAReNum" value="0"></td>

                                    <td>MI不良数</td>
                                    <td>
                                        <input class="weui-input" type="number" id="FunctionMIReNum" name="FunctionMIReNum" value="0"></td>
                                </tr>
                            </table>

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
                            <option value="1">全部接受</option>
                            <option value="2">让步接受(特采)</option>
                            <option value="3">挑选接受</option>
                            <option value="4">免检</option>
                            <option value="5">全部拒收</option>
                        </select>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">接收数量</label>
                    </div>

                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number" id="AcceptQty" name="AcceptQty" onkeyup="this.value = this.value.replace(/[^\d]/g, '')">
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">不良数量</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number" id="NGQty" name="NGQty">
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
        <asp:HiddenField ID="SQCID" runat="server" />
    </form>
</body>
</html>

