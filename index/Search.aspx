<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="index_Search" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>搜索页面</title>
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.min.css"> -->
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm.css">
    <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.css">
    <link rel="stylesheet" href="css/iconfont.css">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <!-- <link rel="stylesheet" href="http://g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css"> -->
    <link rel="stylesheet" href="css/reset.css">


    <link href="css/weui.min.css" rel="stylesheet" />
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //alert(1);
            ////页面加载
            //var req = new AreaRequest("", $('#AreaVal').val());
            //AjaxQueryArea(req);
            $('#BtnSearch').click(function () {
                var searchReq = new AreaRequest($('#searchInput').val(), $('#AreaVal').val());
                AjaxQueryArea(searchReq);
            });


        });

        /** 辅助方法：获取URL参数 **/
        function getQueryStringByName(name) {
            var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
            if (result == null || result.length < 1) {
                return "";
            }
            return result[1];
        }

        function GetTypeName(productTypes) {
            var tpname = "";
            switch (productTypes) {
                case "chujing":
                    tpname = "出境游";
                    break;
                case "guonei":
                    tpname = "国内游";
                    break;
                case "ziyouxing":
                    tpname = "自由行";
                    break;
                case "taiwan":
                    tpname = "台湾游";
                    break;
                case "zhoubian":
                    tpname = "周边游";
                    break;
                default:
                    tpname = "国内游";
                    break;
            }
            return tpname;
        }

        //请求体
        function AreaRequest(searchKey, AreaCode) //声明对象
        {
            this.keywords = searchKey;
            this.areacode = AreaCode;
        }
        //异步请求
        function AjaxQueryArea(request) {
            $.ajax({
                url: 'http://api.lvwei8.com/api/TouristRoutes/QueryTouristRoute',
                type: "post",
                data: {
                    "clientCommonInfo": { "areaCode": "410100", "board": "PLK-TL01H", "brand": "HONOR", "currentUserId": 5802897, "deviceId": "867628027609429", "isOffical": false, "lat": 34.819557, "lng": 113.690696, "model": "PLK-TL01H", "product": "PLK-TL01H", "sdk": "6.0", "terminalSource": 2, "terminalSourceVersion": "1.2.91" }, "page": {
                        "pageNo": 1,
                        "pageSize": 10000,
                        "pageCount": 1,
                        "recordCount": 4,
                        "pageExtend": "sample string 5"
                    },
                    "filterSortMap": {
                        "filterMap": {
                            "year": 1,
                            "month": 1
                        },
                        "sortMap": {
                            "date": 0
                        }
                    },
                    "syncId": Date.now(),
                    "param": request
                },
                dataType: "json",
                success: function (backdate) {
                    var isSuccess = backdate.errorCode == "0";
                    var resultHtml = $('#Areas');
                    if (isSuccess) {
                        resultHtml.empty();
                        var results = backdate.result;
                        if (results.length == 0) {
                            resultHtml.html('<p class="warning">没有搜索到相关数据<p/>');
                        } else {
                            for (var i = 0; i < results.length; i++) {
                                var productresult = results[i];
                                var dateNow = new Date();
                                var date = new Date(Date.parse(productresult.sdate));

                                var date3 = date.getTime() - dateNow.getTime();
                                //计算出相差天数
                                var days = Math.floor(date3 / (24 * 3600 * 1000));
                                //计算出小时数
                                var leave1 = date3 % (24 * 3600 * 1000)    //计算天数后剩余的毫秒数
                                var hours = Math.floor(leave1 / (3600 * 1000));
                                var sdate = days + '天' + hours + '小时';
                                var str = '<a href="showline.aspx?code=' + productresult.proNumCode + '&lineid=' + productresult.id + '" class="picks external">  <div class="head"> ' + productresult.sdate + ' ' + productresult.splace + '出发 <div class="seat">余位<em>' + productresult.adultTicketCount + '</em></div></div><div class="box"><img src="' + productresult.linePic + '" alt=""><div class="mask">' + productresult.tTl + '<div class="price">￥' + productresult.adultzkPrice + '</div></div><div class="agio">' + (10 * productresult.adultzkPrice / productresult.adultTicketPrice).toFixed(1) + '折</div><div class="type">' + GetTypeName(productresult.kindof) + '</div></div><div class="foot"> ' + productresult.provider + '<div class="time">剩<em>' + sdate + '</em></div></div></a>';
                                resultHtml.append(str);

                            }


                        }
                    }
                },
                error: function () {
                    alert('服务器错误');
                }
            });
        }
    </script>
</head>
<body>

    <div class="page-group">
        <!-- 你的html代码 -->
        <div class="page">
            <header class="bar bar-nav">
                <a class="icon icon-left pull-left back"></a>
                <h1 class='title'>搜索页面</h1>
            </header>
            

            <div class="content">
                    <div class="filter clearfix">
                         <div class="row">
                    <div class=" col-60">    <input type="text" class=" form-control" id="searchInput" placeholder="输入关键字.." /></div>
                    <div class=" col-15">      <input type="button" class=" form-control btn-warning" id="BtnSearch" value="搜索" /></div> 
                </div>  
                    </div>
                 
                <input type="hidden" id="AreaVal" value="<%#ViewState["AreaCode"].ToString()%>" />
                <input type="hidden" runat="server" value="" id="IsFirst" />
                <div class="row">
                    <div class="pick" id="Areas">
                        <%if ((bool)ViewState["IsFirst"])
                            {
                                var list = (List<LvULinesViewModel>)ViewState["List"];
                                var str = "";
                                foreach (var item in list)
                                {
                                    str += @"<a href='showline.aspx?code=" + item.ProNumCode + "&lineid=" + item.id + "' class='picks external'><div class='head'>" + (item.Sdate + "" + item.Splace) + "出发<div class='seat'>余位<em>" + item.adultTicketCount + "</em></div></div><div class='box'><img src='" + item.LinePic + "' alt=''><div class='mask'>" + item.TTl.ToString() + "<div class='price'>￥" + item.adultzkPrice + "</div></div><div class='agio'>" + zhekou(item.adultzkPrice.ToString(), item.adultTicketPrice.ToString()) + "折</div><div class='type'>" + typeget(item.Kindof) + "</div></div><div class='foot'>" + item.Provider + "<div class='time'>剩<em>" + Diffdatebynow(item.Enddate.ToString()) + "</em></div></div></a>";
                                }
                                Response.Write(str);
                            };%>
                    </div>
                </div>

            </div>
            <!-- content -->

        </div>
        <!-- page -->
    </div>
    <script type='text/javascript' src='http://g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>

    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm.js' charset='utf-8'></script>
    <script type='text/javascript' src='http://g.alicdn.com/msui/sm/0.6.2/js/sm-extend.js' charset='utf-8'></script>
    <script type="text/javascript" src="js/config.js"></script>



</body>
</html>
