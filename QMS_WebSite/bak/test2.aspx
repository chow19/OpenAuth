<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test2.aspx.cs" Inherits="QMS_WebSite.test2" %>

<html>
  <head>
    <title>jQuery WeUI</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
  
      <link rel="stylesheet" href="Scripts/jquery-weui/lib/weui.min.css" />
      <link rel="stylesheet" href="Scripts/jquery-weui.css" /> 
       <link rel="stylesheet" href="css/demos.css">
      <link href="Scripts/weui.css" rel="stylesheet" />
      <script src="Scripts/zepto.min.js"></script> 

</head>

  <body  >
    
       <div class="weui-gallery" id="gallery">  
            <span class="weui-gallery__img" id="galleryImg"></span>  
            <div class="weui-gallery__opr">  
                <a href="javascript:" class="weui-gallery__del">  
                    <i class="weui-icon-delete weui-icon_gallery-delete"></i>  
                </a>  
            </div>  
        </div>  
        <div class="weui-cells weui-cells_form">  
            <div class="weui-cell">  
                <div class="weui-cell__bd">  
                    <div class="weui-uploader">  
                        <div class="weui-uploader__hd">  
                            <p class="weui-uploader__title">图片上传</p>  
                        </div>  
                        <div class="weui-uploader__bd">  
                            <ul class="weui-uploader__files" id="uploaderFiles">  
                                  
                            </ul>  
                            <div class="weui-uploader__input-box">  
                                <input id="uploaderInput" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">  
                            </div>  
                        </div>  
                    </div>  
                </div>  
            </div>  
        </div>

    <script src="../lib/jquery-2.1.4.js"></script>
<script src="../lib/fastclick.js"></script>
<script>
  $(function() {
    
  });
</script>
<script src="../js/jquery-weui.js"></script>
<script>
  $(function () {  
    // 允许上传的图片类型  
    var allowTypes = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];  
    // 1024KB，也就是 1MB  
    var maxSize = 2048 * 2048;  
    // 图片最大宽度  
    var maxWidth = 10000;  
    // 最大上传图片数量  
    var maxCount = 6;  
    $('#uploaderInput').on('change', function (event) {  
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
              $.weui.alert({text: '最多只能上传' + maxCount + '张图片'});  
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
　　　　　　　　　　　　
                    var base64 = canvas.toDataURL('image/jpeg',0.8);  
                   //console.log(base64);
                    // 插入到预览区  
                    var $preview = $('<li class="weui-uploader__file weui-uploader__file_status" style="background-image:url(' + img.src + ')"><div class="weui-uploader__file-content">0%</div></li>');  
                    $('#uploaderFiles').append($preview);  
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
                                    contentType:false,                                
                                    processData:false, 
                                    success: function(data){ 
                                            $preview.removeClass('weui-uploader__file_status');
                                            $.toast("上传成功");
                                },
                                error: function(xhr, type){
                                alert('Ajax error!')
                                }
                                    }); 
                      };            
                    };  
                    
                  }  
                });  
  }); 
</script>
  </body>
</html>