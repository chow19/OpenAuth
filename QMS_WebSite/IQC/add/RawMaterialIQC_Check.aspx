<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RawMaterialIQC_Check.aspx.cs" Inherits="QMS_WebSite.IQC.add.RawMaterialIQC_Check" %>


<!DOCTYPE html>
<html > 
<head>
    <title>原材料检验</title>
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
    <script src="../../Scripts/comm.js"></script>


    <script>

        $(function () {
            //  onDeviceReady();
            pageLoad();
            // setBarButton();
            //提交按钮  
            //$("#Submit").click(function () {
            //    dataSubmt();
            //});

            $("#AcceptQty").on("keyup", function () {
                var AcceptQty = $("#AcceptQty").val();
                var SendQty = $("#lb_SendQty").text();

                var NGQty = SendQty - AcceptQty;
                $("#NGQty").val(NGQty)
            });

            $("input[type='number']").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ''))

            }).bind("paste", function () {  //CTR+V事件处理    
                $(this).val($(this).val().replace(/[^0-9]/g, ''))
            });

        });
        function setBarButton() {
            $M.setButton("[{\"function\":\"addCheck\",\"title\":\"新增\"}]");
        }

        //ios设备就绪的方法
        function onDeviceReady() {
            //$M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
            $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
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
            //var AcceptQty = $("#AcceptQty").val();
            //var NGQty = $("#NGQty").val();
            var CheckResult = $form["CheckResult"];

            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                CheckResult: CheckResult,
                AcceptQty: 0,
                NGQty: 0,
                CheckType: 2
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
                        $.hideLoading();
                        alert(e.message);
                    }
                }
            });
            $.hideLoading();
        }
        function CheckSubmit() {
            var $form = $("#form1").formSerialize();
            // alert(JSON.stringify( $form));
            var CheckResult = $form["CheckResult"];
            if (CheckResult == "0") {
                $.toptip('请选择检验结果', 'error');
                return false;
            }

            //var AcceptQty = $("#AcceptQty").val();
            //var NGQty = $("#NGQty").val();
            //var SendQty = $("#lb_SendQty").text();
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
                                    if (setMsg == "True") {
                                        setMsg = "合格"
                                    } else if (setMsg == "False") {
                                        setMsg = "不合格"
                                    }
                                    $("#lb_" + o).text(setMsg)

                                }
                            }
                            GetAQLinfo($("#lb_CYFS").text(), $("#lb_CYSP").text(), $("#lb_CYBZ").text());
                            if ($("#lb_POName").text() == "") {
                                $M.alert("数据异常");
                            }

                        } else { 
                            $("lable").text(""); 
                        }
                    } catch (e) {
                        alert("AJAX错误:"+e.message);
                    }
                }
            });

            //加载列表
            templateReload(SQCId);
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
        function GetAQLinfo(cyfs, jcsp, jybz) {
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
                            $("#lb_RequireQty").text(jsonData.data[0].SampleQty);
                            $("#lb_IssueQty").text(jsonData.data[0].ACQty);
                            $("#lb_reject").text(jsonData.data[0].ReQty);
                        }
                        else {
                            $("#lb_RequireQty").text("");
                            $("#lb_IssueQty").text("");
                            $("#lb_reject").text("");
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        };

        function editCheck(RawMaterialIQCCheckId) {
            var SQCId = $("#SQCID").val();
            $M.open("RawMaterialIQC_Check_Edit.aspx?RawMaterialIQCCheckId=" + RawMaterialIQCCheckId + "&SendQCReportId=" + SQCId, "检验");
        }
        function showCheck(RawMaterialIQCCheckId) {
            var SQCId = $("#SQCID").val();
            $M.open("RawMaterialIQC_Check_Show.aspx?RawMaterialIQCCheckId=" + RawMaterialIQCCheckId + "&SendQCReportId=" + SQCId, "检验单详细");
        }

        function delCheck(RawMaterialIQCCheckId) {
            var SQCId = $("#SQCID").val();
            if (!confirm("确定删除???")) {
                return false;
            }
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=RMResultDel&RawMaterialIQCCheckId=" + RawMaterialIQCCheckId,
                type: "post",
                cache: false,

                error: function (XMLHttpRequest, textStatus, e) {
                    $.hideLoading();
                    $M.alert("提交数据异常");
                },
                success: function (data) {

                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            $.toast("删除成功");
                            templateReload(SQCId);
                        }
                        else {
                            $.toast(jsonData.msg, 'forbidden');
                        }
                    } catch (e) {
                        alert(e.message);
                    }
                }
            });
        }

        //上传数据
        function UploadCheckData(SendQCReportId) {

            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=RMResultDataUpload&SendQCReportId=" + SendQCReportId,
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
                            $.toast("上传成功");
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
        }

        function templateReload(SQCId) {
            $("#showTable").html("");
            //加载列表
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=GetRMIQCCheckInfo&SendQCReportId=" + SQCId,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) {
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
                    $(".all_shown").show();
                }
            });
        }

        //扫描
        function scanQrcode() {
           // var qrcode = 'RG1130000002V';
           $M.scanQrcode(function (qrcode) {
                //$M.alert(qrcode);
                $.showLoading();
                var SQCId = document.getElementById("SQCID").value.trim();
                $("#ScanSN").html(qrcode);
                getScanSN_Data(qrcode, SQCId);
                $.hideLoading();
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
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            $("#lb_ScanProductDesc").text(jsonData.data[0].ProductDescription)
                            $("#lb_ScanQty").text(jsonData.data[0].Qty);
                            // $("#txt_getQty").focus('', function fn() { }); 
                            //获取成功则添加一条记录
                            addCheck(scanSN, jsonData.data[0].Qty);
                        }
                        else {
                            $("#lb_ScanProductDesc").text("");
                            $("#lb_ScanQty").text("");
                            $M.alert(jsonData.msg);
                        }

                    } catch (e) {
                        alert(e.message);
                    }
                }
            });

        }
        //新增行记录
        function addCheck(ScanSn, ScanQty) {
            var SQCId = $("#SQCID").val();
            if (SQCId == "") {
                $M.alert("数据异常");
            }
            var postData = {
                SendQCReportId: SQCId,
                ScanSn: ScanSn,
                ScanQty: ScanQty
            };
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=RMIQCCheckScanSubmit&SendQCReportId=" + SQCId,
                type: "post",
                cache: false,
                data: postData,
                error: function (XMLHttpRequest, textStatus, e) {
                    $M.alert("提交数据异常");
                },
                success: function (data) {
                    try {
                        $.parseJSON(data);
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) {
                            templateReload(SQCId);
                        }
                        else {
                            $.toast(jsonData.msg, 'forbidden');
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
                    <th>标签</th>
                    <th>扫描数量</th>
                    <th>扫描时间</th>
                    <th>检验结果</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                {{each data as value i}} 
                       <tr>
                           <td>{{value.ScanSN}}</td>
                           <td>{{value.Qty}}</td>
                           <td>{{value.CreateDate}}</td>
                           <td>{{value.CheckResult}}</td>
                           <td>
                               <table style="width: 80%">
                                   <tr>
                                       <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                       {{if value.IsCheck=='False'}} 
                                       <td><a href="javascript:;" class="weui-btn weui-btn_primary" onclick="editCheck('{{value.RawMaterialIQCCheckId}}');">检验</a></td>
                                       <td><a href="javascript:;" class="weui-btn weui-btn_warn" onclick="delCheck('{{value.RawMaterialIQCCheckId}}');">删除</a></td>
                                       {{/if}}
                                     
                                       <td><a href="javascript:;" class="weui-btn weui-btn_default" onclick="showCheck('{{value.RawMaterialIQCCheckId}}');">查看</a></td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                {{/each}}	
            </tbody>
        </table>
        {{else}}
           <p class="weui-msg__desc">暂无数据</p>
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
    <!--*******************************送检单详细 开始**********************************-->
    <div class="weui-panel weui-panel_access">
        <div class="weui-panel__hd">
            <h1>检验单↓↓</h1>
        </div>
        <div class="weui-panel__bd">
            <table id="detailsTable">
                <tr>
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
                        <label id="lb_ProductId" style="display:none"></label>
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
                        <label id="lb_CYFS"></label>
                    </td>
                    <td style="color: blue" class="auto-style1">检查水平</td>
                    <td>
                        <label id="lb_CYSP"></label>
                    </td>

                    <td style="color: blueviolet">AQL值</td>

                    <td>
                        <label id="lb_CYBZ"></label>
                    </td>

                </tr>
                <tr>
                    <td>样本量</td>

                    <td>
                        <label id="lb_RequireQty" style="color: blueviolet"></label>
                    </td>

                    <td class="auto-style1">允收(AC)</td>

                    <td>
                        <label id="lb_IssueQty" style="color: blueviolet"></label>
                    </td>

                    <td class="auto-style1">拒收(RE)</td>

                    <td>
                        <label id="lb_reject" style="color: red"></label>
                    </td>

                </tr>

                
            </table>
        </div>
    </div>
    <!--******************************送检单详细 结束**********************************-->

    <!--********************************填写检验结果 开始**************************************-->

    <div class="weui-panel weui-panel_access">
        <div class="weui-panel__hd">
            <h1>检验列表↓↓</h1>
        </div>
        <div class="weui-panel__bd">

            <div class="weui-media-box weui-media-box_appmsg">
                <div class="weui-media-box__hd">
                    <a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary" onclick="scanQrcode()">扫描</a>
                </div>
                <div class="weui-media-box__bd">
                    <h4>描述:
                        <span class="weui-media-box__desc" id="lb_ScanProductDesc"></span>
                    </h4>
                    <p>
                        扫描数量:        
                        <span class="weui-media-box__desc" id="lb_ScanQty"></span>
                    </p>
                </div>
            </div>
            <div id="showTable">
            </div>
        </div>
    </div>
    <form id="form1">
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
        <%-- <div class="weui-cell">
            <div class="weui-cell__hd  ">
                <label class="weui-label">接收数量</label>
            </div>

            <div class="weui-cell__bd">
                <input class="weui-input" type="number" id="AcceptQty" name="AcceptQty">
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__hd  ">
                <label class="weui-label">不良数量</label>
            </div>

            <div class="weui-cell__bd">
                <input class="weui-input" type="number" id="NGQty" name="NGQty">
            </div>
        </div>--%>
    </form>
    <a href="javascript:;" class="weui-btn weui-btn_primary" onclick="dataSubmt()">上传数据</a>
    <a href="javascript:;" id='show-loading' class="weui-btn weui-btn_primary" style="display: none">提交中</a>
    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SQCID" runat="server" />

    </form>
</body>
</html>

