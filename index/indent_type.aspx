<%@ Page Language="C#" AutoEventWireup="true" CodeFile="indent_type.aspx.cs" Inherits="index_indent_type" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>订单列表</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
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
    <form id="form1" runat="server">
     <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">订单列表</h1>
          </header>
          <div class="content">
            <div class="buttons-tab">
    <a href="#tab1" class="tab-link active button">未支付</a>
    <a href="#tab2" class="tab-link button">待出行</a>
    <a href="#tab3" class="tab-link button">已完成</a>
    <a href="#tab4" class="tab-link button">待评价</a>
  </div>
  <div class="content-block">
    <div class="tabs">
      <div id="tab1" class="tab active">
        <div class="content-block">
          <ul class="list">
           <asp:Literal ID="lit_wzf" runat="server"></asp:Literal>
          </ul>
         
        </div>
      </div>
      <div id="tab2" class="tab">
        <div class="content-block">
             <ul class="list">
           <asp:Literal ID="lit_dcx" runat="server"></asp:Literal>
          </ul>
        </div>
      </div>
      <div id="tab3" class="tab">
        <div class="content-block">
             <ul class="list">
           <asp:Literal ID="lit_ywc" runat="server"></asp:Literal>
          </ul>
        </div>
      </div>
      <div id="tab4" class="tab">
        <div class="content-block">
             <ul class="list">
           <asp:Literal ID="lit_dpj" runat="server"></asp:Literal>
          </ul>
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
