 $(function(){

// 详情页
  var myPhotoBrowserCaptions = $.photoBrowser({
      photos : [
          {
              url: 'images/sanya.jpg',
              caption: '第一张图片文字说明'
          },
          {
              url: 'images/sanya.jpg',
              caption: '第二张图片文字说明'
          },
          {
              url:  'images/sanya.jpg',
              caption: '第三张图片文字说明'
          },
      ],
      type: 'popup'
  });
  $(document).on('click','.swiper-wrapper',function () {
    myPhotoBrowserCaptions.open();
  });

  // 选项卡
  $(document).on('click','.tabs1 li',function(){
    $(this).addClass("active").siblings().removeClass("active");
  });
  //加减
  $(document).on('click','.decrease',function(){
    var this_=$(this).siblings(".spi_num");
    var this_val=(parseInt(this_.text())-1);
    if(this_val<0){
      this_val=0;
    }
    this_.text(this_val);
  })

  $(document).on('click','.increase',function(){
    var this_=$(this).siblings(".spi_num");
    var this_val=(parseInt(this_.text())+1);
    this_.text(this_val);
  })

  //预约页面

    //删除成功
  $(document).on('click','.rereserved li i',function(){
    $(this).parent().remove();
      $.toast("删除成功") //toast提示框提升用户体验。
  })

//注册页面
$(document).on('click','.get',function(event){
  event.preventDefault();
  var btn=$(this);
  var count = 10;
  var resend = setInterval(function(){
      count--;
      if (count > 0){
          btn.text(count+"秒后可重新获取").attr("style","background-color:#ccc;");
      }else {
          clearInterval(resend);
          btn.text("获取验证码").removeAttr('style');
      }
  }, 1000);
 })
  // 找回密码页面
  $(document).on('click','.get2',function(event){
  event.preventDefault();
  var btn=$(this);
  var count = 60;
  var resend = setInterval(function(){
      count--;
      if (count > 0){
          btn.text(count+"秒后可重新获取").attr("style","background-color:#ccc;");
      }else {
          clearInterval(resend);
          btn.text("获取验证码").removeAttr('style');
      }
  }, 1000);
 })

   // 推荐有奖
   $(document).on('click','.invite_btn',function(){
    $(".mask").show();
    $(".popover").show();
   })
   $(document).on('click','.know',function(){
    $(".mask").hide();
    $(".popover").hide();
   })


  $.init();


})
