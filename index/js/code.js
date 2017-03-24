/** 全局基础配置 **/
var openId = '';
var apiPrefix = 'http://api.lvwei8.com/api/';
var clientCommonInfo = {"areaCode":"410100","board":"PLK-TL01H","brand":"HONOR","currentUserId":5802897,
"deviceId":"867628027609429","isOffical":false,"lat":34.819557,"lng":113.690696,"model":"PLK-TL01H","product":"PLK-TL01H","sdk":"6.0","terminalSource":2,"terminalSourceVersion":"1.2.91"};

Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function fetch(api, type, options, success) {
  options.data.clientCommonInfo = clientCommonInfo;
  options.data.syncId = new Date().Format('yyyy-MM-dd hh:mm:ss');
  options.data.clientCommonInfo.openId = openId;
  $.ajax({
    url: apiPrefix + api,
    type: type || 'POST',
    data: JSON.stringify(options.data),
    contentType: 'application/json',
    dataType: 'json',
    success: success
  });
}

/** 辅助方法：获取URL参数 **/
function getQueryStringByName(name) {
  var result = location.search.match(new RegExp("[\?\&]" + name+ "=([^\&]+)","i"));
  if (result == null || result.length < 1) {
    return "";
  }
  return result[1];
}

$(function() {
  /** 保存微信传来的code **/
  var code = getQueryStringByName('code');
  if (code) {
    fetch('Account/GetUser', 'POST', {
      data: {
        param: { code: code }
      }
    }, function(res) {
      if (res.result && res.result.openId) {
        openId = res.result.openId;
        localStorage.setItem('lvwei8_wx_code', openId);
      }
      if (typeof init !== 'undefined') init();
    });
  } else {
    openId = localStorage.getItem('lvwei8_wx_code');
    if (typeof init !== 'undefined') init();
  }
});
