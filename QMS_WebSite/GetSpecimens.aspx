<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetSpecimens.aspx.cs" Inherits="QMS_WebSite.GetSpecimens" %>

<!DOCTYPE html>
<html>
<head>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>

    <link rel="stylesheet" href="css/page.css" />
    <link href="CSS/comm.css" rel="stylesheet" />

    <script src="scripts/jquery_1.6.3.js"></script>
    <script src="scripts/jquery.lazyload.min.js"></script>
    <script src="scripts/comm.js"></script>
    <script src="scripts/mobilebridge.js?1"></script>
    <script src="scripts/template.js"></script>
    <script src="Scripts/jquery-2.1.4.js"></script>
    <script src="Scripts/fastclick.js"></script>
    <link rel="stylesheet" href="Scripts/jquery-weui/lib/weui.min.css">
    <link rel="stylesheet" href="Scripts/jquery-weui.css">
    <script src="Scripts/jquery-weui.js"></script>

    <!--js 脚本 -->
    <script>
        $(function () {
            pageLoad();

        })

        //页面加载事件
        function pageLoad() {
            $("#Speciment").hide();
            $("#PrintBtn").hide();
            $("#FirstSpecimentBtn").hide();

            var SQCId = $("#SQCID").val();
            var IsS = $("#IsS").val();
            var SN = $("#SN").val();
            // var DesMsg = $("#DesMsg").val();

            if (SN == "" && IsS != "1") {
                $M.alert("数据异常");
                $M.closeAndReload();
            }
            if (SN != "" && IsS != "1") {
                $("#ScanSN").html(SN);
                getScanSN_Data(SN, SQCId);
            }

            $.ajax({
                url: "Handler/IQC.ashx?FunType=PageLoad&SendQCReportId=" + SQCId,
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
                            $("#AcceptQty").val($("#lb_SendQty").text());
                            $("#NGQty").val("0");

                            if ($("#lb_TCQ_Qty").text() == "") {
                                $("#lb_TCQ_Qty").text("0")
                            }
                            if (IsS == "0") {
                                $("#FirstSpecimentBtn").show();
                            }
                            $("#PrintBtn").show();
                            if (IsS == "2") {
                                $("#Speciment").show();
                            }
                            var PN = $("#lb_ProductShortName").text();

                            if ((PN.substring(0, 1) == "E") || (PN.substring(0, 1) == "D") || (PN.substring(0, 1) == "F")) {
                                //辅料打印隐藏
                                $("#PrintBtn").hide();
                            }
                            if ($("#ScanSN").text().length == 0) {
                                $("#scanMsgBtn").show();
                                $("#scanTitle").hide();
                            } else {
                                $("#scanMsgBtn").hide();
                                $("#scanTitle").show();
                            }
                            // getAQLinfo()
                        }
                        else {
                            $("lable").text("");
                        }

                    } catch (e) {
                        alert("数据异常" + e.message);
                    }
                }
            });

            templateReload(SQCId)
        }

        var _cyfs, _jcsp, _jybz;
        //获取AQL参数
        function getAQLParam() {
            var CYFS = $("#CYFS").val();
            var JCSP = $("#JCSP").val();
            var JYBZ = $("#JYBZ").val();
            switch (CYFS) {
                case "1":
                    _cyfs = "1.正常";
                    break;
                case "2":
                    _cyfs = "2.加严";
                    break;
                case "3":
                    _cyfs = "3.放宽";
                    break;
                case "4":
                    _cyfs = "4.免检";
                    break;
                default:
                    _cyfs = "1.正常";
                    break;

            }

            switch (JCSP) {
                case "1":
                    _jcsp = "I";
                    break;
                case "2":
                    _jcsp = "II";
                    break;
                case "3":
                    _jcsp = "III";
                    break;
                case "4":
                    _jcsp = "S-1";
                    break;
                case "5":
                    _jcsp = "S-2";
                    break;
                case "6":
                    _jcsp = "S-3";
                    break;
                case "7":
                    _jcsp = "S-4";
                    break;
            }

            switch (JYBZ) {
                //case "1":
                //    _jybz = "0.01";
                //    break;
                //case "2":
                //    _jybz = "0.015";
                //    break;
                //case "3":
                //    _jybz = "0.025";
                //    break;
                //case "4":
                //    _jybz = "0.041";
                //    break;
                //case "5":
                //    _jybz = "0.065";
                //    break;
                //case "6":
                //    _jybz = "0.1";
                //    break;
                case "7":
                    _jybz = "0.15";
                    break;
                case "8":
                    _jybz = "0.4";
                    break;
                case "9":
                    _jybz = "1";
                    break;
                case "10":
                    _jybz = "1.5";
                    break;
                case "11":
                    _jybz = "2.5";
                    break;
                case "12":
                    _jybz = "4";
                    break;
                case "13":
                    _jybz = "6.5";
                    break;
                default:
                    _jybz = "6.5";
                    break;
            }

        }

        function setAQLParam(cyfs, jcsp, jybz) {
            var v_cysf = "1";
            var v_jcsp = "1";
            var v_jybz = "1";

            switch (cyfs) {
                case "1.正常":
                    v_cysf = "1";
                    break;
                case "2.加严":
                    v_cysf = "2";
                    break;
                case "3.放宽":
                    v_cysf = "3";
                    break;
                case "4.免检":
                    v_cysf = "4";
                    break;
                default:
                    v_cysf = "1";
                    break;
            }

            switch (jcsp) {
                case "I":
                    v_jcsp = "1";
                    break;
                case "II":
                    v_jcsp = "2";
                    break;
                case "III":
                    v_jcsp = "3";
                    break;
                case "S-1":
                    v_jcsp = "4";
                    break;
                case "S-2":
                    v_jcsp = "5";
                    break;
                case "S-3":
                    v_jcsp = "6";
                    break;
                case "S-4":
                    v_jcsp = "7";
                    break;
            }

            switch (jybz) {
                //case "0.01":
                //    v_jybz = "1";
                //    break;
                //case "0.015":
                //    v_jybz = "2";
                //    break;
                //case "0.025":
                //    v_jybz = "3";
                //    break;
                //case "0.041":
                //    v_jybz = "4";
                //    break;
                //case "0.065":
                //    v_jybz = "5";
                //    break;
                //case "0.1":
                //    v_jybz = "6";
                //    break;
                case "0.15":
                    v_jybz = "7";
                    break;
                case "0.4":
                    v_jybz = "8";
                    break;
                case "1":
                    v_jybz = "9";
                    break;
                case "1.5":
                    v_jybz = "10";
                    break;
                case "2.5":
                    v_jybz = "11";
                    break;
                case "4":
                    v_jybz = "12";
                    break;
                case "6.5":
                    v_jybz = "13";
                    break;
                default:
                    v_jybz = "1";
                    break;
            }

            $("#CYFS").val(v_cysf);
            $("#JCSP").val(v_jcsp);
            $("#JYBZ").val(v_jybz);
        }

        //第一次加载页面的时候的处理事件
        function getAQLinfo() {

            getAQLParam();
            var SQCId = $("#SQCID").val();
            $.ajax({
                //url: "../../Handler/IQC.ashx?FunType=getAQL&CYFS=" + _cyfs + "&" + "JCSP=" + _jcsp + "&JYBZ=" + _jybz + "&SendQCReportId=" + SQCId,
                url: "../../Handler/IQC.ashx?FunType=getAQL&SendQCReportId=" + SQCId,
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
                            $("#lb_RequireQty").text(jsonData.data[0].SampleQty);
                            $("#lb_ACQty").text(jsonData.data[0].ACQty);
                            $("#lb_ReQty").text(jsonData.data[0].ReQty);

                            $("#lb_CYSP").text(jsonData.data[0].CheckLevel);
                            $("#lb_CYBZ").text(jsonData.data[0].AQL1);

                            $("#lb_CYBZ2").text(jsonData.data[0].AQL2);
                            $("#lb_ACQty2").text(jsonData.data[0].ACQty2);
                            $("#lb_ReQty2").text(jsonData.data[0].ReQty2);
                        }
                        else {
                            $("#lb_RequireQty").text("");
                            $("#lb_ACQty").text("");
                            $("#lb_ReQty").text("");

                            $("#lb_CYSP").text("");
                            $("#lb_CYBZ").text("");

                            $("#lb_CYBZ2").text("");
                            $("#lb_ACQty2").text("");
                            $("#lb_ReQty2").text("");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });

        };

        //用户选择后的处理事件
        function selectAQLinfo() {
            getAQLParam();
            var SQCId = $("#SQCID").val();
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=selAQL&CYFS=" + _cyfs + "&" + "JCSP=" + _jcsp + "&JYBZ=" + _jybz + "&SendQCReportId=" + SQCId,
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
                            $("#lb_RequireQty").text(jsonData.data[0].SampleQty);
                            $("#lb_ACQty").text(jsonData.data[0].ACQty);
                            $("#lb_ReQty").text(jsonData.data[0].ReQty);
                        }
                        else {
                            $("#lb_RequireQty").text("");
                            $("#lb_ACQty").text("");
                            $("#lb_ReQty").text("");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });

        };

        //扫描
        function scanQrcode() {
            $M.scanQrcode(function (qrcode) {
                var SQCId = document.getElementById("SQCID").value.trim();
                $("#ScanSN").html(qrcode);
                getScanSN_Data(qrcode, SQCId);
            })
        };

        //扫描物料标签获取信息
        function getScanSN_Data(scanSN, SQCID) {
            $.ajax({
                url: "../../Handler/IQC.ashx?SendQCReportId=" + SQCID + "&" + "ScanLotSN=" + scanSN,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                },
                success: function (data) {
                    try {
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            var temp = "描述:" + jsonData.data[0].ProductDescription + ";扫描数量：" + jsonData.data[0].Qty;
                            $("#lb_ScanProductDesc").text(temp)
                            //$("#lb_ScanQty").text(jsonData.data[0].Qty);
                            //  $("#txt_getQty").focus('', function fn() { });
                        }
                        else {
                            $("#lb_ScanProductDesc").text("");
                            $("#ScanSN").text("");
                            alert(jsonData.msg);
                        }

                    } catch (e) {
                        alert(e.message);
                    }
                }
            });

        }

        ///抽样方式或者检查水平发生改变 
        function ChangeValue() {
            selectAQLinfo();
        }

        //ios设备就绪的方法
        function onDeviceReady() {
            //$M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
            //$("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        }

        function getErrors() {
            $M.alert("errors");
            alert(XmlHttpRequest.responseText);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }

        //加抽
        function getSpecimentExt() {
            var SQCId = $("#SQCID").val();          //送检单
            var Scna_SN = $("#ScanSN").text();      //扫描标签
            var ExtQty = $("#ExtQty").val();  //加抽数量 

            if (Scna_SN.length == 0) {
                $M.alert("扫描信息不能为空...");
                return false;
            }
            if (ExtQty == "") {
                $M.alert("请输入抽取数量");
                return false;
            }

            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=ScanSubmitExt&SendQCReportId=" + SQCId + "&ExtQty=" + ExtQty,
                type: "POST",
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
                            $M.alert("加抽成功");
                            //$M.closeAndReload();
                            var TCQ_Qty = parseFloat($("#lb_TCQ_Qty").text());
                            var newtcp_qty = TCQ_Qty + parseFloat(ExtQty);
                            $("#lb_TCQ_Qty").text(newtcp_qty.toString());

                            templateReload(SQCId)
                        }
                        else {
                            alert(jsonData.msg);
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });

        };

        //抽样按钮点击事件
        function FirstSpecimentBtnClick() {
            $.prompt({
                title: '自定义抽样数量',
                text: '输入抽样数量',
                input: '11',
                empty: false, // 是否允许为空
                onOK: function (input) {
                    //点击确认
                    FirstSpeciment(input);
                },
                onCancel: function () {
                    //点击取消
                }
            });
        }

        //第一次抽检
        function FirstSpeciment(Spec_Qty) {
            //写入样本数据
            var SQCId = $("#SQCID").val();          //送检单
            var Scna_SN = $("#ScanSN").text();      //扫描标签
            $("#lb_CQty").text(Spec_Qty);  //抽检数量
            //var lotQty = $("#lb_ScanQty").text();   // 
            var RequireQty = $("#lb_CQty").text();
            if (Scna_SN.length == 0) {
                alert("扫描信息不能为空...");
                return false;
            }
            if (Spec_Qty == "") {
                alert("抽取数量错误");
                return false;
            }
            var SQCId = $("#SQCID").val();

            var cyfs = $("#CYFS").val();
            var jcsp = $("#lb_CYSP").text();
            var jybz = $("#lb_CYBZ").text();

            var jybz2 = $("#lb_CYBZ2").text();

            //getAQLParam();
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=FirstSpeciment&SendQCReportId=" + SQCId + "&CYFS=" + cyfs + "&JCSP=" + jcsp + "&JYBZ=" + jybz + "&ScanSN=" + Scna_SN + "&CQ_Qty=" + Spec_Qty + "&JYBZ2=" + jybz2,
                type: "Post",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                },
                success: function (data) {
                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result >= 0) {
                            var TCQ_Qty = parseFloat($("#lb_CQty").text());
                            $("#FirstSpecimentBtn").hide();
                            $M.alert("抽样成功");

                            //$M.closeAndReload();
                        }
                        else {
                            $M.alert(jsonData.msg);
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }

        function PrintLabel() {
            //写入样本数据
            var SQCId = $("#SQCID").val();          //送检单
            var Scna_SN = $("#ScanSN").text();      //扫描标签
            var Spec_Qty = $("#lb_CQty").text();  //抽检数量
            //var lotQty = $("#lb_ScanQty").text();   // 
            var RequireQty = $("#lb_CQty").text();
            var Describe = $("#Describe").text();

            if (Scna_SN.length == 0) {
                alert("扫描信息不能为空...");
                return false;
            }
            if (Spec_Qty == "") {
                alert("抽取数量错误");
                return false;
            }
            if (Describe.length > 25) {
                alert("描述不能超过20个字");
                return false;
            }
            var SQCId = $("#SQCID").val();

            //getAQLParam();
            $.ajax({
                url: "Handler/IQC.ashx?FunType=PrintLabel&SendQCReportId=" + SQCId,
                type: "Post",
                data: { Describe: Describe },
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                },
                success: function (data) {
                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result >= 0) {
                            runPrint(jsonData.msg);
                            //$M.alert("抽样成功");
                            //$M.closeAndReload();
                        }
                        else {
                            $M.alert(jsonData.msg);
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }

        function runPrint(YBBQ) {
            var SQCId = $("#SQCID").val();          //送检单<a href="../../Handler/IQC.ashx">Handler/IQC.ashx</a>
            $.ajax({
                url: "Handler/IQC.ashx?FunType=GetPrintContentCode&SendQCReportId=" + SQCId + "&YBBQ=" + YBBQ,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert("Errors");
                },
                success: function (data) {
                    var resJson = JSON.parse(data);
                    if (resJson.result = "0") {
                        $M.openPrint(resJson.msg);
                    } else {
                        $.toast(resJson.msg, "forbidden");
                    }

                }
            });
        }
        //模板
        function templateReload(SQCId) {
            $("#showTable").html("");
            //加载列表
            $.ajax({
                url: "Handler/IQC.ashx?FunType=GetRMExtRecordList&SendQCReportId=" + SQCId,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                    alert("Errors");
                },
                success: function (data) {
                    if (JSON.parse(data).result = "0") {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tb', jsonData); //套模版出html 
                        $("#showTable").append(html); //填充到目标div 

                    } else {
                        $.toast(JSON.parse(data).msg, "forbidden");
                    }
                    $(".weui-loadmore").remove();

                }
            });
        }

        function TestPrint() {
            var SQCId = $("#SQCID").val();          //送检单
            $.ajax({
                url: "Handler/IQC.ashx?FunType=GetPrintContentCode&SendQCReportId=SQCR000000TV&YBBQ=YP1807130001",
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert("Errors");
                },
                success: function (data) {
                    var resJson = JSON.parse(data);
                    if (resJson.result = "0") {
                        $M.openPrint(resJson.msg);
                    } else {
                        $.toast(resJson.msg, "forbidden");
                    }
                }
            });
        }

        function RePrintLabel() {
            var SQCId = $("#SQCID").val();          //送检单
            var Describe = $("#Describe").text();
            $.ajax({
                url: "Handler/IQC.ashx?FunType=RePrintLabel&SendQCReportId=" + SQCId,
                type: "Post",
                data: { Describe: Describe },
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
                    alert(XMLHttpRequest.responseText);
                },
                success: function (data) {
                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result >= 0) {
                            runPrint(jsonData.msg);
                            //$M.alert("抽样成功");
                            //$M.closeAndReload();
                        }
                        else {
                            $M.alert(jsonData.msg);
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }
    </script>

    <script id="SC_ScanList" type="text/html">
        {{each data as value i}}
             
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>扫描SN:{{value.LotSN}}; 抽样方式:{{value.CYFS}}; 检查水平:{{value.CYSP}}; 抽样标准:{{value.CYBZ}}; 抽取数量:{{value.SpecQty}};</p>
                </div>

                <div class="weui-cell__ft">
                    <a href="javascript:;" class="weui-btn weui-btn_warn" onclick="deleteScanList('{{value.LotSN}}')">删除</a>
                </div>
            </div>

        {{/each}}	
    </script>

    <script id="row_tb" type="text/html">
        {{if msg!='没有数据'}}
        <table class="weui-table weui-border-tb weui-table-2n">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>创建时间</th>
                    <th>加抽数量</th>
                    <th>是否完成</th>
                </tr>
            </thead>
            <tbody>
                {{each data as value i}} 
                       <tr>
                           <td>第{{value.CheckNo}}次加抽</td>
                           <td>{{value.CreateDate}}</td>
                           <td>{{value.ExtQty}}</td>
                           <td>{{if  value.IsDone=='True'}}
                                 完成
                               {{else}}
                                待完成
                               {{/if}}
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

    <div id="loading" style="top: 150px; display: none;">
        <div class="lbk">
        </div>
        <div class="lcont">
            <img src="images/loading.gif" alt="loading...">正在提交...
        </div>
    </div>

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
            <td style="color: blue">抽样方式</td>
            <td>
                <div id="cyfs_M" class="weui-cell weui-cell_select weui-cell_select-after  ">
                    <div class="weui-cell__bd ">
                        <select id="CYFS" class="weui-select" name="sel_CYFS" onchange="ChangeValue()">
                            <option value="1.正常">1.正常</option>
                            <option value="2.加严">2.加严</option>
                            <option value="3.放宽">3.放宽</option>
                            <option value="4.免检">4.免检</option>
                        </select>
                    </div>
                </div>
                <td style="color: blue" class="auto-style1">检查水平</td>

            <td>
                <label id="lb_CYSP"></label>

            </td>

            <td colspan="2">
                <table style="width: 100%">
                    <tr>
                        <td style="color: blueviolet">AQL值-1</td>
                        <td>
                            <label id="lb_CYBZ"></label>
                        </td>
                    </tr>
                    <tr>
                        <td style="color: blueviolet">AQL值-2</td>
                        <td>
                            <label id="lb_CYBZ2"></label>
                        </td>
                    </tr>
                </table>
            </td> 
        </tr>
        <tr>
            <td>样本量</td>

            <td>
                <label id="lb_CQty" style="color: blueviolet"></label>
            </td>
            <td colspan="4">
                <table style="width: 100%">
                    <tr>
                        <td class="auto-style1">允收-1(AC)</td>

                        <td>
                            <label id="lb_ACQty" runat="server" style="color: blueviolet"></label>
                        </td>

                        <td class="auto-style1">拒收-1(RE)</td>
                        <td>
                            <label id="lb_ReQty" runat="server" style="color: red"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">允收-2(AC)</td>

                        <td>
                            <label id="lb_ACQty2" runat="server" style="color: blueviolet"></label>
                        </td>

                        <td class="auto-style1">拒收-2(RE)</td>
                        <td>
                            <label id="lb_ReQty2" runat="server" style="color: red"></label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td>
                <input type="button" class="weui-btn weui-btn_primary" value="扫描" onclick="scanQrcode()" id="scanMsgBtn" />
                <span id="scanTitle">扫描信息</span>

            </td>
            <td>
                <label id="ScanSN" runat="server" style="color: red; font-weight: 500"></label>
            </td>
            <td colspan="4">
                <label id="lb_ScanProductDesc" style="color: gray"></label>
            </td>

        </tr>
        <tr>
            <td class="auto-style1">累计扫描数量:</td>
            <td colspan="5">
                <label id="lb_TCQ_Qty"></label>
            </td>

        </tr>
        <tr id="Speciment">
            <td colspan="3">
                <input type="button" class="weui-btn weui-btn_primary" value="加抽" onclick="getSpecimentExt()" />
            <td colspan="3">
                <input class="weui-input" type="number" id="ExtQty" name="ExtQty" placeholder="请输入加抽数量" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')" />
            </td>
        </tr>
        <tr>
            <td class="auto-style1">备注:</td>
            <td colspan="5">
                <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe" readonly="readonly"></textarea>
            </td>

        </tr>
    </table>
    <br />
    <div class="weui-cells__tips tltles">加抽列表</div>
    <div class="weui-cells weui-cells_form" style="margin-top: 0">
        <div class="weui-cell">
            <div id="showTable" style="width: 100%">
            </div>
        </div>

    </div>

    <%--   <input type="button" class="weui-btn weui-btn_primary" value="打印测试" onclick="TestPrint()"   />--%>

    <input type="button" class="weui-btn weui-btn_primary" value="抽样" onclick="FirstSpecimentBtnClick()" id="FirstSpecimentBtn" />
    <input type="button" class="weui-btn weui-btn_primary" value="打印样本标签" onclick="PrintLabel()" id="PrintBtn" />
    <input type="button" class="weui-btn weui-btn_primary" value="重新打印" onclick="RePrintLabel()" id="RePrintBtn" />
    <%--</form>--%>
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SQCID" runat="server" />
        <asp:HiddenField ID="IsS" runat="server" />
        <asp:HiddenField ID="DesMsg" runat="server" />
        <asp:HiddenField ID="SN" runat="server" />
    </form>
</body>
</html>
