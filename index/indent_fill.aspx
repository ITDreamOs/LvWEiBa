<%@ Page Language="C#" AutoEventWireup="true" CodeFile="indent_fill.aspx.cs" Inherits="index_indent_fill" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>填写订单</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css"> -->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css" />
    <link rel="stylesheet" href="css/iconfont.css" />
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css"/> -->
    <link rel="stylesheet" href="css/reset.css" />
    <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
    <script src="http://res.mail.qq.com/mmr/static/lib/js/jquery.js" type="text/javascript"></script>

    <style type="text/css">
        .hotel {
            margin-left: 20px;
        }
    </style>
    <script type="text/javascript">
        function addhotel() {
            if (document.getElementById("hotelname").value != "") {
                var checkBox = document.createElement("input");
                checkBox.setAttribute("type", "checkbox");

                checkBox.setAttribute("name", "hotel");

                document.getElementById("div_hotel").appendChild(checkBox);

            }
        }
        function checkParams() {
            var name = $("#hotelname").val();
            var card = $("#card").val();
            var mobile = $("#Mobile").val();
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
                    <div class="list-block">
                        <ul>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">商品名称</div>
                                    <div class="item-after">
                                        <asp:Label ID="lbl_ProName" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">产品编号</div>
                                    <div class="item-after">
                                        <asp:Label ID="lbl_ProNum" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">出发日期</div>
                                    <div class="item-after">
                                        <asp:Label ID="lbl_Cfdate" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">出发城市</div>
                                    <div class="item-after">
                                        <asp:Label ID="lbl_Cfcity" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">预订人数</div>
                                    <div class="item-after">
                                        <asp:Label ID="lbl_Ydrs" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">订单金额</div>
                                    <div class="item-after">
                                        <asp:Label ID="lbl_DDjE" runat="server" Text=""></asp:Label>
                                    </div>
                                </div>
                            </li>
                            <div class="jine">

                                <asp:Literal ID="li_jine" runat="server"></asp:Literal>
                                <%-- <p>市场价：￥8500（成人￥3000 x2；儿童￥2500 x1）</p>
                       <p>优惠价：￥8500（成人￥3000 x2；儿童￥2500 x1）</p>--%>
                            </div>

                            <div class="point">
                                重要提示：所有产品均按市场价支付，旅行结束后48小时内
                    驴尾巴网将差价返还至会员现金账户，会员可自由选择提现
                    或二次消费。<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                            </div>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div class="item-title">选择旅客</div>

                                </div>

                            </li>
                        </ul>

                        <ul>
                            <li class="item-content">
                                <div class="item-inner">
                                    <div id="div_hotel" class="item-title">
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                        <%--       <input id="Checkbox1" name="hotel" class="hotel" type="checkbox" value="1" />李明
                              <input id="Checkbox2" name="hotel" class="hotel"  type="checkbox" value="1" />李明2--%>
                                    </div>
                                </div>
                            </li>
                            <asp:Literal ID="lit_hotel" runat="server"></asp:Literal>
                        </ul>

                        <li class="item-content">
                            <div class="item-inner">
                                <div class="item-title">新增旅客</div>
                                <asp:Button class="button" ID="Button1" runat="server" Text="添加" Width="100" OnClick="Button1_Click" OnClientClick="return checkParams()" />
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
                                                <input id="hotelname" name="hotelname" type="text" placeholder="请填写旅客姓名">
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="item-content">
                                        <div class="item-media"><i class="icon icon-form-email"></i></div>
                                        <div class="item-inner">
                                            <div class="item-title label">身份证</div>
                                            <div class="item-input">
                                                <input id="card" name="card" type="text" placeholder="请填写身份证">
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
                                                <input id="Mobile" name="Mobile" type="text" placeholder="请填写手机号">
                                            </div>
                                        </div>
                                    </div>
                                </li>

                            </ul>
                        </div>
                    </div>
                    <div class="content-block indent">
                        <div class="col-100" id="subdiv">
                            <asp:Button class="button button-big " ID="btn_submit" runat="server" Text="提交订单" OnClick="btn_submit_Click" />
                        </div>
                    </div>
                </div>
                <!-- content -->
                <asp:HiddenField ID="hid_pronum" runat="server" />
                <asp:HiddenField ID="hid_lb" runat="server" />
                <asp:HiddenField ID="hid_price_sc" runat="server" />
                <asp:HiddenField ID="hid_price_yh" runat="server" />
                <asp:HiddenField ID="hid_price_jj" runat="server" />
                <asp:HiddenField ID="hid_count" runat="server" />
                <asp:HiddenField ID="HiddenFieldBZ" runat="server" />

            </form>
        </div>
        <!-- page -->
    </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>



</body>
</html>
