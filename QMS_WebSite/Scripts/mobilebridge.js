//跨平台操作类
var $M = {

    //获取操作系统类型
    getOs: function() {
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        if (bIsAndroid) {
            return "android";
        }
        else if (bIsIphoneOs || bIsIpad) {
            return "ios";
        }
        else {
            return "";
        }
    },

    //打开页面
    open: function(url, title, callback) {
        var os = this.getOs();
        url = this.full_url(url);
        if (typeof callback == "function") {
            callback = getCallbackName(callback);
        }
        if (os == "android") {
            android.open(url, title, callback);
        }
        else if (os == "ios") {
            ios.open(url, title, callback);
        }
    },

    //关闭页面
    close: function(returnValue) {
        var os = this.getOs();
        if (os == "android") {
            android.close(returnValue);
        }
        else if (os == "ios") {
            ios.close(returnValue);
        }
    },

    //关闭页面并刷新
    closeAndReload: function() {
        var os = this.getOs();
        if (os == "android") {
            android.closeAndReload();
        }
        else if (os == "ios") {
            ios.closeAndReload();
        }
    },

    //信息提示框
    alert: function(msg) {
        var os = this.getOs();
        if (os == "android") {
            android.toast(msg);
        }
        else if (os == "ios") {
            //ios.alert(msg);
            alert(msg);
        }
    },

    //加载url
    loadUrl: function(url) {
        var os = this.getOs();
        url = this.full_url(url);
        if (os == "android") {
            android.loadUrl(url);
        }
        else if (os == "ios") {
            ios.loadUrl(url);
        }
    },

    //设置导航栏标题
    setTitle: function(title) {
        var os = this.getOs();
        if (os == "android") {
            android.setTitle(title);
        }
        else if (os == "ios") {
            ios.setTitle(title);
        }
    },

    //设置导航栏按钮
    setButton: function(buttonStr) {
        var os = this.getOs();
        if (os == "android") {
            android.setButton(buttonStr);
        }
        else if (os == "ios") {
            ios.setButton(buttonStr);
        }
    },

    //隐藏导航栏
    hideNaviBar: function() {
        var os = this.getOs();
        if (os == "android") {
            android.hideNaviBar();
        }
        else if (os == "ios") {
            ios.hideNaviBar();
        }
    },

    //显示导航栏
    showNaviBar: function() {
        var os = this.getOs();
        if (os == "android") {
            android.showNaviBar();
        }
        else if (os == "ios") {
            ios.showNaviBar();
        }
    },

    //上传文件
    upload: function(uploadUrl, maxEdgeSize, startback, callback) {
        var os = this.getOs();
        //uploadUrl = this.full_url(uploadUrl);
        if (typeof startback == "function") {
            startback = getCallbackName(startback);
        }
        if (typeof callback == "function") {
            callback = getCallbackName(callback);
        }
        if (os == "android") {
            android.upload(uploadUrl, maxEdgeSize, startback, callback);
        }
        else if (os == "ios") {
            ios.upload(uploadUrl, maxEdgeSize, startback, callback);
        }
    },

    //重新绑定地理位置
    rebindLocations: function(dataUrl) {
        var os = this.getOs();
        if (os == "android") {
            android.close(dataUrl);
        }
        else if (os == "ios") {
            ios.rebindLocations(dataUrl);
        }
    },

    //打开显示点的地图
    openShowPointMap: function(lat, lng, pointname, subInfo_1, subInfo_2) {
        var os = this.getOs();
        if (os == "android") {
            android.openShowPointMap(lat, lng, pointname, subInfo_1, subInfo_2);
        }
        else if (os == "ios") {
            ios.openShowPointMap(lat, lng, pointname, subInfo_1, subInfo_2);
        }
    },

    //扫描二维码
    scanQrcode: function(callback) {
        var os = this.getOs();
        if (typeof callback == "function") {
            callback = getCallbackName(callback);
        }
        if (os == "android") {
            android.scanQrcode(callback);
        }
        else if (os == "ios") {
            ios.scanQrcode(callback);
        }
    },

    //扫描条码
    scanBarcode: function(callback) {
        var os = this.getOs();
        if (typeof callback == "function") {
            callback = getCallbackName(callback);
        }
        if (os == "android") {
            android.scanBarcode(callback);
        }
        else if (os == "ios") {
            ios.scanBarcode(callback);
        }
    },

    //Print
    openPrint: function(printContent, callback) {
        var os = this.getOs();
        if (typeof callback == "function") {
            callback = getCallbackName(callback);
        }
        if (os == "android") {
            android.openPrint(printContent, callback);
        }
        else if (os == "ios") {
            ios.openPrint(printContent, callback);
        }
    },

    //自定义按返回键触发事件
    customBackPressed: function(callback) {
        var os = this.getOs();
        if (typeof callback == "function") {
            callback = getCallbackName(callback);
        }
        if (os == "android") {
            android.customBackPressed(callback);
        }
        else if (os == "ios") {
        }
    },

    //全屏
    fullScreen: function() {
        var os = this.getOs();
        if (os == "android") {
            android.fullScreen();
        }
        else if (os == "ios") {
            ios.fullScreen();
        }
    },

    //退出全屏
    exitFullScreen: function() {
        var os = this.getOs();
        if (os == "android") {
            android.exitFullScreen();
        }
        else if (os == "ios") {
            ios.exitFullScreen();
        }
    },

    //获取好友
    getMyFriends: function() {
        var os = this.getOs();
        if (os == "android") {
            return android.getMyFriends();
        }
        else if (os == "ios") {
            return ios.getMyFriends();
        }
    },

    //处理url为全路径的url，回传到客户端处理
    full_url: function(url) {
        if (url.indexOf("http://") == 0 || url.indexOf("https://") == 0) {
            return url;
        }
        else {
            var tmpurl = location.href;
            return tmpurl.substring(0, tmpurl.lastIndexOf("/") + 1) + url;
        }
    }
};

//deal callback
var i = 0;
var callbacks = [];
function getCallbackName(callback) {
    var tmp = i++;
    callbacks[tmp] = callback;
    return "callbacks[" + tmp + "]";
}
