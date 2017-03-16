<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CouponForNinety.aspx.cs" Inherits="index_CouponForNinety" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!-- Required meta tags always come first -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <link rel="stylesheet" href="https://npmcdn.com/basscss@8.0.1/css/basscss.min.css" media="all" title="no title" charset="utf-8">
    <link rel="stylesheet" href="css/bindPhone.css" media="all" title="no title" charset="utf-8">
    <script src="js/jquery-1.8.2.min.js"></script>
    <script src="http://res.mail.qq.com/mmr/static/lib/js/jquery.js" type="text/javascript"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
    <title>领取90元代金券</title>
</head>
<body>
    <div id="main-container" class="clearfix">
        <div class="col-12 mt4 clearfix">
            <div class="col-10 right z1 relative" id="daijinquan">
                <p class="absolute z2 price m0">￥90</p>
                <img class="col-12 z1" src="images/image-daijinquan.png" alt="" />
            </div>
        </div>
        <div class="col-12 mt3">
            <form id="form1" class="col-10 mx-auto border-box px2" method="post" runat="server">
                <input class="col-12 border-box p1 mt1 mb1 center h4" type="tel" name="tel" id="tel" placeholder="输入手机号领取奖品" value="" />
                <div class="relative">
                    <input class="col-12 border-box p1 mt1 mb1 pl2 h4" type="num" name="code" id="code" placeholder="输入验证码" value="" />
                    <input class="col-7 absolute border-box mt1 py1 mb1 px2 h4" type="button" onclick="getCode()" name="btn" id="btn" value="点击获取验证码" />
                </div>
                <input class="col-12 mt1 block" type="submit" style="background: url(images/image-button.jpg) no-repeat; background-size: 100%; height: 8rem" value="" />
            </form>
        </div>
    </div>
    <script src="http://zeptojs.com/zepto.min.js" charset="utf-8"></script>
    <script type="text/javascript">
        function getCode() {
            var tel = $('#tel').val();
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号格式有误");
                return;
            }
            $.post('control/sendCodeByPhone.aspx', { "mobile": tel }, function (data) {
                //result = eval(data);
                //alert(result.code);
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
                    btn.attr("disabled", false);
                    return false;
                } else {
                    btn.val("" + (time--) + "秒后可发送");
                }
            }, 1000);
        }
    </script>
</body>
</html>
