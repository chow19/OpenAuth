<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bonded_Show.aspx.cs" Inherits="QMS_WebSite.IPQCRoute.show.Bonded_Show" %>


<!DOCTYPE html>
<html>
<head>
    <title>贴合</title>
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

        $(function () {
            pageLoad();

        });

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
        };
  
        //页面加载事件
        function pageLoad() {
            var RouteId = $("#RouteId").val();
            if (RouteId == "") {
                $M.alert("数据异常");
                return;
            }
            $.ajax({
                url: "../../Handler/IPQCRountCheck.ashx?FunType=GetRountInfo&RouteId=" + RouteId,
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
                                if (o == "IsDone") {
                                    if (retdata[o] != 1) {
                                        alert("数据异常");
                                        $M.closeAndReload();
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
                <tr style="display: none">
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
                    <td>工序</td>
                    <td>
                        <label id="lb_SpecificationName"></label>
                    </td>
                    <td>工单数量</td>
                    <td>
                        <label id="lb_MOQtyRequired"></label>
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

                <div class="weui-cells__tips tltles">材质</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">玻璃具号</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ModualNo"></label>

                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">AB胶原料</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ABRW"></label>

                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">AB胶模具号</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ABMJH"></label>
                        </div>
                    </div>

                </div>

                <div class="weui-cells__tips tltles">平面尺寸</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd  ">
                            <label class="weui-label">待定</label>
                        </div>
                        <div class="weui-cell__bd">
                            todo
                        </div>
                    </div>

                </div>

                <div class="weui-cells__tips tltles">外观</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">吻合度</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_MGD"></label>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">试贴</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">外观</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_WG"></label>
                        </div>
                    </div>

                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">排气效果</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_PQXG"></label>
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
                        <label class="weui-label">备注</label>
                    </div>
                    <div class="weui-cell__bd">
                        <label id="lb_Describe"></label>
                    </div>

                </div>
            </div>
        </div>

    </form>

    <!--********************************填写检验结束 开始**************************************-->
    <input type="hidden" id="hidgalley" />
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="SteptID" runat="server" />
        <asp:HiddenField ID="RouteId" runat="server" />
    </form>
</body>
</html>

