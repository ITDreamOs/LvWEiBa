<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="index_Default" %>

<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>首页</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">


   <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css">
     <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css">

    <link rel="stylesheet" href="index/css/iconfont.css">
    <link rel="stylesheet" href="index/css/reset.css">

    <script src="index/js/analyse.js" type="text/javascript"></script>
<%--    <script src="index/js/jquery-3.1.1.min.js"></script>
        <link href="index/css/swiper-3.4.1.min.css" rel="stylesheet" />--%>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

    <script type="text/javascript">

    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            $.ajax({
                type: 'GET',
                url: 'http://wx.lvwei8.com/API/WeixinApi.aspx' + '?url=' + location.href.split('#')[0],
                withCredentials: false,
                error: function () {
                    console.log('出错');
                    //alert('请求出错');
                },
                success: function (data) {
                    data = eval('(' + data + ')');
                    startConfig(data);
                }
            });
            //开始配置微信js-sdk
            var startConfig = function (data) {
                wx.config({
                    debug: true,
                    appId: 'wx1bbadc0beedbcc39',
                    timestamp: data.timestamp,
                    nonceStr: data.nonce,
                    signature: data.signature,
                    jsApiList: [
                        // 所有要调用的 API 都要加到这个列表中
                        'checkJsApi',
                        'onMenuShareTimeline',
                        'onMenuShareAppMessage',
                        'onMenuShareQQ',
                        'onMenuShareWeibo',
                        'onMenuShareQZone',
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
                    title: '测试标题', // 分享标题
                    link: 'http://lvwei8.com/demo/test', // 分享链接
                    imgUrl: 'http://lwb.0351ets.com/media/ProductConTPIC/201609/636091184579665428.jpg', // 分享图标
                    success: function () {
                        alert("分享成功");
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                        alert("分享失败");
                    }
                });
            });
        })
    </script>
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
                $("#login_icon").css('display', 'none');
            }
        }
    </script>
</head>
<body>

    <div class="page-group">
        <!-- 你的html代码 -->
        <div class="page">
            <header class="bar bar-nav">

   <a class="icon icon-app pull-left open-popup" href="#"></a>
                <a id="login_icon" href="index/login.aspx" class="icon icon-me pull-right"></a>
                <h1 class="title">驴尾巴旅游网</h1>
            </header>
            <nav class="bar bar-tab">
                <a class="tab-item active external" href="http://wx.lvwei8.com/Default.aspx">
                    <span class="icon icon-home"></span>
                    <span class="tab-label">首页</span>
                </a>
                <a class="tab-item external" href="http://wx.lvwei8.com/index/Reservation.aspx?ticks="+<%=DateTime.Now.Millisecond %>>
                    <span class="icon icon-clock"></span>
                    <span class="tab-label">尾单预约</span>
                </a>
                <a class="tab-item external" href="http://wx.lvwei8.com/index/myindex.aspx">
                    <span class="icon icon-me"></span>
                    <span class="tab-label">个人中心</span>
                </a>

            </nav>
            <div class="content">
              <div class="swiper-container">
    <div class="swiper-wrapper">
        <%
            var list = new BaseClass.Dal.App_Ad().GetListAds("");
            foreach (var item in list)
            {
                var str = string.Format("<div class='swiper-slide'><a href='{1}'><img src='{0}' style='width:100%' /></a></div>", item.AdPic,item.AdjumpUrl);
                Response.Write(str);
            }
    %>
    </div>
    <div class="swiper-pagination"></div>
    <div class="swiper-scrollbar"></div>
