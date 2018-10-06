<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetSQDetails.aspx.cs" Inherits="QMS_WebSite.GetSQDetails" %>

<!DOCTYPE html>
<html>
<head>
    <title>检验</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

    <link rel="stylesheet" href="css/page.css" />
    <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.min.css" />
    <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.css" />

    <style>
        #detailsTable {
            width: 100%;
            font-size: 20px;
            border-collapse: collapse;
        }

            #detailsTable td {
                width: 17%;
                height: 50px;
                padding: 5px;
                border: solid 1px #ccc;
            }

        .myOwn {
            width: 50%;
        }

        .imgspace {
            padding-left: 30px;
        }
    </style>
    <%--    <script src="scripts/jquery_1.6.3.js"></script>
    <script src="scripts/jquery.lazyload.min.js"></script>
    <script src="scripts/comm.js"></script>
    <script src="scripts/mobilebridge.js?1"></script>
    <script src="Scripts/jquery-weui.js"></script>
    <link href="Scripts/mui/mui.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-2.1.4.js"></script>--%>

    <link rel="stylesheet" href="css/page.css" />
    <script src="scripts/jquery_1.6.3.js"></script>
    <script src="scripts/jquery.lazyload.min.js"></script>
    <script src="scripts/comm.js"></script>
    <script src="scripts/mobilebridge.js?1"></script>
    <script src="scripts/template.js"></script>
    <script src="Scripts/jquery-2.1.4.js"></script>

    <link rel="stylesheet" href="Scripts/jquery-weui.css">
    <%--    <link href="Scripts/mui/mui.min.css" rel="stylesheet" />--%>
    <script src="Scripts/jquery-weui.js"></script>
    <%--    <script src="Scripts/mui/mui.min.js"></script>--%>
    <style>
        #detailsTable {
            width: 100%;
            font-size: 20px;
            border-collapse: collapse;
        }

            #detailsTable td {
                width: 17%;
                height: 50px;
                padding: 5px;
                border: solid 1px #ccc;
            }

        .auto-style1 {
            width: 19%;
        }

        .myOwn {
            width: 50%;
        }

        .weui-input {
            border: 1px solid rgba(0,0,0,.2);
        }
    </style>

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
            //  onDeviceReady();
            pageLoad();

            //图片组件初始化
            ImgControllerinit();
            //提交按钮  
            $("#Submit").click(function () {
                dataSubmt();
                //var tel = $('#tel').val();
                //var code = $('#code').val();
                //if(!tel || !/1[3|4|5|7|8]\d{9}/.test(tel)) $.toptip('请输入手机号');
                //else if(!code || !/\d{6}/.test(code)) $.toptip('请输入六位手机验证码');
                //else $.toptip('提交成功', 'success');
                $.toptip('提交测试', 'success');
            });
        });

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
            //var $uploaderFiles_ZM = $("#uploaderFilesimg_ZM");
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
                $("#hidgalley").val("UV");
            });
            //var indexzm;
            //$uploaderFiles_ZM.on("click", "li", function () {
            //    indexzm = $(this).index();
            //    $galleryImg.attr("style", this.getAttribute("style"));
            //    $gallery.fadeIn(100);
            //    $("#hidgalley").val("ZW");
            //});
            var indexvl;
            $uploaderFiles_ZM.on("click", "li", function () {
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
            var indexnm;
            $uploaderFiles_NM.on("click", "li", function () {
                indexnm = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("NM");
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
                    case "BLH":
                        $uploaderFiles_BLH.find("li").eq(indexblh).remove();
                        img_BLHarr.splice(indexzh, 1);
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

                    if ($('.weui-uploader__file').length >= maxCount) {
                        $.weui.alert({ text: '最多只能上传' + maxCount + '张图片' });
                        return;
                    }
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
                            //console.log(img.src);
                            $.ajax({
                                url: "UploadFile.aspx",
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

            }
        }

        //ios设备就绪的方法
        function onDeviceReady() {
            $M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
            $("img").lazyload({ effect: "fadeIn" });    //图片懒加载
        };

        function save() {
            if (!confirm("确认提交？")) {
                return false;
            }
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
            CheckSubmit();
        }
        function CheckSubmit() {
            var $form = $("#form1");
            alert($form.serialize());
            $form.form();

            $form.validate(function (error) {
                if (error) {
                    $.toast(error, "forbidden");
                } else {
                    $M.alert("提交测试");
                }
            });
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
            if (SQCId=="") { 
                $M.alert("数据异常");
            }
            $.ajax({
                url: "RM_IQC.aspx?FunType=PageLoad&SendQCReportId=" + SQCId,
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
                            $("#lb_POName").text(jsonData.data[0].POName);
                            $("#lb_Vendor").text(jsonData.data[0].VendorName);
                            $("#lb_PrdNo").text(jsonData.data[0].ProductShortName);
                            $("#lb_SendQty").text(jsonData.data[0].SendQCQty);
                            $("#lb_Product").text(jsonData.data[0].ProductDescription);
                            $("#lb_TCQ_Qty").text(jsonData.data[0].TCQ_Qty);
                            //$("#CYFS").text(jsonData.data[0].CYFS);
                            //$("#JCSP").text(jsonData.data[0].JYSP);
                            //$("#JYBZ").text(jsonData.data[0].JYBZ);
                            // CYFS JYSP JYBZ
                            //alert(JSON.stringify( jsonData.data[0]));
                            //alert(jsonData.data[0].JYSP);

                            $("#lb_JCSP").text(jsonData.data[0].JYSP);
                            $("#lb_JYBZ").text(jsonData.data[0].JYBZ);
                            setAQLParam(jsonData.data[0].CYFS);
                        }
                        else {
                            $("#lb_POName").text("");
                            $("#lb_Vendor").text("");
                            $("#lb_PrdNo").text("");
                            $("#lb_SendQty").text("");
                            $("#lb_Product").text("");//lb_Product
                            $("#lb_TCQ_Qty").text("");

                            $("#lb_CYFS").text("");
                            $("#lb_JCSP").text("");//lb_Product
                            $("#lb_JYBZ").text("");
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
                    <%--<td><asp:Label ID="lb_POName" runat="server" Text="PO123456"></asp:Label></td>--%>
                    <td>
                        <label id="lb_POName" runat="server" text=""></label>
                    </td>
                    <td class="auto-style1">供应商</td>
                    <td>
                        <label id="lb_Vendor" runat="server"></label>
                    </td>
                    <td>物料代码</td>
                    <td>
                        <label id="lb_PrdNo" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td>物料描述</td>
                    <td colspan="3">
                        <label id="lb_Product" runat="server"></label>
                    </td>
                    <td>送货数量</td>
                    <td>
                        <label id="lb_SendQty" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td style="color: blue">抽样方式</td>
                    <td>
                        <label id="lb_CYFS" runat="server"></label>
                    </td>
                    <td style="color: blue" class="auto-style1">检查水平</td>
                    <td>
                        <label id="lb_JCSP" runat="server"></label>
                    </td>

                    <td style="color: blueviolet">检验标准</td>

                    <td>
                        <label id="lb_JYBZ" runat="server"></label>
                    </td>

                </tr>
                <tr>
                    <td>样本量</td>
                    <%--<td><asp:Label ID="lb_RequireQty" runat="server" Text="200" ForeColor="#cc33ff"></asp:Label></td>--%>
                    <td>
                        <label id="lb_RequireQty" runat="server" style="color: blueviolet"></label>
                    </td>

                    <td class="auto-style1">允收(AC)</td>
                    <%--<td ><asp:Label ID="lb_IssueQty" runat="server" Text="200" ForeColor="blueviolet" ></asp:Label></td>--%>
                    <td>
                        <label id="lb_IssueQty" runat="server" style="color: blueviolet"></label>
                    </td>

                    <td class="auto-style1">拒收(RE)</td>
                    <%--<td ><asp:Label ID="lb_reject" runat="server" Text="200"  ForeColor="Red"></asp:Label></td>--%>
                    <td>
                        <label id="lb_reject" runat="server" style="color: red"></label>
                    </td>

                </tr>
                <tr>
                    <td>扫描详细</td>
                    <td colspan="5">
                        <label id="lb_ScanProductDesc" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td>数量</td>
                    <td>
                        <label id="lb_ScanQty" runat="server"></label>
                    </td>
                    <td>本次抽取数</td>
                    <td>
                        <label id="lb_gQty" runat="server"></label>
                    </td>
                    <td>累计抽取数</td>
                    <td>
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
                <h1>检验结果↓↓</h1>
            </div>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">UV</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" placeholder="UV">

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

                        <%-- <div class="weui-uploader__input-box">
                            <ul class="weui-uploader__files" id="uploaderFiles">  
                                  
                            </ul>  
                            <input id="uploaderInputimg_UV" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                          
                        </div>--%>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd   ">
                            <label class="weui-label">VL</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" placeholder="VL">
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
                            <label class="weui-label">IR</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" placeholder="IR">
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
                            <label class="weui-label">总厚</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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
                            <label class="weui-label">耐磨</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">磨擦后</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
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
                        <div class="weui-cell__bd">
                            <select class="weui-select" name="select2">
                                <option value="1">OK</option>
                                <option value="2">NG</option>
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
                        <div class="weui-cell__bd">
                            <select class="weui-select" name="select2" onselect="onselected">
                                <option value="1">OK</option>
                                <option value="2" class="NG_Select">NG</option>
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
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">

                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">钢球落下</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select class="weui-select" name="select2" onselect="onselected">
                                <option value="1">OK</option>
                                <option value="2" class="NG_Select">NG</option>
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
                        </div>

                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">弯爆</label>
                        </div>
                        <div class="weui-cell__bd">
                            <select class="weui-select" name="select2" onselect="onselected">
                                <option value="1">OK</option>
                                <option value="2" class="NG_Select">NG</option>
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
                        <div class="weui-cell__bd">
                            <select class="weui-select" name="select2" onselect="onselected">
                                <option value="1" style="color: blue">OK</option>
                                <option value="2" style="color: red; background-color: red">NG</option>
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
                            <input class="weui-input" type="number">
                        </div>
                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">宽</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
                        </div>

                    </div>

                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">高</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number">
                        </div>
                    </div>
                </div>

                <div class="weui-cells__title">品质检验结果</div>
                <div class="weui-cells weui-cells_radio">
                    <label class="weui-cell weui-check__label" for="x11">
                        <div class="weui-cell__bd">
                            <p>合格</p>
                        </div>
                        <div class="weui-cell__ft">
                            <input type="radio" class="weui-check" name="radio1" id="x11">
                            <span class="weui-icon-checked"></span>
                        </div>
                    </label>
                    <label class="weui-cell weui-check__label" for="x12">

                        <div class="weui-cell__bd">
                            <p>不合格</p>
                        </div>
                        <div class="weui-cell__ft">
                            <input type="radio" name="radio1" class="weui-check" id="x12" checked="checked">
                            <span class="weui-icon-checked"></span>
                        </div>
                    </label>

                </div>
            </div>


        </div>

    </form>

    <div class="weui-btn-area">
        <a class="weui-btn weui-btn_primary" href="javascript:" id="Submit">提交</a>
    </div>

    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SQCID" runat="server" />
    </form>
</body>
</html>
