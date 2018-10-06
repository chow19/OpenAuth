<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RawMaterialIQC_Check_Show.aspx.cs" Inherits="QMS_WebSite.IQC.add.RawMaterialIQC_Check_Show" %>


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
    <%--    <link href="Scripts/mui/mui.min.css" rel="stylesheet" />--%>
    <script src="../../Scripts/jquery-weui.js"></script>
    <%--    <script src="Scripts/mui/mui.min.js"></script>--%>
    <script src="../../Scripts/comm.js"></script>
   
    <script>
        var img_UVarr = [];
        // var img_ZMarr = [];
        var img_VLarr = [];
        var img_IRarr = [];
        var img_ZHarr = [];
        var img_BHCarr = [];
        var img_SYCarr = [];
        var img_LCMarr = [];
        var img_YDarr = [];
        var img_NMarr = [];
        var img_CBarr = [];
        var img_CNLarr = [];
        var img_BGCSarr = [];
        var img_SKBHarr = [];
        var img_SKLXarr = [];

        var img_SKSYarr = [];
        var img_D65CHarr = [];
        var img_TL84CHarr = [];
        var img_CWFCHarr = [];
        var img_QBarr = [];
        var img_PQSJarr = [];
        var img_SYCHarr = [];
        var img_FACHarr = [];
        $(function () {
            //  onDeviceReady();

            //图片组件初始化
            ImgControllerinit();

            pageLoad();
            //提交按钮  
            $("#Submit").click(function () {
                dataSubmt();
            });
        });

        //图片组件初始化
        function ImgControllerinit() {



            var $gallery = $("#gallery");
            var $galleryImg = $("#galleryImg");

            var $uploaderFiles = $("#uploaderFilesimg_UV");
            //var $uploaderFiles_ZM = $("#uploaderFilesimg_ZM");
            var $uploaderFiles_VL = $("#uploaderFilesimg_VL");
            var $uploaderFiles_IR = $("#uploaderFilesimg_IR");
            var $uploaderFiles_ZH = $("#uploaderFilesimg_ZH");
            var $uploaderFiles_BHC = $("#uploaderFilesimg_BHC");
            var $uploaderFiles_SYC = $("#uploaderFilesimg_SYC");

            var $uploaderFiles_LCM = $("#uploaderFilesimg_LCM");
            var $uploaderFiles_YD = $("#uploaderFilesimg_YD");
            var $uploaderFiles_NM = $("#uploaderFilesimg_NM");
            var $uploaderFiles_CB = $("#uploaderFilesimg_CB");
            var $uploaderFiles_CNL = $("#uploaderFilesimg_CNL");
            var $uploaderFiles_BGCS = $("#uploaderFilesimg_BGCS");
            var $uploaderFiles_SKBH = $("#uploaderFilesimg_SKBH");
            var $uploaderFiles_SKLX = $("#uploaderFilesimg_SKLX");

            var $uploaderFiles_SKSY = $("#uploaderFilesimg_SKSY");

            var $uploaderFiles_D65CH = $("#uploaderFilesimg_D65CH");
            var $uploaderFiles_TL84CH = $("#uploaderFilesimg_TL84CH");
            var $uploaderFiles_FACH = $("#uploaderFilesimg_FACH");
            var $uploaderFiles_CWFCH = $("#uploaderFilesimg_CWFCH");
            var $uploaderFiles_QB = $("#uploaderFilesimg_QB");
            var $uploaderFiles_PQSJ = $("#uploaderFilesimg_PQSJ");

            var index; //第几张图片  
            $uploaderFiles.on("click", "li", function () {
                index = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("UV");
            });

            var indexvl;
            $uploaderFiles_VL.on("click", "li", function () {
                indexvl = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("VL");
            });
            var indexir;
            $uploaderFiles_IR.on("click", "li", function () {
                indexir = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("IR");
            });
            var indexzh;
            $uploaderFiles_ZH.on("click", "li", function () {
                indexzh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ZH");
            });
            var indexbhc;
            $uploaderFiles_BHC.on("click", "li", function () {
                indexbhc = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("BHC");
            });
            var indexsyc;
            $uploaderFiles_SYC.on("click", "li", function () {
                indexsyc = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("SYC");
            });

            var indexlcm;
            $uploaderFiles_LCM.on("click", "li", function () {
                indexlcm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("LCM");
            });

            var indexyd;
            $uploaderFiles_YD.on("click", "li", function () {
                indexyd = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("YD");
            });

            var indexnm;
            $uploaderFiles_NM.on("click", "li", function () {
                indexnm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("NM");
            });
            var indexcb;
            $uploaderFiles_CB.on("click", "li", function () {
                indexcb = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("CB");
            });
            var indexcnl;
            $uploaderFiles_CNL.on("click", "li", function () {
                indexcnl = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("CNL");
            });

            var indexbgcs;
            $uploaderFiles_BGCS.on("click", "li", function () {
                indexbgcs = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("BGCS");
            });

            var indexskbh;
            $uploaderFiles_SKBH.on("click", "li", function () {
                indexskbh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("SKBH");
            });

            var indexsklx;
            $uploaderFiles_SKBH.on("click", "li", function () {
                indexsklx = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("SKLX");
            });

            var indexsksy;
            $uploaderFiles_SKSY.on("click", "li", function () {
                indexsksy = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("SKSY");
            });

            var indexd65ch;
            $uploaderFiles_D65CH.on("click", "li", function () {
                indexd65ch = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("D65CH");
            });

            var indextl84ch;
            $uploaderFiles_TL84CH.on("click", "li", function () {
                indextl84ch = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("TL84CH");
            });

            var indexfach;
            $uploaderFiles_FACH.on("click", "li", function () {
                indexfach = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("FACH");
            });

            var indexcwfch;
            $uploaderFiles_CWFCH.on("click", "li", function () {
                indexcwfch = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("CWFCH");
            });

            var indexqb;
            $uploaderFiles_QB.on("click", "li", function () {
                indexqb = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("QB");
            });

            var indexpqsj;
            $uploaderFiles_PQSJ.on("click", "li", function () {
                indexpqsj = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("PQSJ");
            });

            $gallery.on("click", function () {
                $gallery.fadeOut(100);
            });

        }

        //添加图片名称到li
        function addImgli(control, msg) {
            if (msg == "") {
                return;
            }
            var arr = msg.split(';');
            var str = "";
            for (var i = 0; i < arr.length; i++) {

                str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"></li>";
            }

            $("#uploaderFilesimg_" + control).append(str);
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

            var RMIID = $("#RMIID").val();
            if (RMIID == "") {
                $M.alert("数据异常");
            }

            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=GetRMIQCCheckDetailInfo&SendQCReportId=" + SQCId + "&RawMaterialIQCCheckId=" + RMIID,
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
                                    if (setMsg == "Ture") {
                                        setMsg = "合格"
                                    } else if (setMsg == "False") {
                                        setMsg = "不合格"
                                    }
                                    if (o == "CheckResult") {
                                        switch (retdata[o]) {
                                            case "1":
                                                setMsg = "合格"
                                                break;
                                            case "2":
                                                setMsg = "不合格"
                                                break; 
                                        }

                                    }

                                    if (o == "CNL_CNL") {

                                        if (retdata[o] == "1") {
                                            setMsg = "1#球" 
                                        }
                                        if (retdata[o] == "2") {
                                            setMsg = "2#球"
                                        }
                                        if (retdata[o] == "3") {
                                            setMsg = "3#球" 
                                        }

                                    }
                                }

                                    $("#lb_" + o).text(setMsg)
                                    if (setMsg == "不合格") {
                                        $("#lb_" + o).css('color', 'red')
                                    }
                                  
                            }

                            GetAQLinfo($("#lb_CYFS").text(), $("#lb_CYSP").text(), $("#lb_CYBZ").text());

                            if ($("#lb_Qty").text() == "") {
                                $M.alert("数据异常");
                            }

                            if (retdata.SpecimentId=="") {
                                return;
                            }
                            if (retdata.UV_Images != "") {
                                addImgli("UV", retdata.UV_Images);
                            }
                            if (retdata.VL_Images != "") {
                                addImgli("VL", retdata.VL_Images);
                            }
                            if (retdata.IR_Images != "") {
                                addImgli("IR", retdata.IR_Images);
                            }

                            if (retdata.HD_ZH_Images != "") {
                                addImgli("ZH", retdata.HD_ZH_Images);
                            }
                            if (retdata.HD_BHC_Images != "") {
                                addImgli("BHC", retdata.HD_BHC_Images);
                            }
                            
                            if (retdata.HD_SYC_Images != "") {
                                addImgli("SYC", retdata.HD_SYC_Images);
                            }
                            if (retdata.HD_LCM_Images != "") {
                                addImgli("LCM", retdata.HD_LCM_Images);
                            }
                            if (retdata.YD_YD_Images != "") {
                                addImgli("YD", retdata.YD_YD_Images);
                            }
                            if (retdata.NM_NM_Images != "") {

                                addImgli("NM", retdata.NM_NM_Images);
                            }
                            if (retdata.CB_CB_Images != "") {
                                addImgli("CB", retdata.CB_CB_Images);
                            }
                            if (retdata.CNL_CNL_Images != "") {
                                addImgli("CNL", retdata.CNL_CNL_Images);
                            }
                            if (retdata.BGCS_BGCS_Images != "") {
                                addImgli("BGCS", retdata.BGCS_BGCS_Images);
                            }
                            if (retdata.GDWBC_SKBH_Images != "") {
                                addImgli("SKBH", retdata.GDWBC_SKBH_Images);
                            }
                            if (retdata.GDWBC_SKSY_Images != "") {
                                addImgli("SKSY", retdata.GDWBC_SKSY_Images);
                            }
                            if (retdata.ST_D65CH_Images != "") {
                                addImgli("D65CH", retdata.ST_D65CH_Images);
                            }

                            if (retdata.ST_TL84CH_Images != "") {
                                addImgli("TL84CH", retdata.ST_TL84CH_Images);
                            }

                            if (retdata.ST_CWFCH_Images != "") {
                                addImgli("CWFCH", retdata.ST_CWFCH_Images);
                            }

                            if (retdata.ST_FACH_Images != "") {
                                addImgli("FACH", retdata.ST_FACH_Images);
                            }

                            if (retdata.ST_QB_Images != "") {
                                addImgli("QB", retdata.ST_QB_Images);
                            }

                            if (retdata.ST_PQSJ_Images != "") {
                                addImgli("PQSJ", retdata.ST_PQSJ_Images);
                            }

                        } else {
                            $("input").val("");
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
               <tr >
                    <td>标签</td>

                    <td>
                        <label id="lb_ScanSN"></label>
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
                <tr  >
                    <td>物料描述</td>
                    <td colspan="3">
                        <label id="lb_ProductDescription"></label>
                    </td>
                    <td>检验数量</td>
                    <td>
                        <label id="lb_Qty"></label>
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
    <form id="form1">
        <%-- <div class="weui-cells__tips"></div>--%>
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <h1>检验结果↓↓<a  href="javascript:" onclick="openCheckStd()" style="font-size:small" >查看检验标准</a></h1>
            </div>
            <div class="weui-panel__bd">

                <div class="weui-cells__tips tltles">透光率</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">UV(%)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_UV"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_UV">
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd   ">
                            <label class="weui-label">VL(%)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_VL"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_VL">
                                    </ul>

                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">IR(%)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_IR"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_IR">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="weui-cells__tips tltles">厚度</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">总厚度(mm)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_HD_ZH"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_ZH">
                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">保护层厚(mm)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_HD_BHC"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_BHC">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">使用层厚度(mm)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_HD_SYC"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SYC">
                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">离层膜厚度(mm)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_HD_LCM"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_LCM">
                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">硬度</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">硬度</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_YD_YD"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_YD">
                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">耐磨</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">耐磨</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_NM_NM"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_NM">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">擦边</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">擦边</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_CB_CB"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CB">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="weui-cells__tips tltles">初粘力</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">初粘力</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_CNL_CNL"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CNL">
                                    </ul>

                                </div>
                            </div>
                        </div>
                        <%-- <div class="weui-uploader__input-box">
                            <input id="img_ZM" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                        </div>--%>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">百格测试</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">百格测试</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_BGCS_BGCS"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_BGCS">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="weui-cells__tips tltles">高低温保存测试</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">撕开保护层</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_GDWBC_SKBH"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SKBH">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">撕开离型层</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_GDWBC_SKLX"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SKLX">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">撕开使用层</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_GDWBC_SKSY"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SKSY">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="weui-cells__tips tltles">试贴</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">D65彩虹纹</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ST_D65CH"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_D65CH">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">TL84彩虹纹</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ST_TL84CH"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_TL84CH">
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">F/A彩虹纹</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ST_FACH"></label>

                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_FACH">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">CWF彩虹纹</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ST_CWFCH"></label>

                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CWFCH">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">气边</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ST_QB"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_QB">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">排气时间(s)</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ST_PQSJ"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_PQSJ">
                                    </ul>

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
            </div>
        </div>

    </form>

   
    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SQCID" runat="server" />
        <asp:HiddenField ID="RMIID" runat="server" />
    </form>
</body>
</html>
