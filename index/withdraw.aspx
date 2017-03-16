<%@ Page Language="C#" AutoEventWireup="true" CodeFile="withdraw.aspx.cs" Inherits="index_withdraw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>提现</title>
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
    //js正则实现用户输入银行卡号的控制及格式化
<script language="javascript" type="text/javascript">
    function formatBankNo(BankNo) {
        if (BankNo.value == "") return;
        var account = new String(BankNo.value);
        account = account.substring(0, 22); /*帐号的总数, 包括空格在内 */
        if (account.match(".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null) {
            /* 对照格式 */
            if (account.match(".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" +
        ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null) {
                var accountNumeric = accountChar = "", i;
                for (i = 0; i < account.length; i++) {
                    accountChar = account.substr(i, 1);
                    if (!isNaN(accountChar) && (accountChar != " ")) accountNumeric = accountNumeric + accountChar;
                }
                account = "";
                for (i = 0; i < accountNumeric.length; i++) {    /* 可将以下空格改为-,效果也不错 */
                    if (i == 4) account = account + " "; /* 帐号第四位数后加空格 */
                    if (i == 8) account = account + " "; /* 帐号第八位数后加空格 */
                    if (i == 12) account = account + " "; /* 帐号第十二位后数后加空格 */
                    account = account + accountNumeric.substr(i, 1)
                }
            }
        }
        else {
            account = " " + account.substring(1, 5) + " " + account.substring(6, 10) + " " + account.substring(14, 18) + "-" + account.substring(18, 25);
        }
        if (account != BankNo.value) BankNo.value = account;
    }
    function limitInput(o) {
        var value = o.value;
        var min = 1;
        var max = <%=yue %>;
        if (parseInt(value) > max) {
            alert('输入金额超过账户余额！');
            o.value = max;
        }

    }
    function setvalue()
    {
    $("#cardname").val("1");
    $("#card").val("1");
    }
       function setvalue2()
    {
    $("#cardname").val("");
    $("#card").val("");
    }
      function setvalue3()
    {
    $("#txt_money").val("1");

    }
</script>
</head>
<body>

   <form runat=server>
  <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">提现</h1>
          </header>
          <div class="content recharge">
            <div class="price_pay">
              <p>账户余额<span><%=yue %> 元</span></p>
            </div>

       

            <div class="content-block-title">您可以提现到以下银行卡</div>
            <div class="list-block">
              <ul>
   
                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
              </ul>
            </div>

            <!-- add -->
            <div class="add">
              <a href="#" onclick="setvalue2()" class="open-popup">新增银行卡</a>
            </div>

            <div class="list-block">
              <div class="item-inner">
               <div class="item-title name">提现金额</div>
                <div class="item-input">
                <input id="txt_money" required name="money" onkeyup="limitInput(this);"  type="number" placeholder="请输入提现金额">
                </div>
              </div>
            </div>
       <div class="content-block tp05">
           <div class="row no-gutter">
               <div class="col-100">
       <asp:Button ID="btnMoney" class="button button-big " runat="server" Text="提现"  OnClientClick="setvalue()" onclick="btnMoney_Click"/>
           <%--        <asp:Button ID="btn_Tx" class="button button-big " runat="server" Text="提现" OnClick="btn_Tx_Click" />--%>
                   
                   </div>
           </div>
       </div>
        </div><!-- content --> 
          </div> <!-- page -->
        <!-- About Popup 新增银行卡--> 
        <div class="popup">
           <header class="bar bar-nav">
              <h1 class="title">新增银行卡</h1>
          </header>
          <!-- 银行卡表单 -->
          <div class="list-block">
    <ul>
      <!-- Text inputs -->
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">姓名</div>
            <div class="item-input">
              <input id="cardname" name="name" type="text" value="" placeholder="请输入姓名" required>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-gender"></i></div>
          <div class="item-inner">
            <div class="item-title label">银行</div>
            <div class="item-input">

              <asp:DropDownList
       ID="ddl_bank" runat="server">

        <asp:ListItem>中国银行</asp:ListItem>
                <asp:ListItem>中国工商银行</asp:ListItem>
                <asp:ListItem>中国建设银行</asp:ListItem>
                <asp:ListItem>中国农业银行</asp:ListItem>
                <asp:ListItem>招商银行</asp:ListItem>
                <asp:ListItem>交通银行</asp:ListItem>
   </asp:DropDownList>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-password"></i></div>
          <div class="item-inner">
            <div class="item-title label">卡号</div>
            <div class="item-input">
              
              <input required type="text" value=""  placeholder="请输入卡号"  size="25" onkeyup="formatBankNo(this)" onkeydown="formatBankNo(this)" name="card" id="card">
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
  <div class="login_btn">
   <asp:Button ID="btn_Tj" class="button button-big " runat="server" Text="保存信息" OnClientClick="setvalue3()" onclick="btn_Tj_Click" />
 <%--   <a href="#" class="close-popup">保存信息</a>--%>
  </div>

        </div>

          </div><!-- pagebox -->
 
 </form>
</body>
</html>
   <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>