layui.config({
    base: "/js/"
}).use(['form', 'vue', 'ztree', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils'], function () {
    var form = layui.form,
        layer = layui.layer,
        $ = layui.jquery;
    var table = layui.table;
    var openauth = layui.openauth;

    $("#menus").loadMenus("Message");

    //主列表加载，可反复调用进行刷新
    var config = {};  //table的参数，如搜索key，点击tree的id
    var mainList = function (options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList', {
            url: '/Message/GetMessageList',
            where: config,
            done: function (res, curr, count) {
                $("[data-field='Id']").css('display', 'none');
                $("[data-field='MsgContent']").each(function () {
                    var content = $(this).children(".laytable-cell-2-MsgContent").text();
                    if (content.length > 40) {
                        var subcontent = "<span title='" + content + "'>" + content.substring(0, 39) + "...</span>";
                        $(this).html(subcontent);
                    }

                })
            }
        });
    }

    //添加（编辑）对话框
    var editDlg = function () {

    }();

    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'ToRecevice') {      //标记已读
            $.post('/Message/UpdateToRecevice',
                       { id: data.Id },
                       function (resdata) {
                           layer.msg(resdata.Message);
                       },
                       "json");

        }
    });
     
    //监听页面主按钮操作
    var active = {
        //btnDel: function () {      //批量删除
        //    var checkStatus = table.checkStatus('mainList')
        //        , data = checkStatus.data;
        //    openauth.del("/Message/Delete",
        //        data.map(function (e) { return e.Id; }),
        //        mainList);
        //},
        btnToRecevice: function () {  //编辑
             var checkStatus = table.checkStatus('mainList')
               , data = checkStatus.data;
             var ids = data.map(function (e) { return e.Id; })
             $.post('/Message/UpdateToRecevice',
                      { ids: ids },
                      function (resdata) {
                          layer.msg(resdata.Message);
                      },
                      "json"); 
         } 
        , btnRefresh: function () {
            mainList();
        }

    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end
})