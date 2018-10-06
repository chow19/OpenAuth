 
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Diecut_Show.aspx.cs" Inherits="QMS_WebSite.IPQC.show.Diecut_Show" %>
 

<!DOCTYPE html>
<html>
<head>
    <title>模切</title>
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
         

        function pageLoad() {
            var SteptID = $("#SteptID").val();
            if (SteptID == "") {
                $M.alert("数据异常");
                return;
            }
            $.ajax({
                url: "../../Handler/IPQCRountCheck.ashx?FunType=getRountInfo&WFSteptId=" + SteptID,
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
                            <label class="weui-label">原料</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ScanProductDesc"></label>
                        </div>
                    </div>
                </div>
                <div class="weui-cells__tips tltles">模具编码</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">模具</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_ModualNo"></label>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__tips tltles">透光/外观</div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">UV</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_UV"></label>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">VL</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_VL"></label>
                        </div>
                    </div>

                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">IR</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_IR"></label>
                        </div>
                    </div>
                </div>

                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">无暴边、刮花</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_WBBGH"></label>
                        </div>
                    </div>

                    <div class="weui-cells__tips tltles">平面尺寸</div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">长</label>
                            </div>
                            <div class="weui-cell__bd">
                                <label id="lb_CD"></label>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd">
                                <label class="weui-label">宽度</label>
                            </div>
                            <div class="weui-cell__bd">
                                <label id="lb_KD"></label>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">二次元测试</label>
                            </div>
                            <div class="weui-cell__bd">
                            </div>
                        </div>

                    </div>

                    <div class="weui-cells__tips tltles">厚度尺寸</div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">总厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <label id="lb_ZH"></label>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">使用层厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <label id="lb_SYCH"></label>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">保护层厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <label id="lb_BHCH"></label>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cells weui-cells_form" style="margin-top: 0">
                        <div class="weui-cell">
                            <div class="weui-cell__hd  ">
                                <label class="weui-label">离型层厚</label>
                            </div>
                            <div class="weui-cell__bd">
                                <label id="lb_LXCH"></label>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="weui-cells__title">性能/试贴 </div>
                <div class="weui-cells weui-cells_form" style="margin-top: 0">
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">试贴效果</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_STXG"></label>
                        </div>
                    </div>

                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">排气效果</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_PQXG"></label>
                        </div>
                    </div>

                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">贴膜拉力≤20牛顿</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_QMLL"></label>
                        </div>
                    </div>
                    <div class="weui-cell weui-cell_select weui-cell_select-after">
                        <div class="weui-cell__hd">
                            <label for="" class="weui-label">防窥最佳视角</label>
                        </div>
                        <div class="weui-cell__bd">
                            <label id="lb_FKSJ"></label> 
                        </div>
                    </div>

                </div>

                <div class="weui-cells__title">粘力测试 </div>
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">撕Ⅱ面不带起使用层</label>
                    </div>
                    <div class="weui-cell__bd">
                          <label id="lb_BDQSYC"></label>  
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
    </form>
</body>
</html>

