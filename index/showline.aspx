<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showline.aspx.cs" Inherits="index_showline" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>首页</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css" />
    <link rel="stylesheet" href="css/iconfont.css" />
    <link rel="stylesheet" href="css/reset.css" />
    <link href="css/passenger.css" rel="stylesheet" />
    <script src="js/passenger.js"></script>
    <%--    <script src="js/jquery-1.8.2.min.js"></script>--%>
    <%--    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>--%>
    <%--    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>--%>
    <%-- <script type="text/javascript">
        $(document).ready(function () {
            //alert(location.href.split('#')[0]);
            $.ajax({
                type: 'GET',
                url: 'http://wx.lvwei8.com/API/WeixinApi.aspx' + '?url=' + location.href.split('#')[0],
                withCredentials: false,
                error: function () {
                    alert('请求出错');
                },
                success: function (data) {
                    data = eval('(' + data + ')');
                    //alert(data.signature);
                    startConfig(data);
                }
            });
            //开始配置微信js-sdk
            var startConfig = function (data) {
                wx.config({
                    debug: false,
                    appId: 'wx1bbadc0beedbcc39',
                    timestamp: data.timestamp,
                    nonceStr: data.nonce,
                    signature: data.signature,
                    jsApiList: [
                        // 所有要调用的 API 都要加到这个列表中
                        'checkJsApi',
                        'onMenuShareTimeline',
                        'onMenuShareAppMessage',
                        'hideMenuItems',
                        'showMenuItems',
                        'hideAllNonBaseMenuItem',
                        'showAllNonBaseMenuItem'
                    ]
                });
            };
            wx.ready(function () {
                // 在这里调用 API
                wx.onMenuShareTimeline({
                    title: $("#hidTitle").val().trim(), // 分享标题
                    link: $("#hidLink").val().trim(), // 分享链接
                    imgUrl: $("#hidImgUrl").val().trim(), // 分享图标
                    success: function () {
                        alert("分享成功");
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                        alert("分享取消");
                    }
                });

                // 在这里调用 API
                wx.onMenuShareAppMessage({
                    title: $("#hidTitle").val().trim(), // 分享标题
                    link: $("#hidLink").val().trim(), // 分享链接
                    imgUrl: $("#hidImgUrl").val().trim(), // 分享图标
                    success: function () {
                        alert("分享成功");
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                        alert("分享取消");
                    }
                });
            });
        })
    </script>--%>
    <style type="text/css">
        #mcover {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            z-index: 20000;
        }

            #mcover img {
                position: fixed;
                right: 18px;
                top: 5px;
                width: 100%;
                z-index: 999;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server" method="get" action="indent_fill.aspx">
        <div class="page-group">
            <div class="page">

                <!-- 预定入口 -->
                <nav class="bar bar-tab book">
                    <div class="tell"><a href="tel:4000044007" class="iconfont">&#xe62c;</a></div>

                    <div class="reserve">
                        <asp:HiddenField ID="HiddenFieldid" runat="server" />
                        <a class="external" href="indent_fill.aspx?adult=0&children=0&lineid=<%=lineid %>" id="yudingbtn">立即预定</a>
                    </div>
                </nav>

                <div class="content">
                    <!-- 返回按钮 -->
                    <a class="icon icon-left pull-left back show_btn"></a>
                    <!-- 触摸轮播图 -->
                    <div class="swiper-container index_">
                        <div class="swiper-wrapper">
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                    <div class="swiper-slide">
                                        <img src="<%#Eval("Pics")%>" alt="">
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                    <!-- 详细信息 -->
                    <div class="floor2">
                        <div class="about">
                            <%=ttl %>
                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="message clearfix">

                            <div class="left"><i class="iconfont">&#xe613;</i><%=sdate %></div>

                            <div class="right"><i class="iconfont">&#xe618;</i><asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>出发</div>
                        </div>
                        <div class="message clearfix">
                            <div class="left">
                                <asp:Label ID="Label4" runat="server" Text="山西万景国旅"></asp:Label>
                            </div>
                            <div class="right">
                                <asp:Label ID="Label5" runat="server" Text="剩2天16小时"></asp:Label>
                            </div>
                        </div>
                        <ul class="list">
                            <li>
                                <span class="type">成人丨</span>
                                <span class="price">市场价</span>
                                <span class="norm">￥<asp:Label ID="Label6" runat="server" Text="Label"></asp:Label></span>
                                <em><%=azhe %>折</em>
                                <span class="coupon fr">￥<asp:Label ID="Label7" runat="server" Text="Label"></asp:Label></span>
                                <span class="price fr">优惠价：</span>
                            </li>

                            <li>
                                <span class="type">儿童丨</span>
                                <span class="price">市场价</span>
                                <span class="norm">￥<asp:Label ID="Label8" runat="server" Text="Label"></asp:Label></span>
                                <em><%=pzhe %>折</em>
                                <span class="coupon fr">￥<asp:Label ID="Label9" runat="server" Text="Label"></asp:Label></span>
                                <span class="price fr">优惠价：</span>
                            </li>
                        </ul>
                        <div class="share">
                            <div class="ms">马上分享</div>
                            <div class="share_s" onclick="document.getElementById('mcover').style.display='block';">
                                <a class="green" href="#"><i class="iconfont">&#xe61e;</i></a>
                                <a class="green" href="#"><i class="iconfont">&#xe61c;</i></a>
                                <a class="blue" href="#"><i class="iconfont">&#xe619;</i></a>
                                <a class="yellow" href="#"><i class="iconfont">&#xe620;</i></a>
                                <a class="red" href="#"><i class="iconfont">&#xe61a;</i></a>
                            </div>
                        </div>
                        <div class="big_news clearfix">
                            <div class="nominate">更多惊喜</div>
                            <div class="news">即将联合各大银行推出更多优惠</div>
                        </div>
                    </div>
                    <!-- 详细内容 -->
                    <ul class="tabs1 clearfix">
                        <li class="active">推荐理由</li>
                        <li class="">行程</li>
                        <li class="">费用须知</li>
                        <li class="">点评</li>
                    </ul>
                    <div class="content_">
                        <!-- 行程 -->
                        <div class="recommend" id="xingcheng">
                            <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>
                        </div>
                        <!-- 行程 -->
                        <!-- 费用包含 -->
                        <div class="recommend" id="feiyong">
                            <asp:Label ID="Label11" runat="server" Text="Label"></asp:Label>
                        </div>

                        <!-- 用户评价 -->
                        <div class="opinion tp5">
                            <ul>
                                <li>
                                    <div class="tit"><span>国国蛋</span>2016-03-04</div>
                                    <p>驴尾巴不错，以后出门旅游首选。坐等退钱！</p>
                                </li>
                                <li>
                                    <div class="tit"><span>善缘</span>2016-03-01</div>
                                    <p>玩的特别好。拍的图片已经分享到你们微信公众号，我会一如既往的支持驴尾巴，确实是说走就走还省钱！</p>
                                </li>
                            </ul>
                        </div>
                        <!-- 提示 -->
                        <div class="hint">
                            <a class="tab-item" href="http://wx.lvwei8.com/index/Reservation.aspx">觉得不合适？快来试试尾单预约吧！ </a>
                        </div>
                        <!-- form -->

                    </div>
                    <div class="footer">Copyright©2015 旅微科技有限公司</div>
                </div>

            </div>
        </div>
        <asp:HiddenField ID="hidTitle" runat="server" />
        <asp:HiddenField ID="hidImgUrl" runat="server" />
        <asp:HiddenField ID="hidLink" runat="server" />

        <div id="mcover" onclick="document.getElementById('mcover').style.display='';" style="display: none;">
            <img src="images/guide.png" />
        </div>
        <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
        <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
        <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
        <script type="text/javascript" src="js/config.js"></script>
    </form>
</body>
</html>
