// 数据中心
var selectedPassengers = []; // 订单选中的乘客
var passengerList = {}; // 可选的所有乘客

// dom节点
var passengerListDom = null;

/**
  方法：更新passengerList
  */
function updatePassengerList(list) {
  for (var i = 0; i < list.length; i++) {
    passengerList[list[i].id] = list[i];
  }
}

/**
  方法：取总数据
  */
function getPassengerData() {
  if (selectedPassengers.length < 1) {
    alert('请至少选择一位旅客');
    return null;
  }
  var contactPhone = $('.contact-phone input').val();
  if (!(/^1[34578]\d{9}$/.test(contactPhone))) {
    alert('请填写正确的手机号码');
    return null;
  }
  var passengers = [];
  for (var i = 0; i < selectedPassengers.length; i++) {
    passengers.push(passengerList[selectedPassengers[i]]);
  }
  return {
    passengers: passengers,
    contactPhone: contactPhone
  };
}

/**
  方法：插入订单预定页面旅客数据
  data: 数组
  dom: html元素
  */
function selectPassengers(data, dom) {
  for (var i = 0; i < data.length; i++) {
    dom.append([
      '<li class="passenger-select" data-id="' + passengerList[data[i]].id + '">',
        '<i class="icon-del" data-id="' + passengerList[data[i]].id + '"></i>',
        '<div class="passenger-info">',
          '<div class="passenger-name">' + passengerList[data[i]].personName + '</div>',
          '<div class="passenger-idcard">' + (passengerList[data[i]].birthDate ? '出生日期：' + passengerList[data[i]].birthDate : passengerList[data[i]].idCard) + '</div>',
          '<div class="passenger-type">' + (passengerList[data[i]].type === 'adult' ? '成人票' : '儿童票') +'</div>',
        '</div>',
      '</li>'
    ].join().replace(/,/g, ''));
  }
  // 更新数据
  selectedPassengers = selectedPassengers.concat(data);
}

/**
  方法：删除订单预定页面旅客数据
  data: 数组
  dom: html元素
  */
function removePassengers(data, dom) {
  var domList = dom.find('.passenger-select');
  if (data) {
    domList.each(function(index) {
      var el = $(this);
      if (data.indexOf(el.data('id')) > -1) {
        el.remove();
        // 更新数据
        var newPassengerList = [];
        for (var i = 0; i < selectedPassengers.length; i++) {
          if (selectedPassengers[i] != el.data('id')) {
            newPassengerList.push(selectedPassengers[i]);
          }
        }
        selectedPassengers = newPassengerList;
      }
    });
  } else {
    domList.remove();
    selectedPassengers = [];
  }

  console.log(selectedPassengers);
}

/**
  方法：插入常用旅客列表数据
  data: 数组
  */
function insertPassengerList(data) {
  var domList = $('.J_adult_list').find('.passenger-list');
  if (data) {
    var domStr = '';
    for (var i = 0; i < data.length; i++) {
      if (data[i].type === 'adult') {
        domStr += [
          '<li class="passenger-select selected" data-id="' + data[i].id + '">',
            '<i class="icon-tick"></i>',
            '<div class="passenger-info">',
              '<div class="passenger-name">' + data[i].personName + '<span class="extra-name">（成人票）</span></div>',
              '<div class="passenger-idcard">' + data[i].idCard + '</div>',
            '</div>',
            '<div class="edit-con">',
              '<i class="icon-editboard" data-id="' + data[i].id + '"></i>',
            '</div>',
          '</li>'
        ].join().replace(/,/g, '');
      }
      domList.append(domStr);
      // 更新数据
      passengerList[data[i].id] = data[i];
      // 默认订单页选中
      selectPassengers([data[i].id], passengerListDom);
    }
  }

  console.log(passengerList);
}

/**
  方法：删除常用旅客列表数据
  data: 数组
  */
