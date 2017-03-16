<%@ Page Language="C#" AutoEventWireup="true" CodeFile="choose.aspx.cs" Inherits="index_choose" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>推荐有奖</title>
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
    <link href="css/base.css" rel="stylesheet" /> 

</head>
<body>
  <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">推荐有奖</h1>
          </header>
          <div class="content">
            <div class="choose">
      <asp:Image ID="Image1" runat="server" ImageUrl="images/bg.jpg" /></div>
            <div class="yellow">
              <div class="invite_btn" onclick="document.getElementById('mcover').style.display='block';">邀请好友</div>
              <div class="rule">优惠券&活动规则</div>
            </div>
            <!-- 遮罩层 -->
            <div class="mask"></div>
            <div class="popover">
              <div class="tit"><span>优惠券&活动规则</span></div>
              <ul>
                <li>1、您邀请的用户首次下单订购驴尾巴商品，邀请人将获得20元优惠券奖励(奖励将在订单完成24小时内发放)；</li>
                <li>2、邀请人向新用户发券的次数不限，邀请人领取奖励优惠券的上限为20张；</li>
                <li>3、新用户的标准为从未注册并使用过驴尾巴服务的用户；</li>
                <li>4、本优惠券可抵扣所有驴尾巴商品项目；</li>
                <li>5、本活动最终解释权归驴尾巴所有。</li>
              </ul>
              <div class="know">我知道了</div>
            </div>
          </div><!-- content --> 

          </div><!-- page -->
      </div>
    <div id="mcover" onclick="document.getElementById('mcover').style.display='';" style=""><img src="images/tishi.png"></div>

    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
</body>
</html>
