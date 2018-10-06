layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils', 'upload'], function () {
    var form = layui.form,
        layer = layui.layer,
        upload = layui.upload,
        $ = layui.jquery;

    var table = layui.table;
    var openauth = layui.openauth;

    //加载左边报表 ，可反复调用进行刷新
    var leftConfig = {};  //table的参数，如搜索key，点击tree的id
    var leftMainList = function (options) {
        if (options != undefined) {
            $.extend(leftConfig, options);
        }
        table.reload('leftMainList', {
            url: '/SEOrders/GetSeOrderList',
            where: leftConfig
        });
    }
    
    //绑定查询按钮事件 
    $('#searchKey').bind('keypress', function (event) {
        if (event.keyCode == 13) {
            leftMainList({ key: $('#searchKey').val() });
        }
    });

    //加载可操作按钮
    $("#menus").loadMenus("ProductFeedOrder");

    //右边边列表加载，可反复调用进行刷新
    var rightConfig = {};  //table的参数，如搜索key，点击tree的id
    var rightMainList = function (options) {
        if (options != undefined) {
            $.extend(rightConfig, options);
            table.reload('rightMainList', {
                url: '/ProductFeedOrder/GetProFeedData',
                where: rightConfig,
                done: function (res, curr, count) {

                    if (count > 0) {
                        var data = res.data[0];
                        $("#ContactNo").text(data.FHeadSelfS0155);
                        $("#FItemID").val(data.FItemID);

                        $("#CustomName").text(data.ClientName);
                        $("#Remark").text(data.FNote);
                        $("#BillNo").text(data.FBillNo);
                        $("#MO").text(data.pro_OutSourceOrder);
                        $("#FeedOrder").text(data.productFeed);
                        $("#ProNumber").text(data.FNumber);
                        $("#ProName").text(data.FName);
                        $("#Qty").text(data.FHeadSelfS0151);
                        $("#RId").val(data.RecordId);
                        $("#FEntryID").val(data.FEntryID);

                        var schemeid = data.RecordId;
                        $.post("/Scheme/GetScheme",
                         { schemeid: schemeid },
                          function (data) {
                              $("#MakeRequest").val(data.MakeRequest);
                              $('#imagesArea').attr('src', "/uploadfiles/oldajdimgs/" + data.imagesNew); //图片链接（base64） 
                              $('#imagesNew').val(data.imagesNew); //图片链接（base64） 

                              $("#SchemeRemark").val(data.SchemeRemark);
                              var SchemeName = data.SchemeName;
                              var SchemeMaker = data.SchemeMaker;
                              var SchemeTime = data.SchemeTime;

                              $("#schemeInfo").children("span").remove();
                              var schemeInfo = "<span>当前使用方案：" + SchemeName + " " + SchemeMaker + "  " + SchemeTime + "</span>";
                              $("#schemeInfo").append(schemeInfo);
                          },
                          "json");
                    }
                }
            });
        } else {
            $("#FItemID").val("");
            $("#RId").val("");
            $("#ContactNo").text("");
            $("#CustomName").text("");
            $("#Remark").text("");
            $("#BillNo").text("");
            $("#MO").text("");
            $("#FeedOrder").text("");
            $("#ProNumber").text("");
            $("#ProName").text("");
            $("#Qty").text("");
            $("#MakeRequest").val("");
            $("#imagesArea").html("");
            $("#SchemeRemark").val("");
            $("#FEntryID").val("");

            $("#schemeInfo").children("span").remove();
            $('#imagesNew').val();
        }
    }

    $("#tree").height($("div.layui-table-view").height());

    //普通图片上传
    var uploadInst = upload.render({
        elem: '#btnupdate'
      , url: '/Scheme/uploadFile'
      , before: function (obj) {
          if ($("#RId").val() == "") {
              return layer.msg('请先选择销售订单行');
          }
          //预读本地文件
          obj.preview(function (index, file, result) {
              $('#imagesArea').attr('src', result); //图片链接（base64）
          });
      }
      , done: function (res) {
          //如果上传失败
          if (res.code != 200) {
              return layer.msg('上传失败');
          } else {
              $('#AttachUrl').attr('src', res.Message);
              return layer.msg('上传成功');
          }
          //上传成功
      }
      , error: function () {
          //演示失败状态，并实现重传
          var demoText = $('#demoText');
          demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
          demoText.find('.demo-reload').on('click', function () {
              uploadInst.upload();
          });
      }
    });

    //添加（编辑）对话框
    var editDlg = function () {
        var vm = new Vue({
            el: "#formShow"
        });
        var update = false;  //是否为更新 
        var edit = function (data) {
            var url = "/Scheme/Add";
            if (update) {
                url = "/Scheme/Update"; //暂时和添加一个地址
            }
            var postdata = {
                RecordId: $("#RId").val(),
                MakeRequest: $("#MakeRequest").val(),
                imagesNew: $("#imagesNew").val(),
                SchemeRemark: $("#SchemeRemark").val(),
                FBillNo: $("#BillNo").val(),
                FEntryID: $("#FEntryID").val(),
                FItemID: $("#FItemID").val(),
            };
            $.post(url,
                      postdata,
                      function (data) {
                          layer.msg(data.Message);
                      },
                      "json");
        }
        return {
            add: function () { //弹出添加
                update = false;
                edit({
                    RId: ''
                });
            },
            update: function (data) { //弹出编辑框
                update = true;
                edit(data);
            }
        };
    }();

    //监听表格内部按钮
    //table.on('tool(list)', function (obj) {
    //    var data = obj.data;
    //    if (obj.event === 'ShowDetail') {      //展示右边数据 
    //        var BillNo = data.FBillNo;
    //        var EntryID = data.FEntryID;
    //        rightMainList({ BillNo: BillNo, EntryID: EntryID });
    //    }
    //});
    //table.on('row(leftMainList)', function (obj) {
    //   alert("2222");
    //});

    table.on('tool(leftMainList)', function (obj) {
    
        var data = obj.data;
        if (obj.event === 'show') {      //展示右边数据 
            var BillNo = data.FBillNo;
            var EntryID = data.FEntryID;
            rightMainList({ BillNo: BillNo, EntryID: EntryID });
        }
    });

    //监听页面主按钮操作
    var active = {
        btnQuery: function () { //查询
            leftMainList({ key: $('#searchKey').val() });
        }
        , btnSchemeManage: function () {  //方案管理    
            if ($("#RId").val() == "") {
                editDlg.add();
            } else {
                editDlg.update();
            }
        }
         , btnSend: function () {  //下达
             var FEntryID = $("#FEntryID").val();
             var BillNo = $("#BillNo").text();
             if (FEntryID == "" || BillNo == "") {
                 layer.msg("请先选择需要下达的行");
                 return;
             } 
             var postdata = {
                 FEntryID: FEntryID,
                 BillNo: BillNo
             }; 
             $.post('/PBOM/SendBom',
                     postdata,
                     function (resdata) {
                           layer.msg(resdata.Message);
                       },
                    "json");
         }
        , btnRefresh: function () {
            leftMainList();
            RightMainList();
        }
        , btnChekScheme: function () {
            var FEntryID = $("#FEntryID").val();
            var BillNo = $("#BillNo").text();
            if (FEntryID == "" || BillNo == "") {
                layer.msg("请先选择需要下达的行");
                return;
            } 
            layer.open({
                title: "方案详细=>>" + BillNo + "_" + FEntryID,
                area: ["500px", "600px"],
                type: 1,
                content: $('#divEdit'),
                success: function () {
                  
                } 
            });
        }
        
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end
})