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
        refreshReserverRef();
    })

    $(document).on('click', '.increase', function () {
        var this_ = $(this).siblings(".spi_num");
        var this_max = $(this).siblings(".spi_maxnum");
        var max = parseInt(this_max.text());
        var this_val = (parseInt(this_.text()) + 1);
        if (this_val > max)
        { this_val = max; }
        this_.text(this_val);
        refreshReserverRef()
    })

    function refreshReserverRef() {
        var ticket_count = $("#ticket_count").text();
        var ticket_id = $("#HiddenFieldid").val();
        var myDate = new Date();
        var newurl = "http://wx.lvwei8.com/index/indent_ticket_fill.aspx?reserverCount=" + ticket_count + "&ticketId=" + ticket_id;
        $('#yudingbtn_ticket').attr('href', newurl);
    }

    //预约页面

    //删除成功
    $(document).on('click', '.rereserved li i', function () {
        $(this).parent().remove();
        $.toast("删除成功") //toast提示框提升用户体验。
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

