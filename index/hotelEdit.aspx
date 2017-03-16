<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hotelEdit.aspx.cs" Inherits="index_hotelEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>修改旅客信息</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css" />
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css" />
    <link rel="stylesheet" href="css/iconfont.css" />
    <link rel="stylesheet" href="css/reset.css" />
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
    <form id="form1" runat="server">
        <div class="page-group">
            <!-- 你的html代码 -->
            <div class="page">
                <header class="bar bar-nav">
                    <a class="icon icon-left pull-left back"></a>
                    <h1 class="title">修改旅客信息</h1>
                </header>
                <div class="content reservation">
                    <div class="list-block">
                        <ul>
                            <li>
                                <div class="item-content">
                                    <div class="item-media"><i class="icon icon-form-name"></i></div>
                                    <div class="item-inner">
                                        <div class="item-title label">姓名</div>
                                        <div class="item-input">
                                            <asp:TextBox runat="server" ID="hotelname" placeholder="请填写旅客姓名"></asp:TextBox>
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
                                            <asp:TextBox runat="server" ID="card" placeholder="请填写身份证"></asp:TextBox>
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
                                            <asp:TextBox runat="server" ID="Mobile" placeholder="请填写手机号"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="item-content">
                                    <div class="item-media"><i class="icon icon-form-gender"></i></div>
                                    <div class="item-inner">
                                        <div class="item-title label">乘客类型</div>
                                        <div class="item-input">
                                            <asp:DropDownList runat="server" ID="hotelType">
                                            </asp:DropDownList>
                                        </div>
                                        <%--<div class="item-input">
                                            <select id="type" name="type">
                                                <option value="0">成人</option>
                                                <option value="1">儿童</option>
                                            </select>
                                        </div>--%>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="content-block">
                        <div class="row no-gutter">
                            <div class="col-100">
                                <asp:Button CssClass="button button-big" ID="Button1" runat="server" Text="确定修改" OnClick="Button1_Click" OnClientClick="return checkParams()" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- content -->
            </div>
            <!-- page -->
            <asp:HiddenField ID="hotelId"  runat="server"/>
        </div>
        <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
        <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
        <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
        <script type="text/javascript" src="js/config.js?version=222221"></script>
    </form>
</body>
</html>
