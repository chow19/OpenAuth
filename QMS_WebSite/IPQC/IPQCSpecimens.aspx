<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IPQCSpecimens.aspx.cs" Inherits="QMS_WebSite.IPQC.IPQCSpecimens" %>


<!DOCTYPE html>
<html>
<head>


    <title></title>

    <link rel="stylesheet" href="../css/page.css" />
    <link href="../CSS/comm.css" rel="stylesheet" />

    <script src="../scripts/jquery_1.6.3.js"></script>
    <script src="../scripts/jquery.lazyload.min.js"></script>
    <script src="../scripts/comm.js"></script>
    <script src="../scripts/mobilebridge.js?1"></script>
    <script src="../scripts/template.js"></script>
    <script src="../Scripts/jquery-2.1.4.js"></script>
    <script src="../Scripts/fastclick.js"></script>
    <link rel="stylesheet" href="../Scripts/jquery-weui/lib/weui.min.css">
    <link rel="stylesheet" href="../Scripts/jquery-weui.css">
    <script src="../Scripts/jquery-weui.js"></script>
    >
    <!--js 脚本 -->
    <script>
        $(function () {
            pageLoad();

        })

        //页面加载事件
        function pageLoad() {
            $("#PrintBtn").hide();

            var SteptID = $("#SteptID").val();

            if (SteptID == "") {
                $M.alert("数据异常");
                $M.closeAndReload();
            }

            $.ajax({
                url: "Handler/IPQCFirstCheck.ashx?FunType=getStepInfo&wFSteptId=" + SteptID,
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


        //ios设备就绪的方法
        function onDeviceReady() {
            //$M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
            //$("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        }

        function getErrors() {
            $M.alert("errors");
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
            <td>销售订单</td>

            <td>
                <label id="lb_POName"></label>
            </td>
            <td class="auto-style1">客户</td>
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
            <td>工序</td>
            <td colspan="3">
                <label id="lb_ProductDescription"></label>
            </td>
            <td>工单数量</td>
            <td>
                <label id="lb_SendQCQty"></label>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">备注:</td>
            <td colspan="5">
                <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe" readonly="readonly"></textarea>
            </td>

        </tr>
    </table>

    <input type="button" class="weui-btn weui-btn_primary" value="打印样本标签" onclick="PrintLabel()" id="PrintBtn" />
    <%--</form>--%>
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="StepID" runat="server" />
    </form>
</body>
</html>
