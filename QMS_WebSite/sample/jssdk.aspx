<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jssdk.aspx.cs" Inherits="sample_jssdk" %>

<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Js示例测试页</title>
        <script src="../scripts/jquery_1.6.3.js"></script>
        <script src="../scripts/mobilebridge.js?5"></script>
        <script>
            function showOs() {
                alert($M.getOs());
            }

            function openNewWindow() {
                $M.open("jssdk.aspx", "百度", function(msg) {
                    if (msg != "undefined") {
                        $("#spMsg").html(msg);
                    }
                });
            }

            function openWeb() {
                $M.open("http://m.baidu.com", "百度");
            }

            function closeWindow() {
                $M.close();
            }

            function closeWindow1() {
                $M.close("123456");
            }

            function closeAndReload() {
                $M.closeAndReload();
            }

            function loadUrl() {
                $M.loadUrl("http://mail.163.com");
            }

            function setBarTitle() {
                $M.setTitle("网易");
            }

            function setBarButton() {
                $M.setButton("[{\"function\":\"search\",\"title\":\"搜索\"}]");
            }

            function setBarButtonImage() {
                $M.setButton("[{\"function\":\"search\",\"icon\":\"icon_search\"}]");
            }

            function search() {
                alert("调用了search");
            }

            function hideNaviBar() {
                $M.hideNaviBar();
            }

            function showNaviBar() {
                $M.showNaviBar();
            }

            function scanQrcode() {
                $M.scanQrcode(function(qrcode) {
                    $("#spMsg").html(qrcode);
                })
            }

            function openPrint() {
                //$M.openPrint("G1oAAQA5AMnPuqPWpb/CtPLToby8yvXT0M/euavLviAgtdjWt6O6yc+6o8bWtqvQ48bMwrczOTk5usU2usXCpQ==");
                $M.openPrint("ISAwIDIwMCAyMDAgNDI0IDENClBBR0UtV0lEVEggNjQwDQpHQVAtU0VOU0UNCkJPWCAwIDAgNTY4IDM1OCA0DQpMSU5FIDAgNDggIDU2OCA0OCAzIA0KTElORSAwIDk2ICA1NjggOTYgMyANCkxJTkUgMCAxNDQgNTY4IDE0NCAzIA0KTElORSAwIDE5MiA1NjggMTkyIDMgDQpMSU5FIDAgMjQwIDU2OCAyNDAgMyANCkxJTkUgMCAzMDAgNTY4IDMwMCAzIA0KTElORSAxMjAgNDggMTIwIDM1OCAzIA0KTElORSAzMzYgNDggMzM2IDE0NCAzIA0KTElORSA0MDggNDggNDA4IDE0NCAzIA0KTElORSAyMzAgMzAwIDIzMCAzNTYgMyANCkxJTkUgMjkyIDMwMCAyOTIgMzU2IDMgDQpMSU5FIDM5MCAzMDAgMzkwIDM1NiAzIA0KTElORSA0NTIgMzAwIDQ1MiAzNTYgMyANClNFVEJPTEQgMQ0KIFNFVE1BRyAxIDEgDQpURVhUIDEyIDIgMTUwIDE1IMn6svrB99eqv6goRlQxODA4MDgwMDAwMDEpDQogU0VUTUFHIDAgMCANClNFVEJPTEQgMA0KIExFRlQNCiBTRVRNQUcgMSAxIA0KVEVYVCAxMCAxMCAyNSA2MiC2qbWlusUNCiBURVhUIDEwIDEwIDE0OCA2MiBTRTIwMTgwNjA0MDUNCiBURVhUIDEwIDEwIDM0MiA2MiDF+iC0zg0KIFRFWFQgMTAgMTAgNDE1IDYyIDE4MDgxNjAwQUMNCiBURVhUIDEwIDEwIDE1IDEwOSDO78HPseDC6w0KIFRFWFQgMTAgMTAgMTY2IDEwOSBCMDExMDM0MTMwDQogVEVYVCAxMCAxMCAzNDIgMTA5ILmkINDyDQogVEVYVCAxMCAxMCA0MTggMTA5IE1LLTIwLcSjx9ANCiBURVhUIDEwIDEwIDE1IDE1NyDO78HPw/uzxg0KIFRFWFQgMTAgMTAgMTI4IDE1NyA0MDM2IEFscGhhIE5FWC01Ti9BbHBoYSBORVgtRjOholNvbnkNCiBURVhUIDEwIDEwIDI1IDIwNSC55iAguPENCiBURVhUIDEwIDEwIDEyOCAyMDUgzbjD97Gju6TEpCAtIEFwcGxlIGlQaG9uZSA1Yy81cy81DQogVEVYVCAxMCAxMCAyNSAyNTggzPUgIMLrDQogVEVYVCAxMCAxMCAyNSAzMTYgyv0gIMG/DQogVEVYVCAxMCAxMCAxMjggMzE2IDEwMDAgUENTIA0KIFRFWFQgMTAgMTAgMjM1IDMxNiDW2MG/DQogVEVYVCAxMCAxMCAzMDYgMzE2IDUwMCBHIA0KIFRFWFQgMTAgMTAgMzk3IDMxNiDQ1cP7IA0KIFRFWFQgMTAgMTAgNDYwIDMxNiDA7tK7xNAgDQogU0VUTUFHIDAgMCANCkJBUkNPREUgMTI4IDEgMSA1MCAxOTAgMjQ1IDEyMzQ1Njc4OUFCQyANCkZPUk0NClBSSU5UDQo=");
            }

            function upload() {
                var serverurl = "http://47.106.195.224:10080/AJD/";
                //var serverurl = "http://192.168.199.193:18080/AJD/";
                $M.upload(serverurl + "upload.aspx", 1200, function() {
                    $("#divLoading").show();
                }, function(ret) {
                    $("#divLoading").hide();
                    $("#spMsg").html(ret);

                    var jsonData = eval("(" + ret + ")");
                    if (jsonData.status == 1) {
                        $("#imgUpload").attr("src", serverurl + jsonData.url).show();
                    } else {
                        //$("#spMsg").html(jsonData.message);
                    }
                })
            }
        </script>
    </head>
    <body>
        <input type="button" value="获取操作系统类型" onclick="showOs()"/><br>
        <input type="button" value="打开新窗" onclick="openNewWindow()"/>
        <input type="button" value="打开其他网站" onclick="openWeb()"/><br>
        <input type="button" value="关闭窗口" onclick="closeWindow()"/>
        <input type="button" value="关闭窗口并返回值" onclick="closeWindow1()"/>
        <input type="button" value="关闭窗口并刷新父页面" onclick="closeAndReload()"/>
        <br>
        <input type="button" value="加载指定URL的页面" onclick="loadUrl()"/>
        <br><br>
        <input type="button" value="设置导航栏标题" onclick="setBarTitle()"/><br>
        <input type="button" value="设置导航栏文字按钮" onclick="setBarButton()"/>
        <input type="button" value="设置导航栏图标按钮" onclick="setBarButtonImage()"/>
        <br>
        <input type="button" value="隐藏导航栏" onclick="hideNaviBar()"/>
        <input type="button" value="显示导航栏" onclick="showNaviBar()"/>
        <br>
        <input type="button" value="扫描二维码" onclick="scanQrcode()"/>
        <br>
        <input type="button" value="上传" onclick="upload()"/>
		<br>
        <input type="button" value="打印" onclick="openPrint()"/>
        
        <br />
        <br />
        返回信息：<br /><br />
        <div id="divLoading" style="display:none;"><img src="../images/small_Loading.gif" />图片上传中</div><br />
        <span id="spMsg" style="color:Red"></span><br>
        <img id="imgUpload" height="200px" width="200px" style="display:none;" />
        
    </body>
</html>

