<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowCheckItem.aspx.cs" Inherits="QMS_WebSite.IQC.Show.ShowCheckItem" %>


<!DOCTYPE html>
<html > 
<head>
    <title></title>
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
 
    <script>
 
        $(function () { 
            //加载列表
            templateReload(PID);

        });
         
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
         
        //模板
        function templateReload(PID) {
            $("#showTable").html("");
            var PID = $("#PID").val();
            if (PID == "") {
                $M.alert("数据异常");
            }
            //加载列表
            $.ajax({
                url: "../../Handler/IQC.ashx?FunType=getIQCCheckItemByPID&PID=" + PID,
                type: "Get",
                cache: false,
                error: function (XMLHttpRequest, textStatus, e) { 
                    alert("Errors");
                },
                success: function (data) {

                    if (JSON.parse(data).result = "0") {
                        var jsonData = eval("(" + data + ")");
                        var html = template('row_tb', jsonData); //套模版出html 
                        $("#showTable").append(html); //填充到目标div   
                    } else {
                        $.toast(JSON.parse(data).msg, "forbidden");
                    }
                    $(".weui-loadmore").remove();

                }
            });
            $(".weui-loadmore").remove();
        }  
    </script>

    <script id="row_tb" type="text/html">
        {{if msg!='没有数据'}}
        <table class="weui-table weui-border-tb weui-table-2n">
            <thead>
                <tr>
                    <th>检验项目</th>
                    <th>检验类型</th> 
                    <th>标准值</th>
                    <th>范围值</th>
                </tr>
            </thead>
            <tbody>
                {{each data as value i}} 
                       <tr>
                           <td>{{value.IQC_CheckItemName}}</td>
                           <td>{{value.IQC_CheckItemValueType}}</td>
                           <td>{{value.IQC_CheckItemStdValue}}</td>
                           <td>大于{{value.IQC_CheckItemStdDownLimit}};
                               {{if value.IQC_CheckItemStdUpLimit!=''}}
                               小于{{value.IQC_CheckItemStdUpLimit}}
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
     
    <div class="weui-panel weui-panel_access">
        <div class="weui-panel__hd">
            <h1>检验项目列表↓↓</h1>
        </div>
        <div class="weui-panel__bd"> 
            <div class="weui-cells weui-cells_form" style="margin-top: 0">
                <div class="weui-cell">
                    <div id="showTable" style="width: 100%">
                    </div>
                </div>

            </div>

        </div>
    </div>
     <div class="weui-loadmore">
        <i class="weui-loading"></i>
        <span class="weui-loadmore__tips">正在加载</span>
    </div>
    <form id="form2" runat="server" target="">
        <asp:HiddenField ID="PID" runat="server" />
    </form>
</body>
</html>
