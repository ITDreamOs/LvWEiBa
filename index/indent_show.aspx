﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="indent_show.aspx.cs" Inherits="index_indent_show" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
    <title>支付订单</title>
</head>
<body>

    <div class="page-group">
        <!-- 你的html代码 -->
        <div class="page">
            <header class="bar bar-nav">
                <a class="icon icon-left pull-left back"></a>
                <h1 class="title">订单详情</h1>
            </header>
            <div class="content show">
                <div class="tit">订单状态：<span><%=orderState %></span></div>
                <ul class="indent_xx">
                    <li>订单编号：<span><%=orderId %></span></li>
                    <li>产品编号：<span><%=goodId %></span></li>
                    <li>出发日期：<span><%=startDate %></span></li>
                    <%
                        if (orderStateDB != "DZF")
                        {
                    %>
                    <li>供应商：<span><%=provider %></span></li>
                    <li>线路负责人：<span><%=lineMaster %></span></li>
                    <li>导游/接站人：<span><%=leader %></span></li>
                    <li>集合时间：<span><%=jeHeTime %></span></li>
                    <li>集合地点：<span><%=jeHePlace %></span></li>
                    <%
                        }
                    %>
                    <li>人数：<span><%=member %></span></li>
                </ul>
                <div class="price_pay">
                    <p>市场价：<em>￥<%=marketPrice %></em> <span class="sm">（支付时按市场价支付）</span></p>
                    <p>优惠价：<em>￥<%=transferPrice %></em> <span class="sm">（返还差价之后的实际成交价）</span></p>
                </div>
                <div class="prix_error">* 旅行结束后48小时内差价将会返还回您的现金账户 *</div>
                <ul class="prix_xx">
                    <li class="nam">联系人信息</li>
                    <li>姓名：<%=contactPersonName %></li>
                    <li>手机号码：<%=contactPersonMobile %></li>
                </ul>
                <ul class="prix_xx">
                    <li class="nam">旅客信息</li>
                    <%
                        if (travellers.Rows.Count > 0)
                        {
                            for (int i = 0; i < travellers.Rows.Count; i++)
                            {
                              
                    %>
                    <li>姓名：<%=travellers.Rows[i]["Name"].ToString()%></li>
                    <li>手机号码：<%=travellers.Rows[i]["Mobile"].ToString()%></li>
                    <li>身份证号码：<%=travellers.Rows[i]["Card"].ToString()%></li>
                    <%     }
                        }
                    %>
                </ul>
            </div>
            <!-- content -->
        </div>
        <!-- page -->
    </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
</body>
</html>

