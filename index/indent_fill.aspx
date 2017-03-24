<%@ Page Language="C#" AutoEventWireup="true" CodeFile="indent_fill.aspx.cs" Inherits="index_indent_fill" %>

<html >
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>填写订单</title>
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
    <link rel="stylesheet" href="css/passenger.css">
  </head>
<body>

  <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">订单填写</h1>
          </header>
          <div class="content">
            <div class="list-block">
                <ul>
                  <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">商品名称</div>
                      <div class="item-after">加载中</div>
                    </div>
                  </li>
                  <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">产品编号</div>
                      <div class="item-after">加载中</div>
                    </div>
                  </li>
                  <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">出发日期</div>
                      <div class="item-after">加载中</div>
                    </div>
                  </li>
                  <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">出发城市</div>
                      <div class="item-after">加载中</div>
                    </div>
                  </li>
                  <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">预订人数</div>
                      <div class="item-after">成人*0 儿童*0</div>
                    </div>
                  </li>
                  <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">订单金额</div>
                      <div class="item-after"></div>
                    </div>
                  </li>
                  <div class="jine">
                    <p>请选择旅客</p>
                  </div>

                <div class="point">
                    重要提示：所有产品均按市场价支付，旅行结束后48小时内
                    驴尾巴网将差价返还至会员现金账户，会员可自由选择提现
                    或二次消费。
                </div>
                <li class="item-content">
                    <div class="item-inner">
                      <div class="item-title">选择旅客</div>
                    </div>
                  </li>
                </ul>
              </div>
          <div class="content-block indent passenger-order-submit">
              <div class="col-100"><input type="button" href="indent_pay.html" class="button button-big" value="提交订单" /></div>
          </div>
          </div><!-- content -->
          </div><!-- page -->
      </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>

    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
    <script src="js/code.js"></script>
    <script type="text/javascript" src="js/passenger.js"></script>
  </body>
</html>
