<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RawMaterialIQC_Check_Edit.aspx.cs" Inherits="QMS_WebSite.IQC.add.RawMaterialIQC_Check_Edit" %>


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

            onDeviceReady();

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
            
            $("input[type='number']").on("keyup", function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ''))

            }).bind("paste", function () {  //CTR+V事件处理    
                $(this).val($(this).val().replace(/[^0-9]/g, ''))
            }); 
        });

        //图片组件初始化
        function ImgControllerinit() {

            uploadImgInit("uploaderInputimg_UV", "uploaderFilesimg_UV");
            // uploadImgInit("uploaderInputimg_ZM", "uploaderFilesimg_ZM");
            uploadImgInit("uploaderInputimg_VL", "uploaderFilesimg_VL");
            uploadImgInit("uploaderInputimg_IR", "uploaderFilesimg_IR");
            uploadImgInit("uploaderInputimg_ZH", "uploaderFilesimg_ZH");
            uploadImgInit("uploaderInputimg_BHC", "uploaderFilesimg_BHC");
            uploadImgInit("uploaderInputimg_SYC", "uploaderFilesimg_SYC");
            uploadImgInit("uploaderInputimg_LCM", "uploaderFilesimg_LCM");
            uploadImgInit("uploaderInputimg_YD", "uploaderFilesimg_YD");
            uploadImgInit("uploaderInputimg_NM", "uploaderFilesimg_NM");

            uploadImgInit("uploaderInputimg_CB", "uploaderFilesimg_CB");
            uploadImgInit("uploaderInputimg_CNL", "uploaderFilesimg_CNL");
            uploadImgInit("uploaderInputimg_BGCS", "uploaderFilesimg_BGCS");
            uploadImgInit("uploaderInputimg_SKBH", "uploaderFilesimg_SKBH");
            uploadImgInit("uploaderInputimg_SKLX", "uploaderFilesimg_SKLX");
            uploadImgInit("uploaderInputimg_SKSY", "uploaderFilesimg_SKSY");

            uploadImgInit("uploaderInputimg_D65CH", "uploaderFilesimg_D65CH");
            uploadImgInit("uploaderInputimg_TL84CH", "uploaderFilesimg_TL84CH");
            uploadImgInit("uploaderInputimg_CWFCH", "uploaderFilesimg_CWFCH");
            uploadImgInit("uploaderInputimg_FACH", "uploaderFilesimg_FACH");
            uploadImgInit("uploaderInputimg_QB", "uploaderFilesimg_QB");
            uploadImgInit("uploaderInputimg_PQSJ", "uploaderFilesimg_PQSJ");

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
            //删除图片  
            $(".weui-gallery__del").click(function () {
                var hidgalley = $("#hidgalley").val();
                switch (hidgalley) {
                    case "UV":
                        $uploaderFiles.find("li").eq(index).remove();
                        img_UVarr.splice(index, 1);
                        break;
                        //case "ZW":
                        //    $uploaderFiles_ZM.find("li").eq(indexzm).remove();
                        //    img_ZMarr.splice(indexzm, 1);
                        //    break;
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
                    case "BHC":
                        $uploaderFiles_BHC.find("li").eq(indexbhc).remove();
                        img_BHCarr.splice(indexbhc, 1);
                        break;
                    case "SYC":
                        $uploaderFiles_SYC.find("li").eq(indexsyc).remove();
                        img_SYCarr.splice(indexsyc, 1);
                        break;
                    case "LCM":
                        $uploaderFiles_LCM.find("li").eq(indexlcm).remove();
                        img_LCMarr.splice(indelcm, 1);
                        break;
                    case "YD":
                        $uploaderFiles_YD.find("li").eq(indexyd).remove();
                        img_YDarr.splice(indelyd, 1);
                        break;
                    case "NM":
                        $uploaderFiles_NM.find("li").eq(indexnm).remove();
                        img_NMarr.splice(indexnm, 1);
                        break;
                    case "CB":
                        $uploaderFiles_CB.find("li").eq(indexcb).remove();
                        img_CBarr.splice(indexcb, 1);
                        break;
                    case "CNL":
                        $uploaderFiles_CNL.find("li").eq(indexcnl).remove();
                        img_CNLarr.splice(indexcnl, 1);
                        break;
                    case "BGCS":
                        $uploaderFiles_BGCS.find("li").eq(indexbgcs).remove();
                        img_BGCSarr.splice(indexbgcs, 1);
                        break;
                    case "SKBH":
                        $uploaderFiles_SKBH.find("li").eq(indexskbh).remove();
                        img_SKBHarr.splice(indexskbh, 1);
                        break;
                    case "SKLX":
                        $uploaderFiles_SKLX.find("li").eq(indexsklx).remove();
                        img_SKLXarr.splice(indexsklx, 1);
                        break;
                    case "SKSY":
                        $uploaderFiles_SKSY.find("li").eq(indexsksy).remove();
                        img_SKSYarr.splice(indexsksy, 1);
                        break;
                    case "D65CH":
                        $uploaderFiles_D65CH.find("li").eq(indexd65ch).remove();
                        img_D65CHarr.splice(indexd65ch, 1);
                        break;
                    case "TL84CH":
                        $uploaderFiles_TL84CH.find("li").eq(indextl84ch).remove();
                        img_TL84CHarr.splice(indextl84ch, 1);
                        break;
                    case "FACH":
                        $uploaderFiles_FACH.find("li").eq(indexfach).remove();
                        img_FACHarr.splice(indexfach, 1);
                        break;
                    case "CWFCH":
                        $uploaderFiles_CWFCH.find("li").eq(indexcwfch).remove();
                        img_CWFCHarr.splice(indexcwfch, 1);
                        break;
                    case "QB":
                        $uploaderFiles_QB.find("li").eq(indexqb).remove();
                        img_QBarr.splice(indexqb, 1);
                        break;
                    case "PQSJ":
                        $uploaderFiles_PQSJ.find("li").eq(indexpqsj).remove();
                        img_PQSJarr.splice(indexpqsj, 1);
                        break;
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
                                        $.toast(jsonData.msg, "forbidden");
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
                case "BHC":
                    img_BHCarr.push(msg);
                    break;
                case "SYC":
                    img_SYCarr.push(msg);
                    break;
                case "LCM":
                    img_LCMarr.push(msg);
                    break;
                case "YD":
                    img_YDarr.push(msg);
                    break;
                case "NM":
                    img_NMarr.push(msg);
                    break;
                case "CB":
                    img_CBarr.push(msg);
                    break;
                case "CNL":
                    img_CNLarr.push(msg);
                    break;
                case "BGCS":
                    img_BGCSarr.push(msg);
                    break;
                case "SKBH":
                    img_SKBHarr.push(msg);
                    break;
                case "SKLX":
                    img_SKLXarr.push(msg);
                    break;
                case "SKSY":
                    img_SKSYarr.push(msg);
                    break;
                case "D65CH":
                    img_D65CHarr.push(msg);
                    break;
                case "TL84CH":
                    img_TL84CHarr.push(msg);
                    break;
                case "FACH":
                    img_FACHarr.push(msg);
                    break;
                case "CWFCH":
                    img_CWFCHarr.push(msg);
                    break;
                case "QB":
                    img_QBarr.push(msg);
                    break;
                case "PQSJ":
                    img_PQSJarr.push(msg);
                    break;

            }
        }
        //添加图片名称到数组
        function addImgArr2(cor, msg) {

            switch (cor) {
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
                case "BHC":
                    img_BHCarr.push(msg);
                    break;
                case "SYC":
                    img_SYCarr.push(msg);
                    break;
                case "LCM":
                    img_LCMarr.push(msg);
                    break;
                case "YD":
                    img_YDarr.push(msg);
                    break;
                case "NM":
                    img_NMarr.push(msg);
                    break;
                case "CB":
                    img_CBarr.push(msg);
                    break;
                case "CNL":
                    img_CNLarr.push(msg);
                    break;
                case "BGCS":
                    img_BGCSarr.push(msg);
                    break;
                case "SKBH":
                    img_SKBHarr.push(msg);
                    break;
                case "SKLX":
                    img_SKLXarr.push(msg);
                    break;
                case "SKSY":
                    img_SKSYarr.push(msg);
                    break;
                case "D65CH":
                    img_D65CHarr.push(msg);
                    break;
                case "TL84CH":
                    img_TL84CHarr.push(msg);
                    break;
                case "FACH":
                    img_FACHarr.push(msg);
                    break;
                case "CWFCH":
                    img_CWFCHarr.push(msg);
                    break;
                case "QB":
                    img_QBarr.push(msg);
                    break;
                case "PQSJ":
                    img_PQSJarr.push(msg);
                    break;

            }
        }
        //添加图片名称到li
        function addImgli(control, msg) {
            if (msg == "") {
                return;
            } 
            var arr = msg.split(';');
            var str = "";
            for (var i = 0; i < arr.length; i++) {
                addImgArr2(control, arr[i]);
                str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"></li>";
            }

            $("#uploaderFilesimg_" + control).append(str);
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

        function onselected() {
            var result = 1;
            document.getElementsByName()
        };

        window.onbeforeunload = function () {
            if (!confirm("是否退出???")) {
                return false;
            }
        };

        function saveTempData() {
            if (!confirm("该操作只是保存编剧数据，并不会提交检验结果，确认保存吗？")) {
                return false;
            }
            $.showLoading();
            var SQCId = $("#SQCID").val();
            if (SQCId == "") {
                $M.alert("数据异常");
            }
            var RMIID = $("#RMIID").val();
            if (RMIID == "") {
                $M.alert("数据异常");
            }
 
            var $form = $("#form1").formSerialize();

            $form["UV_Images"] = img_UVarr.join(";");
            $form["VL_Images"] = img_VLarr.join(";");
            $form["IR_Images"] = img_IRarr.join(";");
            $form["HD_ZH_Images"] = img_ZHarr.join(";");

            $form["HD_BHC_Images"] = img_BHCarr.join(";");
            $form["HD_SYC_Images"] = img_SYCHarr.join(";");
            $form["HD_LCM_Images"] = img_LCMarr.join(";");

            $form["YD_YD_Images"] = img_YDarr.join(";");
            $form["NM_NM_Images"] = img_NMarr.join(";");
            $form["CB_CB_Images"] = img_CBarr.join(";");
            $form["CNL_CNL_Images"] = img_CNLarr.join(";");
            $form["BGCS_BGCS_Images"] = img_BGCSarr.join(";");
            $form["GDWBC_SKBH_Images"] = img_SKBHarr.join(";");
            $form["GDWBC_SKLX_Images"] = img_SKLXarr.join(";");
            $form["GDWBC_SKSY_Images"] = img_SKSYarr.join(";");

            $form["ST_D65CH_Images"] = img_D65CHarr.join(";");
            $form["ST_TL84CH_Images"] = img_TL84CHarr.join(";");

            $form["ST_FACH_Images"] = img_FACHarr.join(";");
            $form["ST_CWFCH_Images"] = img_CWFCHarr.join(";");
            $form["ST_QB_Images"] = img_QBarr.join(";");
            $form["ST_PQSJ_Images"] = img_PQSJarr.join(";");

            //var CheckResult = $form["CheckResult"];
            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                CheckResult: $form["CheckResult"],
                CheckType: 2,
                RawMaterialIQCCheckId: RMIID
            };


            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=SaveIQCRMCheckResultTempXmlData&SendQCReportId=" + SQCId + "&RawMaterialIQCCheckId=" + RMIID,
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
                $M.alert("数据异常");
            }
            var RMIID = $("#RMIID").val();
            if (RMIID == "") {
                $M.alert("数据异常");
            }

            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = $("#form1").formSerialize();

            $form["UV_Images"] = img_UVarr.join(";");
            $form["VL_Images"] = img_VLarr.join(";");
            $form["IR_Images"] = img_IRarr.join(";");
            $form["HD_ZH_Images"] = img_ZHarr.join(";");

            $form["HD_BHC_Images"] = img_BHCarr.join(";");
            $form["HD_SYC_Images"] = img_SYCHarr.join(";");
            $form["HD_LCM_Images"] = img_LCMarr.join(";");

            $form["YD_YD_Images"] = img_YDarr.join(";");
            $form["NM_NM_Images"] = img_NMarr.join(";");
            $form["CB_CB_Images"] = img_CBarr.join(";");
            $form["CNL_CNL_Images"] = img_CNLarr.join(";");
            $form["BGCS_BGCS_Images"] = img_BGCSarr.join(";");
            $form["GDWBC_SKBH_Images"] = img_SKBHarr.join(";");
            $form["GDWBC_SKLX_Images"] = img_SKLXarr.join(";");
            $form["GDWBC_SKSY_Images"] = img_SKSYarr.join(";");

            $form["ST_D65CH_Images"] = img_D65CHarr.join(";");
            $form["ST_TL84CH_Images"] = img_TL84CHarr.join(";");

            $form["ST_FACH_Images"] = img_FACHarr.join(";");
            $form["ST_CWFCH_Images"] = img_CWFCHarr.join(";");
            $form["ST_QB_Images"] = img_QBarr.join(";");
            $form["ST_PQSJ_Images"] = img_PQSJarr.join(";");

            //var CheckResult = $form["CheckResult"];
            var postData = {
                SendQCReportId: SQCId,
                IQCData: JSON.stringify($form),
                CheckResult: $form["CheckResult"],
                CheckType: 2,
                RawMaterialIQCCheckId: RMIID
            };


            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=RMIQCCheckSubmit&SendQCReportId=" + SQCId + "&RawMaterialIQCCheckId=" + RMIID,
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

            var VL = $form["VL"];
            if (VL == "") {
                $.toptip('VL不能为空', 'error');
                return false;
            }
            var IR = $form["IR"];
            if (IR == "") {
                $.toptip('IR不能为空', 'error');
                return false;
            }
            var HD_ZH = $form["HD_ZH"];
            if (HD_ZH == "") {
                $.toptip('总厚不能为空', 'error');
                return false;
            }
            var HD_BHC = $form["HD_BHC"];
            if (HD_BHC == "") {
                $.toptip('保护层厚不能为空', 'error');
                return false;
            }

            var HD_SYC = $form["HD_SYC"];
            if (HD_SYC == "") {
                $.toptip('使用层厚不能为空', 'error');
                return false;
            }

            var HD_LCM = $form["HD_LCM"];
            if (HD_LCM == "") {
                $.toptip('离膜层厚不能为空', 'error');
                return false;
            }

            var YD_YD = $form["YD_YD"];
            if (YD_YD == "") {
                $.toptip('硬度不能为空', 'error');
                return false;
            }
            var CNL_CNL = $form["CNL_CNL"];
            if (CNL_CNL == "") {
                $.toptip('请选择初粘力', 'error');
                return false;
            }
            var NM_NM = $form["NM_NM"];
            if ( img_NMarr.length <= 0) {
                $.toptip('耐磨需上传图片', 'error');
                return false;
            }
            var CB_CB = $form["CB_CB"];
            if ( img_CBarr.length <= 0) {
                $.toptip('擦边需上传图片', 'error');
                return false;
            }
            var CNL_CNL = $form["CNL_CNL"];
            if (CNL_CNL == "") {
                $.toptip('初粘力不能为空', 'error');
                return false;
            }
            var BGCS_BGCS = $form["BGCS_BGCS"];
            if (img_BGCSarr.length <= 0) {
                $.toptip('百格测试需上传图片', 'error');
                return false;
            }
            var GDWBC_SKBH = $form["GDWBC_SKBH"];
            if (img_SKBHarr.length <= 0) {
                $.toptip('撕开保护层需上传图片', 'error');
                return false;
            }

            var GDWBC_SKLX = $form["GDWBC_SKLX"];
            if (img_SKLXarr.length <= 0) {
                $.toptip('撕开离型层需上传图片', 'error');
                return false;
            }

            var GDWBC_SKSY = $form["GDWBC_SKSY"];
            if (img_SKSYarr.length <= 0) {
                $.toptip('撕开使用层需上传图片', 'error');
                return false;
            }
            var ST_D65CH = $form["ST_D65CH"];
            if (img_D65CHarr.length <= 0) {
                $.toptip('试贴D65彩虹纹需上传图片', 'error');
                return false;
            }

            var ST_TL84CH = $form["ST_TL84CH"];
            if (img_TL84CHarr.length <= 0) {
                $.toptip('试贴TL84彩虹纹需上传图片', 'error');
                return false;
            }

            var ST_FACH = $form["ST_FACH"];
            if (img_FACHarr.length <= 0) {
                $.toptip(' F / A彩虹纹需上传图片', 'error');
                return false;
            }

            var ST_CWFCH = $form["ST_CWFCH"];
            if (img_CWFCHarr.length <= 0) {
                $.toptip('CWF彩虹纹需上传图片', 'error');
                return false;
            }

            var ST_QB = $form["ST_QB"];
            if (img_QBarr.length <= 0) {
                $.toptip('气边需上传图片', 'error');
                return false;
            }

            var ST_PQSJ = $form["ST_PQSJ"];
            if (img_PQSJarr.lenght <= 0) {
                $.toptip('排气时间不能为空', 'error');
                return false;
            }
            
            if (img_SYCarr.lenght <= 0) {
                $.toptip('使用层厚度需上传图片', 'error');
                return false;
            }

            var ST_PQSJ = $form["ST_PQSJ"];
            if (ST_PQSJ == "") {
                $.toptip('排气时间不能为空', 'error');
                return false;
            }

            var CheckResult = $form["CheckResult"];
            if (CheckResult == "" || CheckResult == "0") {
                $.toptip('请选择检验结果', 'error');
                return false;
            }
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
                        var retdata = JSON.parse(JSON.stringify(objArray.data));
                        if (objArray.result == 0) {
                            for (var o in retdata) {
                                var setMsg = retdata[o];
                                if ($("#" + o).length > 0) { 
                                    if ($("#" + o).prop("tagName").toLowerCase() == "input") {
                                        //if ($("#" + o).attr("type") == "checkbox") {
                                        //    if (setMsg) {
                                        //        $("#" + o).attr("checked", "checked")
                                        //    } else {
                                        //        $("#" + o).removeAttr("checked")
                                        //    }
                                        //}
                                       $("#" + o).val(setMsg)
                                        //if (o == "CheckResult") { 
                                        //    $("#" + o + "Sel").val(retdata[o]);
                                        //    if (retdata[o] == "1") {
                                        //        $("#CheckResultSel").val("1.全部接受");
                                        //    }
                                        //    if (retdata[o] == "2") {
                                        //        $("#CheckResultSel").val("2.让步接受");
                                        //    }
                                        //    if (retdata[o] == "3") {
                                        //        $("#CheckResultSel").val("3.挑选接受");
                                        //    }
                                        //    if (retdata[o] == "4") {
                                        //        $("#CheckResultSel").val("4.免检");
                                        //    }
                                        //    if (retdata[o] == "5") {
                                        //        $("#CheckResultSel").val("5.全部拒绝");
                                        //    }
                                        //}
                                        if (o == "CNL_CNL") {

                                            if (retdata[o] == "1") {
                                                $("#CNL_CNLSel").val("1#球");
                                            }
                                            if (retdata[o] == "2") {
                                                $("#CNL_CNLSel").val("2#球");
                                            }
                                            if (retdata[o] == "3") {
                                                $("#CNL_CNLSel").val("3#球");
                                            }

                                        }
                                    } else if ($("#" + o).prop("tagName").toLowerCase() == "select") { 
                                        $("#" + o).val(setMsg)
                                    }
                                } else if ($("#lb_" + o).length > 0) {
                                    $("#lb_" + o).text(setMsg);
                                }
                            } 
                            GetAQLinfo($("#lb_CYFS").text(), $("#lb_CYSP").text(), $("#lb_CYBZ").text());
 
                            if (typeof(retdata.UV_Images)== "undefined")
                            { 
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
                            if (retdata.GDWBC_SKLX_Images != "") {
                                addImgli("SKLX", retdata.GDWBC_SKLX_Images);
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
            <h1>检验单↓↓</h1><a  href="javascript:" onclick="openCheckStd()" style="font-size:small" >查看检验标准</a>
        </div>
        <div class="weui-panel__bd">
            <table id="detailsTable">
                <tr style="display: none">
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
                <tr style="display: none">
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
                <h1>检验结果↓↓</h1>
            </div>
            <div class="weui-panel__bd">

                <div class="weui-cells__tips tltles">透光率</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">UV(%)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" placeholder="UV" name="UV" id="UV" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

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
                    <div class="weui-cell">
                        <div class="weui-cell__hd   ">
                            <label class="weui-label">VL(%)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" placeholder="VL" name="VL" id="VL" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <label class="weui-label">IR(%)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" placeholder="IR" name="IR" id="IR" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
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
                            <label class="weui-label">总厚度(mm)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" name="HD_ZH" placeholder="请输入总厚度" id="HD_ZH" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
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
                            <label class="weui-label">保护层厚</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" name="HD_BHC" placeholder="请输入保护层厚" id="HD_BHC" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_BHC">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_BHC" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">使用层厚度</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" name="HD_SYC" placeholder="请输入使用层厚度" id="HD_SYC" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SYC">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_SYC" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">离层膜厚度</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" name="HD_LCM" placeholder="请输入离层膜厚度" id="HD_LCM" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_LCM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_LCM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
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
                            <input class="weui-input" type="number" name="YD_YD" placeholder="请输入硬度" id="YD_YD" onkeyup="this.value = this.value.replace(/[^\d\.]/g,'')" onafterpaste="this.value = this.value.replace(/[^\d\.]/g, '')">
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

                <div class="weui-cells__tips tltles">耐磨</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">耐磨</label>
                        </div>
                        <div class="myOwn">
                            <%-- <label for="NM_NM" class="weui-switch-cp">
                                <input id="NM_NM" name="NM_NM" class="weui-switch-cp__input" type="checkbox">
                                <div class="weui-switch-cp__box"></div>
                            </label>--%>
                            <select id="NM_NM" class="weui-select" name="NM_NM">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_NM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_NM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
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
                        <div class="myOwn">
                            <select id="CB_CB" class="weui-select" name="CB_CB">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CB">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_CB" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
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
                        <div class="myOwn">
                            <select id="CNL_CNL" class="weui-select" name="CNL_CNL">
                                <option value="0">请选择</option>
                                <option value="1">1#球</option>
                                <option value="2">2#球</option>
                                <option value="3">3#球</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CNL">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_CNL" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
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
                        <div class="myOwn">
                            <select id="BGCS_BGCS" class="weui-select" name="BGCS_BGCS">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_BGCS">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_BGCS" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
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
                        <div class="myOwn">
                            <select id="GDWBC_SKBH" class="weui-select" name="GDWBC_SKBH">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SKBH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_SKBH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">撕开离型层</label>
                        </div>
                        <div class="myOwn">
                            <select id="GDWBC_SKLX" class="weui-select" name="GDWBC_SKLX">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SKLX">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_SKLX" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">撕开使用层</label>
                        </div>
                        <div class="myOwn">
                            <select id="GDWBC_SKSY" class="weui-select" name="GDWBC_SKSY">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>

                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_SKSY">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_SKSY" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
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
                            <label for="" class="weui-label">D65彩虹纹</label>
                        </div>
                        <div class="myOwn">
                            <select id="ST_D65CH" class="weui-select" name="ST_D65CH">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_D65CH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_D65CH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">TL84彩虹纹</label>
                        </div>
                        <div class="myOwn">
                            <select id="ST_TL84CH" class="weui-select" name="ST_TL84CH">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_TL84CH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_TL84CH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">F/A彩虹纹</label>
                        </div>
                        <div class="myOwn">
                             <select id="ST_FACH" class="weui-select" name="ST_FACH">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select> 
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_FACH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_FACH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">CWF彩虹纹</label>
                        </div>
                        <div class="myOwn">
                              <select id="ST_CWFCH" class="weui-select" name="ST_CWFCH">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select> 
                            
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_CWFCH">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_CWFCH" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">气边</label>
                        </div>
                        <div class="myOwn">
                             <select id="ST_QB" class="weui-select" name="ST_QB">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>  
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_QB">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_QB" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">排气时间(s)</label>
                        </div>
                        <div class="myOwn">
                            <input class="weui-input" type="number" id="ST_PQSJ" name="ST_PQSJ" placeholder="请输入排气时间">
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">

                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_PQSJ">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_PQSJ" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
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
                        <select id="CheckResult" class="weui-select" name="CheckResult">
                            <option value="0">请选择</option>
                            <option value="1">合格</option>
                            <option value="2">不合格</option>

                        </select>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <div class="weui-btn-area">
<%--        <a class="weui-btn weui-btn_primary" href="javascript:" id="SaveTemp">保存</a>--%>
        <a class="weui-btn weui-btn_primary" href="javascript:" id="Submit">提交</a>
    </div>
    <a href="javascript:;" id='show-loading' class="weui-btn weui-btn_primary" style="display: none">提交中</a>
    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SQCID" runat="server" />
        <asp:HiddenField ID="RMIID" runat="server" />
    </form>
</body>
</html>
