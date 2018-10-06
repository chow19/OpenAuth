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
            url: '/PMC_MasterProductSchedule/GetPMC_MasterProductScheduleList',
            where: leftConfig,
            done: function (res, curr, count) {
                $("[data-field='Id']").css('display', 'none');

            }
        });
    };
    leftMainList();

    var checkfun = function () {
        if ($("#closedOnly").val() == "1") {
            $("#closedOnly").val("0");
            $("#closedOnly").find("input[type='checkbox']").prop("checked", false);

        } else {
            $("#closedOnly").val("1");
            $("#closedOnly").find("input[type='checkbox']").prop("checked", true);
        }
    }

    $("#closedOnly").change(function () {
        checkfun();
    });

    //绑定查询按钮事件 
    $('#searchKey').bind('keypress', function (event) {
        if (event.keyCode == 13) {
            leftMainList({ key: $('#searchKey').val(), isOk: $("#closedOnly").val() });
        }
    });

    //绑定查询按钮事件 
    $('#btnQuery').click(function () {
        table.reload('totalList2', {
            url: '/PMC_MasterProductSchedule/GetPMC_OweTotal',
            where: { FNumber: $("#FNumber2").val() },
            done: function (res, curr, count) {
                $("#totalmsg2").text(res.msg);
            }
        });
    });

    //加载可操作按钮
    $("#menus").loadMenus("PMC_MasterProductSchedule");

    //右边边列表加载，可反复调用进行刷新
    var rightConfig = {};  //table的参数，如搜索key，点击tree的id
    var rightMainList = function (options) {
        if (options != undefined) {
            $.extend(rightConfig, options);
            table.reload('rightMainList', {
                url: '/PMC_MasterProductSchedule/GetPMC_MasterProductScheduleBomList',
                where: rightConfig,
                done: function (res, curr, count) {
                    if (count > 0) {

                    }
                }
            });
        } else {
            $("#BillNo").text("");
            $("#CustomName").text("");
            $("#FNumber").text("");
            $("#FName").text("");
            $("#DealLine").text("");
            $("#AuxQty").text("");
        }
    }

    var totalListConfig = {}
    var totalListConfig = function (options) {
        if (options != undefined) {
            $.extend(rightConfig, options);
            table.reload('totalList', {
                url: '/PMC_MasterProductSchedule/GetPMC_OweTotal',
                where: rightConfig,
                done: function (res, curr, count) {
                    $("#totalmsg").text(res.msg);
                }
            });
        } else {
            $("#totalmsg").text("");
        }
    }

    $("#tree").height($("div.layui-table-view").height());

    //监听表格内部按钮
    table.on('tool(list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'ShowDetail') {      //展示右边数据 
            var Mid = data.Id;

            $("#BillNo").text(data.SEOrder);
            $("#CustomName").text(data.CustomerName);
            $("#FNumber").text(data.FNumber);
            $("#FName").text(data.FName);
            $("#DealLine").text(data.DealLine);
            $("#AuxQty").text(data.AuxQty);

            rightMainList({ MId: Mid });
        } else if (obj.event == 'showTotal') {
            //$("#StoreQty").text(data.FName + "=>" + data.StockQty);
            totalListConfig({ FNumber: data.FNumber })
        }

    });

    //监听页面主按钮操作
    var active = {
        btnQueryOwe: function () { 
            $("#totalmsg2").text("");
            layer.open({
                title: "欠领查询",
                area: ["600px", "400px"],
                type: 1,
                content: $('#divQuery'),
                success: function () { 
                    
                } 
            });
        } ,
        btnQuery: function () { //查询
            leftMainList({ key: $('#searchKey').val(), isOk: $("#closedOnly").val() });
        },
        btnSync: function () {  //手工同步数据
             $.post('/PMC_MasterProductSchedule/StrongeSync',
                       { id: '' },
                       function (resdata) {
                           layer.msg(resdata.Message);
                       },
                       "json");
         }
        , btnRefresh: function () {
            leftMainList();
            rightMainList();
            totalListConfig();
        }

    };

    $('.toolList .layui-btn').on('click', function () {
        var type = $(this).data('type');
 
        active[type] ? active[type].call(this) : '';
    });

    //监听页面主按钮操作 end
})