function removePassengerList(data) {
  var domList = $('.J_adult_list').find('.passenger-select');
  if (data) {
    domList.each(function(index) {
      var el = $(this);
      console.log(data, el.data('id'));
      if (data.indexOf(el.data('id').toString()) > -1) {
        el.remove();
        // 处理预定页面的删除
        removePassengers([el.data('id')], passengerListDom);
        // 更新常用旅客列表数据
        var newObj = {};
        for (var i in passengerList) {
          if (passengerList[i].id != el.data('id')) {
            newObj[passengerList[i].id] = passengerList[i];
          }
        }
        passengerList = newObj;
      }
    });
  } else {
    domList.remove();
    passengerList = {};
  }

  console.log(passengerList);
}

/**
  方法：唤出成人旅客列表
 */
function showAdultPassengers() {
  // 先加载框架
  $('body').append([
    '<div class="passenger-mask J_adult_list">',
      '<header class="bar bar-nav">',
        '<a class="icon icon-left pull-left passenger-back"></a>',
        '<h1 class="title">常用旅客</h1>',
      '</header>',
    '</div>'
  ].join().replace(/,/g, ''));
  // 出动画
  var passengerMask;
  setTimeout(function() {
    passengerMask = $('.J_adult_list');
    passengerMask.addClass('slide-in');
  }, 100);
  // 动画完毕后载数据
  setTimeout(function() {
    // 拼接列表
    var domStr = '';
    console.log('load data', passengerList);
    for (var i in passengerList) {
      if (passengerList[i].type === 'adult') {
        var isSelected = selectedPassengers.indexOf(passengerList[i].id) > -1;
        domStr += [
          '<li class="passenger-select ' + (isSelected ? 'selected' : '') + '" data-id="' + passengerList[i].id + '">',
            '<i class="icon-tick"></i>',
            '<div class="passenger-info">',
              '<div class="passenger-name">' + passengerList[i].personName + '<span class="extra-name">（成人票）</span></div>',
              '<div class="passenger-idcard">' + passengerList[i].idCard + '</div>',
            '</div>',
            '<div class="edit-con" data-id="' + passengerList[i].id + '">',
              '<i class="icon-editboard"></i>',
            '</div>',
          '</li>'
        ].join().replace(/,/g, '');
      }
    }
    // 加载数据
    passengerMask.append([
      '<div class="add-passenger">+ 新增旅客</div>',
      '<div class="passenger-list">' + domStr + '</div>',
      '<div class="content-block indent passenger-mask-submit" data-type="choose-passenger">',
        '<div class="col-100"><a class="button">完成</a></div>',
      '</div>'
    ].join().replace(/,/g, ''));
  }, 400);
}

/**
  方法：唤出新增、修改旅客列表
 */
function showAdultMgr(type, id) {
  // 先加载框架
  $('body').append([
    '<div class="passenger-mask J_adult_mgr">',
      '<header class="bar bar-nav">',
        '<a class="icon icon-left pull-left passenger-back"></a>',
        '<h1 class="title">' + (type === 'add' ? '新增旅客' : '修改旅客') + '</h1>',
      '</header>',
    '</div>'
  ].join().replace(/,/g, ''));
  // 出动画
  var passengerMask;
  setTimeout(function() {
    passengerMask = $('.J_adult_mgr');
    passengerMask.addClass('slide-in');
  }, 100);
  // 动画完毕后载数据
  setTimeout(function() {
    // 加载数据
    passengerMask.append([
      '<div style="padding-top: 2.2rem"></div>',
      '<div class="passenger-list list-block">',
        '<li class="item-content">',
          '<div class="item-inner">',
            '<div class="item-title">旅客姓名</div>',
            '<div class="item-after item-input">',
              '<input type="text" placeholder="请填写旅客姓名" ' + (type === 'edit' ? 'value=' + passengerList[id].personName : '') + ' />',
            '</div>',
          '</div>',
        '</li>',
        '<li class="item-content">',
          '<div class="item-inner">',
            '<div class="item-title">旅客类型</div>',
            '<div class="item-after">',
              '<span style="margin-left: 0.25rem">成人票</span>',
            '</div>',
          '</div>',
        '</li>',
        '<li class="item-content">',
          '<div class="item-inner">',
            '<div class="item-title">身份证号</div>',
            '<div class="item-after item-input">',
              '<input type="text" placeholder="请填写身份证号码" ' + (type === 'edit' ? 'value=' + passengerList[id].idCard : '') + ' />',
            '</div>',
          '</div>',
        '</li>',
      '</div>',
      '<div class="content-block indent passenger-mask-submit" data-type="' + (type === 'edit' ? 'edit-passenger' : 'add-passenger') + '" ' + (type === 'edit' ? 'data-id=' + id : '') + '>',
          '<div class="col-100"><a class="button">完成</a></div>',
      '</div>'
    ].join().replace(/,/g, ''));
  }, 400);
}

