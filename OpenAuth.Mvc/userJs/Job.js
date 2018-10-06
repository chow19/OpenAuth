layui.config({
    base: "/js/"
}).use(['form', 'vue', 'layer', 'jquery', 'table', 'droptree', 'openauth', 'utils', 'laydate'], function () {
    var form = layui.form,
        layer = layui.layer,
        laydate = layui.laydate, //日期
        $ = layui.jquery;
    var table = layui.table;

    var openauth = layui.openauth;
    var toplayer = (top == undefined || top.layer === undefined) ? layer : top.layer;  //顶层的LAYER
    
    $("#menus").loadMenus("Job");

    //日期时间选择器
    laydate.render({
        elem: '#StartDateTime'
      , type: 'datetime' 
      //, done: function (value, date) {
      //    layer.alert('你选择的日期是：' + value + '<br>获得的对象是' + JSON.stringify(date));
      //}
    });

    laydate.render({
        elem: '#EndDateTime'
     , type: 'datetime'
     //, done: function (value, date) {
     //    layer.alert('你选择的日期是：' + value + '<br>获得的对象是' + JSON.stringify(date));
     //}
    });

    //主列表加载，可反复调用进行刷新
    var config = {};  //table的参数，如搜索key，点击tree的id
    var mainList = function (options) {
        if (options != undefined) {
            $.extend(config, options);
        }
        table.reload('mainList', {
            url: '/Job/GetTaskDataTable',
            where: config,
            done: function (res, curr, count) {
                $("[data-field='Id']").css('display', 'none'); 
            }
        });
    }
    
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
                area: ["600px", "730px"],
                type: 1,
                content: $('#divEdit'),
                success: function () {
                    vm.$set('$data', data);
                    $("#StartDateTime").val(data.StartDateTime);
                    $("#EndDateTime").val(data.EndDateTime);
                    $("#TaskType").val(data.TaskType); 
                    $("#TiggerType").val(data.TiggerType);
                    $("#DataType").val(data.DataType); 
                    $('input:checkbox[name="IsUse"]').prop('checked', data.IsUse == true);

                    form.render();
                },
                end: mainList
            });
            var url = "/Job/Add";
            if (update) {
                url = "/Job/Update"; //暂时和添加一个地址
            }
            //提交数据
            form.on('submit(formSubmit)',
                function (data) {  
                    $('input:checkbox[name="IsUse"]').prop('checked') == true ? data.field.IsUse = true : data.field.IsUse = false; 
                    $.post(url,
                        data.field,
                        function (data) {
                            layer.msg(data.Message);
                        },
                        "json");
                    return false;
                });
        }
        return {
            add: function () { //弹出添加
                update = false;
                show({
                    Id: ''
                });
            },
            update: function (data) { //弹出编辑框
                update = true;
                show(data);
            }
        };
    }();

    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'detail') {      //查看
            layer.msg('ID：' + data.Id + ' 的查看操作');
        }
    });

    //监听页面主按钮操作
    var active = {
        btnDel: function () {      //批量删除
            var checkStatus = table.checkStatus('mainList')
                , data = checkStatus.data;
            openauth.del("/job/Delete",
                data.map(function (e) { return e.Id; }),
                mainList);
        }
        , btnAdd: function () {  //添加 
            editDlg.add();
        }
        , btnEdit: function () {  //编辑
             var checkStatus = table.checkStatus('mainList')
               , data = checkStatus.data;
             if (data.length != 1) {
                 layer.msg("请选择编辑的行，且同时只能编辑一行");
                 return;
             }
             editDlg.update(data[0]);
         }
        , search: function () {   //搜索
            mainList({ key: $('#key').val() });
        }
     
        
    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end
})