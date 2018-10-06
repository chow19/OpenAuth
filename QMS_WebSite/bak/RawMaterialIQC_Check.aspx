<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RawMaterialIQC_Check.aspx.cs" Inherits="QMS_WebSite.RawMaterialIQC_Check" %>

 
<!DOCTYPE html>
<html>
 <head  >
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

      <link rel="stylesheet" href="css/page.css"/>
      <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.min.css"/>
      <link rel="stylesheet" href="scripts/jquery-weui/lib/weui.css"/>
      <script src="scripts/jquery_1.6.3.js"></script>
      <script src="scripts/jquery.lazyload.min.js"></script>
      <script src="scripts/comm.js"></script>
      <script src="scripts/mobilebridge.js?1"></script>
      <script src="scripts/jquery-weui/js/jquery-weui.js"></script>  
      <script type="text/javascript" src="scripts/jquery-weui/js/mui.min.js"></script>  
      <script type="text/javascript" src="scripts/jquery-weui/js/jquery.min.js"></script>  



      <style>

          .myTitles{
              color:darkblue;
              font-size:20px;
              font-weight:700;
          } 
          .in_Bdy{
              font-size:20px; 
          } 
          .seg_style{
               font-size:20px;
          }
           .myOwn{
            width:50%; 
          }

           .lb_style{
               font-size:20px;
           }

           .NG_Select{
               color:red;
           }
            
      </style> 

     <script>
         function onselected(sel)
         { 
              try {
                 alert($(".weui - select").find("option:selected").text());
                 alert(sel.value);
             }catch(e)
             {
                 alert(e.description);
             }
         }
         $(".my-select").change(function (index,element) {
             alert($(".my-select").find("option:selected").text());
         });
     </script>