/**
  方法：唤出新增儿童窗口
 */
function showChildMgr(type, id) {
  // 先加载框架
  $('body').append([
    '<div class="passenger-mask J_child_mgr">',
      '<header class="bar bar-nav">',
        '<a class="icon icon-left pull-left passenger-back"></a>',
        '<h1 class="title">' + (type === 'add' ? '新增儿童' : '修改儿童') + '</h1>',
      '</header>',
    '</div>'
  ].join().replace(/,/g, ''));
  // 出动画
  var passengerMask;
  setTimeout(function() {
    passengerMask = $('.J_child_mgr');
    passengerMask.addClass('slide-in');
  }, 100);
  // 动画完毕后载数据
  setTimeout(function() {
    // 加载数据
    passengerMask.append([
      '<div style="padding-top: 2.2rem"></div>',
      '<div class="passenger-list list-block">',
        '<li class="item-content">',
          '<div class="item-inner">',
            '<div class="item-title">儿童姓名</div>',
            '<div class="item-after item-input">',
              '<input type="text" placeholder="请填写儿童姓名" />',
            '</div>',
          '</div>',
        '</li>',
        '<li class="item-content">',
          '<div class="item-inner">',
            '<div class="item-title">儿童性别</div>',
            '<div class="item-after">',
              '<span style="margin-left: 0.25rem"><div class="radio-sex man selected">男</div><div class="radio-sex woman">女</div></span>',
            '</div>',
          '</div>',
        '</li>',
        '<li class="item-content">',
          '<div class="item-inner">',
            '<div class="item-title">出生日期</div>',
            '<div class="item-after item-input">',
              '<input type="date" placeholder="请选择出生日期" />',
            '</div>',
          '</div>',
        '</li>',
      '</div>',
      '<div class="tip-info">儿童身高须在1.2-1.5米，用同行成人证件取票。</div>',
      '<div class="content-block indent passenger-mask-submit" data-type="add-child">',
          '<div class="col-100"><a class="button">完成</a></div>',
      '</div>'
    ].join().replace(/,/g, ''));
  }, 400);
}

/**
  方法：收集选择的成人旅客
 */
function collectSelectedPassengers() {
  var dom = $('.J_adult_list');
  var arr = [];
  dom.find('.passenger-select').each(function(index) {
    if ($(this).hasClass('selected')) {
      arr.push($(this).data('id').toString());
    }
  });
  // 更新数据
  var oldSelected = [];
  for (var i = 0; i < selectedPassengers.length; i++) {
    if (passengerList[selectedPassengers[i]].type === 'child') {
      oldSelected.push(selectedPassengers[i]);
    }
  }
  removePassengers(null, passengerListDom);
  selectPassengers(arr.concat(oldSelected), passengerListDom);
  setTimeout(function() {
    closeMask(dom);
  }, 100);
}

/**
  方法：新增、修改成人旅客
 */
function updatePassenger(type, id) {
  var el = $('.J_adult_mgr');
  var keys = el.find('input');
  var personName = keys.eq(0).val();
  var idCard = keys.eq(1).val().toUpperCase();
  if (!personName) {
    alert('请填写旅客姓名');
    return;
  }
  if (!idCard.match(/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/)) {
    alert('请填写正确的身份证号');
    return;
  }
  // ajax请求模拟
  var record = {
    id: type === 'edit' ? id.toString() : parseInt(Math.random() * 100000 + 1000).toString(),
    personName: personName,
    idCard: idCard,
    type: 'adult'
  };
  if (id) removePassengerList([record.id]);
  insertPassengerList([record]);
  setTimeout(function() {
    closeMask(el);
  }, 100);
}

