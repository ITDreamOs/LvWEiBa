<%@ Page Language="C#" AutoEventWireup="true" CodeFile="indent_pay.aspx.cs" Inherits="index_indent_pay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>订单支付</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css"> -->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css" />
    <link rel="stylesheet" href="css/iconfont.css?version=1" />
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css"> -->
    <link rel="stylesheet" href="css/reset.css" />
    <link href="js/showLoading/css/showLoading.css" rel="stylesheet" />
    <script src="js/jquery-1.8.2.min.js"></script>
    <script src="http://res.mail.qq.com/mmr/static/lib/js/jquery.js" type="text/javascript"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script src="js/showLoading/js/jquery.showLoading.min.js"></script>
    <script type="text/javascript">
        function isWeiXin() {
            var ua = window.navigator.userAgent.toLowerCase();
            if (ua.match(/MicroMessenger/i) == 'micromessenger') {
                return true;
            } else {
                return false;
            }
        }
        //window.onload = function () {
        //    if (!isWeiXin()) {
        //        alert("请微信关注驴尾巴公众号，完成支付！")
        //    }
        //}
    </script>
    <script type='text/javascript'>
        var appId = "";
        var timeStamp = "";
        var nonceStr = "";
        var prepay_id = "";
        var paySign = "";
        var OrderID = "";
        var totalAmount = 0;
        var type = "";
        var useLeftMoney = 0;
        var useCoupon = 0;
        $(document).ready(function () {
            $.post("control/CouponList.ashx",
                { "openid": "<%=openid%>", "orderMoney": $("#HiddenFieldchctt").val().trim() }
                , function (data, status) {
                    var coupons = document.getElementById("couponList");
                    coupons.options.length = 0;
                    var jsonData = eval(data)
                    for (var i = 0; i < jsonData.length; i++) {
                        coupons.add(new Option("不使用优惠券", "0"));
                        coupons.add(new Option(jsonData[i].name + ":" + jsonData[i].price + "元*" + jsonData[i].count + "张", jsonData[i].id));
                    }
                    if (jsonData == null || jsonData.length == 0) {
                        coupons.add(new Option("不使用优惠券", "0"));
                    }
                });
            type = $("#hid_order_type").val().trim();
            if (type == "wd") {
                totalAmount = parseInt(<%=shichangjia%>);
            }
            else if (type == "jh" || type == "mp") {
                totalAmount = parseInt(<%=youhuijia%>);
            } else {
                totalAmount = parseInt(<%=shichangjia%>);
            }
        })


        //调用微信JS api 支付
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
                                $("#maindiv").hideLoading();
                                alert("支付成功！");
                                if ($("#hid_order_type").val().trim() == "wd") {
                                    window.location.href = 'http://wx.lvwei8.com/index/indent_show.aspx?order_id=' + $("#hid_order_id").val();//支付成功后的跳转页面
                                }
                                else {
                                    window.location.href = 'http://wx.lvwei8.com/index/indent_ticket_show.aspx?order_id=' + $("#hid_order_id").val();//支付成功后的跳转页面
                                }

                            } else {
                                WeixinJSBridge.call('closeWindow');
                            }

                        }
                        );
        }

        function callpay(fee, jinbic) {
            if (!isWeiXin()) {
                alert("请微信关注“驴尾巴”公众号，完成支付！")
            } else {
                //千岁金币转让中·········
                $("#maindiv").showLoading();
                //alert($("#hid_order_id").val().trim())
                //支付准备开始
                $.ajax({
                    type: "POST",
                    url: "control/indent_pay.ashx",
                    data: {
                        openid: "<%=openid%>", feee: $("#HiddenFieldchctt").val().trim(), orderid: $("#hid_order_id").val(), jinbi: jinbic, HostAddress: "<%=HUserHostAddress%>"
                        , couponid: $("#couponList").find("option:selected").val(), usemoneyleft: $("#money").val()
                    },
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
                    }, error: function (XMLResponse) {
                        $("#maindiv").hideLoading();
                        alert(XMLResponse.responseText)
                    }
                });
                //支付准备开始结束
            }
        }


        //直接支付
        function direct_pay(jinbic) {
            //千岁金币转让中·········
            $("#maindiv").showLoading();
            //支付准备开始
            $.ajax({
                type: "POST",
                url: "control/direct_pay.ashx",
                data: {
                    openid: "<%=openid%>", jinbi: jinbic, feee: $("#HiddenFieldchctt").val().trim(), orderid: $("#hid_order_id").val(), HostAddress: "<%=HUserHostAddress%>"
                    , couponid: $("#couponList").find("option:selected").val(), usemoneyleft: $("#money").val()
                },
                dataType: "json",
                success: function (data) {
                    var json = eval(data);
                    if (data.code == "0") {
                        $("#maindiv").hideLoading();
                        alert("支付成功！");
                        if ($("#hid_order_type").val() == "wd") {
                            window.location.href = 'http://wx.lvwei8.com/index/indent_show.aspx?order_id=' + $("#hid_order_id").val();//支付成功后的跳转页面
                        }
                        else {
                            window.location.href = 'http://wx.lvwei8.com/index/indent_ticket_show.aspx?order_id=' + $("#hid_order_id").val();//支付成功后的跳转页面
                        }
                    }
                    else {
                        $("#maindiv").hideLoading();
                        alert("支付失败！");
                    }

                }, error: function (XMLResponse) {
                    $("#maindiv").hideLoading();
                    alert(XMLResponse.responseText);
                }

            });

            //支付准备开始结束
        }
        //阿里支付
        function call_ali_pay(fee, jinbic) {
            if (isWeiXin()) {
                alert("支付宝请到浏览器中完成支付！")
            } else {
                //千岁金币转让中·········
                $("#maindiv").showLoading();
                //alert($("#hid_order_id").val().trim())
                //支付准备开始
                window.location.href = "control/AliPayHandler.aspx?feee=" + totalAmount + "&orderid=" + $("#hid_order_id").val() + "&jinbi=" + jinbic + "&couponid=" + $("#couponList").find("option:selected").val()
                + "&usemoneyleft=" + $("#money").val();
            }
        }
        //select事件
        function selectCoupon() {
            if ($("#couponList").find("option:selected").val() != "0") {
                var couponText = $("#couponList").find("option:selected").text();
                var couponValue = parseInt(couponText.match(/:\d{0,3}[\\u4e00-\\u9fa5]/i).toString().replace(":", ""));
                useCoupon = couponValue;
                totalAmount = totalAmount - useCoupon;
                changeTotalAmount(totalAmount);
                showPay(totalAmount);
            }
            else {
                totalAmount = totalAmount + useCoupon;
                useCoupon = 0;
                changeTotalAmount(totalAmount);
                showPay(totalAmount);
            }
        }

        //使用可用余额
        function useAvaliableMoney() {
            if ($("#money").val() != "") {
                var toUse = parseInt($("#money").val());
                var moneyLeft = parseInt(<%=moneyLeft%>);
                if (moneyLeft <= 0) {
                    alert("可用余额不足,请充值");
                }
                if (toUse > moneyLeft) {
                    alert("不能超过可用余额");
                    $("#money").val("");
                    $("#moneyLeft").text(<%=moneyLeft%>);
                    totalAmount = totalAmount + useLeftMoney;
                    useLeftMoney = 0;
                    changeTotalAmount(totalAmount);
                    //调用
                    showPay(totalAmount);
                }
                else {
                    $("#money").val(toUse);
                    totalAmount = totalAmount + useLeftMoney;
                    useLeftMoney = toUse;
                    totalAmount = totalAmount - useLeftMoney;
                    //动态变化余额
                    $("#moneyLeft").text(moneyLeft - toUse);
                    changeTotalAmount(totalAmount);
                    showPay(totalAmount);
                }
            }
            else {
                $("#money").val("");
                //未提交还原
                $("#moneyLeft").text(<%=moneyLeft%>);
                totalAmount = totalAmount + useLeftMoney;
                useLeftMoney = 0;
                changeTotalAmount(totalAmount);
                showPay(totalAmount);

            }
        }

        function showPay(amount) {
            if (amount == 0) {
                $("#usemoneypay")[0].style.display = "block";
            }
            else {
                $("#usemoneypay")[0].style.display = "none";
            }
        }

        function changeTotalAmount(amount) {
            $("#HiddenFieldchctt").val(amount + "00");
            $("#<%=Label1.ClientID%>").text(amount + ".00");
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
                    <h1 class="title">订单支付</h1>
                </header>
                <div class="content">
                    <div class="price_pay">
                        <p>
                            市场价：<em>￥<%=shichangjia %></em> <span class="sm">
                                <asp:Label ID="lbl_scsm" runat="server" Text="Label"></asp:Label></span>
                        </p>
                        <p>
                            优惠价：<em>￥<%=youhuijia%></em> <span class="sm">
                                <asp:Label ID="lbl_yhsm" runat="server" Text="Label"></asp:Label></span>
                        </p>
                        <p>可用余额：<em>￥<span id="moneyLeft"><%=moneyLeft %></span></em>&nbsp;<input id="money" name="money" type="text" style="width: 5rem; font-size: 0.6rem" onblur="useAvaliableMoney()" placeholder="预使用" /></p>
                        <p>可用优惠券：<select id="couponList" onchange="selectCoupon()"></select></p>
                    </div>

                    <div class="point">
                        共需支付:
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><asp:HiddenField ID="HiddenFieldchctt" runat="server" />
                    </div>
                    <div class="point">
                        <asp:Label ID="lbl_zyts" runat="server" Text=""></asp:Label>
                    </div>

                    <div class="content-block-title">选择支付方式</div>
                    <div class="list-block">
                        <ul>
                            <li id="usemoneypay" style="display: none" onclick="direct_pay('1')" class="item-content item-link">
                                <div class="item-inner">
                                    <div class="item-title" onclick="direct_pay('1')">直接支付</div>
                                </div>
                            </li>
                            <li class="item-content item-link" onclick="callpay('1','1')">
                                <div class="item-media"><i class="iconfont wx">&#xe60c;</i></div>
                                <div class="item-inner">
                                    <div class="item-title" onclick="callpay('1','1')">微信支付</div>
                                </div>
                            </li>
                            <li class="item-content item-link" onclick="call_ali_pay('1','1')">
                                <div class="item-media"><i class="iconfont zfb">&#xe600;</i></div>
                                <div class="item-inner">
                                    <div class="item-title" onclick="call_ali_pay('1','1')">支付宝支付</div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <asp:HiddenField ID="hid_order_id" runat="server" />
                <asp:HiddenField ID="hid_order_type" runat="server" />
            </form>
        </div>
        <!-- content -->

    </div>
    <!-- page -->
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>

    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>


</body>
</html>
