<%@ Page Language="C#" AutoEventWireup="true" CodeFile="indent_ticket_fill.aspx.cs" Inherits="index_indent_ticket_fill" %>

<!DOCTYPE html>

<html>
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
    <script type="text/javascript">
        function checkParams() {
            var name = $("#userName").val();
            var card = $("#identityCard").val();
            var mobile = $("#mobile").val();
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            if (name.length <= 0) {
                alert("姓名不为空");
                return false;
            }
            if (card.length <= 0) {
                alert("身份证不为空");
                return false;
            }
            if (reg.test(card) === false) {
                alert("身份证输入不合法");
                return false;
            }
            if (!(/^1[3|4|5|7|8]\d{9}$/.test(mobile))) {
                alert("手机号格式不合法!");
                return;
            }
            return true;
        }
    </script>
</head>
<body>

    <div class="page-group">
        <!-- 你的html代码 -->
        <div class="page">
            <form id="form1" runat="server">
                <header class="bar bar-nav">
                    <a class="icon icon-left pull-left back"></a>
                    <h1 class="title">订单填写</h1>
                </header>
                <div class="content">
                    <div class="list-block ticket-fill">
                        <ul>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">商品名称</div>
                                    <div class="item-after"><%=ticketTitle%>门票</div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">产品编号</div>
                                    <div class="item-after"><%=ticketId%></div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">有效日期</div>
                                    <div class="item-after"><%=startDate %>至<%=endDate %></div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">购买张数</div>
                                    <div class="item-after">
                                        <%=reserverCount%>
                                    </div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">订单金额</div>
                                    <div class="item-after">
                                        <asp:Label ID="orderPriceLbl" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <div class="jine">
                                <asp:Literal ID="priceDetailLbl" runat="server"></asp:Literal>
                                <%--<p>市场价：<del>￥8500</del></p>
                                <p>优惠价：￥7500</p>
                                <p>总计：￥15000</p>--%>
                            </div>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">选择联系人</div>
                                </div>
                            </li>
                        </ul>
                        <!--选择联系人-->
                         <ul>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div id="div_hotel" class="item-title">
                                        <asp:Literal ID="contactPersonsLiteral" runat="server"></asp:Literal>
                                        <%--       <input id="Checkbox1" name="hotel" class="hotel" type="checkbox" value="1" />李明
                              <input id="Checkbox2" name="hotel" class="hotel"  type="checkbox" value="1" />李明2--%>
                                    </div>
                                </div>
                            </li>
                        </ul>

                        <li class="item-content">
                            <div class="item-inner">
                                <div class="item-title">新增旅客</div>
                                <asp:Button class="button" ID="addContactPerson" runat="server" Text="添加" Width="100" OnClick="addContactPerson_Click" OnClientClick="return checkParams()" />
                            </div>
                        </li>
                        <div class="list-block">
                            <ul>
                                <li>
                                    <div class="item-content">
                                        <div class="item-media"><i class="icon icon-form-name"></i></div>
                                        <div class="item-inner">
                                            <div class="item-title label">姓名</div>
                                            <div class="item-input">
                                                <input id="userName" name="userName" type="text" placeholder="请填写联系人姓名">
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="item-content">
                                        <div class="item-media"><i class="icon icon-form-name"></i></div>
                                        <div class="item-inner">
                                            <div class="item-title label">手机</div>
                                            <div class="item-input">
                                                <input id="mobile" name="mobile" type="text" placeholder="请填写手机号">
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="item-content">
                                        <div class="item-media"><i class="icon icon-form-name"></i></div>
                                        <div class="item-inner">
                                            <div class="item-title label">身份证</div>
                                            <div class="item-input">
                                                <input id="identityCard" name="identityCard" type="text" placeholder="请填写身份证信息">
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="last-content-block content-block indent">
                            <div class="col-100">
                                <asp:Button class="button button-big" ID="btn_submit" OnClick="btn_submit_Click" runat="server" Text="提交订单"  />
                            </div>
                        </div>
                    </div>
                    <!-- content -->
                <asp:HiddenField ID="hid_ticket_id" runat="server" />
                <asp:HiddenField ID="hid_lb" runat="server" />
                <asp:HiddenField ID="hid_price_sc" runat="server" />
                <asp:HiddenField ID="hid_price_yh" runat="server" />
                <asp:HiddenField ID="hid_price_jj" runat="server" />
                <asp:HiddenField ID="hid_count" runat="server" />
                <asp:HiddenField ID="HiddenFieldBZ" runat="server" />
                </div>
                <!-- page -->
            </form>
        </div>
        <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
        <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
        <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
        <script type="text/javascript" src="js/config.js"></script>
</body>
</html>
