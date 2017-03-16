<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showTicket.aspx.cs" Inherits="index_showTicket" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>首页</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
-->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css">
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
-->
    <link rel="stylesheet" href="css/reset.css">
</head>
<body>
    <form id="form1" runat="server" method="get" action="indent_ticket_fill.aspx">
        <div class="page-group">
            <div class="page">
                <!-- 预定入口 -->
                <nav class="bar bar-tab book ticket">
                    <div class="tell"><a href="tel:13513637759" class="iconfont">&#xe62c;</a></div>
                    <div class="num">
                        <div class="adult">
                            票数
            <div class="spinner clearfix">
                <span class="decrease iconfont">&#xe62f;</span>
                <div class="spi_num" id="ticket_count">0</div>
                <div class="spi_maxnum" style="display: none"><%=ticketLeftCount%></div>
                <span class="increase iconfont">&#xe62e;</span>
            </div>
                        </div>
                    </div>
                    <div class="reserve">
                        <asp:HiddenField ID="HiddenFieldid" runat="server" />
                        <a class="external" href="indent_ticket_fill.aspx?reserverCount=0&ticketid=<%=tickeId %>" id="yudingbtn_ticket">立即预定</a>
                    </div>

                </nav>

                <div class="content">
                    <!-- 返回按钮 -->
                    <a class="icon icon-left pull-left back show_btn"></a>
                    <!-- 触摸轮播图 -->
                    <div class="swiper-container index_">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <img src="<%=ticketConpics%>" alt="">
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                    <!-- 详细信息 -->
                    <div class="floor2">
                        <div class="about">
                            <%=ticketDetailTitle %>
                            <span>余<%=ticketLeftCount%>张</span>
                        </div>
                        <div class="message clearfix">
                            <div class="ti"><i class="iconfont">&#xe613;</i><%=startDate%>至<%=endDate%></div>
                        </div>
                        <div class="message clearfix">
                            <div class="ti">分类：纸质</div>
                        </div>
                        <ul class="list">
                            <li class="ticket">
                                <!-- <span class="type">成人丨</span> -->
                                <span class="price">市场价</span>
                                <span class="norm">￥<asp:Label ID="marketPriceLbl" runat="server" Text="Label"></asp:Label></span>
                                <em><%=zhekou%>折</em>
                                <span class="coupon fr">￥<asp:Label ID="transactionPriceLbl" runat="server" Text="Label"></asp:Label></span>
                                <span class="price fr">优惠价：</span>
                            </li>
                        </ul>
                        <div class="share">
                            <div class="ms">马上分享</div>
                            <div class="share_s">
                                <a class="green" href=""><i class="iconfont">&#xe61e;</i></a>
                                <a class="green" href=""><i class="iconfont">&#xe61c;</i></a>
                                <a class="blue" href=""><i class="iconfont">&#xe619;</i></a>
                                <a class="yellow" href=""><i class="iconfont">&#xe620;</i></a>
                                <a class="red" href=""><i class="iconfont">&#xe61a;</i></a>
                            </div>
                        </div>
                        <div class="big_news clearfix">
                            <div class="nominate">更多惊喜</div>
                            <div class="news">建行信用卡满5000返300</div>
                        </div>
                    </div>
                    <!-- 详细内容 -->
                    <div class="content_">
                        <!-- 费用包含 -->
                        <div class="cost tp5 ticket-description">
                            <ul>
                                <li class="head">使用说明</li>
                                <li>1、国际往返机票（含机场税），团队经济舱；</li>
                                <li>2、团队旅游签证费；(凡提供假材料者，罚款两千并且材料上交欧盟，如若出签不走，损失团款的三分之二)</li>
                                <li>3、欧洲当地标准三星酒店双人标准间住宿（两人一间，含早餐）意大利升级为四星酒店。</li>
                            </ul>
                        </div>
                        <!-- 用户评价 -->
                        <div class="opinion tp5">
                            <ul>
                                <li>
                                    <div class="tit"><span>用户昵称</span>2016-01-07</div>
                                    <p>整体评价超级棒的一次出游，喜欢大海的朋友一定要去上一次。非常开心，旅途的风景真的很美很美！</p>
                                </li>
                                <li>
                                    <div class="tit"><span>用户昵称</span>2016-01-07</div>
                                    <p>整体评价超级棒的一次出游，喜欢大海的朋友一定要去上一次。非常开心，旅途的风景真的很美很美！</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer">
                        Copyright©2015 旅微科技有限公司
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/showTicket.js"></script>
</body>
</html>
