<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FQCSpecimentCheckAdd.aspx.cs" Inherits="QMS_WebSite.FQC.add.FQCSpecimentCheckAdd" %>

<!DOCTYPE html>
<html>
<head>
    <title>FQC抽检</title>
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
        var img_ZMarr = [];
        var img_CMarr = [];
        var img_KXarr = [];
        var img_NHBZarr = [];
        var img_KNHBZarr = [];
        var img_CPZBMarr = [];
        var img_BZQDarr = [];
        var img_TBarr = [];

        $(function () {
            pageLoad();
            //提交按钮  
            $("#Submit").click(function () {
                dataSubmt();
            });
            //图片组件初始化
            ImgControllerinit();

        });

        //图片组件初始化
        function ImgControllerinit() {

            uploadImgInit("uploaderInputimg_ZM", "uploaderFilesimg_ZM");
            // uploadImgInit("uploaderInputimg_ZM", "uploaderFilesimg_ZM");
            uploadImgInit("uploaderInputimg_CM", "uploaderFilesimg_CM");
            uploadImgInit("uploaderInputimg_KX", "uploaderFilesimg_KX");
            uploadImgInit("uploaderInputimg_NHBZ", "uploaderFilesimg_NHBZ");
            uploadImgInit("uploaderInputimg_KNHBZ", "uploaderFilesimg_KNHBZ");
            uploadImgInit("uploaderInputimg_CPZBM", "uploaderFilesimg_CPZBM");
            uploadImgInit("uploaderInputimg_BZQD", "uploaderFilesimg_BZQD");
            uploadImgInit("uploaderInputimg_TB", "uploaderFilesimg_TB");

            var $gallery = $("#gallery");
            var $galleryImg = $("#galleryImg");

            var $uploaderFiles_ZM = $("#uploaderFilesimg_ZM");
            var $uploaderFiles_CM = $("#uploaderFilesimg_CM");
            var $uploaderFiles_KX = $("#uploaderFilesimg_KX");
            var $uploaderFiles_NHBZ = $("#uploaderFilesimg_NHBZ");
            var $uploaderFiles_KNHBZ = $("#uploaderFilesimg_KNHBZ");
            var $uploaderFiles_CPZBM = $("#uploaderFilesimg_CPZBM");
            var $uploaderFiles_BZQD = $("#uploaderFilesimg_BZQD");
            var $uploaderFiles_TB = $("#uploaderFilesimg_TB");

            var indexZM;
            $uploaderFiles_ZM.on("click", "li", function () {
                indexZM = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ZM");
            });
            var indexCM;
            $uploaderFiles_CM.on("click", "li", function () {
                indexCM = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("CM");
            });
            var indexKX;
            $uploaderFiles_KX.on("click", "li", function () {
                indexKX = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("KX");
            });
            var indexNHBZ;
            $uploaderFiles_NHBZ.on("click", "li", function () {
                indexNHBZ = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("NHBZ");
            });
            var indexKNHBZ;
            $uploaderFiles_KNHBZ.on("click", "li", function () {
                indexKNHBZ = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("KNHBZ");
            });
            var indexCPZBM;
            $uploaderFiles_CPZBM.on("click", "li", function () {
                indexCPZBM = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("CPZBM");
            });
            var indexBZQD;
            $uploaderFiles_BZQD.on("click", "li", function () {
                indexBZQD = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("BZQD");
            });
            var indexTB;
            $uploaderFiles_TB.on("click", "li", function () {
                indexTB = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("TB");
            });

            $gallery.on("click", function () {
                $gallery.fadeOut(100);
            });
            //删除图片  
            $(".weui-gallery__del").click(function () {
                var hidgalley = $("#hidgalley").val();
                switch (hidgalley) {
                    case "ZM":
                        $uploaderFiles.find("li").eq(indexZM).remove();
                        img_ZMarr.splice(indexZM, 1);
                        break;
                    case "CM":
                        $uploaderFiles_CM.find("li").eq(indexCM).remove();
                        img_CMarr.splice(indexCM, 1);
                        break;
                    case "KX":
                        $uploaderFiles_KX.find("li").eq(indexKX).remove();
                        img_KXarr.splice(indexKX, 1);
                        break;
                    case "NHBZ":
                        $uploaderFiles_NHBZ.find("li").eq(indexNHBZ).remove();
                        img_NHBZarr.splice(indexNHBZ, 1);
                        break;
                    case "KNHBZ":
                        $uploaderFiles_KNHBZ.find("li").eq(indexKNHBZ).remove();
                        img_KNHBZarr.splice(indexKNHBZ, 1);
                        break;
                    case "CPZBM":
                        $uploaderFiles_CPZBM.find("li").eq(indexCPZBM).remove();
                        img_CPZBMarr.splice(indexCPZBM, 1);
                        break;
                    case "BZQD":
                        $uploaderFiles_BZQD.find("li").eq(indexBZQD).remove();
                        img_BZQDarr.splice(indexBZQD, 1);
                        break;
                    case "TB":
                        $uploaderFiles_TB.find("li").eq(indexTB).remove();
                        img_TBarr.splice(indexTB, 1);
                        break;
                }
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
                case "ZM":
                    img_ZMarr.push(msg);
                    break;
                case "CM":
                    img_CMarr.push(msg);
                    break;
                case "KX":
                    img_KXarr.push(msg);
                    break;
                case "NHBZ":
                    img_NHBZarr.push(msg);
                    break;
                case "KNHBZ":
                    img_KNHBZarr.push(msg);
                    break;
                case "CPZBM":
                    img_CPZBMarr.push(msg);
                    break;
                case "BZQD":
                    img_BZQDarr.push(msg);
                    break;
                case "TB":
                    img_TBarr.push(msg);
                    break;

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
            var FID = $("#FID").val();
            if (FID == "") {
                $M.alert("数据异常");
            }

            var $form = $("#form1").formSerialize();

            $form["ZM_Images"] = img_ZMarr.join(";");
            $form["CM_Images"] = img_CMarr.join(";");
            $form["KX_Images"] = img_KXarr.join(";");
            $form["NHBZ_Images"] = img_NHBZarr.join(";");
            $form["KNHBZ_Images"] = img_KNHBZarr.join(";");
            $form["BZQD_Images"] = img_BZQDarr.join(";");
            $form["CPZBM_Images"] = img_CPZBMarr.join(";");
            $form["TB_Images"] = img_TBarr.join(";");

            var postData = {
                FQCCheckId: FID,
                FQCData: JSON.stringify($form),
                Describe: $form["Describe"]
            };
            $.ajax({
                url: "../../Handler/FQC.ashx?FunType=checkResultTempSubmit&FQCCheckId=" + FID,
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
            var FID = $("#FID").val();
            if (FID == "") {
                $M.alert("数据异常");
            }
            if (!CheckSubmit()) {
                $.hideLoading();
                return;
            }
            var $form = $("#form1").formSerialize();
            var CheckResult = $form["CheckResult"];

            $form["ZM_Images"] = img_ZMarr.join(";");
            $form["CM_Images"] = img_CMarr.join(";");
            $form["KX_Images"] = img_KXarr.join(";");
            $form["NHBZ_Images"] = img_NHBZarr.join(";");
            $form["KNHBZ_Images"] = img_KNHBZarr.join(";");
            $form["BZQD_Images"] = img_BZQDarr.join(";");
            $form["CPZBM_Images"] = img_CPZBMarr.join(";");
            $form["TB_Images"] = img_TBarr.join(";");
            var AcceptQty = $("#AcceptQty").val();
            var NGQty = $("#NGQty").val(); 
            var postData = {
                AcceptQty: AcceptQty,
                NGQty: NGQty,
                FQCCheckId: FID,
                IPQCData: JSON.stringify($form),
                QCResult: CheckResult,
                Describe: $form["Describe"]
            };

            $.ajax({
                url: "../../Handler/FQC.ashx?FunType=checkResultSubmit&FQCCheckId=" + FID,
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

            var AcceptQty = $("#AcceptQty").val();
            var NGQty = $("#NGQty").val();
            var MOQtyRequired = $("#lb_MOQtyRequired").text();
            if (parseFloat(lb_MOQtyRequired) != parseFloat(AcceptQty) + parseFloat(NGQty)) {
                $.toptip('接收数量与不良数量之和应与工单数量一致', 'error');
                return false;
            }
 

            var ZM = $form["ZM"];
            if (ZM == "") {
                $.toptip('请选择正唛检验结果', 'error');
                return false;
            }
            var CM = $form["CM"];
            if (CM == "") {
                $.toptip('请选择侧唛检验结果', 'error');
                return false;
            }
            var KX = $form["KX"];
            if (KX == "") {
                $.toptip('请选择开箱检验结果', 'error');
                return false;
            }
            var NHBZ = $form["NHBZ"];
            if (NHBZ == "") {
                $.toptip('请选择内盒包装检验结果', 'error');
                return false;
            }
            var KNHBZ = $form["KNHBZ"];
            if (KNHBZ == "") {
                $.toptip('请选择开内盒包装检验结果', 'error');
                return false;
            }
            var CPZBM = $form["CPZBM"];
            if (CPZBM == "") {
                $.toptip('请选择产品正背面检验结果', 'error');
                return false;
            }
            var BZQD = $form["BZQD"];
            if (BZQD == "") {
                $.toptip('请选择包装清单检验结果', 'error');
                return false;
            }
            var TB = $form["TB"];
            if (TB == "") {
                $.toptip('请选择托板检验结果', 'error');
                return false;
            }


            if (img_ZMarr.length <= 0) {
                $.toptip('正唛需上传图片', 'error');
                return false;
            };
            if (img_CMarr.length <= 0) {
                $.toptip('侧唛需上传图片', 'error');
                return false;
            };
            if (img_KXarr.length <= 0) {
                $.toptip('开箱需上传图片', 'error');
                return false;
            };
            if (img_NHBZarr.length <= 0) {
                $.toptip('内盒包装需上传图片', 'error');
                return false;
            };
            if (img_KNHBZarr.length <= 0) {
                $.toptip('开内盒包装需上传图片', 'error');
                return false;
            };
            if (img_CPZBMarr.length <= 0) {
                $.toptip('产品正背面需上传图片', 'error');
                return false;
            };
            if (img_BZQDarr.length <= 0) {
                $.toptip('包装清单需上传图片', 'error');
                return false;
            };
            if (img_TBarr.length <= 0) {
                $.toptip('托板需上传图片', 'error');
                return false;
            };

            var CheckResult = $form["CheckResult"];
            if (CheckResult == "0") {
                $.toptip('请选择检验结果', 'error');
                return false;
            }

            return true;
        }

        //页面加载事件
        function pageLoad() {
            var FID = $("#FID").val();
            if (FID == "") {
                $M.alert("数据异常");
            }
            $.ajax({
                url: "../../Handler/IPQCFirstCheck.ashx?FunType=getStepInfo&FQCCheckId=" + FID,
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

        //扫描物料 
        function scanProduct() {
            //var qrcode = 'A.01.01.G3-IPHONE61GL';
            $M.scanQrcode(function (qrcode) {
                $.ajax({
                    url: "../../Handler/FQC.ashx?FunType=getProductDetail&ProductId=" + qrcode,
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
                                $("#lb_ScanProductDesc").text(jsonData.data.ProductDescription);
                                $("#ScanProductDesc").val(jsonData.data.ProductDescription);
                            }
                            else {
                                $("#lb_ScanProductDesc").text("");
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
                <tr>
                    <td>销售订单</td>

                    <td>
                        <label id="lb_BillNo"></label>
                    </td>
                    <td class="auto-style1">客户</td>
                    <td>
                        <label id="lb_CustomerName"></label>
                    </td>
                    <td>销售行号</td>
                    <td>
                        <label id="lb_SOEntry"></label>
                    </td>


                </tr>
                <tr>
                    <td>物料代码</td>
                    <td>
                        <label id="lb_ProductName"></label>
                        <label id="lb_ProductId" style="display: none"></label>
                    </td>
                    <td>物料描述</td>
                    <td colspan="3">
                        <label id="lb_ProductDescription"></label>
                    </td>

                </tr>
                <tr>
                    <td>工单</td>
                    <td>
                        <label id="lb_MOName"></label>
                    </td>
                    <td>工单数量</td>
                    <td>
                        <label id="lb_MOQtyRequired"></label>
                    </td>
                    <td>检验类型</td>
                    <td>
                        <label id="lb_CheckType"></label>
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

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">确认产品</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ScanProductDesc"></label>
                            <input type="hidden" id="ScanProductDesc" />
                            <a id="scanbtn" class="weui-btn_primary" onclick="scanProduct()">扫描</a>
                        </div>
                    </div>
                </div>


                <div class="weui-cells__tips tltles">外箱</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">正唛</label>
                        </div>
                        <div class="myOwn">
                            <select id="ZM" class="weui-select" name="ZM">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="ploaderFilesimg_ZM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_ZM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">侧唛</label>
                        </div>
                        <div class="myOwn">
                            <select id="CM" class="weui-select" name="CM">
                                <option value="0">请选择</option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="ploaderFilesimg_CM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_CM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">开箱</label>
                        </div>
                        <div class="myOwn">
                            <select id="KX" class="weui-select" name="KX">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="uploaderFilesimg_KX">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_KX" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">内盒包装</label>
                        </div>
                        <div class="myOwn">
                            <select id="NHBZ" class="weui-select" name="NHBZ">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader_files" id="uploaderFilesimg_NHBZ">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_NHBZ" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">开内盒包装</label>
                        </div>
                        <div class="myOwn">
                            <select id="KNHBZ" class="weui-select" name="KNHBZ">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader_files" id="uploaderFilesimg_KNHBZ">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_KNHBZ" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">产品正背面</label>
                        </div>
                        <div class="myOwn">
                            <select id="CPZBM" class="weui-select" name="CPZBM">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader_files" id="uploaderFilesimg_CPZBM">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_CPZBM" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">包装清单</label>
                        </div>
                        <div class="myOwn">
                            <select id="BZQD" class="weui-select" name="BZQD">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader_files" id="uploaderFilesimg_BZQD">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_BZQD" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">托板</label>
                        </div>
                        <div class="myOwn">
                            <select id="TB" class="weui-select" name="TB">
                                <option value="0">请选择</option>
                                <option value="Ture">合格</option>
                                <option value="False">不合格</option>
                            </select>
                        </div>
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader_files" id="uploaderFilesimg_TB">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_TB" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
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
                        <label class="weui-label">备注</label>
                    </div>
                    <div class="weui-cell__bd">
                        <textarea class="weui-textarea" placeholder="描述" rows="3" id="Describe" name="Describe"></textarea>
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
        <asp:HiddenField ID="FID" runat="server" />
    </form>
</body>
</html>

