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
            url: '/PBOM/GetLeftPBOMData',
            where: leftConfig,
            done: function (res, curr, count) {
                $("[data-field='AttachUrl']").css('display', 'none');
                //$("[data-field='Remark']").css('display', 'none');
                $("[data-field='PBOMStates']").css('display', 'none');
                $("[data-field='Id']").css('display', 'none');
            }
        });
    }

    leftMainList();
    //绑定查询按钮事件 
    $('#searchKey').bind('keypress', function (event) {
        if (event.keyCode == 13) {
            leftMainList({ key: $('#searchKey').val() });
        }
    });

    //加载可操作按钮
    $("#menus").loadMenus("PBOM");

    //右边边列表加载，可反复调用进行刷新
    var rightConfig = {};  //table的参数，如搜索key，点击tree的id
    var rightMainList = function (options) {
        if (options != undefined) {
            $.extend(rightConfig, options);
            table.reload('rightMainList', {
                url: '/PBOM/GetRightPBOMData',
                where: rightConfig,
                done: function (res, curr, count) {

                    if (count > 0) {
                        var data = res.data[0];
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
            $("#Remark_").text("");
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

    //添加（编辑）对话框
    var editDlg = function () {
        var vm = new Vue({
            el: "#formEdit"
        });
        var update = false;  //是否为更新
        var show = function (data) {
            var title = update ? "编辑信息" : "添加";
            layer.open({
                title: title,
                area: ["600px", "600px"],
                type: 1,
                content: $('#divEdit'),
                success: function () {
                    vm.$set('$data', data);
                    if (data.AttachUrl != "" && data.AttachUrl != "null") {
                        $('#imagesArea2').attr('src', "/uploadfiles/oldajdimgs/" + data.AttachUrl); //图片链接（base64） 
                    }
                    $("input:checkbox[name='PBOMStates']").prop("checked", data.Status == 1);
                    form.render();
                },
                end: leftMainList
            });
            var url = "";
            if (update) {
                url = "/PBOM/Update"; //暂时和添加一个地址
            }
            //提交数据
            form.on('submit(formSubmit)',
                function (data) { 
                    $.post(url,
                        { Id: $("#Id").val(), AttachUrl: $("#AttachUrl").attr("src"), Remark: $("#Remark").val(), PBOMStates: $("#PBOMStates").val() },
                        function (data) {
                            layer.msg(data.Message);
                        },
                        "json");
                    return false;
                });
        }
        return {
            update: function (data) { //弹出编辑框
                update = true;
                show(data);
            }
        };
    }();

    //普通图片上传
    var uploadInst = upload.render({
        elem: '#btnupdate'
      , url: '/Scheme/uploadFile'
      , before: function (obj) {
          if ($("#Id").val() == "") {
              return layer.msg('请先订单行');
          }
          //预读本地文件
          obj.preview(function (index, file, result) {
              $('#imagesArea2').attr('src', result); //图片链接（base64）
          });
      }
      , done: function (res) {

          //如果上传失败
          if (res.Code != 200) {
              return layer.msg('上传失败');
          } else {
              $('#AttachUrl').attr('src', res.Message);
              return layer.msg('上传成功');

          }

      }
      , error: function () {
          //演示失败状态，并实现重传
          var demoText = $('#AttachUrl');
          demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
          demoText.find('.demo-reload').on('click', function () {
              uploadInst.upload();
          });
      }
    });
     
    //监听单元格编辑
    table.on('edit(rightMainList)', function (obj) {
        var value = obj.value //得到修改后的值
                  , data = obj.data //得到所在行所有键值
                  , field = obj.field; //得到字段 

        $.post("/PBOM/UpdateLine",
                      { field: field, Id: data.Id, value: value },
                       function (data) {
                           layer.msg("修改成功");
                       },
                       "json");

    });

    table.on('row(leftMainList)', function (obj) {
     
            var data = obj.data;
            var Id = data.Id;
            $("#Id").val(Id);
            $("#ContactNo").text(data.ContactNo);
            //$("#FItemID").val(data.FItemID);

            $("#CustomName").text(data.CustomName);
            $("#Remark_").text(data.Remark);
            $("#BillNo").text(data.BillNo);
            $("#MO").text(data.MO);
            $("#FeedOrder").text(data.FeedOrder);
            $("#ProNumber").text(data.ProNumber);
            $("#ProName").text(data.ProName);

            $("#AuxQty").text(data.AuxQty);
            $("#DeadLine").text(data.DeadLine);

            $("#RId").val(data.RecordId);
            $("#FEntryID").val(data.FEntryID);
            rightMainList({ PBOMId: Id });
       
    });

    //监听页面主按钮操作
    var active = {
        btnQuery: function () { //查询
            leftMainList({ key: $('#searchKey').val() });
        }

        , btnRefresh: function () {
            leftMainList();
            rightMainList();
        }
        , btnEdit: function () {
            var checkStatus = table.checkStatus('leftMainList')
             , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg("请选择编辑的行，且同时只能编辑一行");
                return;
            }
            editDlg.update(data[0]);
        }, btnChekScheme: function () {
            var checkStatus = table.checkStatus('leftMainList')
             , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg("请选择查看行");
                return;
            }
            layer.open({
                title: "方案详细=>>" + data[0].BillNo + "_" + data[0].FEntryID,
                area: ["500px", "800px"],
                type: 1,
                content: $('#divShowScheme'),
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