<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="QMS_WebSite.test" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

    <link href="Scripts/mui/mui.min.css" rel="stylesheet" />
    <link href="Scripts/jquery-weui/lib/weui.min.css" rel="stylesheet" />
    <link href="Scripts/jquery-weui.css" rel="stylesheet" />
</head>
<body>
    <div class="weui-gallery" id="gallery">
        <span class="weui-gallery__img" id="galleryImg"></span>
        <div class="weui-gallery__opr">
            <a href="javascript:" rel="external nofollow" class="weui-gallery__del">
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
                        <div class="weui-uploader__info">0/2</div>
                    </div>
                    <div class="weui-uploader__bd">
                        <ul class="weui-uploader__files" id="uploaderFiles">
       
                            <li class="weui-uploader__file" style="background-image: url(../images/applogo180x180.gif)"></li>
                            <li class="weui-uploader__file" style="background-image: url(../images/applogo180x180.gif)"></li>
                            <li class="weui-uploader__file" style="background-image: url(../images/applogo180x180.gif)"></li>
                            <li class="weui-uploader__file weui-uploader__file_status" style="background-image: url(../images/applogo180x180.gif)">
                                <div class="weui-uploader__file-content">
                                    <i class="weui-icon-warn"></i>
                                </div>
                            </li>
                            <li class="weui-uploader__file weui-uploader__file_status" style="background-image: url(../images/applogo180x180.gif)">
                                <div class="weui-uploader__file-content">50%</div>
                            </li>
                        </ul>
                        <div class="weui-uploader__input-box">
                            <input id="uploaderInput" class="weui-uploader__input zjxfjs_file" type="file" accept="image/*" multiple="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


   


    <script src="Scripts/mui/mui.min.js"></script>
    <script src="Scripts/jquery-2.1.4.js"></script>
    <script src="Scripts/jquery-weui.js"></script>
    <script type="text/javascript">
        mui.init();
        $(function () {
            var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
              $gallery = $("#gallery"),
              $galleryImg = $("#galleryImg"),
              $uploaderInput = $("#uploaderInput"),
              $uploaderFiles = $("#uploaderFiles");
            $uploaderInput.on("change", function (e) {
                var src, url = window.URL || window.webkitURL || window.mozURL,
                  files = e.target.files;
                for (var i = 0, len = files.length; i < len; ++i) {
                    var file = files[i];
                    if (url) {
                        src = url.createObjectURL(file);
                    } else {
                        src = e.target.result;
                    } 
                    $uploaderFiles.append($(tmpl.replace('#url#', src)));
                }
            });
            var index; //第几张图片
            $uploaderFiles.on("click", "li", function () {
                index = $(this).index();
                $galleryImg.attr("style", this.getAttribute("style"));
                $gallery.fadeIn(100);
            });
            $gallery.on("click", function () {
                $gallery.fadeOut(100);
            });
            //删除图片 删除图片的代码也贴出来。
            $(".weui-gallery__del").click(function () { //这部分刚才放错地方了，放到$(function(){})外面去了
                console.log('删除');
                $uploaderFiles.find("li").eq(index).remove();
            });
        });
    </script>
</body>
</html>
