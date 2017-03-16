<%@ Page Language="C#" AutoEventWireup="true" CodeFile="account.aspx.cs" Inherits="index_account" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>现金账户</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <link rel="shortcut icon" href="/favicon.ico"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css"> -->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css"/>
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css"/>
    <link rel="stylesheet" href="css/iconfont.css"/>
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css"> -->
    <link rel="stylesheet" href="css/reset.css"/>
</head>
<body>
  <div class="page-group">
      <!-- 你的html代码 -->
      <div class="">
     <form id="form1" runat="server">
         <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">现金账户</h1>
          </header>
          <div class="content account">
            <div class="find_pswd">
            <div class="retrieve">
              <div class="tit">账户余额</div>
              <div class="box"><%=yue %> <span>元</span></div>
            </div>
              <a href="http://wx.lvwei8.com/index/chongzhi.aspx" class="external to_up">充&nbsp;值</a>
              <a class="external to_up" href="withdraw.aspx" >提&nbsp;现</a>
            </div>
          </div><!-- content --> 

     </form>         </div><!-- page -->
      </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    
    <script type="text/javascript" src="js/config.js"></script>

</body>
</html>
