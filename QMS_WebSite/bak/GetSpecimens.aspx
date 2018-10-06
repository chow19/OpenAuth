<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetSpecimens.aspx.cs" Inherits="QMS_WebSite.GetSpecimens" %>


<!DOCTYPE html>

<html >
      <head>
     
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>

       <link rel="stylesheet" href="css/page.css"/>   
        <script src="scripts/jquery_1.6.3.js"></script>
        <script src="scripts/jquery.lazyload.min.js"></script>
        <script src="scripts/comm.js"></script>
        <script src="scripts/mobilebridge.js?1"></script> 
        <script src="scripts/template.js"></script>
        <script src="Scripts/jquery-2.1.4.js"></script>
        <script src="Scripts/fastclick.js"></script>
        <link rel="stylesheet" href="Scripts/jquery-weui/lib/weui.min.css">
        <link rel="stylesheet" href="Scripts/jquery-weui.css"> 
        <script src="Scripts/jquery-weui.js"></script>
        
        <!--CSS 脚本 -->
        <style>
	    #detailsTable 
	    {
	        width:100%;
	        font-size:20px;
            border-collapse:collapse;
        }  
        
        #detailsTable td 
        {
            width:17%;
            height:50px;
            padding:5px;
            border:solid 1px #ccc;
        } 
        
        #txt_getQty
        {
            font-size:20px;
            height:50%;
            width:100%;
        }

        #txt_ScanSN{
             font-size:20px;
        }

	        .auto-style1 {
                width: 19%;
            }

	    </style>
        

        <!--js 脚本 -->
        <script>
            $(function () {
                pageLoad();
                getAQLinfo(); 
                getSPecimentScanList();
            })


            //页面加载事件
            function pageLoad(){
                var SQCId = $("#SQCID").val();
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
                                setAQLParam(jsonData.data[0].CYFS, jsonData.data[0].JYSP, jsonData.data[0].JYBZ);
                            }
                            else {
                                $("#lb_POName").text("");
                                $("#lb_Vendor").text("");
                                $("#lb_PrdNo").text("");
                                $("#lb_SendQty").text("");
                                $("#lb_Product").text("");//lb_Product
                                $("#lb_TCQ_Qty").text("");
                            }
                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });
            }

            var _cyfs, _jcsp, _jybz;
            //获取AQL参数
            function getAQLParam() {
                var CYFS = $("#CYFS").val();
                var JCSP = $("#JCSP").val();
                var JYBZ = $("#JYBZ").val(); 
                switch (CYFS) {
                    case "1":
                        _cyfs = "1.正常";
                        break;
                    case "2":
                        _cyfs = "2.加严";
                        break;
                    case "3":
                        _cyfs = "3.放宽";
                        break;
                    case "4":
                        _cyfs = "4.免检";
                        break;
                    default:
                        _cyfs = "1.正常";
                        break;

                }

                switch (JCSP) {
                    case "1":
                        _jcsp = "I";
                        break;
                    case "2":
                        _jcsp = "II";
                        break;
                    case "3":
                        _jcsp = "III";
                        break;
                    case "4":
                        _jcsp = "S-1";
                        break;
                    case "5":
                        _jcsp = "S-2";
                        break;
                    case "6":
                        _jcsp = "S-3";
                        break;
                    case "7":
                        _jcsp = "S-4";
                        break;
                }

                switch (JYBZ) {
                    case "1":
                        _jybz = "0.01";
                        break;
                    case "2":
                        _jybz = "0.015";
                        break;
                    case "3":
                        _jybz = "0.025";
                        break;
                    case "4":
                        _jybz = "0.041";
                        break;
                    case "5":
                        _jybz = "0.065";
                        break;
                    case "6":
                        _jybz = "0.1";
                        break;
                    case "7":
                        _jybz = "0.15";
                        break;
                    case "8":
                        _jybz = "0.4";
                        break;
                    case "9":
                        _jybz = "1";
                        break;
                    case "10":
                        _jybz = "1.5";
                        break;
                    case "11":
                        _jybz = "2.5";
                        break;
                    case "12":
                        _jybz = "4";
                        break;
                    case "13":
                        _jybz = "6.5";
                        break;
                    default:
                        _jybz = "6.5";
                        break;
                }
                 
            }

            function setAQLParam(cyfs,jcsp,jybz) {
                var v_cysf = "1";
                var v_jcsp = "1";
                var v_jybz = "1";

                switch (cyfs) {
                    case "1.正常":
                        v_cysf = "1";
                        break;
                    case "2.加严":
                        v_cysf = "2";
                        break;
                    case "3.放宽":
                        v_cysf = "3";
                        break;
                    case "4.免检":
                        v_cysf = "4";
                        break;
                    default:
                        v_cysf = "1";
                        break;
                }

                switch (jcsp) {
                    case "I":
                        v_jcsp = "1";
                        break;
                    case "II":
                        v_jcsp = "2";
                        break;
                    case "III":
                        v_jcsp = "3";
                        break;
                    case "S-1":
                        v_jcsp = "4";
                        break;
                    case "S-2":
                        v_jcsp = "5";
                        break;
                    case "S-3":
                        v_jcsp = "6";
                        break;
                    case "S-4":
                        v_jcsp = "7";
                        break;
                }

                switch (jybz) {
                    case "0.01":
                        v_jybz = "1";
                        break;
                    case "0.015":
                        v_jybz = "2";
                        break;
                    case "0.025":
                        v_jybz = "3";
                        break;
                    case "0.041":
                        v_jybz = "4";
                        break;
                    case "0.065":
                        v_jybz = "5";
                        break;
                    case "0.1":
                        v_jybz = "6";
                        break;
                    case "0.15":
                        v_jybz = "7";
                        break;
                    case "0.4":
                        v_jybz = "8";
                        break;
                    case "1":
                        v_jybz = "9";
                        break;
                    case "1.5":
                        v_jybz = "10";
                        break;
                    case "2.5":
                        v_jybz = "11";
                        break;
                    case "4":
                        v_jybz = "12";
                        break;
                    case "6.5":
                        v_jybz = "13";
                        break;
                    default:
                        v_jybz = "1";
                        break;
                }

                $("#CYFS").val(v_cysf);
                $("#JCSP").val(v_jcsp);
                $("#JYBZ").val(v_jybz);
            }

            //第一次加载页面的时候的处理事件
            function getAQLinfo() {
                 
                getAQLParam();
                var SQCId = $("#SQCID").val();
                $.ajax({
                    url: "RM_IQC.aspx?FunType=getAQL&CYFS=" + _cyfs + "&" + "JCSP=" + _jcsp + "&JYBZ=" + _jybz + "&SendQCReportId=" + SQCId,
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
            
            //用户选择后的处理事件
            function selectAQLinfo() { 
                getAQLParam();
                var SQCId = $("#SQCID").val();
                $.ajax({
                    url: "RM_IQC.aspx?FunType=selAQL&CYFS=" + _cyfs + "&" + "JCSP=" + _jcsp + "&JYBZ=" + _jybz + "&SendQCReportId=" + SQCId,
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

            //扫描
            function scanQrcode() {
                $M.scanQrcode(function (qrcode) {
                    //$M.alert(qrcode);
                    
                    var SQCId = document.getElementById("SQCID").value.trim();
                    $("#ScanSN").html(qrcode);
                    getScanSN_Data(qrcode, SQCId);
                    
                })
            };
            
            //扫描物料标签获取信息
            function getScanSN_Data(scanSN, SQCID) {
               
                $.ajax({
                    url: "RM_IQC.aspx?SendQCReportId=" + SQCID + "&" + "ScanLotSN=" + scanSN,
                    type: "Get",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) { 
                        alert(XMLHttpRequest.responseText); 
                    },
                    success: function (data) { 
                        try {
                            $.parseJSON(data); 
                        var jsonData = eval("(" + data + ")");
                        if (jsonData.result == 0) { 
                            $("#lb_ScanProductDesc").text(jsonData.data[0].ProductDescription)
                            $("#lb_ScanQty").text(jsonData.data[0].Qty);
                            $("#txt_getQty").focus('',function fn(){});
                        }
                        else { 
                            $("#lb_ScanProductDesc").text("");
                            $("#lb_ScanQty").text("");
                            alert(jsonData.msg);
                        }

                        } catch (e) {
                            alert(e.message);
                        } 
                    }
                });
                
            }

            ///抽样方式或者检查水平发生改变 
            function ChangeValue() { 
                selectAQLinfo(); 
            }

            //ios设备就绪的方法
            function onDeviceReady() {
                //$M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
                //$("img").lazyload({ effect: "fadeIn" });    //图片懒加载
            }
             
            function openTest()
            {
                var SQCId = document.getElementById("SQCID").value.trim(); 
                $.ajax({
                    url: "RM_IQC.aspx?SendQCReportId=" + '1234' + "&" + "ScanLotSN=" + 'RG01400000048',
                    type: "Get",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus,e) {
                         
                    },
                    success: function (data) { 
                        var jsonData = eval("(" + data + ")"); 
                        
                        if (   jsonData.result == 0) {
                             
                            alert(jsonData.msg);
                            alert(jsonData.data[0].ProductShortName);
                            alert(jsonData.data[0].ProductDescription);
                        }
                        else {
                             alert("000"); 
                        }  
                    }
                });
            }
             
            function getErrors(){
                    $M.alert("errors");
                    alert(XmlHttpRequest.responseText);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
             
            //扫描获取
            function getSpeciment() {
                var SQCId = $("#SQCID").val();          //送检单
                var Scna_SN = $("#ScanSN").text();      //扫描标签
                var Spec_Qty = $("#txt_getQty").val();  //抽检数量
                var lotQty = $("#lb_ScanQty").text();   // 
                var RequireQty = $("#lb_RequireQty").text();
                if (Scna_SN.length == 0) {
                    alert("扫描信息不能为空...");
                    return false;
                }
                if (Spec_Qty.length == 0) {
                    alert("请输入抽取数量...");
                    return false;
                }

                if (parseInt(Spec_Qty) > parseInt(lotQty)) {
                    alert("抽取数量不能大于扫描数量..." + Spec_Qty + ":" + lotQty);
                    return false;
                }
                if (parseInt(RequireQty) < parseInt(Spec_Qty)) {
                    if (confirm("抽取数量是否要大于样本需求数量...?") == false) {
                        return false;
                    }
                }
                getAQLParam();//获取抽检参数

                // SendQCReportId, CYFS, JCSP, JYBZ, ScanSN, CQ_Qty
                $.ajax({
                    url: "RM_IQC.aspx?FunType=ScanSubmit&SendQCReportId=" + SQCId + "&" + "CYFS=" + _cyfs + "&" + "JCSP="
                            + _jcsp + "&" + "JYBZ=" + _jybz + "&" + "ScanSN=" + Scna_SN + "&" + "CQ_Qty=" + Spec_Qty,
                    type: "POST",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) {
                        alert(XMLHttpRequest.responseText);
                        alert("Errors");
                    },
                    success: function (data) {
                        try {
                            $.parseJSON(data); 
                            var jsonData = eval("(" + data + ")");
                            if (jsonData.result >= 0) {
                                getSPecimentScanList();
                                $("#ScanSN").text("");
                                $("#txt_getQty").val("");
                                $("#lb_ScanQty").text("");
                                $("#lb_ScanProductDesc").text(""); 
                            }
                            else { 
                                alert(jsonData.msg); 
                            }
                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });


            };

            //获取样本扫描数量
            function getSPecimentScanList()
            {
                try{
                    var SQCId = $("#SQCID").val();          //送检单
                    $.ajax({
                        url: "RM_IQC.aspx?FunType=LoadScanList&SendQCReportId=" + SQCId  ,
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
                                if (jsonData.result >= 0) {
                                    var html = template('SC_ScanList', jsonData); //套模版出html
                                    $("#ScanLists").children("div").remove();
                                    $("#ScanLists").append(html);
                                    $("#lb_TCQ_Qty").text(jsonData.T_Qty);
                                   
                                }
                                else {
                                    alert(jsonData.msg);
                                }
                            } catch (e) {
                                alert(e.message);
                            }
                        }
                    });

                } catch (e) {
                    alert(e.message);
                }
            }

            //删除扫描列表
            function deleteScanList( LotSN)
            {
                if (confirm("是否删除抽样记录...?") == false)
                {
                    return false;
                }
                var SQCId = $("#SQCID").val();
                $.ajax({
                    url: "RM_IQC.aspx?FunType=DelScanList&SendQCReportId=" + SQCId + "&" + "DelSN=" + LotSN,
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
                            if (jsonData.result >= 0) {
                                getSPecimentScanList();
                                //alert(jsonData.msg);
                               
                            }
                            else {
                                getSPecimentScanList(); 
                                alert(jsonData.msg);  
                            }
                        }catch (e) {
                            alert(e.message);
                        }
                    }
                });
            }

            //打印样本标签
            function PrintLabel() {
                var SQCId = $("#SQCID").val();
                getAQLParam();
                $.ajax({
                    url: "RM_IQC.aspx?FunType=PrintLabel&SendQCReportId=" + SQCId +"&CYFS=" + _cyfs + "&" + "JCSP=" + _jcsp + "&JYBZ=" + _jybz ,
                    type: "Post",
                    cache: false,
                    error: function (XMLHttpRequest, textStatus, e) {
                        alert(XMLHttpRequest.responseText); 
                    },
                    success: function (data) {
                        try {
                            $.parseJSON(data); 
                            var jsonData = eval("(" + data + ")");
                            if (jsonData.result >= 0) {
                                confirm(jsonData.msg); 
                            }
                            else { 
                                alert(jsonData.msg);
                            }
                        } catch (e) {
                            alert(e.message);
                        }
                    }
                });
            }

        </script>


        <script id="SC_ScanList" type="text/html">  
            {{each data as value i}}
             
            <div class="weui-cell"> 
                <div class="weui-cell__bd">
                    <p>扫描SN:{{value.LotSN}}; 抽样方式:{{value.CYFS}}; 检查水平:{{value.CYSP}}; 抽样标准:{{value.CYBZ}}; 抽取数量:{{value.SpecQty}};</p> 
                </div>

                <div class="weui-cell__ft">
                    <a href="javascript:;" class="weui-btn weui-btn_warn" onclick="deleteScanList('{{value.LotSN}}')">删除</a> 
                </div>
            </div>
             
            {{/each}}	
        </script>

           
    </head>
    <body>

        <!---->
        <%--<form id="form1"  runat="server" target=""  > --%>
         
        <div id="loading" style="top: 150px;display:none;">
            <div class="lbk">
            </div>
            <div class="lcont">
                <img src="images/loading.gif" alt="loading...">正在提交...</div>
        </div>
        
        <table id="detailsTable">
            <tr>
                <td>采购单</td>
                <%--<td><asp:Label ID="lb_POName" runat="server" Text="PO123456"></asp:Label></td>--%>
                <td><Label ID="lb_POName" runat="server" Text=""></Label></td>
                <td class="auto-style1">供应商</td>
                <td><Label ID="lb_Vendor" runat="server"  ></Label></td>
                <td>物料代码</td>
                <td><Label ID="lb_PrdNo" runat="server"  ></Label></td>
            </tr>
            <tr>                
                <td>物料描述</td> 
                <td colspan="3"> <Label id="lb_Product" runat="server"  ></Label></td>
                <td>送货数量</td> 
                 <td><Label ID="lb_SendQty" runat="server"  ></Label></td>
            </tr>
            <tr>                
                <td style="color:blue">抽样方式</td>
                <td>
                    <div id="cyfs_M" class="weui-cell weui-cell_select weui-cell_select-after  ">
                        <div class="weui-cell__bd "   >
                            <select id="CYFS"  class="weui-select" name="sel_CYFS" onchange="ChangeValue()" >
                                 <option value="1">1.正常</option>
                                 <option value="2">2.加严</option> 
                                 <option value="3">3.放宽</option> 
                                 <option value="4">4.免检</option> 
                            </select>
                        </div>
                    </div>
                      
                <td style="color:blue" class="auto-style1">检查水平</td>

                <td> 
                    <div id="JCSP_M" class="weui-cell weui-cell_select weui-cell_select-after  ">
                        <div class="weui-cell__bd">
                          <select id="JCSP" class="weui-select" name="sel_JYSP"  onchange="ChangeValue()">
                             <option value="1">I</option>
                             <option value="2">II</option> 
                             <option value="3">III</option> 
                             <option value="4">S-1</option> 
                             <option value="5">S-2</option> 
                             <option value="6">S-3</option> 
                             <option value="7">S-4</option> 
                          </select>
                     </div>
                     </div> 

                </td>

                <td style="color:blueviolet">检验标准</td>

                <td>  
                    <div id="JYBZ_M" class="weui-cell weui-cell_select weui-cell_select-after  ">
                         <div class="weui-cell__bd">
                        <select id="JYBZ" class="weui-select" name="sel_JYBZ"  onchange="ChangeValue()" >
                             <option value="1">0.01</option>
                             <option value="2">0.015</option> 
                             <option value="3">0.025</option> 
                             <option value="4">0.041</option> 
                             <option value="5">0.065</option> 
                             <option value="6">0.1</option> 
                             <option value="7">0.15</option> 
                             <option value="8">0.4</option> 
                             <option value="9">1</option> 
                             <option value="10">1.5</option> 
                             <option value="11">2.5</option> 
                             <option value="12">4</option> 
                             <option value="13">6.5</option> 
                         </select>
                     </div>
                    </div> 
                </td>

            </tr>
            <tr>                
                <td>样本量</td>
                <%--<td><asp:Label ID="lb_RequireQty" runat="server" Text="200" ForeColor="#cc33ff"></asp:Label></td>--%>
                <td><Label ID="lb_RequireQty" runat="server" style="color:blueviolet"></Label></td>
                
                <td class="auto-style1" >允收(AC)</td>
                <%--<td ><asp:Label ID="lb_IssueQty" runat="server" Text="200" ForeColor="blueviolet" ></asp:Label></td>--%>
                <td ><Label ID="lb_IssueQty" runat="server"  style="color:blueviolet" ></Label></td>

                <td class="auto-style1" >拒收(RE)</td>
                <%--<td ><asp:Label ID="lb_reject" runat="server" Text="200"  ForeColor="Red"></asp:Label></td>--%>
                <td ><Label ID="lb_reject" runat="server"  style="color:red"></Label></td>
                
            </tr>
            <tr>
                <td><input type="button" class="weui-btn weui-btn_primary" value="扫描" onclick="scanQrcode()" /></td>
                <td><Label ID="ScanSN" runat="server"  ></Label>   </td> 
                <td colspan="4"><Label ID="lb_ScanProductDesc" runat="server"  ></Label> </td> 

            </tr>
             <tr>  
                <td>数量</td>
                <td> <Label ID="lb_ScanQty" runat="server"  ></Label> </td> 
                <td>本次抽取数</td>
                <td> 
                    <%--<asp:TextBox ID="txt_getQty" runat="server"></asp:TextBox>--%>
                    <input type="number" title="t_gQty"   id="txt_getQty" autofocus="autofocus" onkeyup="value=value.replace(/[^\d]/g,'') " />
                </td>
                 <td>累计抽取数</td>
                 <td> <Label ID="lb_TCQ_Qty" runat="server"  ></Label> </td> 
            </tr>
             
        </table>
          
        
        <input type="button" class="weui-btn weui-btn_primary" value="抽取" onclick="getSpeciment()" />   
        <%--</form>--%> 
        <form id="form2"  runat="server" target=""  > 
            <asp:HiddenField ID="SQCID" runat="server" />
        </form> 


        <!--   扫描列表  -->
        <div class="weui-cells" id="ScanLists">
             <!--

             <div class="weui-cell"> 
            <div class="weui-cell__bd">
                <p>标题文字</p> 
            </div>
            <div class="weui-cell__ft">
                <a href="javascript:;" class="weui-btn weui-btn_warn">删除</a> 
            </div>
          </div>
             
             <div class="weui-cell"> 
            <div class="weui-cell__bd">
                <p>标题文字</p>
            </div>
            <div class="weui-cell__ft">
                <a href="javascript:;" class="weui-btn weui-btn_warn">删除</a> 
            </div>
          </div>
             
             <div class="weui-cell"> 
            <div class="weui-cell__bd">
                <p>标题文字</p>
            </div>
            <div class="weui-cell__ft">
                <a href="javascript:;" class="weui-btn weui-btn_warn">删除</a> 
            </div>
          </div>

             -->
             
         </div>  

        


          <input type="button" class="weui-btn weui-btn_primary" value="打印样本标签" onclick="PrintLabel()" /> 
 

    </body>
</html>
