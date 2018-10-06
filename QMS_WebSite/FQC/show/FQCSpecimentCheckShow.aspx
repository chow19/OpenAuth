<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FQCSpecimentCheckShow.aspx.cs" Inherits="QMS_WebSite.FQC.show.FQCSpecimentCheckShow" %>

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
           
        };
         
        window.onbeforeunload = function () {
            if (!confirm("是否退出???")) {
                return false;
            }
        };
         
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

                                if (retdata.ZM_Images != "") {
                                    addImgli("ZM", retdata.ZM_Images);
                                }
                                if (retdata.CM_Images != "") {
                                    addImgli("CM", retdata.CM_Images);
                                }
                                if (retdata.KX_Images != "") {
                                    addImgli("KX", retdata.KX_Images);
                                }

                                if (retdata.NHBZ_Images != "") {
                                    addImgli("NHBZ", retdata.NHBZ_Images);
                                }
                                if (retdata.KNHBZ_Images != "") {
                                    addImgli("KNHBZ", retdata.KNHBZ_Images);
                                }
                                if (retdata.CPZB_Images != "") {
                                    addImgli("CPZB", retdata.CPZB_Images);
                                }
                                if (retdata.BZQD_Images != "") {
                                    addImgli("BZQD", retdata.BZQD_Images);
                                }
                                if (retdata.TB_Images != "") {
                                    addImgli("TB", retdata.TB_Images);
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

        //添加图片名称到数组
        function addImgli(control, msg) { 
            var arr = msg.split(';'); 
            var str = "";
            for (var i = 0; i < arr.length; i++) { 
                var temp = arr[i].split('-');
                str += "<li class=\"weui-uploader__file\"  style=\"background-image:url(../../upload/" + arr[i] + ")\"></li>";
            }
            $("#uploaderFilesimg_" + control).append(str);
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
                    <td>物料代码</td>
                    <td>
                        <label id="lb_ProductName"></label>
                        <label id="lb_ProductId" style="display: none"></label>
                    </td>
                </tr>
                <tr>
                    <td>物料描述</td>
                    <td colspan="5">
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
                            <select id="Sel_ZM" class="weui-select" name="Sel_ZM">
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
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">侧唛</label>
                        </div>
                        <div class="myOwn">
                            <select id="Sel_CM" class="weui-select" name="Sel_CM">
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
                            <select id="Sel_KX" class="weui-select" name="Sel_KX">
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
                            <select id="Sel_NHBZ" class="weui-select" name="Sel_NHBZ">
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
                            <select id="Sel_KNHBZ" class="weui-select" name="Sel_KNHBZ">
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
                            <select id="Sel_CPZBM" class="weui-select" name="Sel_CPZBM">
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
                            <select id="Sel_BZQD" class="weui-select" name="Sel_BZQD">
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
                            <select id="Sel_TB" class="weui-select" name="Sel_TB">
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