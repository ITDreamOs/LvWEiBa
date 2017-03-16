<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bindCode.aspx.cs" Inherits="index_bindCode" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>绑定微信号</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico/">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css" />
    <link rel="stylesheet" href="css/iconfont.css" />
    <link rel="stylesheet" href="css/reset.css" />
    <script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="js/analyse.js" type="text/javascript"></script>
    <style type="text/css">
        .getcode {
            position: absolute;
            top: 0rem;
            right: 0rem;
            height: 2.15rem;
            line-height: 2.15rem;
            padding: 0rem 0.5rem;
            background-color: #ffb300;
            color: #fff;
            font-size: 0.6rem;
        }
    </style>
    <script type="text/javascript">
        function isWeiXin() {
            var ua = window.navigator.userAgent.toLowerCase();
            if (ua.match(/MicroMessenger/i) == 'micromessenger') {
                return true;
            } else {
                return false;
            }
        }
        window.onload = function () {
            if (!isWeiXin()) {
                window.location.href = "Login.aspx";
            }
        }

        function check() {
            var tel = $('#tel').val();
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号格式有误!");
                return false;
            }
        }


        function getCode() {
            var tel = $('#tel').val();
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号格式有误!");
                return;
            }
            $.post('control/sendCodeByPhone.aspx', { "mobile": tel }, function (data, status) {
                // do something
                //result = eval(data);
                //if (result.code == "0") {
                //    alert(result.data);
                //    //置灰
                //    timer(60)

                //}
                //else {
                //    alert(result.data);
                //}
                timer(60);
            });
        }

        function timer(time) {
            var btn = $("#btn");
            btn.attr("disabled", true);  //按钮禁止点击
            btn.val(time <= 0 ? "点击获取验证码" : ("" + (time) + "秒后可发送"));
            var hander = setInterval(function () {
                if (time <= 0) {
                    clearInterval(hander); //清除倒计时
                    btn.val("点击获取验证码");
                    //                  btn.attr("disabled", false);
                    btn.removeAttr('disabled');

                    return false;
                } else {
                    btn.val("" + (time--) + "秒后可发送");
                }
            }, 1000);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return check()">
        <div class="page-group">
            <!-- 你的html代码 -->
            <div class="page">
                <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">登陆</h1>
          </header>
                <div class="content login">
                    <div class="list-block">
                        <ul>
                            <li><i class="iconfont">&#xe648;</i><input name="tel" id="tel" required type="number" placeholder="请输入手机号"></li>
                            <li><i class="iconfont">&#xe64a;</i>
                                <input type="text" name="code" placeholder="请输入验证码" />
                                <input class="getcode" type="button" style="width: 200px" onclick="getCode()" id="btn" value="点击获取验证码" />
                            </li>
                            <li class="login_btn">
                                <input type="submit" value="立即绑定" /></li>
                            <li class="registration"><a class="external" href="Default.aspx">返回首页</a></li>
                        </ul>
                    </div>
                </div>
                <!-- content -->
            </div>
            <!-- page -->
        </div>
    </form>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
</body>
</html>
