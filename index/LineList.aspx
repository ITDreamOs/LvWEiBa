<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LineList.aspx.cs" Inherits="index_LineList" %>


<html>
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>首页</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta http-equiv="Cache-Control" content="no-cache">
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
    <form runat="server">
        <div class="page-group">
            <!-- 你的html代码 -->
            <div class="page">
                <header class="bar bar-nav">
                    <a class="icon icon-left pull-left back"></a>
                    <a href="Search.aspx" class="icon icon-search pull-right"></a>
                    <h1 class="title"><%=tpname %>列表页</h1>
                    <asp:HiddenField ID="HiddenFieldchanle" runat="server" />
                </header>
                <div class="content">
                    <!-- 触摸轮播图 -->
                    <div class="swiper-container index_">
                        <div class="swiper-wrapper">
                            <asp:Repeater ID="Repeater2" runat="server">
                                <ItemTemplate>
                                    <div class="swiper-slide">
                                        <img src="<%#Eval("adpic") %>" alt="">
                                    </div>

                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                    <!-- 今日头条 -->
                    <div class="big_news clearfix">
                        <div class="wz">尾单预约</div>
                        <div class="nominate">涨姿势</div>
                        <div class="news">
                            <asp:Label ID="LabelNotice"  runat="server" Text="LabelNotice"></asp:Label>
                        </div>
                    </div>
                    <!-- 筛选列表 -->
                    <div class="filter clearfix">
                        <div class="num"><asp:Button runat="server" BorderColor="Transparent" BackColor="Transparent" OnClick="PriceFilter_Click" ID="PriceFilter" Text="价格"/><i class="iconfont">&#xe610;</i></div>
                        <div class="num"><asp:Button runat="server" BorderColor="Transparent" BackColor="Transparent" OnClick="ZKFilter_Click" ID="ZKFilter" Text="折扣"></asp:Button><i class="iconfont">&#xe610;</i></div>
                        <div class="num"><asp:Button runat="server" BorderColor="Transparent" BackColor="Transparent" OnClick="DateFilter_Click" ID="DateFilter" Text="日期"></asp:Button><i class="iconfont">&#xe610;</i></div>
                        <div class="num"><asp:Button runat="server" BorderColor="Transparent" BackColor="Transparent" OnClick="DaysFilter_Click" ID="DaysFilter" Text="天数"></asp:Button><i class="iconfont">&#xe610;</i></div>
                    </div>
                    <div class="pick" id="list_box">
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <a href="showline.aspx?code=<%#Eval("ProNumCode") %>&lineid=<%#Eval("id") %>" class="picks external">
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
                                        <div class="agio"><%#zhekou(Eval("adultSellPrice").ToString(),Eval("adultTicketPrice").ToString()) %>折</div>
                                        <div class="type"><%#typeget(Eval("kindof").ToString()) %></div>
                                    </div>
                                    <div class="foot"> 
                                        <%#Eval("provider") %>
                                        <div class="time">剩<em><%#Diffdatebynow(Eval("sdate").ToString()) %></em></div>
                                    </div>
                                </a>

                            </ItemTemplate>
                        </asp:Repeater>


                     
                    <asp:Label Visible="false"  runat="server" ID="typeName"/>
                    </div>
                    <div style="width: auto; background(url: images/loding.gif)no-repeat 0 center; display: none;" id="loading"></div>
                    <div class="footer">Copyright©2015 旅微科技有限公司</div>
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
    <script src="js/jquery-1.8.2.min.js"></script>
    <script src="js/linelistAutoLoad.js"></script>

</body>
</html>
