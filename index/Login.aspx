<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="index_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>登陆</title>
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
            if (isWeiXin()) {
                $.get("control/WeixinAuthorization.ashx", null, function (data) {
                })
            }
        }

        function check() {
            var tel = $('#tel').val();
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号格式有误!");
                return false;
            }
            var str = document.getElementById("pass").value;
            if (str.length < 6) {
                alert('对不起，您的密码小于六位!');
                return false;

            }
        }


        function getCode() {
            var tel = $('#tel').val();
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号格式有误!");
                return;
            }
            $.ajax({
                url: "http://api.lvwei8.com/api/Message/SendPhoneCode",
                data: {
                    "clientCommonInfo": {
                        "areaCode": "410100", "board": "PLK-TL01H", "brand": "HONOR", "currentUserId": 5802897,
                        "deviceId": "867628027609429", "isOffical": false, "lat": 34.819557, "lng": 113.690696, "model": "PLK-TL01H", "product": "PLK-TL01H", "sdk": "6.0", "terminalSource": 2, "terminalSourceVersion": "1.2.91"
                    },
                    "param":tel
                },
                dataType: "json",
                type: "post",
                success: function (databack) {
              
                        timer(60);
                   
                },
                error: function () { alert("服务器异常"); }
            });
        

            //$.post('control/sendCodeByPhone.aspx', { "mobile": tel }, function (data, status) {
            //    // do something
            //    //result = eval(data);
            //    //if (result.code == "0") {
            //    //    alert(result.data);
            //    //    //置灰
            //    //    timer(60)

            //    //}
            //    //else {
            //    //    alert(result.data);
            //    //}
            //    timer(60);
            //});
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
              <h1 class="title">快速登录</h1>
          </header>
                <div class="content login">
                    <div class="list-block">
                        <ul>
                            <li><i class="iconfont">&#xe648;</i><input name="tel" id="tel" required type="number" placeholder="请输入手机号"></li>
                            <%--                            <li><i class="iconfont">&#xe643;</i><input name="pass" id="pass" required type="password" placeholder="请输入密码"></li>--%>
                            <li><i class="iconfont">&#xe64a;</i>
                                <input type="text" name="code" placeholder="请输入验证码" />
                                <input class="get2" style="border: none" type="button" onclick="getCode()" id="btn" value="获取验证码" />
                            </li>
                            <li class="login_btn">
                                <input type="submit" value="登录" /></li>
                            <li class="registration"><a class="external" href="#">一个月之内免登录</a></li>
                        </ul>
                    </div>
                    <%-- <div class="find_password">
                        <a href="lost_password.html">忘记密码</a>
                    </div>--%>
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
