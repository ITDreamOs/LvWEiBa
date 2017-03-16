<%@ Page Language="C#" AutoEventWireup="true" CodeFile="chongzhi.aspx.cs" Inherits="index_chongzhi" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>充值</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css"> -->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css" />
    <link rel="stylesheet" href="css/iconfont.css" />
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css"> -->
    <link rel="stylesheet" href="css/reset.css" />
    <link href="js/showLoading/css/showLoading.css" rel="stylesheet" />
    <script src="js/jquery-1.8.2.min.js"></script>
    <script src="http://res.mail.qq.com/mmr/static/lib/js/jquery.js" type="text/javascript"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script src="js/showLoading/js/jquery.showLoading.min.js"></script>
    <script type='text/javascript'>

        //调用微信JS api 支付
        var appId = "";
        var timeStamp = "";
        var nonceStr = "";
        var prepay_id = "";
        var paySign = "";
        var OrderID = "";
        function jsApiCall() {
            WeixinJSBridge.invoke(
            'getBrandWCPayRequest',
            {
                "appId": appId,     //公众号名称，由商户传入     
                "timeStamp": timeStamp,         //时间戳，自1970年以来的秒数     
                "nonceStr": nonceStr, //随机串     
                "package": "prepay_id=" + prepay_id,
                "signType": "MD5",         //微信签名方式:     
                "paySign": paySign //微信签名 
            },//josn串
                        function (res) {
                            if (res.err_msg == 'get_brand_wcpay_request:ok') {
                                alert("充值成功！");
                                window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx1bbadc0beedbcc39&redirect_uri=http://wx.lvwei8.com/index/myindex.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect';//支付成功后的跳转页面

                            } else {
                                WeixinJSBridge.call('closeWindow');
                            }

                        }
                        );
        }

        function callpay(fee, jinbic) {
        var chctt=$('#chctt').val();
        if (chctt == "") {
            alert("请输入充值金额");
            return;
        }
            //千岁金币转让中·········
            $("#maindiv").showLoading();
            //支付准备开始

            $.ajax({
                type: "POST",
                url: "control/chongzhi.ashx",
                data: { openid: "<%=openid%>", feee: $("#chctt").val(), jinbi: jinbic, HostAddress: "<%=HUserHostAddress%>" },
                            dataType: "json",
                            success: function (data) {
                                var json = eval(data);
                                appId = json.appId;
                                timeStamp = json.timeStamp;
                                nonceStr = json.nonceStr;
                                prepay_id = json.prepay_id;
                                paySign = json.paySign;
                                OrderID = json.OrderID;
                                if (typeof WeixinJSBridge == 'undefined') {
                                    if (document.addEventListener) {
                                        document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
                                    }
                                    else if (document.attachEvent) {
                                        document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                                        document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
                                    }
                                }
                                else {
                                    jsApiCall();
                                }
                            }, error: function (XMLResponse) { alert(XMLResponse.responseText) }

                        });

                        //支付准备开始结束
                    }

    </script>
</head>
<body>
    <div class="page-group" id="maindiv">
        <!-- 你的html代码 -->
        <div class="page">
            <form id="form1" runat="server">
                <header class="bar bar-nav">
                    <a class="icon icon-left pull-left back"></a>
                    <h1 class="title">充值</h1>
                </header>
                <div class="content recharge">
                    <div class="price_pay" style="color: #ccc;">
                        <p>账户余额<span><%=yue %>元</span></p>
                    </div>
                    <div class="list-block">
                        <div class="item-inner">
                            <div class="item-title name">充值金额</div>
                            <div class="item-input">
                                <input  type="number" onkeyup="value=value.replace(/[^\d]/g,'')" id="chctt" placeholder="请输入充值金额" />
                            </div>
                        </div>
                    </div>

                    <div class="content-block-title">您可以用以下方式充值</div>
                    <div class="list-block">
                        <ul>
                            <li class="item-content">
                                <div class="item-media"><i class="iconfont wx">&#xe638;</i></div>
                                <div class="item-inner">
                                    <div class="item-title">微信支付</div>
                                </div>
                            </li>

                        </ul>
                    </div>
                    <div class="login_btn">
                        <a href="" onclick="callpay('1','1')" id="suresub">确定</a>
                    </div>
                </div>
            </form>
        </div>
        <!-- content -->

    </div>
    <!-- page -->
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on('click', '#suresub', function () {
                callpay('1', '1');
            })
            $("#suresub").on("", "");
        })
    </script> 
</body>
</html>