</head>
<body>
      <div class="weui-cells__tips tltles myTitles">透光率</div>
      <div class="weui-cells weui-cells_form seg_style">
              <div class="weui-cell in_Bdy ">
                <div class="weui-cell__hd  "><label class="weui-label">UV</label></div>
                <div class="weui-cell__bd">
                      <input class="weui-input  " type="text"   placeholder="UV">
                 </div>
                   
                 <div class="weui-cell__bd"><label class="weui-label ">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_UV" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div>

              <div class="weui-cell in_Bdy">
                <div class="weui-cell__hd   "><label class="weui-label">VL</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input  " type="text"   placeholder="VL">
                </div>
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_VL" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                </div>
                  

              </div>

              <div class="weui-cell in_Bdy">
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
      
      <div class="weui-cells__tips tltles myTitles">厚度</div>
      <div class="weui-cells weui-cells_form">
              <div class="weui-cell in_Bdy ">
                <div class="weui-cell__hd  "><label class="weui-label">总厚度</label></div>
                <div class="weui-cell__bd">
                      <input class="weui-input" type="text"   >
                 </div>
                   
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_ZHD" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div>

              <div class="weui-cell in_Bdy">
                <div class="weui-cell__hd   "><label class="weui-label">保护层厚度</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input  " type="text"   placeholder="">
                </div>
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_BHCHD" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                </div>
                  

              </div>
          
              <div class="weui-cell in_Bdy">
                <div class="weui-cell__hd"><label class="weui-label">使用层厚度</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="text"   placeholder="">
                </div>

                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_SYCHD" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div> 

              <div class="weui-cell in_Bdy">
                <div class="weui-cell__hd"><label class="weui-label">离型膜厚度</label></div>
                <div class="weui-cell__bd">
                  <input class="weui-input" type="text"   placeholder="">
                </div>

                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_LXMHD" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div> 

      </div>
      
      
       <div class="weui-cells__tips tltles myTitles">硬度500g</div>
       <div class="weui-cell in_Bdy"> 
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_YD5" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div> 
       </div> 
       
       <div class="weui-cells__tips tltles myTitles">耐磨500g</div>
       <div class="weui-cell in_Bdy"> 
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_NM5" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div> 
       </div> 
       
       
       <div class="weui-cells__tips tltles myTitles">擦边500g</div>
       <div class="weui-cell in_Bdy"> 
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_CB5" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div> 
       </div> 
        
        <div class="weui-cells__tips tltles myTitles">初粘力 </div>
        <div class="weui-cells weui-cells_form">
            <div class="weui-cell in_Bdy ">
                <div class="weui-cell__hd  "><label class="weui-label">初粘力</label></div>
                <div class="weui-cell__bd">
                      <input class="weui-input  " type="text"   >
                 </div>
                   
                 <div class="weui-cell__bd"><label class="weui-label">图片</label></div>
                 <div class="weui-uploader__input-box">
                        <input id="img_CZL" class="weui-uploader__input" type="file" accept="image/*" multiple="">
                 </div>
                  
              </div> 
        </div>

        <div class="weui-cells__tips tltles myTitles">百格测试</div>
        <div class="weui-cells weui-cells_form">
              <div class="weui-cell"> 
                 <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label lb_style">百格测试</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select my-select" name="select2" id="Selected_BHCS" onchange="onselected(this)">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div>
                </div>
                  <div class="weui-cell__hd"><label class="weui-label lb_style">图片</label></div>
                  <div class="weui-uploader__input-box">
                        <input id="img_BGCE" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                  </div>

               </div> 
           </div>

        <div class="weui-cells__tips tltles myTitles">高低温保存测试</div>
        <div class="weui-cells weui-cells_form">
              <div class="weui-cell"> 
                 <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label lb_style">撕开保护层</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select" name="select2" onchange="onselected(this)">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div>
                </div>
                  <div class="weui-cell__hd"><label class="weui-label lb_style">图片</label></div>
                  <div class="weui-uploader__input-box">
                        <input id="img_SKBHC" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                  </div>

               </div> 
              
              <div class="weui-cell">
                <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label lb_style">撕开离型层</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="select2" onchange="onselected(this)">
                            <option value="1">OK</option>
                            <option value="2" class="NG_Select">NG</option>
                        </select>
                    </div>
                </div>
                <div class="weui-cell__hd">
                    <label class="weui-label lb_style">图片</label></div>
                <div class="weui-uploader__input-box">
                    <input id="img_SKLXC" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                </div> 
            </div>
            
              <div class="weui-cell">
                <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label lb_style">撕开使用层</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="select2" onchange="onselected(this)">
                            <option value="1">OK</option>
                            <option value="2" class="NG_Select">NG</option>
                        </select>
                    </div>
                </div>
                <div class="weui-cell__hd">
                    <label class="weui-label lb_style">图片</label>
                </div>
                <div class="weui-uploader__input-box">
                    <input id="img_SKSYC" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                </div> 
            </div> 
             
          </div>
        
        <div class="weui-cells__tips tltles myTitles">试贴</div>
        <div class="weui-cells weui-cells_form">
              <div class="weui-cell"> 
                 <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label lb_style">D65彩虹纹</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select" name="select2" onchange="onselected(this)">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div>
                </div>
                  <div class="weui-cell__hd"><label class="weui-label lb_style">图片</label></div>
                  <div class="weui-uploader__input-box">
                        <input id="img_D65CHC" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                  </div>

               </div> 
            
              <div class="weui-cell"> 
                 <div class="weui-cell weui-cell_select weui-cell_select-after myOwn">
                   <div class="weui-cell__hd">
                      <label for="" class="weui-label lb_style">CWF彩虹纹</label>
                  </div>
                  <div class="weui-cell__bd">
                         <select class="weui-select" name="select2" onchange="onselected(this)">
                             <option value="1">OK</option>
                             <option value="2" class="NG_Select">NG</option> 
                         </select>
                  </div>
                </div>
                  <div class="weui-cell__hd"><label class="weui-label lb_style">图片</label></div>
                  <div class="weui-uploader__input-box">
                        <input id="img_CWECHC" class="weui-uploader__input" type="file" accept="image/*" multiple="" onselect="">
                  </div>

               </div> 
         </div>

    <form id="form1" runat="server">
         <asp:HiddenField ID="SQCID" runat="server" />
    </form>
</body>
</html>

