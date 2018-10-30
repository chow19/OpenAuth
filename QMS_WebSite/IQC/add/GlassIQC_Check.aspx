<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GlassIQC_Check.aspx.cs" Inherits="QMS_WebSite.IQC.add.GlassIQC_Check" %>


<!DOCTYPE html>
<html > 
<head>
    <title>玻璃检验</title>
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
        var img_XHTZarr = [];
        var img_UVarr = [];
        var img_ZHarr = [];
        var img_BLHarr = [];
        var img_ABJHarr = [];
        var img_YDarr = [];
        var img_CSarr = [];
        var img_MCHarr = [];
        var img_ZMarr = [];
        var img_BMarr = [];
        var img_GQLXarr = [];
        var img_WBarr = [];
        var img_STarr = [];
        var img_PCarr = [];

        $(function () {
             
            pageLoad();

            //图片组件初始化
            ImgControllerinit();
            //提交按钮  
            $("#Submit").click(function () { 
                dataSubmt();
              
            });

            $("#SaveTemp").click(function () {
                saveTempData();
            });

            $("#GHXG_GQLX_TJ").click(function () {
                var parma = {
                    'GD': '',
                    'QZ': '',
                    'ZJ': '',
                    'JCSL': '',
                    'TGSL': ''
                };
                addGQLXData(parma);
            });

            $("#AcceptQty").on("keyup", function () {
                var AcceptQty = $("#AcceptQty").val();
                var SendQty = $("#lb_SendQCQty").text();

                var NGQty = SendQty - AcceptQty;
                $("#NGQty").val(NGQty)
            });

          
        });

        //图片组件初始化
        function ImgControllerinit() {

            uploadImgInit("uploaderInputimg_XHTZ", "uploaderFilesimg_XHTZ");
            uploadImgInit("uploaderInputimg_UV", "uploaderFilesimg_UV");
            uploadImgInit("uploaderInputimg_ZH", "uploaderFilesimg_ZH");
            uploadImgInit("uploaderInputimg_BLH", "uploaderFilesimg_BLH");
            uploadImgInit("uploaderInputimg_ABJH", "uploaderFilesimg_ABJH");
            uploadImgInit("uploaderInputimg_YD", "uploaderFilesimg_YD");
            uploadImgInit("uploaderInputimg_CS", "uploaderFilesimg_CS");
            uploadImgInit("uploaderInputimg_MCH", "uploaderFilesimg_MCH");
            uploadImgInit("uploaderInputimg_ZM", "uploaderFilesimg_ZM");
            uploadImgInit("uploaderInputimg_BM", "uploaderFilesimg_BM");
            uploadImgInit("uploaderInputimg_GQLX", "uploaderFilesimg_GQLX");
            uploadImgInit("uploaderInputimg_WB", "uploaderFilesimg_WB");
            uploadImgInit("uploaderInputimg_ST", "uploaderFilesimg_ST");
            uploadImgInit("uploaderInputimg_PC", "uploaderFilesimg_PC");

            var $gallery = $("#gallery");
            var $galleryImg = $("#galleryImg");

            var $uploaderFiles = $("#uploaderFilesimg_UV");
            var $uploaderFiles_XHTZ = $("#uploaderFilesimg_XHTZ");
            var $uploaderFiles_ZH = $("#uploaderFilesimg_ZH");
            var $uploaderFiles_BLH = $("#uploaderFilesimg_BLH");
            var $uploaderFiles_ABJH = $("#uploaderFilesimg_ABJH");
            var $uploaderFiles_YD = $("#uploaderFilesimg_YD");
            var $uploaderFiles_CS = $("#uploaderFilesimg_CS");
            var $uploaderFiles_MCH = $("#uploaderFilesimg_MCH");
            var $uploaderFiles_ZM = $("#uploaderFilesimg_ZM");
            var $uploaderFiles_BM = $("#uploaderFilesimg_BM");

            var $uploaderFiles_GQLX = $("#uploaderFilesimg_GQLX");
            var $uploaderFiles_WB = $("#uploaderFilesimg_WB");
            var $uploaderFiles_ST = $("#uploaderFilesimg_ST");

            var $uploaderFiles_PC = $("uploaderFilesimg_PC");

            var index; //第几张图片  
            $uploaderFiles.on("click", "li", function () {
                index = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("UV");
            });
            var indexxhtz;
            $uploaderFiles_XHTZ.on("click", "li", function () {
                indexzh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("XHTZ");
            });
            var indexzh;
            $uploaderFiles_ZH.on("click", "li", function () {
                indexzh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ZH");
            });
            var indexblh;
            $uploaderFiles_BLH.on("click", "li", function () {
                indexblh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("BLH");
            });
            var indexabjh;
            $uploaderFiles_ABJH.on("click", "li", function () {
                indexabjh = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ABJH");
            });
            var indexyd;
            $uploaderFiles_YD.on("click", "li", function () {
                indexyd = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("YD");
            });
            var indexcs;
            $uploaderFiles_CS.on("click", "li", function () {
                indexcs = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("CS");
            });
            var indexmch;
            $uploaderFiles_MCH.on("click", "li", function () {
                indexmch = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("MCH");
            });
            var indexzm;
            $uploaderFiles_ZM.on("click", "li", function () {
                indexzm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ZM");
            });
            var indexbm;
            $uploaderFiles_BM.on("click", "li", function () {
                indexbm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("BM");
            });
            var indexgqlx;
            $uploaderFiles_GQLX.on("click", "li", function () {
                indexgqlx = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("GQLX");
            });
            var indexwb;
            $uploaderFiles_GQLX.on("click", "li", function () {
                indexwb = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("WB");
            });
            var indexst;
            $uploaderFiles_ST.on("click", "li", function () {
                indexst = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ST");
            });
            var indexpc;
            $uploaderFiles_PC.on("click", "li", function()  {
                indexpc = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("PC");
            });

            $gallery.on("click", function () {
                $gallery.fadeOut(100);
            });
            //删除图片  
            $(".weui-gallery__del").click(function () {
                var hidgalley = $("#hidgalley").val();
                switch (hidgalley) {
                    case "XHTZ":
                        $uploaderFiles.find("li").eq(index).remove();
                        img_XHTZarr.splice(index, 1);
                        break;
                    case "UV":
                        $uploaderFiles.find("li").eq(index).remove();
                        img_UVarr.splice(index, 1);
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
                    case "PC":
                        $uploaderFiles_PC.find("li").eq(indexst).remove();
                        img_PCarr.splice(indexst, 1);

                }
                //alert(img_UVarr.toString());
            });
        }
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
                            var $preview = $('<li class="weui-uploader__file weui-uploader__file_status" style="background-image:url(' + img.src + ')"><div class="weui-uploader__file-content">0%</div></li>');
                            $uploaderFiles.append($preview);
                            var num = $('.weui-uploader__file').length;
                            $('.weui-uploader__info').text(num + '/' + maxCount);

                            var formData = new FormData();

                            formData.append("images", base64);
                            formData.append("filetype", file.type);
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
                case "XHTZ":
                    img_XHTZarr.push(msg);
                    break;
                case "UV":
                    img_UVarr.push(msg);
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
                case "PC":
                    img_PCarr.push(msg);
                    break;
            }
        }

        //ios设备就绪的方法
        function onDeviceReady() {
            $M.setButton("[{\"function\":\"saveTempData\",\"title\":\"保存\"}]");
           // $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        };

        function save() {
            if (!confirm("确认提交？")) {
                return false;
            }
            dataSubmt();
            //$M.open("Upload_Pics.aspx", "送检单检验"); 
        };

        function saveTempData() {
            if (!confirm("该操作只是保存编剧数据，并不会提交检验结果，确认保存吗？")) {
                return false;
            }
            $.showLoading();
            var SQCId = $("#SQCID").val();
            if (SQCId == "") {
                $M.alert("saveTempData_SQCID数据异常");
            }
            
            var $form = $("#form1").formSerialize();
            console.log($form);
            $form["XHTZ_Images"] = img_XHTZarr.join(";");
            $form["UV_Images"] = img_UVarr.join(";");
            $form["HD_ZH_Images"] = img_ZHarr.join(";");
            $form["HD_BLH_Images"] = img_BLHarr.join(";");
            $form["HD_ABJH_Images"] = img_ABJHarr.join(";");
            $form["YD_YD_Images"] = img_YDarr.join(";");
            $form["SDJ_CS_Images"] = img_CSarr.join(";");
            $form["SDJ_MCH_Images"] = img_MCHarr.join(";");
            $form["ZWY_ZM_Images"] = img_ZMarr.join(";"); 
            $form["ZWY_BM_Images"] = img_BMarr.join(";");
            $form["GHXG_GQLX_Images"] = img_GQLXarr.join(";");
            $form["GHXG_WB_Images"] = img_WBarr.join(";");
            $form["ST_ST_Images"] = img_STarr.join(";");
            $form["PC_PC_Images"] = img_PCarr.join(";");
            var forea = [];
            $(".GQLXXXDIV").each(function () {
                var $uploaderFilesimg_GQLX = []
                $(this).find("li").each(function () {
                    $uploaderFilesimg_GQLX.push($(this).attr("id"));
                })
                var eac = {
                    'GD' : $(this).find(".GD").val(),
                    'QZ' : $(this).find(".QZ").val(),
                    'ZJ' : $(this).find(".ZJ").val(),
                    'JCSL' : $(this).find(".JCSL").val(),
                    'TGSL': $(this).find(".TGSL").val(),
                    'uploaderFilesimg_GQLX': $uploaderFilesimg_GQLX
                };
                if ($(this).find(".GD").val() != '' && $(this).find(".JCSL").val() != '') {
                    forea.push(eac);
                }
            })
            $form.GHXG_list = forea;


            var CheckResult = $form["CheckResult"];
            var AcceptQty = $("#AcceptQty").val();
            var NGQty = $("#NGQty").val();
            var Describe = $("#Describe").val();
            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                CheckResult: CheckResult,
                AcceptQty: AcceptQty,
                NGQty: NGQty,
                CheckType: 1,
                Describe: Describe
            };
            console.log("new");
            console.log($form);
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=SaveIQCCheckResultTempXmlData&SendQCReportId=" + SQCId,
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
        function dataSubmt() {
            $.showLoading();
            var SQCId = $("#SQCID").val();
            if (SQCId == "") {
                $M.alert("dataSubmt_SQCID数据异常");
            }
            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = $("#form1").formSerialize();

            $form["XHTZ_Images"] = img_XHTZarr.join(";");
            $form["UV_Images"] = img_UVarr.join(";");
            $form["HD_ZH_Images"] = img_ZHarr.join(";");
            $form["HD_BLH_Images"] = img_BLHarr.join(";");
            $form["HD_ABJH_Images"] = img_ABJHarr.join(";");
            $form["YD_YD_Images"] = img_YDarr.join(";");
            $form["SDJ_CS_Images"] = img_CSarr.join(";");
            $form["SDJ_MCH_Images"] = img_MCHarr.join(";");
            $form["ZWY_ZM_Images"] = img_ZMarr.join(";");

            $form["ZWY_BM_Images"] = img_BMarr.join(";");
            $form["GHXG_GQLX_Images"] = img_GQLXarr.join(";");
            $form["GHXG_WB_Images"] = img_WBarr.join(";");
            $form["ST_ST_Images"] = img_STarr.join(";");
            $form["PC_PC_Images"] = img_STarr.join(";");
            var forea = [];
            $(".GQLXXXDIV").each(function () {
                var $uploaderFilesimg_GQLX = []
                $(this).find("li").each(function () {
                    $uploaderFilesimg_GQLX.push($(this).attr("id"));
                })
                var eac = {
                    'GD': $(this).find(".GD").val(),
                    'QZ': $(this).find(".QZ").val(),
                    'ZJ': $(this).find(".ZJ").val(),
                    'JCSL': $(this).find(".JCSL").val(),
                    'TGSL': $(this).find(".TGSL").val(),
                    'uploaderFilesimg_GQLX': $uploaderFilesimg_GQLX
                };
                if ($(this).find(".GD").val() != '' && $(this).find(".JCSL").val() != '') {
                    forea.push(eac);
                }
            })
            $form.GHXG_list = forea;

            var CheckResult = $form["CheckResult"];
            var AcceptQty = $("#AcceptQty").val();
            var NGQty = $("#NGQty").val();
            var Describe = $("#Describe").val();
            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                CheckResult: CheckResult,
                AcceptQty: AcceptQty,
                NGQty: NGQty,
                CheckType: 1,
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
            // alert(JSON.stringify( $form));
            var UV = $form["UV"];
            if (UV == "") {
                $.toptip('UV不能为空', 'error');
                return false;
            }
            //var HD_ZH = $form["HD_ZH"];
            //if (HD_ZH == "") {
            //    $.toptip('总厚不能为空', 'error');
            //    return false;
            //}
            //var HD_BLH = $form["HD_BLH"];
            //if (HD_BLH == "") {
            //    $.toptip('玻璃厚不能为空', 'error');
            //    return false;
            //}

            //var HD_ABJH = $form["HD_ABJH"];
            //if (HD_ABJH == "") {
            //    $.toptip('AB胶厚不能为空', 'error');
            //    return false;
            //}

            //var YD_YD = $form["YD_YD"];
            //if (YD_YD == "") {
            //    $.toptip('硬度不能为空', 'error');
            //    return false;
            //}
            var SDJ_CS = $form["SDJ_CS"];
            if (SDJ_CS == "") {
                $.toptip('水滴角初始不能为空', 'error');
                return false;
            }
            //var SDJ_NM = $form["SDJ_NM"];
            //if (SDJ_NM == "") {
            //    $.toptip('水滴角耐磨不能为空', 'error');
            //    return false;
            //}
            //var SDJ_MCH = $form["SDJ_MCH"];
            //if (SDJ_NM == "") {
            //    $.toptip('水滴角摩擦后不能为空', 'error');
            //    return false;
            //}

            // var img_ZMarr = [];
            if (img_XHTZarr.length <= 0) {
                $.toptip('型号图纸需上传图片', 'error');
                return false;
            };
            if (img_UVarr.length <= 0) {
                $.toptip('UV需上传图片', 'error');
                return false;
            };
            //if (img_ZHarr.length <= 0) {
            //    $.toptip('总厚需上传图片', 'error');
            //    return false;
            //};
            //if (img_BLHarr.length <= 0) {
            //    $.toptip('玻璃厚需上传图片', 'error');
            //    return false;
            //};
            //if (img_ABJHarr.length <= 0) {
            //    $.toptip('AB胶需上传图片', 'error');
            //    return false;
            //};
            //if (img_YDarr.length <= 0) {
            //    $.toptip('硬度需上传图片', 'error');
            //    return false;
            //};
            if (img_CSarr.length <= 0) {
                $.toptip('初始需上传图片', 'error');
                return false;
            }
            //if (img_MCHarr.length <= 0) {
            //    $.toptip('摩擦后需上传图片', 'error');
            //    return false;
            //}

            //if (img_ZMarr.length <= 0) {
            //    $.toptip('正面-质检需上传图片', 'error');
            //    return false;
            //}

            //if (img_BMarr.length <= 0) {
            //    $.toptip('背面-质检需上传图片', 'error');
            //    return false;
            //}

            //if (img_GQLXarr.length <= 0) {
            //    $.toptip('钢球落下需上传图片', 'error');
            //    return false;
            //}

            //if (img_WBarr.length <= 0) {
            //    $.toptip('弯爆需上传图片', 'error');
            //    return false;
            //}

            //if (img_STarr.length <= 0) {
            //    $.toptip('试贴需上传图片', 'error');
            //    return false;
            //}
            var Size_Long = $form["Size_Long"];
            if (Size_Long == "") {
                $.toptip('长不能为空', 'error');
                return false;
            }
            var Size_Width = $form["Size_Width"];
            if (Size_Width == "") {
                $.toptip('宽不能为空', 'error');
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
            if (parseFloat(SendQty) != parseFloat(AcceptQty) + parseFloat(NGQty)) {
                $.toptip('接收数量与不良数量之和应与送货数量一致', 'error');
                return false;
            }

            if (CheckResult == "1" && NGQty != 0) {
                $.toptip('全部接受时不良数量应该为0', 'error');
                return false;
            }
            if (CheckResult == "5" && AcceptQty != 0) {
                $.toptip('全部拒绝时接收数量应该为0', 'error');
                return false;
            }
            return true;
        }

        function onselected() {
            var result = 1;
            document.getElementsByName()
        };

        window.onbeforeunload = function () {
            if (!confirm("是否退出???")) {
                return false;
            }
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
                $M.alert("SQCID数据异常");
            }
            //$.ajax({
            //    url: "../../../../Handler/IQC.ashx?FunType=PageLoad&SendQCReportId=" + SQCId,
            //    type: "Get",
            //    cache: false,
            //    error: function (XMLHttpRequest, textStatus, e) {
            //        alert(XMLHttpRequest.responseText);
            //        alert("Errors");
            //    },
            //    success: function (data) {
            //        try { 
            //            var jsonData = eval("(" + data + ")"); 
            //            if (jsonData.result == 0) {
            //                $("#lb_POName").text(jsonData.data[0].POName);
            //                $("#lb_Vendor").text(jsonData.data[0].VendorName);
            //                $("#lb_ProductShortName").text(jsonData.data[0].ProductShortName);
            //                $("#lb_SendQCQty").text(jsonData.data[0].SendQCQty);
            //                $("#lb_Product").text(jsonData.data[0].ProductDescription);
            //                $("#lb_TCQ_Qty").text(jsonData.data[0].TCQ_Qty);
            //                $("#lb_ProductId").text(jsonData.data[0].ProductId);
                            
            //                $("#lb_JCSP").text(jsonData.data[0].JYSP);
            //                $("#lb_JYBZ").text(jsonData.data[0].JYBZ);
            //                $("#lb_CYFS").text(jsonData.data[0].CYFS);

            //                $("#AcceptQty").val(jsonData.data[0].SendQCQty);
            //                $("#NGQty").val("0");
            //                //setAQLParam(jsonData.data[0].CYFS);
            //                GetAQLinfo(jsonData.data[0].CYF, jsonData.data[0].JYSP, jsonData.data[0].JYBZ);
                           
            //                if (jsonData.data[0].TCQ_Qty == "") { 
            //                    $M.alert("请先抽样");
            //                    //$M.loadUrl("../../Default.aspx");
            //                    $M.closeAndReload();
            //                }
            //            }
            //            else {
            //                $("#lb_ProductId").text("");
            //                $("#lb_POName").text("");
            //                $("#lb_Vendor").text("");
            //                $("#lb_ProductShortName").text("");
            //                $("#lb_SendQCQty").text("");
            //                $("#lb_Product").text("");//lb_Product
            //                $("#lb_TCQ_Qty").text("");

            //                $("#lb_CYFS").text("");
            //                $("#lb_JCSP").text("");
            //                $("#lb_JYBZ").text("");
            //            }
            //        } catch (e) {
            //            alert(e.message);
            //        }
            //    }
            //}); 

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
                                //if ($("#lb_" + o).length > 0) {
                                //    var setMsg = retdata[o];
                                //    if (setMsg == "True") {
                                //        setMsg = "合格"
                                //    } else if (setMsg == "False") {
                                //        setMsg = "不合格"
                                //    } 
                                //    $("#lb_" + o).text(setMsg)
                                    
                                //}
                                var setMsg = retdata[o];
                                if (o == "GHXG_list") {
                                    $.each(setMsg, function (objkey, objvalue) {
                                        addGQLXData(objvalue);
                                        //$.each(objvalue, function (key, value) {
                                        //    alert(value.GD);
                                        //    addGQLXData(value);
                                        //})
                                    })
                                } else if ($("#" + o).length > 0) {
                                    if ($("#" + o).prop("tagName").toLowerCase() == "input") {
                                        $("#" + o).val(setMsg)
                                    } else if ($("#" + o).prop("tagName").toLowerCase() == "select") {
                                        $("#" + o).val(setMsg)
                                    }
                                } else if ($("#lb_" + o).length > 0) {
                                    $("#lb_" + o).text(setMsg);
                                }
                            }
                            GetAQLinfo($("#lb_CYFS").text(), $("#lb_CYSP").text(), $("#lb_CYBZ").text());
                            if ($("#lb_CQty").text() == "") {
                                $M.alert("lb_CQty数据异常");
                            }
                            if (typeof (retdata.UV_Images) == "undefined") {
                                return;
                            }
                                if (retdata.UV_Images != "") {
                                    addImgli("UV", retdata.UV_Images);
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
                                if (retdata.PC_PC_Images != "") {
                                    addImgli("PC", retdata.PC_PC_Images);
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

        //添加钢球落下数据
        function addGQLXData(parma) {
            var li =" ";
            if (parma.uploaderFilesimg_GQLX != null) {
                $.each(parma.uploaderFilesimg_GQLX, function (key, value) {
                    li=li+('<li id="' + value + '" class="weui-uploader__file" style="background-image:url(../../upload/' + value + ')"></li>');
                })
            }
            var html = '\
                <div class="weui-cell GQLXXXDIV">\
                <div class="weui-cell_hd">\
                    <label for="" class="weui-label">钢球落下详细</label>\
                </div>\
                <div class="weui-cell_bd">\
                <div class="weui-cell">\
                <label for="" class="weui-label">高度</label>\
                <input class="weui-input GD" type="text" value="' + parma.GD + '" list="high">\
                <select id="" class="weui-select input_select">\
                <option value=">">></option>\
                <option value="120">120</option>\
                <option value="90">90</option>\
                <option value="60"> 60</option>\
                <option value="50"> 50</option>\
                </select>\
                </div>\
                <div class="weui-cell">\
                <label for="" class="weui-label">球重</label>\
                <input class="weui-input QZ" type="text" value="' + parma.QZ + '" list="height">\
                <select id="" class="weui-select input_select">\
                <option value=">">></option>\
                <option value="64">64</option>\
                <option value="100">100</option>\
                </select>\
                </div>\
                <div class="weui-cell">\
                <label for="" class="weui-label">治具</label>\
                <input class="weui-input ZJ" type="text" value="' + parma.ZJ + '" list="matrie">\
                <select id="" class="weui-select input_select">\
                <option value=">">></option>\
                <option value="实心">实心</option>\
                <option value="空心">空心</option>\
                </select>\
                </div>\
                <div class="weui-cell">\
                <label for="" class="weui-label weui-cell__hd">检测数量</label>\
                <input class="weui-input weui-cell__bd JCSL" type="number" pattern="[0-9]*" value="' + parma.JCSL + '" placeholder="">\
                </div>\
                <div class="weui-cell">\
                <label for="" class="weui-label weui-cell__hd ">通过数量</label>\
                <input class="weui-input weui-cell__bd TGSL" type="number" pattern="[0-9]*" value="' + parma.TGSL + '" placeholder="">\
                </div>\
                <div class="weui-cell_bd">\
                <div class="weui-uploader imgspace">\
                <div class="weui-uploader__bd">                                    图片上传 &nbsp;                                    \
                <ul class="weui-uploader__files uploaderFilesimg_GQLX">' +li+ '</ul>\
                <div class="weui-uploader__input-box">\
                <input class="weui-uploader__input zjxfjs_file uploaderInputimg_GQLX" type="file" accept="image/*" multiple="">\
                </div>\
                </div>\
                </div>\
                </div>\
                </div>\
                </div>\
                '
            $("#GHXG_list").append(html);
            $(".GQLX_delete:last").click(function () {
                $(this).parent().parent().remove();
            });
            $(".GQLXXXDIV:last").each(function () {
                uploadGQLXImgInit($(this));
                $(this).find(".input_select").on("change", function () {
                    $(this).prev().val($(this).val());
                    $(this).children("option:first").attr("selected", "selected");
                })
            });
        };
         
        /***
            钢球落下详细上传图片初始化
            *** $obj 传入GQLXXX对象
            *** 
        ***/
        function uploadGQLXImgInit($obj) {

            //alert("uploadGQLXImgInit" + $obj);
            var $uploaderInput = $obj.find(".uploaderInputimg_GQLX");
            var $uploaderFiles = $obj.find(".uploaderFilesimg_GQLX");

            // 允许上传的图片类型  
            var allowTypes = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
            // 1024KB，也就是 1MB  
            var maxSize = 2048 * 2048;
            // 图片最大宽度  
            var maxWidth = 10000;
            // 最大上传图片数量  
            var maxCount = 6;

            $uploaderInput.on('change', function (event) {

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

                            var formData = new FormData();

                            formData.append("images", base64);
                            formData.append("filetype", file.type);
                            //console.log(img.src);<a href="../../UploadFile.aspx">../../UploadFile.aspx</a>
                            $.ajax({
                                url: "../../UploadFile.aspx",
                                type: 'POST',
                                data: formData,
                                contentType: false,
                                processData: false,
                                success: function (data) {
                                    var jsonData = eval("(" + data + ")");
                                    if (jsonData.result == 0) {
                                        // 插入到预览区  
                                        var $preview = $('<li id="' + jsonData.msg + '" class="weui-uploader__file" style="background-image:url(' + img.src + ')"><div class="weui-uploader__file-content">0%</div></li>');
                                        $uploaderFiles.append($preview);
                                        var num = $('.weui-uploader__file').length;
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
         
        function openCheckStd() {
            var psn = $("#lb_ProductShortName").text();
            var pid = $("#lb_ProductId").text();
            $M.open("../Show/ShowCheckItem.aspx?PID=" + pid, psn + "检验标准");
        }

        //添加图片名称到数组
        function addImgArr2(cor, msg) { 
        
            switch (cor) {
                case "UV":
                    img_UVarr.push(msg);
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
                case "PC":
                    img_PCarr.push(msg);
                    break;
            }
        }
        //添加图片名称到数组
        function addImgli(control, msg) { 
            var arr = msg.split(';');
             
            var str = "";
            for (var i = 0; i < arr.length; i++) {
                addImgArr2(control, arr[i]);
                var temp = arr[i].split('-'); 
                if (temp.length > 1) {
                    str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"><span style=\"color:red\">第" + temp[0] + "次加抽</span></li>";
                } else {
                    str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"></li>";
                }
            }
            $("#uploaderFilesimg_" + control).append(str);
        }

        /***
         ***添加GQLX图片名称到数组
         ***/
        function addGQLXImgli($obj, msg) {
            var arr = msg.split(';');

            var str = "";
            for (var i = 0; i < arr.length; i++) {
                var temp = arr[i].split('-');
                if (temp.length > 1) {
                    str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"><span style=\"color:red\">第" + temp[0] + "次加抽</span></li>";
                } else {
                    str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"></li>";
                }
            }
            $obj.find(".uploaderFilesimg_GQLX").append(str);
        }

    </script>

</head>
<body>

    <div class="weui-gallery" id="gallery" style="display: none">
        <button class="weui-icon-delete"
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
                <div class="weui-cells__tips tltles">型号图纸拍照</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_XHTZ">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_XHTZ" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">透光率(%)</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">UV(%)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="NUMBER" placeholder="UV" name="UV" id="UV" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                            
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd   ">
                            <label class="weui-label">VL(%)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="NUMBER" placeholder="VL" name="VL" id="VL" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">IR(%)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="NUMBER" placeholder="IR" name="IR" id="IR" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_UV">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_UV" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
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
                            <input class="weui-input" type="number" name="HD_ZH" id="HD_ZH" placeholder="请输入总厚度" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <input class="weui-input" type="number" id="HD_BLH" name="HD_BLH" placeholder="请输入玻璃厚" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <input class="weui-input" type="number" id="HD_ABJH" name="HD_ABJH" placeholder="请输入AB胶厚" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <input class="weui-input" type="number"  id="YD_YD" name="YD_YD" placeholder="请输入硬度" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <input class="weui-input" type="number"  id="SDJ_CS"  name="SDJ_CS" placeholder="初始" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <label class="weui-label">磨擦后</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" id="SDJ_MCH" name="SDJ_MCH" placeholder="磨擦后" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                              <select id="ZWY_ZM" class="weui-select" name="ZWY_ZM">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select> 
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <select id="ZWY_BM" class="weui-select" name="ZWY_BM">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                <div class="weui-cells weui-cells_form" >
                    <div id="GHXG_list">
                       
                    </div>
                    <div  class="weui-cell">
                        <a id="GHXG_GQLX_TJ" href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">添加</a>
                    </div>
                    <div class="weui-cell">
                         <div class="weui-cell__hd">
                                <label for="" class="weui-label">钢球落下检验结果</label>
                        </div>
                        <div class="myOwn">
                            <select id="GHXG_GQLX" class="weui-select" name="GHXG_GQLX">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                     </div>
                        <%--<div class="weui-cell__hd">
                            <label for="" class="weui-label">钢球落下</label>
                        </div>
                        <div class="myOwn">
                            <select id="GHXG_GQLX" class="weui-select" name="GHXG_GQLX">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>

                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_GQLX">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_GQLX" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">弯爆</label>
                        </div>
                        <div class="myOwn">
                            <select id="GHXG_WB" class="weui-select" name="GHXG_WB">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>

                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <select id="ST_ST" class="weui-select" name="ST_ST">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>

                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <input class="weui-input" type="number" id="Size_Long" name="Size_Long" placeholder="长" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">宽</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="Size_Width" id="Size_Width" placeholder="宽" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                    </div>

                    <div class="weui-cell" style="display: none">
                        <div class="weui-cell__hd">
                            <label class="weui-label">高</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="Size_Height" id="Size_Height" placeholder="高" value="0" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">平整度</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell_bd">
                        <div class="weui-cell">
                            <div class="weui-cell__hd">
                                    <label for="" class="weui-label">厚度</label>
                            </div>
                            <div class="myOwn">
                                <select id="PC_HD" class="weui-select" name="PC_HD">
                                    <option value="0">请选择</option>
                                    <option value="0.2">0.2</option>
                                    <option value="0.3">0.3</option>
                                    <option value="0.4">0.4</option>
                                </select>
                            </div>
                        </div>

                        <div class="weui-cell">
                            <div class="weui-cell__hd">
                                    <label for="" class="weui-label">检验结果</label>
                            </div>
                            <div class="myOwn">
                                <select id="PC_PC" class="weui-select" name="PC_PC">
                                    <option value="0">请选择</option>
                                    <option value="Ture">合格</option>
                                    <option value="False">不合格</option>
                                </select>
                            </div>
                            <div class="weui-cell__bd">
                                <div class="weui-uploader imgspace">

                                    <div class="weui-uploader__bd">
                                        图片上传 &nbsp;
                                        <ul class="weui-uploader__files" id="uploaderFilesimg_PC">
                                        </ul>
                                        <div class="weui-uploader__input-box">
                                            <input id="uploaderInputimg_PC" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%--<div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">左</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="P_Left" id="P_Left" placeholder="左" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">右</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="P_Right" id="P_Right" placeholder="右" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">上</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="P_UP" id="P_UP" placeholder="上" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">下</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="P_Down"  id="P_Down" placeholder="下" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>
                    </div>
                </div>--%>


                <div class="weui-cells__title">品质检验结果</div>
                <div class="weui-cells weui-cells_form">
                <div class="weui-cell">
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
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">接收数量</label>
                    </div>

                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number" id="AcceptQty" name="AcceptQty" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">不良数量</label>
                    </div>

                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number" id="NGQty" name="NGQty" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                    </div>
                </div>

                   <div class="weui-cell">
                    <div class="weui-cell__hd  ">
                        <label class="weui-label">描述:</label>
                    </div> 
                    <div class="weui-cell__bd">
                       <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe"></textarea>
                    </div>
                </div> 
                
        </div>
    </form>

    <div class="weui-btn-area" >
        <a class="weui-btn weui-btn_primary" href="javascript:" id="SaveTemp">保存</a>
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
