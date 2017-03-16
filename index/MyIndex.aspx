<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyIndex.aspx.cs" Inherits="index_Myindex" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>首页</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css"> -->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css">
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css"> -->
    <link rel="stylesheet" href="css/reset.css">
    <script type="text/javascript">
        function logout() {
            $.get("control/LogOut.ashx", null, function (data) {
            })
        }
    </script>
</head>
<body>

    <div class="page-group">
        <!-- 你的html代码 -->
        <div class="page">
            <nav class="bar bar-tab">
                <a class="tab-item external" href="http://wx.lvwei8.com/default.aspx">
                    <span class="icon icon-home"></span>
                    <span class="tab-label">首页</span>
                </a>
                <a class="tab-item" href="http://wx.lvwei8.com/index/Reservation.aspx">
                    <span class="icon icon-clock"></span>
                    <span class="tab-label">尾单预约</span>
                </a>
                <a class="tab-item active external" href="http://wx.lvwei8.com/index/myindex.aspx">
                    <span class="icon icon-me"></span>
                    <span class="tab-label">个人中心</span>
                </a>
            </nav>
            <div class="content user">
                <div class="user_bg">
                    <div class="head">
                        <asp:Image ID="Image1" runat="server" ImageUrl="images/head.jpg" />
                    </div>
                    <div class="wz">
                        <div class="name">
                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="setup">
                        <a class="external" href="aboutme.aspx"><i class="icon icon-settings "></i></a>
                    </div>
                </div>
                <div class="list-block">
                    <ul>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe667;</i></div>
                            <div class="item-inner">
                                <a href="http://wx.lvwei8.com/index/account.aspx"></a>
                                <div class="item-title">现金账户</div>
                            </div>
                        </li>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe64f;</i></div>
                            <div class="item-inner">
                                <a class="tab-item external" href="Coupon.aspx?openid=<%=openid %>"></a>
                                <div class="item-title">我的优惠券</div>
                            </div>
                        </li>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe656;</i></div>
                            <div class="item-inner">
                                <a href="Integral.aspx"></a>
                                <div class="item-title">我的积分</div>
                            </div>
                        </li>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe651;</i></div>
                            <div class="item-inner">
                                <a class="tab-item" href="http://wx.lvwei8.com/index/choose.aspx?openid=<%=openid %>"></a>
                                <div class="item-title">推荐有奖</div>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="list-block tp05">
                    <ul>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe65d;</i></div>
                            <div class="item-inner">
                                <a href="indent_type.aspx?openid=<%=openid %>"></a>
                                <div class="item-title">订单管理</div>
                            </div>
                        </li>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe663;</i></div>
                            <div class="item-inner">
                                <a class="tab-item external" href="http://wx.lvwei8.com/index/Reservation.aspx"></a>
                                <div class="item-title">尾单预约</div>

                            </div>
                        </li>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe65e;</i></div>
                            <div class="item-inner">
                                <a href="news.aspx"></a>
                                <div class="item-title">消息中心</div>
                            </div>
                        </li>
                    </ul>
                </div>

                <div class="list-block tp05">
                    <ul>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe652;</i></div>
                            <div class="item-inner">
                                <a class="tab-item external" href="hotel.aspx"></a>
                                <div class="item-title">常用旅客</div>
                            </div>
                        </li>
                        <li class="item-content item-link">
                            <div class="item-media"><i class="iconfont">&#xe650;</i></div>
                            <div class="item-inner">
                                <div  onclick="logout()" class="item-title">退出</div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="question">
                    有问题欢迎随时致电400-0044-007
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery-1.8.2.min.js"></script>
    <script type='text/javascript' src='js/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
</body>
</html>

