<%@ Page Language="C#" AutoEventWireup="true" CodeFile="aboutme.aspx.cs" Inherits="aboutme" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
         <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>个人资料</title>
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
    <script>

        function Check() {
            var tel = $('#txt_tel').val();
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
                alert("手机号格式有误");

                return false;
            }
            var card = $('#txt_card').val(); 
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            if (reg.test(card) === false) {
                alert("身份证输入不合法");
                return false;
            }
            var mail = $('#txt_mail').val();
            var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(mail))
            {
                alert('您的邮箱格式不正确');
                return false;
            }

            var pwd = $('#txt_pwd').val(); 
            var pwd2 = $('#txt_pwd2').val(); 
            if (pwd.length < 6) {
                alert('对不起，您的密码小于六位!');
                return false;
            }
            if (pwd != pwd2) {
                alert('对不起，您两次输入的密码不一致!');
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">个人资料</h1>
          </header>
          <div class="content aboutme">
          <div class="user_about">
            <div class="head"><img src="images/head.jpg"></div>
          </div>

          <div class="list-block">
    <ul>
      <!-- Text inputs -->
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">用户名</div>
            <div class="item-input">
              <input id="txt_user"  name="txt_user" value="<%=nickname %>"  type="text" placeholder="用户名" required>
            </div>
          </div>
        
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-email"></i></div>
          <div class="item-inner">
            <div class="item-title label">手机号</div>
            <div class="item-input">
            <input id="txt_tel" name="txt_tel"  value="<%=Tel %>" type="text" placeholder="手机号"  required>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-password"></i></div>
          <div class="item-inner">
            <div class="item-title label">姓名</div>
            <div class="item-input">

        <input id="txt_xm" name="txt_xm"  value="<%=MemberName %>" type="text" placeholder="姓名"  required/>
              
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-gender"></i></div>
          <div class="item-inner">
            <div class="item-title label">性别</div>
            <div class="item-input">
            
        <asp:DropDownList ID="ddl_sex" runat="server">
        <asp:ListItem Value="1">男</asp:ListItem>
                <asp:ListItem Value="2">女</asp:ListItem>
        </asp:DropDownList>
            </div>
          </div>
        </div>
      </li>
       <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-password"></i></div>
          <div class="item-inner">
            <div class="item-title label">身份证</div>
            <div class="item-input">
            <input id="txt_card" name="txt_card"  value="<%=Card %>"  type="text" placeholder="身份证" required  />
            </div>
          </div>
        </div>
      </li>
       <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-password"></i></div>
          <div class="item-inner">
            <div class="item-title label">邮箱</div>
            <div class="item-input">
              <input id="txt_mail" name="txt_mail"  value="<%=Mail %>"  type="text" placeholder="邮箱"  required>
            </div>
          </div>
        </div>
      </li>
 <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-password"></i></div>
          <div class="item-inner">
            <div class="item-title label">密码</div>
            <div class="item-input">
              <input id="txt_pwd" name="txt_pwd"   value="<%=Pwd %>" type="password" placeholder="密码" required>
            </div>
          </div>
        </div>
      </li>
       <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-password"></i></div>
          <div class="item-inner">
            <div class="item-title label">确认密码</div>
            <div class="item-input">
              <input id="txt_pwd2" name="txt_pwd2" value="<%=Pwd %>"  type="password" placeholder="确认密码"  required>
            </div>
          </div>
        </div>
      </li>

    </ul>
  </div>
  <div class="content-block tp15">
    <div class="row">
      <div class="col-50">
        <asp:Button ID="btn_Tj" class="button button-big button-fill but1" runat="server" Text="确定" OnClientClick=" return Check()" onclick="btn_Tj_Click" />
</div>
      <div class="col-50">
     <input class="button button-big button-fill but2"  type="button" value="取消" 
onclick="javascrtpt:window.location.href='Myindex.aspx'">
</div>
    </div>
  </div>
            
          </div><!-- content --> 

          </div><!-- page -->
      </div>
    </form>
</body>
</html>
  <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
