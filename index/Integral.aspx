<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Integral.aspx.cs" Inherits="index_Integral" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>积分</title>
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
              <h1 class="title">积分</h1>
          </header>
           <div class="content integral">
               <div class="integral_head">
                   <div class="num">
                       <asp:Label ID="lbl_Points" runat="server" Text="Label"></asp:Label></div>
                   <div class="ms">
                       驴尾巴积分：积分可兑换消费券哦</div>
               </div>
               <div class="cash">
                   <a href="#"></a>兑换入口 <i class="icon icon-right pull-right"></i>
               </div>
               <ul class="details">
                   <li class="tit">积分明细</li>
                   <asp:Literal ID="Literal1" runat="server"></asp:Literal>
               </ul>
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
</body>
</html>
