<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OQCCheckShow.aspx.cs" Inherits="QMS_WebSite.OQC.show.OQCCheckShow" %>
 
<!DOCTYPE html>
<html>
<head>
    <title>OQC</title>
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
        var img_STarr = [];
        var img_KHZDarr = [];

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
             

            var $gallery = $("#gallery");
            var $galleryImg = $("#galleryImg");

            var $uploaderFiles_ST = $("#uploaderFilesimg_ST");
            var $uploaderFiles_KHZD = $("#uploaderFilesimg_KHZD");

            var indexST;
            $uploaderFiles_ST.on("click", "li", function () {
                indexST = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("ST");
            });
            var indexKHZD;
            $uploaderFiles_KHZD.on("click", "li", function () {
                indexKHZD = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
                $("#hidgalley").val("KHZD");
            });

            $gallery.on("click", function () {
                $gallery.fadeOut(100);
            });
         
        }
        
        //添加图片名称到数组
        function addImgArr(msg) {
            var hidgalley = $("#hidgalley").val();
            switch (hidgalley) {
                case "ST":
                    img_STarr.push(msg);
                    break;
                case "KHZD":
                    img_KHZDarr.push(msg);
                    break; 
            }
        }

      
     
    

      
        //页面加载事件
        function pageLoad() {
            var OID = $("#OID").val();
            if (OID == "") {
                $M.alert("数据异常");
            }
            $.ajax({
                url: "../../Handler/IPQCFirstCheck.ashx?FunType=getCheckInfo&OQCCheckId=" + OID,
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
                    url: "../../Handler/OQC.ashx?FunType=getProductDetail&ProductId=" + qrcode,
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
                    <td>销售出库单</td>
                    <td>
                        <label id="lb_FBillNo"></label>
                    </td>
                    <td class="auto-style1">客户</td>
                    <td colspan="3">
                        <label id="lb_CustomerName"></label>
                    </td>
                </tr>
                <tr>
                    <td>物料代码</td>
                    <td>
                        <label id="lb_ProductName"></label>
                        <label id="lb_ProductId" style="display: none"></label>
                    </td>
                    <td>物料描述</td>
                    <td>
                        <label id="lb_ProductDescription"></label>
                    </td>
                    <td>数量</td>
                    <td>
                        <label id="lb_Qty"></label>
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
                 
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">试贴</label>
                        </div>
                       
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="ploaderFilesimg_ST">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_ST" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">客户指定照片</label>
                        </div>
                        
                        <div class="weui-cell__bd">
                            <div class="weui-uploader imgspace">
                                <div class="weui-uploader__bd">
                                    图片上传 &nbsp;
                                    <ul class="weui-uploader__files" id="ploaderFilesimg_KHZD">
                                    </ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="uploaderInputimg_KHZD" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
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
        <asp:HiddenField ID="OID" runat="server" />
    </form>
</body>
</html>

