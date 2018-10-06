<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowCheckResultDFInfo.aspx.cs" Inherits="QMS_WebSite.IQC.Show.ShowCheckResultDFInfo" %>



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
    <link href="../../CSS/comm.css" rel="stylesheet" />

    <link rel="stylesheet" href="../../css/page.css" />
    <script src="../../scripts/jquery_1.6.3.js"></script>
    <script src="../../scripts/jquery.lazyload.min.js"></script>
    <script src="../../scripts/comm.js"></script>
    <script src="../../scripts/mobilebridge.js?1"></script>
    <script src="../../scripts/template.js"></script>
    <script src="../../Scripts/jquery-2.1.4.js"></script> 
    <link rel="stylesheet" href="../../Scripts/jquery-weui.css">
    <script src="../../Scripts/jquery-weui.js"></script>

    <style> 
        .weui-input {
            border: 1px solid rgba(0,0,0,.2);
        }
    </style>

    <script>

        $(function () {
            //  onDeviceReady();
            pageLoad();
            //提交按钮  
            $("#Submit").click(function () {

                dataSubmt();
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

            if (isNotANumber($("#lb_PackegeMAReNum").text())) {
                pageMA = parseFloat($("#lb_PackegeMAReNum").text());
            }
            if (isNotANumber($("#lb_PackegeMIReNum").text())) {
                pageMI = parseFloat($("#lb_PackegeMAReNum").text());
            }


            if (isNotANumber($("#lb_OutLookMAReNum").text())) {
                outlookMA = parseFloat($("#lb_OutLookMAReNum").text());
            }
            if (isNotANumber($("#lb_OutLookMIReNum").text())) {
                outlookMI = parseFloat($("#lb_OutLookMIReNum").text());
            }


            if (isNotANumber($("#lb_SizeMAReNum").text())) {
                sizeMA = parseFloat($("#lb_SizeMAReNum").text());
            }
            if (isNotANumber($("#lb_SizeMIReNum").text())) {
                sizeMI = parseFloat($("#lb_SizeMAReNum").text());
            }


            if (isNotANumber($("#lb_FunctionMAReNum").text())) {
                functionMA = parseFloat($("#lb_FunctionMAReNum").text());
            }
            if (isNotANumber($("#lb_FunctionMIReNum").text())) {
                functionMI = parseFloat($("#lb_FunctionMIReNum").text());
            }

            var matotal = pageMA + outlookMA + sizeMA + functionMA;
            var mitotal = pageMI + outlookMI + sizeMI + functionMI;

            $("#lb_MATotal").text(matotal.toString());

            $("#lb_MITotal").text(mitotal.toString());

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
                                if ($("#lb_" + o).length > 0) {
                                    var setMsg = retdata[o];
                                    if (setMsg == "true") {
                                        setMsg = "合格"
                                    } else if (setMsg == "false") {
                                        setMsg = "<span style=\"color:red\">不合格</span>"
                                    }
                                    if (o == "CheckResult") {
                                        switch (retdata[o]) {
                                            case "1":
                                                setMsg = "全部接受"
                                                break;
                                            case "2":
                                                setMsg = "让步接受(特采)"
                                                break;
                                            case "3":
                                                setMsg = "挑选接受"
                                                break;
                                            case "4":
                                                setMsg = "免检"
                                                break;
                                            case "5":
                                                setMsg = "全部拒收"
                                                break;
                                            default:
                                                setMsg = "未知错误"
                                                break;
                                        }

                                    }
                                    $("#lb_" + o).text(setMsg)
                                }
                            }
                            GetAQLinfoMA("1.正常", retdata.CYSP, retdata.CYBZ);
                            GetAQLinfoMI("2.加严", retdata.CYSP, retdata.CYBZ);
                            setTotal();
                            if ($("#lb_CQty").text() == "") {
                                $M.alert("数据异常");
                            }
                        } else {
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
                            $("#lb_IssueQty").text(jsonData.data[0].ACQty);
                            $("#lb_reject").text(jsonData.data[0].ReQty);
                        }
                        else {
                            //$("#lb_RequireQty").text("");
                            $("#lb_IssueQty").text("");
                            $("#lb_reject").text("");
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
                            $("#lb_IssueQty2").text(jsonData.data[0].ACQty);
                            $("#lb_reject2").text(jsonData.data[0].ReQty);
                        }
                        else {
                            //$("#lb_RequireQty2").text("");
                            $("#lb_IssueQty2").text("");
                            $("#lb_reject2").text("");
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
            $M.open("ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
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
                    <tr>
                    <td>采购单</td>
                    <%--<td><asp:Label ID="lb_POName"  Text="PO123456"></asp:Label></td>--%>
                    <td>
                        <label id="lb_POName"  ></label>
                    </td>
                    <td class="auto-style1">供应商</td>
                    <td>
                        <label id="lb_VendorName" ></label>
                    </td>
                    <td>物料代码</td>
                    <td>
                       <label id="lb_ProductShortName"></label>
                        <label id="lb_ProductId" style="display:none"></label>
                    </td>
                </tr>
                <tr>
                    <td>物料描述</td>
                    <td colspan="3">
                        <label id="lb_ProductDescription" ></label>
                    </td>
                    <td>送货数量</td>
                    <td>
                        <label id="lb_SendQCQty" ></label>
                    </td>
                </tr>
                <tr>
                    <td style="color: blue">抽样方式</td>
                    <td>
                        <label id="lb_CYFS" ></label>
                    </td>
                    <td style="color: blue" class="auto-style1">检查水平</td>
                    <td>
                        <label id="lb_CYSP" ></label>
                    </td>

                    <td style="color: blueviolet">AQL值</td>

                    <td>
                        <label id="lb_CYBZ" ></label>
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
                                    <label id="lb_IssueQty" style="color: blueviolet"></label>
                                </td>
                                <td>MA合计: </td>
                            </tr>
                            <tr>
                                <td>拒收RE:</td>
                                <td>
                                    <label id="lb_reject" style="color: red"></label>
                                </td>
                                <td>
                                    <label id="lb_MATotal"></label>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="2">MI2.5</td>
                                <td>允收AC:</td>
                                <td>
                                    <label id="lb_IssueQty2" style="color: blueviolet"></label>
                                </td>
                                <td>MI合计:</td>
                            </tr>
                            <tr>
                                <td>拒收RE:</td>
                                <td>
                                    <label id="lb_reject2" style="color: red"></label>
                                </td>
                                <td>
                                    <label id="lb_MITotal"></label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>

                    <td>本次抽取数</td>
                    <td colspan="5">
                        <label id="lb_CQty" runat="server"></label>
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
                <h1>检验结果↓↓<a  href="javascript:" onclick="openCheckStd()" style="font-size:small" >查看检验标准</a></h1>
            </div>
            <div class="weui-panel__bd">

                <div class="weui-cells__tips tltles">包装</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">包装</label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item">
                                    <label id="lb_PackegeDes" style="word-break:break-all;padding-right:10px"></label>
                                </div>
                                <div class="weui-flex__item myborder">MA不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_PackegeMAReNum" style="color: red"></label>
                                </div>
                                <div class="weui-flex__item myborder">MI不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_PackegeMIReNum" style="color: red"></label>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">外观</label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item">
                                    <label id="lb_OutLookDes" style="word-break:break-all;padding-right:10px"></label>
                                </div>
                                <div class="weui-flex__item myborder">MA不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_OutLookMAReNum" style="color: red"></label>
                                </div>
                                <div class="weui-flex__item myborder">MI不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_OutLookMIReNum" style="color: red"></label>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">尺寸</label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item">
                                    <label id="lb_SizeDes" style="word-break:break-all;padding-right:10px"></label>
                                </div>
                                <div class="weui-flex__item myborder">MA不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_SizeMAReNum" style="color: red"></label>
                                </div>
                                <div class="weui-flex__item myborder">MI不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_SizeMIReNum" style="color: red"></label>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">功能实配</label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item">
                                    <label id="lb_FunctionDes"></label>
                                </div>
                                <div class="weui-flex__item myborder">MA不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_FunctionMAReNum" style="color: red"></label>
                                </div>
                                <div class="weui-flex__item myborder">MI不良数</div>
                                <div class="weui-flex__item myborder">
                                    <label id="lb_FunctionMIReNum" style="color: red"></label>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="weui-cells__title">品质检验结果</div>
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">检验结果</label>
                    </div>
                    <div class="weui-cell__bd">
                        <label id="lb_CheckResult"></label>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">接收数量</label>
                    </div>

                    <div class="weui-cell__bd"> 
                        <label id="lb_AcceptQty"   ></label> 
                    </div> 
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">不良数量</label>
                    </div>

                    <div class="weui-cell__bd"> 
              <label id="lb_NGQty" style="color:red" ></label>  
                    </div> 
                </div>
            </div>
        </div>
    </form>
   
    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SQCID" runat="server" />
    </form>
</body>
</html>
