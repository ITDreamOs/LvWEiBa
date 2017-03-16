<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reservation.aspx.cs" Inherits="index_Reservation" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>尾单预约</title>
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
    <script>
        function del(id,num) {
            PageMethods.Del(id,num, CheckIsSuccess);
        }
        function CheckIsSuccess(result) {
           // alert(result);
        }
    </script>
</head>

<body>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"> 
</asp:ScriptManager>
        <asp:HiddenField ID="uid" runat="server" />
     <div class="page-group">
      <!-- 你的html代码 -->
      <div class="page">
          <header class="bar bar-nav">
              <a class="icon icon-left pull-left back"></a>
              <h1 class="title">尾单预约</h1>
          </header>
      <div class="content reservation">
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    <!-- 尾单预约 -->
    <div class="list-block">
    <ul>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">目的地1</div>
            <div class="item-input">
              <input type="text" placeholder="必填" runat=server id="txt_Place1" required>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-email"></i></div>
          <div class="item-inner">
            <div class="item-title label">目的地2</div>
            <div class="item-input">
              <input type="text" placeholder="选填"  runat=server id="txt_Place2">
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">目的地3</div>
            <div class="item-input">
              <input id="txt_Place3" type="text" placeholder="选填"  runat=server />


            </div>
          </div>
        </div>
      </li>
      <!-- Date -->
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-calendar"></i></div>
          <div class="item-inner">
            <div class="item-title label">开始时间</div>
            <div class="item-input">
            <input  id="txt_Begin"  type="date" name="txt_Begin"  value="2016-05-01"  />
            <%--  <input id="txt_Begin" type="text" placeholder="Birth day" value="2014-04-30" runat=server required/>--%>
            </div>
          </div>
        </div>
      </li>
           <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-calendar"></i></div>
          <div class="item-inner">
            <div class="item-title label">结束时间</div>
            <div class="item-input">
            

<input  id="txt_End"  type="date" name="txt_End"  value="2016-05-01"  />


             <%-- <input id="txt_End" type="text" placeholder="Birth day" value="2014-05-30" runat=server required/>--%>
            </div>
          </div>
        </div>
                
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><i class="icon icon-form-name"></i></div>
          <div class="item-inner">
            <div class="item-title label">我的电话</div>
            <div class="item-input">
              <input id="txt_Mobile" name="private_phone" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" maxlength="11" placeholder="必填" runat=server required/>
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
    <div class="content-block tp05">
    <div class="row no-gutter">
      <div class="col-100">
          <asp:Button ID="btn_Tj" class="button button-big " runat="server" Text="提交预约" onclick="btn_Tj_Click" /></div>
    </div>
  </div>
      </div><!-- content --> 

      </div><!-- page -->
      </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>
    <asp:HiddenField ID="hid_id" runat="server" />
    </form>
</body>
</html>
