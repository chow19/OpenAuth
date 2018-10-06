function getPostVal(form){
    var pval = form.elements;
    var res = {};
    var propertyname;
    for (var i = 0; i < pval.length; i++) {
        propertyname = pval[i].name;
        if (propertyname == null || propertyname == "") {
            propertyname = pval[i].id;
        }
        if ((pval[i].type == "radio") && pval[i].checked == false) {
            continue;
        }
        if (pval[i].type == "checkbox" && pval[i].checked == false) {
        	res[pval[i].name ? pval[i].name : pval[i].id] = "";
        }else{
        	res[pval[i].name ? pval[i].name : pval[i].id] = pval[i].value;
        }
    }
    return res;
};

//序列化表单数组  
$.fn.formSerialize = function (formdate) {
    var element = $(this);
    if (!!formdate) {
        for (var key in formdate) {
            var $id = element.find('#' + key);
            var value = $.trim(formdate[key]).replace(/ /g, '');
            var type = $id.attr('type');
            if ($id.hasClass("select2-hidden-accessible")) {
                type = "select";
            }
            switch (type) {
                case "checkbox":
                    if (value == "true") {
                        $id.attr("checked", 'checked');
                    } else {
                        $id.removeAttr("checked");
                    }
                    break;
                case "select":
                    $id.val(value).trigger("change");
                    break;
                default:
                    $id.val(value);
                    break;
            }
        };
        return false;
    }
    var postdata = {};
    element.find('input,select,textarea').each(function (r) {
        var $this = $(this);
        var id = $this.attr('name');
        var type = $this.attr('type');
        switch (type) {
            case "checkbox":
                postdata[id] = $this.is(":checked");
                break;
            default:
                var value = $this.val() == "" ? " " : $this.val();
                if (!$.request("keyValue")) {
                    value = value.replace(/ /g, '');
                }
                postdata[id] = value;
                break;
        }
    });
    if ($('[name=__RequestVerificationToken]').length > 0) {
        postdata["__RequestVerificationToken"] = $('[name=__RequestVerificationToken]').val();
    }
    return postdata;
};

//获取请求链接的参数值  
$.request = function (name) {
    var search = location.search.slice(1);
    var arr = search.split("&");
    for (var i = 0; i < arr.length; i++) {
        var ar = arr[i].split("=");
        if (ar[0] == name) {
            if (unescape(ar[1]) == 'undefined') {
                return "";
            } else {
                return unescape(ar[1]);
            }
        }
    }
    return "";
}