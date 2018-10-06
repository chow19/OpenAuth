<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowCheckResultBInfo.aspx.cs" Inherits="QMS_WebSite.IQC.Show.ShowCheckResultBInfo" %>



<!DOCTYPE html>
<html > 
<head>
    <title>玻璃检验</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <link href="../../CSS/comm.css" rel="stylesheet" /> 

    <link rel="stylesheet" href="../../css/page.css" />
    <link rel="stylesheet" href="../../scripts/jquery-weui/lib/weui.min.css" />
    <link rel="stylesheet" href="../../scripts/jquery-weui/lib/weui.css" />

    <link rel="stylesheet" href="../../css/page.css" />
    <script src="../../scripts/jquery_1.6.3.js"></script>
    <script src="../../scripts/jquery.lazyload.min.js"></script>
    <script src="../../scripts/comm.js"></script>
    <script src="../../scripts/mobilebridge.js?5"></script>
    <script src="../../scripts/template.js"></script>
    <script src="../../Scripts/jquery-2.1.4.js"></script>

    <link rel="stylesheet" href="../../Scripts/jquery-weui.css">
    <script src="../../Scripts/jquery-weui.js"></script>
     
    <script>
        var img_UVarr = [];
        // var img_ZMarr = [];
        var img_VLarr = [];
        var img_IRarr = [];
        var img_ZHarr = [];
        var img_BLHarr = [];
        var img_ABJHarr = [];
        var img_YDarr = [];
        var img_CSarr = [];
        var img_NMarr = [];
        var img_MCHarr = [];
        var img_ZMarr = [];
        var img_BMarr = [];
        var img_GQLXarr = [];
        var img_WBarr = [];
        var img_STarr = [];
        $(function () {

            ini();
            //图片组件初始化
            ImgControllerinit();
            //  onDeviceReady();
            pageLoad();
            //提交按钮  
            $("#Submit").click(function () {
                dataSubmt();
            });

        });

        function save() {
            if (!confirm("确认提交？")) {
                return false;
            }
            dataSubmt();
            //$M.open("Upload_Pics.aspx", "送检单检验"); 
        };
        function dataSubmt() {
            $.showLoading();
            var SQCId = $("#SQCID").val();
            if (SQCId == "") {
                $M.alert("数据异常");
            }
            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = {
                "UV_Images": img_UVarr.join(";"),
                "VL_Images": img_VLarr.join(";"),
                "VL_Images": img_VLarr.join(","),
                "IR_Images": img_IRarr.join(","),
                "HD_ZH_Images": img_ZHarr.join(","),
                "HD_BLH_Images": img_BLHarr.join(","),
                "HD_ABJH_Images": img_ABJHarr.join(","),
                "YD_YD_Images": img_YDarr.join(","),
                "SDJ_CS_Images": img_CSarr.join(","),
                "SDJ_NM_Images": img_NMarr.join(","),
                "SDJ_MCH_Images": img_MCHarr.join(","),
                "ZWY_ZM_Images": img_ZMarr.join(","),

                "ZWY_BM_Images": img_BMarr.join(","),
                "GHXG_GQLX_Images": img_GQLXarr.join(","),
                "GHXG_WB_Images": img_WBarr.join(","),
                "ST_ST_Images": img_STarr.join(",")
            };

            var Describe = $("#Describe").val();

            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                Describe: Describe,
                ExtCheckNo: $("#hidExtCheckNo").val()
            };
            $.ajax({ 
                url: "../../Handler/IQC.ashx?FunType=GlassExtSubmit&SendQCReportId=" + SQCId,
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
                            ini();
                            //加载列表
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
            $.hideLoading();
        }
        function CheckSubmit() {

            var ext = $("#hidExtCheckNo").val()
            if (ext == "") {
                $M.alert("数据异常");
                return false;
            }
            return true;
        }

        function ini() {
            $("#submit").hide();
            $(".weui-uploader__input-box").hide();
            $("#Describe").attr("readonly", "readonly");
        }
        function editOpen() {
            $("#submit").show();
            $(".weui-uploader__input-box").show();
            $("#Describe").removeAttr("readonly");

        }
        //图片组件初始化
        function ImgControllerinit() {

            uploadImgInit("uploaderInputimg_UV", "uploaderFilesimg_UV");
            // uploadImgInit("uploaderInputimg_ZM", "uploaderFilesimg_ZM");
            uploadImgInit("uploaderInputimg_VL", "uploaderFilesimg_VL");
            uploadImgInit("uploaderInputimg_IR", "uploaderFilesimg_IR");
            uploadImgInit("uploaderInputimg_ZH", "uploaderFilesimg_ZH");
            uploadImgInit("uploaderInputimg_BLH", "uploaderFilesimg_BLH");
            uploadImgInit("uploaderInputimg_ABJH", "uploaderFilesimg_ABJH");
            uploadImgInit("uploaderInputimg_YD", "uploaderFilesimg_YD");
            uploadImgInit("uploaderInputimg_CS", "uploaderFilesimg_CS");
            uploadImgInit("uploaderInputimg_NM", "uploaderFilesimg_NM");
            uploadImgInit("uploaderInputimg_MCH", "uploaderFilesimg_MCH");
            uploadImgInit("uploaderInputimg_ZM", "uploaderFilesimg_ZM");
            uploadImgInit("uploaderInputimg_BM", "uploaderFilesimg_BM");
            uploadImgInit("uploaderInputimg_GQLX", "uploaderFilesimg_GQLX");
            uploadImgInit("uploaderInputimg_WB", "uploaderFilesimg_WB");
            uploadImgInit("uploaderInputimg_ST", "uploaderFilesimg_ST");

            var $gallery = $("#gallery");
            var $galleryImg = $("#galleryImg");

            var $uploaderFiles = $("#uploaderFilesimg_UV");
            var $uploaderFiles_VL = $("#uploaderFilesimg_VL");
            var $uploaderFiles_IR = $("#uploaderFilesimg_IR");
            var $uploaderFiles_ZH = $("#uploaderFilesimg_ZH");
            var $uploaderFiles_BLH = $("#uploaderFilesimg_BLH");
            var $uploaderFiles_ABJH = $("#uploaderFilesimg_ABJH");
            var $uploaderFiles_YD = $("#uploaderFilesimg_YD");
            var $uploaderFiles_CS = $("#uploaderFilesimg_CS");
            var $uploaderFiles_NM = $("#uploaderFilesimg_NM");
            var $uploaderFiles_MCH = $("#uploaderFilesimg_MCH");
            var $uploaderFiles_ZM = $("#uploaderFilesimg_ZM");
            var $uploaderFiles_BM = $("#uploaderFilesimg_BM");

            var $uploaderFiles_GQLX = $("#uploaderFilesimg_GQLX");
            var $uploaderFiles_WB = $("#uploaderFilesimg_WB");
            var $uploaderFiles_ST = $("#uploaderFilesimg_ST");

            var index; //第几张图片  
            $uploaderFiles.on("click", "li", function () {
                index = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            //var indexzm;
            //$uploaderFiles_ZM.on("click", "li", function () {
            //    indexzm = $(this).index();
            //    $galleryImg.attr("style", this.getAttribute("style"));
            //    $gallery.fadeIn(100);
            //    $("#hidgalley").val("ZW");
            //});
            var indexvl;
            $uploaderFiles_VL.on("click", "li", function () {
                indexvl = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexir;
            $uploaderFiles_IR.on("click", "li", function () {
                indexir = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexzh;
            $uploaderFiles_ZH.on("click", "li", function () {
                indexzh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexblh;
            $uploaderFiles_BLH.on("click", "li", function () {
                indexblh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexabjh;
            $uploaderFiles_ABJH.on("click", "li", function () {
                indexabjh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexyd;
            $uploaderFiles_YD.on("click", "li", function () {
                indexyd = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexcs;
            $uploaderFiles_CS.on("click", "li", function () {
                indexcs = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexnm;
            $uploaderFiles_NM.on("click", "li", function () {
                indexnm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexmch;
            $uploaderFiles_MCH.on("click", "li", function () {
                indexmch = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexzm;
            $uploaderFiles_ZM.on("click", "li", function () {
                indexzm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexbm;
            $uploaderFiles_BM.on("click", "li", function () {
                indexbm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexgqlx;
            $uploaderFiles_GQLX.on("click", "li", function () {
                indexgqlx = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);

            });
            var indexwb;
            $uploaderFiles_GQLX.on("click", "li", function () {
                indexwb = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            var indexst;
            $uploaderFiles_ST.on("click", "li", function () {
                indexst = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });

            $gallery.on("click", function () {
                $gallery.fadeOut(100);
            });
            //删除图片  
            $(".weui-gallery__del").click(function () {
                var hidgalley = $("#hidgalley").val();
                switch (hidgalley) {
                    case "UV":
                        $uploaderFiles.find("li").eq(index).remove();
                        img_UVarr.splice(index, 1);
                        break;
                    case "VL":
                        $uploaderFiles_VL.find("li").eq(indexvl).remove();
                        img_VLarr.splice(indexvl, 1);
                        break;
                    case "IR":
                        $uploaderFiles_IR.find("li").eq(indexir).remove();
                        img_VLarr.splice(indexir, 1);
                        break;
                    case "ZH":
                        $uploaderFiles_ZH.find("li").eq(indexzh).remove();
                        img_ZHarr.splice(indexzh, 1);
                        break;
                    case "BLH":
                        $uploaderFiles_BLH.find("li").eq(indexblh).remove();
                        img_BLHarr.splice(indexblh, 1);
                        break;
                    case "ABJH":
                        $uploaderFiles_ABJH.find("li").eq(indexabjh).remove();
                        img_ABJHarr.splice(indexabjh, 1);
                        break;
                    case "YD":
                        $uploaderFiles_YD.find("li").eq(indexyd).remove();
                        img_YDarr.splice(indexyd, 1);
                        break;
                    case "CS":
                        $uploaderFiles_CS.find("li").eq(indexcs).remove();
                        img_CSarr.splice(indexcs, 1);
                        break;
                    case "NM":
                        $uploaderFiles_NM.find("li").eq(indexnm).remove();
                        img_NMarr.splice(indexnm, 1);
                        break;
                    case "MCH":
                        $uploaderFiles_MCH.find("li").eq(indexmch).remove();
                        img_MCHarr.splice(indexmch, 1);
                        break;
                    case "ZM":
                        $uploaderFiles_ZM.find("li").eq(indexzm).remove();
                        img_ZMarr.splice(indexzm, 1);
                        break;
                    case "BM":
                        $uploaderFiles_BM.find("li").eq(indexbm).remove();
                        img_BMarr.splice(indexbm, 1);
                        break;
                    case "GQLX":
                        $uploaderFiles_GQLX.find("li").eq(indexgqlx).remove();
                        img_GQLXarr.splice(indexgqlx, 1);
                        break;
                    case "WB":
                        $uploaderFiles_WB.find("li").eq(indexwb).remove();
                        img_WBarr.splice(indexwb, 1);
                        break;
                    case "ST":
                        $uploaderFiles_ST.find("li").eq(indexst).remove();
                        img_STarr.splice(indexst, 1);
                        break;

                }
                //alert(img_UVarr.toString());
            });

        }

        //添加图片名称到数组
        function addImgli(control, msg) {
            //<li class="weui-uploader__file"  style="background-image:url(" 
            var arr = msg.split(';');
            //switch (control) {
            //    case "UV":
            //        arr = msg.split(';');
            //        break;
            //    case "ZW":
            //        arr = msg.split(';');
            //        break;
            //    case "VL":
            //        arr = msg.split(';');
            //        break;
            //    case "IR":
            //        arr = msg.split(';');
            //        break;
            //    case "ZH":
            //        arr = msg.split(';');
            //        break;
            //    case "BLH":
            //        arr = msg.split(';');
            //        break;
            //    case "ABJH":
            //        arr = msg.split(';');
            //        break;
            //    case "YD":
            //        arr = msg.split(';');
            //        break;
            //    case "CS":
            //        arr = msg.split(';');
            //        break;
            //    case "NM":
            //        arr = msg.split(';');
            //        break;
            //    case "MCH":
            //        arr = msg.split(';');
            //        break;
            //    case "ZM":
            //        arr = msg.split(';');
            //        break;
            //    case "BM":
            //        arr = msg.split(';');
            //        break;
            //    case "GQLX":
            //        arr = msg.split(';');
            //        break;
            //    case "WB":
            //        arr = msg.split(';');
            //        break;
            //    case "ST":
            //        arr = msg.split(';');
            //        break;
            //}

            var str = "";
            for (var i = 0; i < arr.length; i++) {

                var temp = arr[i].split('-');
                if (temp.length > 1) {
                    str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"><span style=\"color:red\">第" + temp[0] + "次加抽</span></li>";
                } else {
                    str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"></li>";
                }
            }
            $("#uploaderFilesimg_" + control).append(str);
        }

        //ios设备就绪的方法
        function onDeviceReady() {
            //$M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
            $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
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
            //加载列表
            templateReload(SQCId);

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
                                    if (setMsg == "Ture") {
                                        setMsg = "合格"
                                    } else if (setMsg == "False") {
                                        setMsg = "不合格"
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
                                    if (setMsg == "不合格") {
                                        $("#lb_" + o).css('color', 'red')
                                    }
                                }
                            }
                            GetAQLinfo($("#lb_CYFS").text(), $("#lb_CYSP").text(), $("#lb_CYBZ").text());
                            if ($("#lb_CQty").text() == "") {
                                $M.alert("数据异常");
                            }
                          
                            if (showExtImg()) {
                              
                                //如果是已经加抽的就加载最后一次完成的加抽 
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
                                if (retdata.HD_BLH_Images != "") {
                                    addImgli("BLH", retdata.HD_BLH_Images);
                                }
                                if (retdata.HD_ABJH_Images != "") {
                                    addImgli("ABJH", retdata.HD_ABJH_Images);
                                }
                                if (retdata.YD_YD_Images != "") {
                                    addImgli("YD", retdata.YD_YD_Images);
                                }
                                if (retdata.SDJ_CS_Images != "") {
                                    addImgli("CS", retdata.SDJ_CS_Images);
                                }
                                if (retdata.SDJ_NM_Images != "") {
                                    addImgli("NM", retdata.SDJ_NM_Images);
                                }
                                if (retdata.SDJ_MCH_Images != "") {
                                    addImgli("MCH", retdata.SDJ_MCH_Images);
                                }
                                if (retdata.ZWY_ZM_Images != "") {
                                    addImgli("ZM", retdata.ZWY_ZM_Images);
                                }
                                if (retdata.ZWY_BM_Images != "") {
                                    addImgli("BM", retdata.ZWY_BM_Images);
                                }
                                if (retdata.GHXG_GQLX_Images != "") {
                                    addImgli("GQLX", retdata.GHXG_GQLX_Images);
                                }
                                if (retdata.GHXG_WB_Images != "") {
                                    addImgli("WB", retdata.GHXG_WB_Images);
                                }
                                if (retdata.ST_ST_Images != "") {
                                    addImgli("ST", retdata.ST_ST_Images);
                                }
                            }
                        } else {

                            $("lable").text(""); 
                        } 

                    } catch (e) {
                        
                    }
                }
            });
        }

        function showExtImg() {
            var SQCId = $("#SQCID").val();
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=getExtImgXmlData&SendQCReportId=" + SQCId,
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
                            if (retdata.HD_BLH_Images != "") {
                                addImgli("BLH", retdata.HD_BLH_Images);
                            }
                            if (retdata.HD_ABJH_Images != "") {
                                addImgli("ABJH", retdata.HD_ABJH_Images);
                            }
                            if (retdata.YD_YD_Images != "") {
                                addImgli("YD", retdata.YD_YD_Images);
                            }
                            if (retdata.SDJ_CS_Images != "") {
                                addImgli("CS", retdata.SDJ_CS_Images);
                            }
                            if (retdata.SDJ_NM_Images != "") {
                                addImgli("NM", retdata.SDJ_NM_Images);
                            }
                            if (retdata.SDJ_MCH_Images != "") {
                                addImgli("MCH", retdata.SDJ_MCH_Images);
                            }
                            if (retdata.ZWY_ZM_Images != "") {
                                addImgli("ZM", retdata.ZWY_ZM_Images);
                            }
                            if (retdata.ZWY_BM_Images != "") {
                                addImgli("BM", retdata.ZWY_BM_Images);
                            }
                            if (retdata.GHXG_GQLX_Images != "") {
                                addImgli("GQLX", retdata.GHXG_GQLX_Images);
                            }
                            if (retdata.GHXG_WB_Images != "") {
                                addImgli("WB", retdata.GHXG_WB_Images);
                            }
                            if (retdata.ST_ST_Images != "") {
                                addImgli("ST", retdata.ST_ST_Images);
                            }
                            return false;
                        } else {
                            return true;
                        }
                    } catch (e) {
                        alert(e.message);
                    }

                }
            });
            return true;
        }
        //模板
        function templateReload(SQCId) {
            $("#showTable").html("");
            //加载列表
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=GetRMExtRecordList&SendQCReportId=" + SQCId,
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
                        if (JSON.parse(data).IsHasDone == "1") {
                            //开启编剧模式
                            editOpen();
                            // $("#hidExtCheckNo").val();
                        }

                    } else {
                        $.toast(JSON.parse(data).msg, "forbidden");
                    }
                    $(".weui-loadmore").remove(); 
                }
            });
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
             
            $(".weui-loadmore").remove();
        };

        //上传图片初始化
        function uploadImgInit(uploaderInputimg, uploaderFilesimg) {

            var $uploaderInput = $("#" + uploaderInputimg);
            var $uploaderFiles = $("#" + uploaderFilesimg);

            // 允许上传的图片类型  
            var allowTypes = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
            // 1024KB，也就是 1MB  
            var maxSize = 2048 * 2048;
            // 图片最大宽度  
            var maxWidth = 10000;
            // 最大上传图片数量  
            var maxCount = 6;

            $uploaderInput.on('change', function (event) {

                var inputid = $(this).attr("id");
                $("#hidgalley").val(inputid.replace(/uploaderInputimg_/, ""));

                var files = event.target.files;
                //console.log(files);return false;
                // 如果没有选中文件，直接返回  
                if (files.length === 0) {
                    return;
                }

                for (var i = 0, len = files.length; i < len; i++) {
                    var file = files[i];
                    var reader = new FileReader();

                    // 如果类型不在允许的类型范围内  
                    if (allowTypes.indexOf(file.type) === -1) {

                        $.alert("该类型不允许上传！", "警告！");
                        continue;
                    }

                    if (file.size > maxSize) {
                        //$.weui.alert({text: '图片太大，不允许上传'});
                        $.alert("图片太大，不允许上传", "警告！");
                        continue;
                    }

                    //if ($('.weui-uploader__file').length >= maxCount) {
                    //    $.weui.alert({ text: '最多只能上传' + maxCount + '张图片' });
                    //    return;
                    //}

                    reader.readAsDataURL(file);
                    reader.onload = function (e) {
                        //console.log(e);
                        var img = new Image();
                        img.src = e.target.result;
                        img.onload = function () {
                            // 不要超出最大宽度  
                            var w = Math.min(maxWidth, img.width);
                            // 高度按比例计算  
                            var h = img.height * (w / img.width);
                            var canvas = document.createElement('canvas');
                            var ctx = canvas.getContext('2d');
                            // 设置 canvas 的宽度和高度  
                            canvas.width = w;
                            canvas.height = h;
                            ctx.drawImage(img, 0, 0, w, h);

                            var base64 = canvas.toDataURL('image/jpeg', 0.8);
                            //console.log(base64);

                            // 插入到预览区  
                            var $preview = $('<li class="weui-uploader__file weui-uploader__file_status" style="background-image:url(' + img.src + ')"><div class="weui-uploader__file-content">0%</div><span style=\"color:red\">第' + $("#hidExtCheckNo").val() + '次加抽</span></li>');
                            $uploaderFiles.append($preview);
                            var num = $('.weui-uploader__file').length;
                            $('.weui-uploader__info').text(num + '/' + maxCount);

                            var formData = new FormData();

                            formData.append("images", base64);
                            formData.append("filetype", file.type);

                            formData.append("ExtNo", $("#hidExtCheckNo").val());

                            //console.log(img.src);<a href="../../UploadFile.aspx">../../UploadFile.aspx</a>
                            $.ajax({
                                url: "../../UploadFile.aspx",
                                type: 'POST',
                                data: formData,
                                contentType: false,
                                processData: false,
                                success: function (data) {
                                    $preview.removeClass('weui-uploader__file_status');
                                    var jsonData = eval("(" + data + ")");
                                    if (jsonData.result == 0) {
                                        addImgArr(jsonData.msg);
                                        $.toast("上传成功");
                                    } else {
                                        $.toast("上传失败", "forbidden");
                                    }


                                },
                                error: function (xhr, type) {
                                    $.toast("Ajax error!", "forbidden");
                                }
                            });
                        };
                    };

                }
            });

        }

        //添加图片名称到数组
        function addImgArr(msg) {
            var hidgalley = $("#hidgalley").val();
            switch (hidgalley) {
                case "UV":
                    img_UVarr.push(msg);
                    break;
                case "ZW":
                    img_ZMarr.push(msg);
                    break;
                case "VL":
                    img_VLarr.push(msg);
                    break;
                case "IR":
                    img_IRarr.push(msg);
                    break;
                case "ZH":
                    img_ZHarr.push(msg);
                    break;
                case "BLH":
                    img_BLHarr.push(msg);
                    break;
                case "ABJH":
                    img_ABJHarr.push(msg);
                    break;
                case "YD":
                    img_YDarr.push(msg);
                    break;
                case "CS":
                    img_CSarr.push(msg);
                    break;
                case "NM":
                    img_NMarr.push(msg);
                    break;
                case "MCH":
                    img_MCHarr.push(msg);
                    break;
                case "ZM":
                    img_ZMarr.push(msg);
                    break;
                case "BM":
                    img_BMarr.push(msg);
                    break;
                case "GQLX":
                    img_GQLXarr.push(msg);
                    break;
                case "WB":
                    img_WBarr.push(msg);
                    break;
                case "ST":
                    img_STarr.push(msg);
                    break;
            }
        }
        function openCheckStd() {
            var psn = $("#lb_ProductShortName").text();
            var pid = $("#lb_ProductId").text();
            $M.open("ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
        }
    </script>

    <script id="row_tb" type="text/html">
        {{if msg!='没有数据'}}
        <table class="weui-table weui-border-tb weui-table-2n">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>创建时间</th>
                    <th>加抽数量</th>
                    <th>备注</th>
                    <th>是否完成</th>
                </tr>
            </thead>
            <tbody>
                {{each data as value i}} 
                       <tr>
                           <td>第{{value.CheckNo}}次加抽</td>
                           <td>{{value.CreateDate}}</td>
                           <td>{{value.ExtQty}}</td>
                           <td>{{value.Describe}}</td>
                              <td>{{if  value.IsDone=='True'}}
                                 完成
                               {{else}} 
                                <input type="hidden" id="hidExtCheckNo" value="{{value.CheckNo}}" />
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

    <div class="weui-gallery" id="gallery" style="display: none">
        <span class="weui-gallery__img" id="galleryImg" style="background-image: url(images/pic_article.png);"></span>
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

                <tr>

                    <td>累计抽取数</td>
                    <td colspan="5">
                        <label id="lb_CQty"></label>
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
                <h1>检验结果↓↓ <a  href="javascript:" onclick="openCheckStd()" style="font-size:small" >查看检验标准</a></h1>
            </div>
            <div class="weui-panel__bd">
                <div class="weui-cells__tips tltles">加抽列表</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div id="showTable" style="width: 100%">
                        </div>
                    </div>

                </div>

                <div class="weui-cells__tips tltles">透光率</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">UV</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_UV"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片  &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_UV">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_UV" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd   ">
                            <label class="weui-label">VL</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_VL"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_VL">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_VL" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">IR</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_IR"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_IR">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_IR" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="weui-cells__tips tltles">厚度</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">总厚度</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_HD_ZH"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_ZH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_ZH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">玻璃厚</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_HD_BLH"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_BLH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_BLH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">AB胶厚</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_HD_ABJH"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_ABJH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_ABJH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
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
                        <div class="myOwn">
                            <label id="lb_YD_YD"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_YD">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_YD" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">水滴角</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">初始</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_SDJ_CS"></label>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CS">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_CS" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">耐磨</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_SDJ_NM"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_NM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_NM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">磨擦后</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_SDJ_MCH"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_MCH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_MCH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>

                <div class="weui-cells__tips tltles">指纹油</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">


                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">正面</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_ZWY_ZM"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_ZM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_ZM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- <div class="weui-uploader__input-box">
                            <input id="img_ZM" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                        </div>--%>
                    </div>

                    <div class="weui-cell">

                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">背面</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_ZWY_BM"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_BM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_BM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">钢化效果</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">

                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">钢球落下</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_GHXG_GQLX"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_GQLX">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_GQLX" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">弯爆</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_GHXG_WB"></label>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_WB">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_WB" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">试贴</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">

                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">试贴</label>
                        </div>
                        <div class="myOwn">
                            <label id="lb_ST_ST"></label>

                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_ST">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_ST" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>

                <div class="weui-cells__tips">尺寸</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">长</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_Size_Long"></label>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">宽</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_Size_Width"></label>
                        </div>

                    </div>

                    <div class="weui-cell" style="display: none">
                        <div class="weui-cell__hd">
                            <label class="weui-label">高</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_Size_Height"></label>
                        </div>
                    </div>
                </div>
                <div class="weui-cells__tips">平整度</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">左</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_P_Left"></label>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">右</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_P_Right"></label>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">上</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_P_UP"></label>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">下</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_P_Down"></label>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__title">品质检验结果</div>
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">检验结果</label>
                    </div>
                    <div class="weui-cell__bd">
                        <label id="lb_CheckResult" style="color: blue"></label>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">接收数量</label>
                    </div>
                    <div class="weui-cell__bd">
                        <label id="lb_AcceptQty"></label>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">不良数量</label>
                    </div>

                    <div class="weui-cell__bd">
                        <label id="lb_NGQty" style="color: red"></label>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">描述:</label>
                    </div>
                    <div class="weui-cell__bd">
                        <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe" readonly="readonly"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="weui-btn-area" id="submit">
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
