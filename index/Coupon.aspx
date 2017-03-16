<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Coupon.aspx.cs" Inherits="index_Coupon" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>优惠券</title>
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

    <style>
        .stamp
        {
            margin: 0 auto;
            margin-bottom: 10px;
            width: 90%;
            height: 150px;
            overflow: hidden;
            background-color: White;
            font-family: "Microsoft YaHei" , 'Source Code Pro' , Menlo, Consolas, Monaco, monospace;
            border-bottom: 2px solid #ff9a00;
        }
        .divLeft
        {
            float: left;
            padding-left: 20px;
            padding-top: 10px;
        }
        .divYhq
        {
            color: #ff9a00;
            font-size: 25px;
        }
        .divYxq
        {
            color: #ff9a00;
            font-size: 15px;
        }
        .tabMj
        {
            font-size: 12px;
            margin-top: 30px;
        }
        .divRight
        {
            float: right;
            line-height: 150px;
            padding-right: 10px;
            font-size: 10px;
        }
        .divMoney
        {
            color: #ff9a00;
            font-size: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">优惠券</h1>
          </header>
          <div class="content">
            <div class="buttons-tab">
    <a href="#tab1" class="tab-link active button">待使用</a>
    <a href="#tab2" class="tab-link button">已使用</a>
  </div>
  <div class="content-block">
    <div class="tabs">
      <div id="tab1" class="tab active">
        <div class="content-block" style="background-color: #EEEEF3">
            <br />
            <asp:Literal ID="lit_wsy" runat="server"></asp:Literal>
         
        </div>
      </div>
      <div id="tab2" class="tab">
        <div class="content-block" style="background-color: #EEEEF3">
        <br />
          <asp:Literal ID="lit_ysy" runat="server"></asp:Literal>
        </div>
      </div>
    </div>
  </div>
          </div><!-- content --> 

          </div><!-- page -->
      </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
    </form>
</body>
</html>
