<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ticket.aspx.cs" Inherits="index_ticket" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>门票</title>
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
</head>
<body>
    <form id="form1" runat="server">
    <div class="page-group">
        <!-- 你的html代码 -->
        <div class="page">
            <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <a href="search.html"class="icon icon-search pull-right"></a>
              <h1 class="title">门票</h1>
          </header>
            <div class="content">
                <!-- 触摸轮播图 -->
                <div class="swiper-container index_">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="images/banner.jpg" alt=""></div>
                        <div class="swiper-slide">
                            <img src="images/banner.jpg" alt=""></div>
                        <div class="swiper-slide">
                            <img src="images/banner.jpg" alt=""></div>
                    </div>
                    <div class="swiper-pagination">
                    </div>
                </div>
                <!-- 今日头条 -->
                <div class="big_news clearfix">
                    <div class="wz">
                        尾单预约</div>
                    <div class="nominate">
                        涨姿势</div>
                    <div class="news">
                                    <a class="external" href="http://wx.lvwei8.com/index/Reservation.aspx?ticks="+<%=DateTime.Now.Millisecond %>>
                        没找到合适的？那就预约吧！</a></div>
                </div>
                <!-- 门票列表 -->
                <ul class="ticket_ clearfix">
                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                   
                </ul>
                <div class="footer">
                    Copyright©2015 旅微科技有限公司
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js'
    charset='utf-8'></script>
<script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
<script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js'
    charset='utf-8'></script>
<script type="text/javascript" src="js/config.js"></script>
