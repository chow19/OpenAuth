<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendReportCheck.aspx.cs" Inherits="QMS_WebSite.SendReportCheck" %>
 
<!doctype html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IQC</title>
        <link rel="stylesheet" href="css/page.css"/>
        <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.min.css"/>
        <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.css"/>
         
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
        
        #score
        {
            font-size:20px;
            height:40px;
            width:60px;
        }

        #CheckReslt{
            width:100%;
            height:100%;
            font-size:20px; 
            border:solid 1px #ccc;
            border-collapse:collapse;
        }

         #CheckReslt th { 
            border:solid 1px #ccc;
        }

          #CheckReslt td { 
            border:solid 1px #ccc;
            font-size:20px;
        }

        #CheckReslt tr { 
            border:solid 1px #ccc;
        }

        #Test{
            width:50%;
        } 

        .myOwn{
            width:50%; 
        } 
         
        .NG_Select{
            color:blue;
        } 

        #lb_bottom{
            font-size:25px;
            color:blue;
        }

        .tltles{
            color:lightblue;
        }

	    </style>
        <script src="scripts/jquery_1.6.3.js"></script>
        <script src="scripts/jquery.lazyload.min.js"></script>
        <script src="scripts/comm.js"></script>
        <script src="scripts/mobilebridge.js?1"></script>
        <script src="scripts/jquery-weui/js/jquery-weui.js"></script> 
        <link href="Scripts/mui/mui.min.css" rel="stylesheet" />  
        <script type="text/javascript" src="scripts/jquery-weui/js/jquery.min.js"></script>  

        <script>
            mui.init();
            $(function () {
                onDeviceReady();

                // 允许上传的图片类型  
                var allowTypes = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
                // 1024KB，也就是 1MB  
                var maxSize = 1024 * 1024;
                // 图片最大宽度  
                var maxWidth = 300;
                // 最大上传图片数量  
                var maxCount = 6;
                $('.js_file').on('change', function (event) {
                    var files = event.target.files;

                    // 如果没有选中文件，直接返回  
                    if (files.length === 0) {
                        return;
                    }

                    for (var i = 0, len = files.length; i < len; i++) {
                        var file = files[i];
                        var reader = new FileReader();

                        // 如果类型不在允许的类型范围内  
                        if (allowTypes.indexOf(file.type) === -1) {
                            $.weui.alert({
                                text: '该类型不允许上传'
                            });
                            continue;
                        }

                        if (file.size > maxSize) {
                            $.weui.alert({
                                text: '图片太大，不允许上传'
                            });
                            continue;
                        }

                        if ($('.weui_uploader_file').length >= maxCount) {
                            $.weui.alert({
                                text: '最多只能上传' + maxCount + '张图片'
                            });
                            return;
                        }

                        reader.onload = function (e) {
                            alert("1");
                            var img = new Image();
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
                                var base64 = canvas.toDataURL('image/png');

                                // 插入到预览区  
                                var $preview = $('<li class="weui_uploader_file weui_uploader_status" style="background-image:url(' + base64 + ')"><div class="weui_uploader_status_content">0%</div></li>');
                                $('.weui_uploader_files').append($preview);
                                var num = $('.weui_uploader_file').length;
                                $('.js_counter').text(num + '/' + maxCount);

                                // 然后假装在上传，可以post base64格式，也可以构造blob对象上传，也可以用微信JSSDK上传  
                                alert("shangchuan");
                                var progress = 0;

                                function uploading() {
                                    $preview.find('.weui_uploader_status_content').text(++progress + '%');
                                    if (progress < 100) {
                                        setTimeout(uploading, 30);
                                    } else {
                                        // 如果是失败，塞一个失败图标  
                                        //$preview.find('.weui_uploader_status_content').html('<i class="weui_icon_warn"></i>');  
                                        $preview.removeClass('weui_uploader_status').find('.weui_uploader_status_content').remove();
                                    }
                                }
                                setTimeout(uploading, 30);
                            };

                            img.src = e.target.result;
                        };
                        reader.readAsDataURL(file);
                    }
                });


            });
            
            //ios设备就绪的方法
            function onDeviceReady() {
                $M.setButton("[{\"function\":\"save\",\"title\":\"保存\"}]");
                $("img").lazyload({ effect: "fadeIn" });    //图片懒加载

            };

            function save() {
                  if (!confirm("确认提交？")) {
                    return false;
                }
                  $M.open("Upload_Pics.aspx"  , "送检单检验");
                
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


          //提交按钮  
          $("#Submit").click(function() {
            //var tel = $('#tel').val();
            //var code = $('#code').val();
            //if(!tel || !/1[3|4|5|7|8]\d{9}/.test(tel)) $.toptip('请输入手机号');
            //else if(!code || !/\d{6}/.test(code)) $.toptip('请输入六位手机验证码');
              //else $.toptip('提交成功', 'success');
              $.toptip('提交测试', 'success');
          });

          function CheckSubmit() {
              $M.alert("提交测试");
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







               
        </script>
    </head>
    <body>
        <form id="form1" runat="server">
        <div id="loading" style="top: 150px;display:none;">
            <div class="lbk">
            </div>
            <div class="lcont">
                <img src="images/loading.gif" alt="loading...">正在提交...</div>
        </div>
         
         <div class="weui-cells__tips tltles">透光率</div>
         <div class="weui-cells weui-cells_form">
              <div class="weui-cell">
                <div class="weui-cell__hd  "><label class="weui-label">UV</label></div>
                <div class="weui-cell__bd">
                      <input class="weui-input  " type="text"   placeholder="UV">
                 </div>
                   
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_UV" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div>

              <div class="weui-cell">
                <div class="weui-cell__hd   "><label class="weui-label">VL</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input  " type="text"   placeholder="VL">
                </div>
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_VL" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                </div>
                  

              </div>
             <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">IR</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="text"   placeholder="IR">
                </div>

                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_IR" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div> 
        </div>
          
         <div class="weui-cells__tips tltles">厚度</div>
         <div class="weui-cells weui-cells_form">
              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">总厚</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"    >
                </div>

                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_ZH" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
              </div>

              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">玻璃厚</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"   >
                </div>

                <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_BLH" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>

              </div>
             <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">AB胶厚</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"    >
                </div>

                  <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_ABJH" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
              </div>
              
             
        </div>
         
         <div class="weui-cells__tips tltles">硬度</div>
         <div class="weui-cells weui-cells_form">
              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">硬度</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"    >
                </div>

               <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                  <div class="weui-uploader__input-box">
                    <input id="img_YD" class="weui-uploader__input" type="file" accept="image/*" multiple="">
               </div> 

              </div>
             
              
        </div>

         <div class="weui-cells__tips tltles">水滴角</div>
          <div class="weui-cells weui-cells_form">
              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">初始</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"    >
                </div>

                   <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                   <div class="weui-uploader__input-box">
                            <input id="img_CS" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                   </div> 

              </div>
              
              		 
              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">耐磨</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"   >
                </div>

                   <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                   <div class="weui-uploader__input-box">
                            <input id="img_NM" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                   </div>

              </div>

             

             <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">磨擦后</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"    >
                </div>

                   <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                   <div class="weui-uploader__input-box">
                            <input id="img_MCH" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                   </div>

              </div>

            
              
             
        </div>
            
         <div class="weui-cells__tips tltles">指纹油</div>
          <div class="weui-cells weui-cells_form">
              <div class="weui-cell"> 
               <div id="Test" class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label">正面</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select" name="select2"  onselect="onselected">
                             <option value="1">OK</option>
                             <option value="2">NG</option> 
                         </select>
                  </div>
                 
              </div>
                  <div class="weui-cell__hd"><label class="weui-label">图片</label></div>
                  <div class="weui-uploader__input-box">
                        <input id="img_ZM" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                  </div>
              </div> 

              <div class="weui-cell">
                 <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label">背面</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select"  name="select2" onselect="onselected">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div> 
                </div>
                      <div class="weui-cell__hd"><label class="weui-label">图片</label></div>
                      <div class="weui-uploader__input-box">
                            <input id="img_BM" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                      </div>
              </div> 
        </div>
         
        <div class="weui-cells__tips tltles">钢化效果</div>
        <div class="weui-cells weui-cells_form">
              <div class="weui-cell"> 
                 <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label">钢球落下</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select" name="select2" onselect="onselected">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div>
                </div>
                  <div class="weui-cell__hd"><label class="weui-label">图片</label></div>
                  <div class="weui-uploader__input-box">
                        <input id="img_GQLX" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                  </div>

               </div> 
           </div>
              
             	 
             <div class="weui-cell"> 
                 <div class="weui-cell weui-cell_select weui-cell_select-after  myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label">弯爆</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select" name="select2"  onselect="onselected">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div>
                 
                </div>

                  <div class="weui-cell__hd"><label class="weui-label">图片</label></div>
                    <div class="weui-uploader__input-box">
                        <input id="img_WB" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                    </div>
              </div> 
             

        <div class="weui-cells__tips tltles">试贴</div>
        <div class="weui-cells weui-cells_form">
              <div class="weui-cell">
                    <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                       <div class="weui-cell__hd">
                          <label for="" class="weui-label">试贴</label>
                      </div>
                      <div class="weui-cell__bd">
                             <select class="weui-select" name="select2" onselect="onselected">
                                 <option value="1" style="color:blue">OK</option>
                                 <option value="2" style="color:red;background-color:red">NG</option> 
                             </select>
                      </div>
                    </div> 

                    <div class="weui-cell__hd"><label class="weui-label">图片</label></div>
                    <div class="weui-uploader__input-box">
                        <input id="img_WB" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                    </div>

              </div>
              

        </div>     

        <div class="weui-cells__tips">尺寸</div>
         <div class="weui-cells weui-cells_form">
              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">长</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"    >
                </div>
              </div>

              <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label">宽</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="number"   >
                </div>
                   <div class="weui-cell__hd"><label class="weui-label">高</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number"   >
                    </div>
              </div>
             
        </div>
        
             
           <div class="weui-cells__title" id="lb_bottom">品质检验结果</div>
           <div class="weui-cells weui-cells_radio">
           <label class="weui-cell weui-check__label" for="x11">
                 <div class="weui-cell__bd">
                       <p>合格</p>
                 </div>
                 <div class="weui-cell__ft">
                         <input type="radio" class="weui-check" name="radio1" id="x11" checked="checked">
                         <span class="weui-icon-checked"></span>
                    </div>
             </label>

           <label class="weui-cell weui-check__label" for="x12"> 
                <div class="weui-cell__bd">
                  <p style="color:red">不合格</p>
                </div>
                <div class="weui-cell__ft">
                      <input type="radio" name="radio1" class="weui-check" id="x12" >
                      <span class="weui-icon-checked"></span>
                </div>
          </label>
      
    </div>
             

        
     <div class="weui-btn-area">
      <a class="weui-btn weui-btn_primary" href="javascript:" id="Submit" onclick="CheckSubmit" >提交</a>
    </div>
             
    <asp:HiddenField ID="studentId" runat="server" />
      
        
        </form>
    </body>
</html>