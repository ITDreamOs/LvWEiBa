$(function () {

    // 详情页
    var myPhotoBrowserCaptions = $.photoBrowser({
        photos: [
            {
                url: 'images/sanya.jpg',
                caption: '第一张图片文字说明'
            },
            {
                url: 'images/sanya.jpg',
                caption: '第二张图片文字说明'
            },
            {
                url: 'images/sanya.jpg',
                caption: '第三张图片文字说明'
            },
        ],
        type: 'popup'
    });
    $(document).on('click', '.swiper-wrapper', function () {
        myPhotoBrowserCaptions.open();
    });

    // 选项卡
    $(document).on('click', '.tabs1 li', function () {
        $(this).addClass("active").siblings().removeClass("active");
    });
    //加减
    $(document).on('click', '.decrease', function () {
        var this_ = $(this).siblings(".spi_num");
        var this_val = (parseInt(this_.text()) - 1);
        if (this_val < 0) {
            this_val = 0;
        }
        this_.text(this_val);
        var adnum = $("#adultnum").text();
        var punum = $("#puppynum").text();
        var lineid = $("#HiddenFieldid").val();
        var myDate = new Date();

        var newurl = "http://wx.lvwei8.com/index/redirect.aspx?ticks=" + myDate.getMilliseconds() + "&adult=" + adnum + "&children=" + punum + "&lineid=" + lineid;//支付成功后的跳转页面
        $('#yudingbtn').attr('href', newurl);
        // alert(newurl);
    })

    $(document).on('click', '.increase', function () {
        var this_ = $(this).siblings(".spi_num");
        var this_max = $(this).siblings(".spi_maxnum");
        var max = parseInt(this_max.text());
        var this_val = (parseInt(this_.text()) + 1);
        if (this_val > max)
        { this_val = max; }
        this_.text(this_val);

        var adnum = $("#adultnum").text();
        var punum = $("#puppynum").text();
        var lineid = $("#HiddenFieldid").val();
        var myDate = new Date();
        var newurl = "http://wx.lvwei8.com/index/redirect.aspx?ticks=" + myDate.getMilliseconds() + "&adult=" + adnum + "&children=" + punum + "&lineid=" + lineid;//支付成功后的跳转页面

        $('#yudingbtn').attr('href', newurl);
        // alert(newurl);
    })

    //预约页面

    //删除成功
    $(document).on('click', '.rereserved li i', function () {
        $.post("control/HotelHandler.ashx", { "id": this.id }, function (result) {
                $(this).parent().remove();
                $.toast("删除成功") //toast提示框提升用户体验。
        })
        //上面的this没有意义
        $(this).parent().remove();
    })

    $(document).on('click', '.rereserved li', function () {
        window.location.href = "hotelEdit.aspx?id=" + this.id;
    })



    //注册页面
    $(document).on('click', '.get', function (event) {
        event.preventDefault();
        var btn = $(this);
        var count = 10;
        var resend = setInterval(function () {
            count--;
            if (count > 0) {
                btn.text(count + "秒后可重新获取").attr("style", "background-color:#ccc;");
            } else {
                clearInterval(resend);
                btn.text("获取验证码").removeAttr('style');
            }
        }, 1000);
    })
    // 找回密码页面
    $(document).on('click', '.get2', function (event) {
        event.preventDefault();
        var btn = $(this);
        var count = 60;
        var resend = setInterval(function () {
            count--;
            if (count > 0) {
                btn.text(count + "秒后可重新获取").attr("style", "background-color:#ccc;");
            } else {
                clearInterval(resend);
                btn.text("获取验证码").removeAttr('style');
            }
        }, 1000);
    })

    // 推荐有奖
    $(document).on('click', '.rule', function () {
        $(".mask").show();
        $(".popover").show();
    })
    $(document).on('click', '.know', function () {
        $(".mask").hide();
        $(".popover").hide();
    })

    $.init();


})