/**
  方法：新增、修改儿童
 */
function updateChild(type, id) {
  var el = $('.J_child_mgr');
  var keys = el.find('input');
  var personName = keys.eq(0).val();
  var sex = $('.radio-sex.man').hasClass('selected') ? 'man' : 'woman';
  var birthDate = keys.eq(1).val();
  if (!personName) {
    alert('请填写儿童姓名');
    return;
  }
  if (!birthDate) {
    alert('请填写儿童出生日期');
    return;
  }
  // ajax请求模拟
  var record = {
    id: type === 'edit' ? id.toString() : parseInt(Math.random() * 100000 + 1000).toString(),
    personName: personName,
    birthDate: birthDate,
    sex: sex,
    type: 'child'
  };
  if (id) removePassengerList([record.id]);
  insertPassengerList([record]);
  setTimeout(function() {
    closeMask(el);
  }, 100);
}

$(function() {
  if (location.href.match('indent_fill')) { // 地址判断
    // DOM节点保存
    var listDom = $('.list-block');

    // 乘客部分初始化
    function passengerInit() {
      listDom.children('ul').append('<div class="passenger-area"></div>');
      passengerListDom = $('.passenger-area');
      passengerListDom.after([
        '<li class="passenger-modify">',
          '<div class="passenger-btn add-adult">添加成人</div>',
          '<div class="passenger-btn add-child">添加儿童</div>',
        '</li>',
        '<li class="item-content contact-phone">',
          '<div class="item-inner">',
            '<div class="item-title">联系手机</div>',
            '<div class="item-after item-input">',
              '<input type="number" placeholder="请填写联系手机" />',
            '</div>',
          '</div>',
        '</li>'
      ].join().replace(/,/g, ''));
    }

    // 事件绑定
    function bindEvents() {
      // 绑定删除事件
      $('body').delegate('.icon-del', 'click', function(e) {
        var el = $(e.currentTarget);
        removePassengers([el.data('id')], passengerListDom);
      });
      $('body').delegate('.passenger-back', 'click', function(e) {
        closeMask($(e.currentTarget).parent().parent());
      });
      $('body').delegate('.passenger-mask .passenger-info', 'click', function(e) {
        $(e.currentTarget).parent().toggleClass('selected');
      });
      $('body').delegate('.radio-sex', 'click', function(e) {
        $('.radio-sex').removeClass('selected');
        $(e.currentTarget).addClass('selected');
      });
      $('body').delegate('.passenger-mask-submit', 'click', function(e) {
        var type = $(e.currentTarget).data('type');
        if (type === 'choose-passenger') {
          collectSelectedPassengers();
        }
        if (type === 'add-passenger') {
          updatePassenger('add');
        }
        if (type === 'edit-passenger') {
          updatePassenger('edit', $(e.currentTarget).data('id'));
        }
        if (type === 'add-child') {
          updateChild('add');
        }
      });
      $('body').delegate('.add-passenger', 'click', function(e) {
        showAdultMgr('add');
      });
      $('body').delegate('.add-child', 'click', function(e) {
        showChildMgr('add');
      });
      $('body').delegate('.edit-con', 'click', function(e) {
        showAdultMgr('edit', $(e.currentTarget).data('id'));
      });
      $('body').delegate('.add-adult', 'click', function(e) {
        showAdultPassengers();
      });
    }

    // 页面加载完毕立刻调用
    passengerInit();
    bindEvents();

    // 模拟，初始化乘客列表
    updatePassengerList([{
      id: '111', // id为字符串
      personName: '张三',
      idCard: '33030119900101111X',
      type: 'adult'
    }, {
      id: '222', // id为字符串
      personName: '李儿童',
      birthDate: '2010-01-01',
      sex: 'man',
      type: 'child'
    }, {
      id: '333',
      personName: '王五',
      idCard: '33030119800101111X',
      type: 'adult'
    }]);
     // 模拟，选取两位乘客
      //selectPassengers(['111', '222'], passengerListDom);


  }
});

function closeMask(dom) {
  var el = dom;
  el.addClass('slide-out');
  setTimeout(function() { el.remove(); }, 400);
}
