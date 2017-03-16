$(document).ready(function () {

    var num = 1; //计数器初始化为1

    var maxnum = 10; //设置一共要加载几次
    //  alert("http://wx.lvwei8.com/index/control/loadlineData.aspx?kindof=");

    $(window).scroll(function () {

        checkload();

    });

    //建立加载判断函数

    function checkload() {

        var srollPos = $(window).scrollTop(); //滚动条距离顶部的高度

        var windowHeight = $(window).height(); //窗口的高度

        var dbHiht = $("body").height(); //整个页面文件的高度

        s = setTimeout(function () {

            if ((windowHeight + srollPos) >= (dbHiht) && num != maxnum) {

                num++; //计数器+1
                $("#loading").show(100);
                 LoadList($("#HiddenFieldchanle").val());

            }

        }, 500);

    }

    //创建ajax加载函数，并设置变量C，用于输入调用的页面频道,请根据实际情况判断使用，非必要。

    function LoadList(c) {

        $.get("http://wx.lvwei8.com/index/control/loadlineData.aspx?kindof=" + c + "&pageindex=" + num, function (result) {

            t = setTimeout(function () { $("#list_box").append(result) }, 1);

        });

    }

});