</div>



                <!-- 今日头条 -->
                <div class="big_news clearfix">
                    <div class="wz">通知公告</div>
                    <div class="nominate">推荐</div>
                    <div class="news">
                        <asp:Label ID="LabelNotice" runat="server" Text="LabelNotice"></asp:Label>
                    </div>
                </div>
                <!-- 快捷入口 -->
                <div class="intake clearfix">
                    <a href="index/LineList.aspx?tp=zhoubian&ticks="+<%=DateTime.Now.Millisecond %> class="portal external">
                        <div class="ico ico1"><i class="iconfont">&#xe605;</i></div>
                        <p>周边游</p>
                    </a>
                    <a href="index/LineList.aspx?tp=guonei&ticks="+<%=DateTime.Now.Millisecond %> class="portal external">
                        <div class="ico ico2"><i class="iconfont">&#xe600;</i></div>
                        <p>国内游</p>
                    </a>
                    <a href="index/LineList.aspx?tp=chujing&ticks="+<%=DateTime.Now.Millisecond %> class="portal external">
                        <div class="ico ico3"><i class="iconfont">&#xe60e;</i></div>
                        <p>出境游</p>
                    </a>
                    <a href="index/LineList.aspx?tp=ziyouxing&ticks="+<%=DateTime.Now.Millisecond %> class="portal external">
                        <div class="ico ico4"><i class="iconfont">&#xe607;</i></div>
                        <p>自由行</p>
                    </a>
                    <a href="index/ticket.aspx" class="portal">
                        <div class="ico ico5"><i class="iconfont">&#xe604;</i></div>
                        <p>门票</p>
                    </a>
                </div>
                <!-- 广告位 -->
                <div class="ad clearfix">
                    <a href="http://wx.lvwei8.com/index/Reservation.aspx" class="ad1">
                        <img src="index/images/ad1.png" alt=""></a>
                    <a href="index/LineList.aspx?tp=jianhang&ticks="+<%=DateTime.Now.Millisecond %> class="ad2">
                        <img src="index/images/ad3.png" alt=""></a>
                </div>
                <!-- 推荐精选 -->
                <div class="pick">
                    <div class="title">推荐精选</div>
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <!-- 单个 -->
                            <a href="index/showline.aspx?code=<%#Eval("ProNumCode") %>&lineid=<%#Eval("id") %>" class="picks external">
                                <div class="head">
                                    <%#Convert.ToDateTime(Eval("sdate").ToString()).ToString("yyyy-MM-dd") %> <%#Eval("Splace") %>出发
                <div class="seat">余位<em><%#Eval("adultTicketCount") %></em></div>
                                </div>
                                <div class="box">
                                    <img src="<%#Eval("Spicc") %>" alt="">
                                    <div class="mask">
                                        <%#subttl(Eval("TTl").ToString()) %>
                                        <div class="price">￥<%#Eval("adultzkPrice") %></div>
                                    </div>
                                    <div class="agio"><%#zhekou(Eval("adultzkPrice").ToString(),Eval("adultTicketPrice").ToString()) %>折</div>
                                    <div class="type"><%#typeget(Eval("kindof").ToString()) %></div>
                                </div>
                                <div class="foot">
                                    <%#Eval("provider") %>
                                    <div class="time">剩<em><%#Diffdatebynow(Eval("sdate").ToString()) %></em></div>
                                </div>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- 城市选择 -->


                <div class="footer">
                    Copyright©2015 旅微科技有限公司
                </div>

            </div>
        </div>
        <div class="popup popup-about">
  <div class="content-block">
  <header class="bar bar-nav">
      <a class="icon pull-left close-popup" href="#"><i class="iconfont">&#xe66e;</i></a>
      <h1 class="title">选择城市</h1>
  </header>
  <div class="list-block">
    <ul>
      <li class="item-content">
        <div class="item-inner">
          <div class="item-title">热门城市</div>
        </div>
      </li>
      <li class="item-content">
        <div class="item-inner">
          <div class="item-title"><a href="">北京</a></div>
        </div>
      </li>
            <li class="item-content">
        <div class="item-inner">
          <div class="item-title"><a href="">北京</a></div>
        </div>
      </li>
            <li class="item-content">
        <div class="item-inner">
          <div class="item-title"><a href="">北京</a></div>
        </div>
      </li>
            <li class="item-content">
        <div class="item-inner">
          <div class="item-title">山西省</div>
        </div>
      </li>
            <li class="item-content">
        <div class="item-inner">
          <div class="item-title"><a href="">北京</a></div>
        </div>
      </li>
            <li class="item-content">
        <div class="item-inner">
          <div class="item-title"><a href="">北京</a></div>
        </div>
      </li>
            <li class="item-content">
        <div class="item-inner">
          <div class="item-title"><a href="">太原</a></div>
        </div>
      </li>

    </ul>
  </div>
  </div>
</div>
    </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
  <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="index/js/config.js"></script>
      <script src="index/js/code.js" type="text/javascript"></script>
</body>
</html>
