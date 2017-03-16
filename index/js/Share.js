wx.config({
    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId: 'wx1bbadc0beedbcc39', // 必填，公众号的唯一标识
    timestamp: , // 必填，生成签名的时间戳
    nonceStr: '', // 必填，生成签名的随机串
    signature: '',// 必填，签名，见附录1
    jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
$(function () {
    $(document).on('click', '#shareweixin', function () {
        wx.onMenuShareTimeline({
            title: '这个旅游线路很不错，谁愿意和我一起去哦', // 分享标题
            link: 'wx.lvwei8.com/index/show.html', // 分享链接
            imgUrl: 'http://lwb.0351ets.com/media/ProductConTPIC/201604/ss635975428396828467.jpg', // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
            }
        });
    });
});