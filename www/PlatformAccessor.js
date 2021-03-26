function PlatformAccessor(){}

PlatformAccessor.prototype.getLang = function (successCallback, errorCallback) {
	cordova.exec(successCallback, errorCallback, "PlatformAccessor", "getLang", []);
};

PlatformAccessor.prototype.getUid = function (successCallback, errorCallback) {
	cordova.exec(successCallback, errorCallback, "PlatformAccessor", "getUid", []);
};

PlatformAccessor.prototype.getPlatformData = function (successCallback, errorCallback) {
	cordova.exec(successCallback, errorCallback, "PlatformAccessor", "getPlatformData", []);
};

PlatformAccessor.prototype.minimize = function () {
	cordova.exec(function(){}, function(){}, "PlatformAccessor", "minimize", []);
};

PlatformAccessor.prototype.initWebView = function (successCallback, errorCallback, options) {
	cordova.exec(successCallback, errorCallback||successCallback, "PlatformAccessor", "initWebView", [options]);
};

PlatformAccessor.install = function () {
	if( !cordova.plugins )
		cordova.plugins = {};
	
	cordova.plugins.platformAccessor = new PlatformAccessor();
	
	return cordova.plugins.platformAccessor;
};

cordova.addConstructor(PlatformAccessor.install);
	