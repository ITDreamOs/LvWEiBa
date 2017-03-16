<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DJQ_Code.aspx.cs" Inherits="API_DJQ_Code" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>二维码生成页面</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
</head>
<body>
    <div class="page-group">
        <div class="page page-current">
            <!-- 你的html代码 -->
            <form method="post" action="DJQ_Code.aspx">
                <div class="content">
                    <div class="list-block">
                        <ul>
                            <!-- Text inputs -->
                            <li>
                                <div class="item-content">
                                    <div class="item-media"><i class="icon icon-form-name"></i></div>
                                    <div class="item-inner">
                                        <div class="item-title label">代金券分组</div>
                                        <div class="item-input">
                                            <input type="text" id="djqje" readonly="readonly" placeholder="选择代金券分组">
                                        </div>
                                    </div>
                                </div>
                            </li>

                        </ul>
                    </div>
                    <div class="content-block">
                        <div class="row">
                            <a href="#" id="sublink" class="button button-big button-fill">生成对应二维码</a>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">分组二维码</div>
                        <div class="card-content">
                            <div class="card-content-inner" id="thiscode">
                                <img alt="" id="thiscodepic" width="98%" src="" />
                            </div>
                        </div>
                        <div class="card-footer" id="linktext">该二维码对应的链接：wx.lvweiba.com/index/ActiveForCode.aspx</div>
                    </div>
                </div>

            </form>

        </div>
    </div>

    <script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
    <script type="text/javascript">


        $(function () {
            $(document).on('click', '#sublink', function () {
                if ($("#djqje").val() == "") {
                    $.alert('分组必选', function () {
                        $("#djqje").focus();
                    });
                    return false;
                }


                else {
                    $.showPreloader('二维码计算生成中···')
                    //setTimeout(function () {
                    //    $.hidePreloader();
                    //}, 2000);
                    //$.ajax({
                    //    type: 'POST',
                    //    url: 'Fenzuerweima.ashx',
                    //    data: { fenzu: $("#djqje").val() },
                    //    dataType: 'json',
                    //    timeout: 300,
                    //    context: $('body'),
                    //    success: function (data) {
                    //        $.alert();
                    //    },
                    //    error: function (xhr, type) {
                    //        alert('网络延迟，请重试!')
                    //        $.hidePreloader();
                    //    }
                    //})
                    $.post('Fenzuerweima.ashx', { fenzu: $("#djqje").val() }, function (response) {
                        //console.log(response)
                        $("#thiscodepic").attr("src", response);
                        $("#linktext").html("该二维码对应的链接：wx.lvweiba.com/index/ActiveForCode.aspx?act=" + $("#djqje").val());
                        $.hidePreloader();
                    })
                }
            });
        });

        $(document).on('click', '#djqje', function () {
            var buttons1 = [
              {
                  text: '请选择',
                  label: true
              },
              {
                  text: 'A1',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("A1");
                  }
              },
              {
                  text: 'A2',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("A2");
                  }
              },
              {
                  text: 'A3',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("A3");
                  }
              },
              {
                  text: 'A4',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("A4");
                  }
              }
            ];
            var buttons2 = [
                              {
                                  text: 'B1',
                                  bold: true,
                                  onClick: function () {
                                      // $.alert("你选择了“卖出“");
                                      $("#djqje").val("B1");
                                  }
                              },
              {
                  text: 'B2',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("B2");
                  }
              },
              {
                  text: 'B3',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("B3");
                  }
              },
              {
                  text: 'B4',
                  bold: true,
                  onClick: function () {
                      // $.alert("你选择了“卖出“");
                      $("#djqje").val("B4");
                  }
              }
            ];
            var buttons3 = [
                  {
                      text: 'C1',
                      bold: true,
                      onClick: function () {
                          // $.alert("你选择了“卖出“");
                          $("#djqje").val("C1");
                      }
                  },
  {
      text: 'C2',
      bold: true,
      onClick: function () {
          // $.alert("你选择了“卖出“");
          $("#djqje").val("C2");
      }
  },
  {
      text: 'C3',
      bold: true,
      onClick: function () {
          // $.alert("你选择了“卖出“");
          $("#djqje").val("C3");
      }
  },
  {
      text: 'C4',
      bold: true,
      onClick: function () {
          // $.alert("你选择了“卖出“");
          $("#djqje").val("C4");
      }
  }
            ];

            var buttons4 = [
              {
                  text: '取消',
                  bg: 'danger'
              }
            ];
            var groups = [buttons1, buttons2, buttons3, buttons4];
            $.actions(groups);
        });
    </script>
</body>
</html>
