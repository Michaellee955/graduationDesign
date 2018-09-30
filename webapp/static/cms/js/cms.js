var rootPath = publicPath;
var sURLParms = '';
var addFlag = '-byadd';
var jg_grp_headers = null;

window.urlParam = '';    //**获取url参数
function toolTipShow(tooltipId, infoDivId, params, showStyle) {
	// 处理参数
	$('#' + tooltipId).data(params);
	window.urlParam = jQuery.param(params); // jquery参数序列化

	// 显示tooltip
	var bL = document.getElementById(infoDivId);
	var posX = 0;
	var posY = 0;
	if (bL.offsetParent) {
		for ( var posX = 0, posY = 0; bL.offsetParent; bL = bL.offsetParent) {
			posX += bL.offsetLeft;
			posY += bL.offsetTop;
		}
		posX -= 1;
		posY -= 1;
	} else {
		posX = bL.x;
		posY = bL.y;
	}
	
	
	posX += 53;
	//posY -= 10;
	var rI = document.getElementById(tooltipId);
	if (rI != null) {
		rI.style.position = 'absolute';
		rI.style.left = posX + 'px';
		rI.style.top = posY + 'px';
		rI.style.display = 'block';
	}

	// 控制子项目显示
	if (showStyle) {
		$.each(showStyle, function(i, n) {
			if (n) {
				$($('#' + tooltipId + ' ul li').get(i)).show();
			} else {
				$($('#' + tooltipId + ' ul li').get(i)).hide();
			}
		});
	}

}

//先关闭再打开
function openNewBlank(url, check, tooltipName){
	 if(tooltipName){
		var rowId = $('#'+tooltipName).data('legId');
		 check = rowId+ check;
	 }
	 
	 var win =  window.open(url,check);
     win.close();
     window.open(url,check);
}
 
 
//每次都重新打开一个新窗口
function adpNewWin(url){
	var timestamp = new Date().getTime();
	window.open(url, timestamp );
}
 
//定义全局变量来判断页面是否是第一次打开,局限性:中途刷新页面时失效
window.adpWinMap = {};
function adpWin(url){
	 
	 var _win = window.adpWinMap[url];
	 
	 if($.isWindow(_win)&&$(_win).width()){
		 _win.focus();
		 //title闪烁 -_-!
		 var _title = $(_win.document).find('title').html();
		 $(_win.document).find('title').html('点击查看');
		 for(var i = 1 ;i<8;i++){
			 +function(j){
				 window.setTimeout(function(){
					 if(j%2){
						 $(_win.document).find('title').html(_title);
					 }
					 else{
						 $(_win.document).find('title').html('点击查看');
					 }
						 
				 },300*j);
			 }(i);
		 }
	 }else{
		 _win = window.open(url);
		 window.adpWinMap[url]=_win;
	 }
	 
	 //删除已关闭的页面
	 for(var u in window.adpWinMap){
		 var w = window.adpWinMap[u];
		 if($.isWindow(w)&&!$(w).width()){
			 delete window.adpWinMap[u];
		 }
	 }
	 
}


function toolTipClose(tipIds, infoDiv) {
	infoDiv = infoDiv ? infoDiv : '.infoBlue';
	for ( var i = 0; i < tipIds.length; i++) {
		// $("#"+tipIds[i]).mouseleave( function(){ $("#"+tipIds[i]).hide(); });
		$(document).off('mouseleave', tipIds[i]).on('mouseleave', tipIds[i],
				function(e) {
					$(this).hide();
				});
	}
	$(document).off('mouseleave', infoDiv).on('mouseleave', infoDiv,
			function(e) {
				var ileft = $(this).offset().left;
				var itop = $(this).offset().top;
				if (e.pageX < ileft || e.pageY < itop || e.pageY > itop + 25) {
					for ( var i = 0; i < tipIds.length; i++) {
						$(tipIds[i]).hide();
					}
				}
			});

}


// 打开新的窗口
function openDialog(_url, param , _w, _h) {
	_w = _w ? _w : screen.width;
	_h = _h ? _h : screen.height;
	return window.showModalDialog(_url, param, "dialogWidth:" + _w
			+ "px;dialogHeight:" + _h + "px;center:yes;status:0;help:no;");
}

function openDialogCallBack(_url, param , _w, _h) {
	_w = _w ? _w : screen.width;
	_h = _h ? _h : screen.height;
	var res = window.showModalDialog(_url, param, "dialogWidth:" + _w
			+ "px;dialogHeight:" + _h + "px;center:yes;status:0;help:no;");
	
	$(document).trigger('openDialogCallBack',res );	
	
}


function openStaticWindow(_url, target, _w, _h) {
	_w = _w ? _w : screen.width;
	_h = _h ? _h : screen.height;
	var newwin = null;
	if (typeof (staticWindow) == 'undefined' || staticWindow.closed) { 
		newwin = window.open(_url,	target ,"width="+ _w + ",height="+ _h + ","+ "left="+ (screen.width - _w)/ 2	+ ",top="+ (screen.height - _h)/ 2+ ","
								+ "status=no,help=no,toolbar=no,menubar=no,scrollbars=yes,resizable=no");
		newwin.location.href = _url;
		staticWindow = newwin;
		staticWindow.focus();
	} else { 
		staticWindow.name = target;
		staticWindow.location = _url;
		staticWindow.resizeTo(_w, _h);
		staticWindow.focus();
	}

}

window.PUwin;

function popUp(pu_item, h, w ) {
	
	var newwin = null;
	if (typeof (PUwin) == 'undefined' || PUwin.closed) {
		if(w && h){
			newwin = window.open(pu_item , "", "width=" + w	+ ",height=" + h
					+ ",status=no,resizable=yes,scrollbars=yes" );
		}else{
			newwin = window.open(pu_item , "" );
		}
		
		if (newwin != null) {
			if (newwin.opener == null) newwin.opener = self;
			//newwin.location.href = pu_item;
		}
		PUwin = newwin;
		//PUwin.focus();
	} else {		
		PUwin.location = pu_item;
		//PUwin.resizeTo(w, h);
		//PUwin.focus();
	}
}

function MultiDimensionalArray(iRows, iCols) {
	var i;
	var j;
	var a = new Array(iRows);
	for (i = 0; i < iRows; i++) {
		a[i] = new Array(iCols);
		for (j = 0; j < iCols; j++) {
			a[i][j] = "";
		}
	}
	return (a);
}

/**
 * radio 列
 */
var radioFormatter = function(cellValue, options) {
	if (cellValue) {
		return '<input type="radio" name="radio_' + options.gid + '" value="' + cellValue + '"/>';
	}
	return '';
};

/**
 * 工卡条目radio 列
 */
function checkBoxFormatter(cellvalue, options, rowObject) {
	var result = '';
	if (cellvalue) {
		// 5-拒绝 , 10-完成,72-系统智能关闭 
		if (rowObject.status != 5 || rowObject.status != 10 ||rowObject.status != 72 ) {
			result = '<input type="checkbox" name="cb_' + options.gid + '" value="' + cellvalue + '"/>';
		}
	}
	return result;
}

// 格式化日期
var priorityDateFormatter = function(cellvalue, options, rowObject) {
	var udate = "";
	if (cellvalue) {
		var date = new Date(cellvalue);
		udate = DateFormat.format(date, 'MM-dd hh:mm');
	}
	return udate;
};

var priorityFullDateFormatter = function(cellvalue, options, rowObject) {
	var udate = "";
	if (cellvalue) {
		var date = new Date(cellvalue);
		udate = DateFormat.format(date, 'yyyy-MM-dd hh:mm:ss');
	}
	return udate;
};


var yyyyMMddhhmmDateFormatter = function(cellvalue, options, rowObject) {
	var udate = "";
	if (cellvalue) {
		var date = new Date(cellvalue);
		udate = DateFormat.format(date, 'yyyy-MM-dd hh:mm');
	}
	return udate;
};

var mmddFormatter = function(cellvalue, options, rowObject) {
	var udate = '';
	if (cellvalue) {
		var date = new Date(cellvalue);
		udate = DateFormat.format(date, 'MM-dd');
	}
	return udate;
};

var yymmddFormatter = function(cellvalue, options, rowObject) {
	var udate = '';
	if (cellvalue) {
		var date = new Date(cellvalue);
		udate = DateFormat.format(date, 'yyyy-MM-dd');
	}
	return udate;
};

var hhmmssFormatter = function(cellvalue, options, rowObject) {
	var udate = '';
	if (cellvalue) {
		var date = new Date(cellvalue);
		udate = DateFormat.format(date, 'hh:mm:ss');
	}
	return udate;
};

var hhmmFormatter = function(cellvalue, options, rowObject) {
	var etadate = '';
	if (cellvalue) {
		var date = new Date(cellvalue);
		etadate = DateFormat.format(date, 'hh:mm');
	}
	return etadate;
};

/**
 * 自动关闭alert
 */
function createAutoClosingAlert(selector, delay) {
	window.setTimeout(function() {
		$('#' + selector).alert('close');
	}, delay);
}

// 格式化小数值
var priorityDecimalsValueFormatter = function(cellvalue, options, rowObject) {
	var rValue = "0.0000";
	if (cellvalue) {
		rValue = cellvalue.toFixed(4);
	}
	return rValue;
};

// 格式化小数值(两位)
var priorityDecimalsTwoValueFormatter = function(cellvalue, options, rowObject) {
	var rValue = "";
	if (cellvalue) {
		rValue = cellvalue.toFixed(2);
	}
	return rValue;
};

//bootstrap常规工具条
var noramlProgress = function(curValue, maxValue, styleclass, showtext ) {
	if(!styleclass) styleclass = '';
	var cur_persent = Math.ceil(curValue * 100 / maxValue) ;
	var prgress ='<div class="progress" style="white-space:normal; margin-bottom:0px;" >'
        +' <div class="progress-bar '+styleclass+'" aria-valuenow="'+cur_persent+'" style="width:'+cur_persent+'%;" aria-valuemin="0" aria-valuemax="100" >'
        +'</div>';
        if(showtext){
            prgress +=' <div style="float:right;">'+curValue+'</div>';
        }else{
        	prgress +=' <span class="sr-only">'+curValue+'</span>';
        }
        prgress +='</div>';

	return prgress;

};

//bootstrap正负向工具条
var plusMinusProgress = function(curValue, maxValue ) {
	
	var curLength = Math.abs(curValue);
	var maxlength = maxValue*2;
	var blank = (curValue>=0)?maxValue:(maxValue + curValue);
	var blank_persent = blank * 100 / maxlength ;
	
	var cur_persent = curLength * 100 / maxlength ;
	//当前条颜色
	var cur_class =(curValue>=0) ?'progress-bar-success':'progress-bar-danger';
	var prgress ='<div title="'+maxValue+'"  class="progress" style="white-space:normal; margin-bottom:0px;" >'
      +' <div title="'+(-maxValue)+'" class="progress-bar " style="width:'+blank_persent+'%;background-color: #F5F5F5;" ></div>'
      +' <div title="'+curValue+'" class="progress-bar '+cur_class+'" style="width:'+cur_persent+'%;" ></div>'      
      +'</div>';

	return prgress;

};


/**
		showMessage({
			message:".....要显示的信息",
			isSuccess:false,
			callback:function(){
				//window.close();
			}
		});
 * 
 * 
 * @param message
 *            要提示的信息
 * @param isSuccess
 *            是正确信息（true）还是错误信息(false)
 */
function showMessage(messageOrOptions, _isSuccess) {
	var default_div_id = 'info_div';
	var default_div_selector = '#'+default_div_id;
	var message;
	var isSuccess;
	if(typeof messageOrOptions ==='object'){
		message = messageOrOptions.message;
		isSuccess = messageOrOptions.isSuccess;
	}else{
		message = messageOrOptions;
		isSuccess = _isSuccess;
	}
	
	
	var $messageDiv = $(default_div_selector);
	if(!$messageDiv.length){
		var info_html = '<div id="'+default_div_id+'"    >'+
		'<button class="close" onclick="javascript:$(\''+default_div_selector+'\').hide();"  type="button">×</button>'+
		'<strong>提示信息</strong>'+
		'</div>';
		$messageDiv = $(info_html).appendTo('body');
	}
	
	if (!message) {
		message = isSuccess === true ? '成功，但没有提示信息！' : '失败，但没有提示信息！'
	}
	var $strong = $("strong", $messageDiv);
	$strong.html(message);
	$(document).off('mouseleave', default_div_selector);
	$(document).off('mouseenter', default_div_selector);

	if (isSuccess === true) {
		$messageDiv.addClass('info-success').removeClass('info-danger');
	} else {
		$messageDiv.addClass('info-danger').removeClass('info-success');
	}
	//显示的时间计算
	var mess_len = message.length;
	var times = 400*mess_len;
	
	$messageDiv.slideDown(1000, function() {
		/*// 计算展示高度
		var strongHeight = $strong.height();
		var ht = strongHeight > 50 ? strongHeight : 50;*/
		
		// 拉起
		window.setTimeout(function(){
			$messageDiv.slideUp(1000,function(){
				if(typeof messageOrOptions.callback === 'function'){
					messageOrOptions.callback();
				}
			});
		},times)
		

		/*// 注册事件
		$(document).on('mouseleave', default_div_selector, function(e) {
			$messageDiv.slideUp(1000);
		});
		// 注册进入事件，不能使用mouseover，事件冒泡
		$(document).on('mouseenter', default_div_selector, function(e) {

			$messageDiv.queue("fx", []);
			$messageDiv.stop();

			$messageDiv.animate({
				height : ht,
				'margin-bottom' : 20,
				'padding-top' : 15,
				'padding-bottom' : 15
			}, 500);

		});*/

	});

}
/**
 * 显示一般信息
 * @param message
 * @param callback
 */
function info(message,callback){
	showMessage({
		message:message,
		isSuccess:true,
		callback:callback
	});
}
/**
 * 显示错误信息
 * @param message
 * @param callback
 */
function error(message,callback){
	showMessage({
		message:message,
		isSuccess:false,
		callback:callback
	});
}




//数组去重
function distinctArray(inArray){
	var dic = {};
	$.each( inArray , function(i, field){
		 dic[field] = i;
		});
	var outArray=[];
	$.each( dic , function(n, v){
		outArray.push(n);
		});
	return outArray;
}


//禁用文本选择
function disableSelection(target){
	if (typeof target.onselectstart!="undefined") //IE route
		target.onselectstart=function(){return false;}
	else if (typeof target.style.MozUserSelect!="undefined") //Firefox route
		target.style.MozUserSelect="none";
	else //All other route (ie: Opera)
		target.onmousedown=function(){return false;}
	target.style.cursor = "default";
	}

function showAlertCk(parentId, text, flag, callback, delayTime){
	var flagclass= 'alert-danger';
	if(flag) flagclass= 'alert-success';
	text= text ? text : 'alert';
	delayTime = delayTime ? delayTime: 1000;
	
	var message = '<div  class="alert '+flagclass+'" ><strong>'+text+'</strong></div>';
	$(parentId).append(message);
	
	window.setTimeout(function(){
	$(parentId).html(''); 
	//提供给外包的callback方法
	$.isFunction(callback)&& callback.call();
	}, delayTime);
}




/**************************************************************************************/
/*************************************数字的验证*****************************************/
/**************************************************************************************/

/**
 * 检查输入的一串字符是否全部是数字
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为数字
 */
function checkNum(str){
    return str.match(/\D/) == null;
}


/**
 * 检查输入的一串字符是否为小数
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为小数
 */
function checkDecimal(str){
    if (str.match(/^-?\d+(\.\d+)?$/g) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 检查输入的一串字符是否为整型数据
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为小数
 */
function checkInteger(str){
    if (str.match(/^[-+]?\d*$/) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**************************************************************************************/
/*************************************字符的验证*****************************************/
/**************************************************************************************/

/**
 * 通常作为用户名密码字符检验
 * 检查字符是否只包含数字和字母
 * 输入输入:str  字符串
 * 返回:true 或 flase; true表示为只包含数字和字母
 */	
function checkNumAlpha(str){
	if (/^([0-9a-zA-Z]){0,}$/.test(str)) {
        return true;
    }
	return false;
}


/**
 * 检查输入的一串字符是否是字符
 * 输入:str  字符串
 * 返回:true 或 flase; true表示为全部为字符 不包含汉字
 */
function checkStr(str){
    if (/[^\x00-\xff]/g.test(str)) {
        return false;
    }
    else {
        return true;
    }
}


/**
 * 检查输入的一串字符是否包含汉字
 * 输入:str  字符串
 * 返回:true 或 flase; true表示包含汉字
 */
function checkChinese(str){
    if (escape(str).indexOf("%u") != -1) {
        return true;
    }
    else {
        return false;
    }
}


/**
 * 检查输入的邮箱格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 */
function checkEmail(str){
    if (str.match(/[A-Za-z0-9_-]+[@](\S*)(net|com|cn|org|cc|tv|[0-9]{1,3})(\S*)/g) == null) {
        return false;
    }
    else {
        return true;
    }
}


/**
 * 检查输入的手机号码格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 */
function checkMobilePhone(str){
    if (str && str.match(/^(?:13\d|15[89])-?\d{5}(\d{3}|\*{3})$/) == null) {
        return false;
    }
    else {
        return true;
    }
}


/**
 * 检查输入的固定电话号码是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 */
function checkTelephone(str){
    if (str && str.match(/^(\d{7,8})(-(\d{3,}))?$/) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 检查QQ的格式是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkQQ(str){
    if (str && str.match(/^\d{5,10}$/) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 检查输入的身份证号是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkCard(str){
    //15位数身份证正则表达式
    var arg1 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
    //18位数身份证正则表达式
    var arg2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[A-Z])$/;
    if (str && str.match(arg1) == null && str.match(arg2) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 检查输入的IP地址是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkIP(str){
    var arg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
    if (str.match(arg) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**
 * 检查输入的URL地址是否正确
 * 输入:str  字符串
 *  返回:true 或 flase; true表示格式正确
 */
function checkURL(str){
    if (str && str.match(/(http[s]?|ftp):\/\/[^\/\.]+?\..+\w$/i) == null) {
        return false
    }
    else {
        return true;
    }
}

/**
 * 检查输入的字符是否具有特殊字符
 * 输入:str  字符串
 * 返回:true 或 flase; true表示包含特殊字符
 * 主要用于注册信息的时候验证
 */
function checkQuote(str){
    var items = new Array("~", "`", "!", "@", "#", "$", "%", "^", "&", "*", "{", "}", "[", "]", "(", ")");
    items.push(":", ";", "'", "|", "\\", "<", ">", "?", "/", "<<", ">>", "||", "//");
    items.push("admin", "administrators", "administrator", "管理员", "系统管理员");
    items.push("select", "delete", "update", "insert", "create", "drop", "alter", "trancate");
    str = str.toLowerCase();
    for (var i = 0; i < items.length; i++) {
        if (str.indexOf(items[i]) >= 0) {
            return true;
        }
    }
    return false;
}


/**************************************************************************************/
/*************************************时间的验证*****************************************/
/**************************************************************************************/

/**
 * 检查日期格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 * 注意：此处不能验证中文日期格式
 * 验证短日期（2007-06-05）
 */
function checkDate(str){
    //var value=str.match(/((^((1[8-9]\d{2})|([2-9]\d{3}))(-)(10|12|0?[13578])(-)(3[01]|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(11|0?[469])(-)(30|[12][0-9]|0?[1-9])$)|(^((1[8-9]\d{2})|([2-9]\d{3}))(-)(0?2)(-)(2[0-8]|1[0-9]|0?[1-9])$)|(^([2468][048]00)(-)(0?2)(-)(29)$)|(^([3579][26]00)(-)(0?2)(-)(29)$)|(^([1][89][0][48])(-)(0?2)(-)(29)$)|(^([2-9][0-9][0][48])(-)(0?2)(-)(29)$)|(^([1][89][2468][048])(-)(0?2)(-)(29)$)|(^([2-9][0-9][2468][048])(-)(0?2)(-)(29)$)|(^([1][89][13579][26])(-)(0?2)(-)(29)$)|(^([2-9][0-9][13579][26])(-)(0?2)(-)(29)$))/);
    var value = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
    if (value == null) {
        return false;
    }
    else {
        var date = new Date(value[1], value[3] - 1, value[4]);
        return (date.getFullYear() == value[1] && (date.getMonth() + 1) == value[3] && date.getDate() == value[4]);
    }
}

/**
 * 检查时间格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 * 验证时间(10:57:10)
 */
function checkTime(str){
    var value = str.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/)
    if (value == null) {
        return false;
    }
    else {
        if (value[1] > 24 || value[3] > 60 || value[4] > 60) {
            return false
        }
        else {
            return true;
        }
    }
}

/**
 * 检查全日期时间格式是否正确
 * 输入:str  字符串
 * 返回:true 或 flase; true表示格式正确
 * (2007-06-05 10:57:10)
 */
function checkFullTime(str){
    //var value = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/);
    var value = str.match(/^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]:[0-5][0-9]$/);
    if (value == null) {
        return false;
    }
    else {
        //var date = new Date(checkFullTime[1], checkFullTime[3] - 1, checkFullTime[4], checkFullTime[5], checkFullTime[6], checkFullTime[7]);
        //return (date.getFullYear() == value[1] && (date.getMonth() + 1) == value[3] && date.getDate() == value[4] && date.getHours() == value[5] && date.getMinutes() == value[6] && date.getSeconds() == value[7]);
        return true;
    }
    
}




/**************************************************************************************/
/************************************身份证号码的验证*************************************/
/**************************************************************************************/

/**  
 * 身份证15位编码规则：dddddd yymmdd xx p
 * dddddd：地区码
 * yymmdd: 出生年月日
 * xx: 顺序类编码，无法确定
 * p: 性别，奇数为男，偶数为女
 * <p />
 * 身份证18位编码规则：dddddd yyyymmdd xxx y
 * dddddd：地区码
 * yyyymmdd: 出生年月日
 * xxx:顺序类编码，无法确定，奇数为男，偶数为女
 * y: 校验码，该位数值可通过前17位计算获得
 * <p />
 * 18位号码加权因子为(从右到左) Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2,1 ]
 * 验证位 Y = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ]
 * 校验位计算公式：Y_P = mod( ∑(Ai×Wi),11 )
 * i为身份证号码从右往左数的 2...18 位; Y_P为脚丫校验码所在校验码数组位置
 *
 */
var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1];// 加权因子   
var ValideCode = [1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2];// 身份证验证位值.10代表X   
function IdCardValidate(idCard){
    idCard = trim(idCard.replace(/ /g, ""));
    if (idCard.length == 15) {
        return isValidityBrithBy15IdCard(idCard);
    }
    else 
        if (idCard.length == 18) {
            var a_idCard = idCard.split("");// 得到身份证数组   
            if (isValidityBrithBy18IdCard(idCard) && isTrueValidateCodeBy18IdCard(a_idCard)) {
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
}

/**  
 * 判断身份证号码为18位时最后的验证位是否正确
 * @param a_idCard 身份证号码数组
 * @return
 */
function isTrueValidateCodeBy18IdCard(a_idCard){
    var sum = 0; // 声明加权求和变量   
    if (a_idCard[17].toLowerCase() == 'x') {
        a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
    }
    for (var i = 0; i < 17; i++) {
        sum += Wi[i] * a_idCard[i];// 加权求和   
    }
    valCodePosition = sum % 11;// 得到验证码所位置   
    if (a_idCard[17] == ValideCode[valCodePosition]) {
        return true;
    }
    else {
        return false;
    }
}

/**  
 * 通过身份证判断是男是女
 * @param idCard 15/18位身份证号码
 * @return 'female'-女、'male'-男
 */
function maleOrFemalByIdCard(idCard){
    idCard = trim(idCard.replace(/ /g, ""));// 对身份证号码做处理。包括字符间有空格。   
    if (idCard.length == 15) {
        if (idCard.substring(14, 15) % 2 == 0) {
            return 'female';
        }
        else {
            return 'male';
        }
    }
    else 
        if (idCard.length == 18) {
            if (idCard.substring(14, 17) % 2 == 0) {
                return 'female';
            }
            else {
                return 'male';
            }
        }
        else {
            return null;
        }
}

/**  
 * 验证18位数身份证号码中的生日是否是有效生日
 * @param idCard 18位书身份证字符串
 * @return
 */
function isValidityBrithBy18IdCard(idCard18){
    var year = idCard18.substring(6, 10);
    var month = idCard18.substring(10, 12);
    var day = idCard18.substring(12, 14);
    var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
    // 这里用getFullYear()获取年份，避免千年虫问题   
    if (temp_date.getFullYear() != parseFloat(year) ||
    temp_date.getMonth() != parseFloat(month) - 1 ||
    temp_date.getDate() != parseFloat(day)) {
        return false;
    }
    else {
        return true;
    }
}


function isValidityBrithBy15IdCard(idCard15){
    var year = idCard15.substring(6, 8);
    var month = idCard15.substring(8, 10);
    var day = idCard15.substring(10, 12);
    var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
    // 对于老身份证中的年龄则不需考虑千年虫问题而使用getYear()方法   
    if (temp_date.getYear() != parseFloat(year) ||
    temp_date.getMonth() != parseFloat(month) - 1 ||
    temp_date.getDate() != parseFloat(day)) {
        return false;
    }
    else {
        return true;
    }
}

//去掉字符串头尾空格   
function trim(str){
    return str.replace(/(^\s*)|(\s*$)/g, "");
}


/**  
 * 输入提示信息
 * @param cell, message, type = {required,unique,url,mobilephone,telephone,integer,num_alpha,...}
 * @return
 */

function assistAttr(cell, message, type) {
	$.each(type, function (i, item) {  
		if(item == 'required') {
			cell.attr("required",'required');
			appendAssistAttr(cell,"<li>"+message+"必填</li>");
		}
		if(/^unique:/.test(item)) {
			cell.attr("unique",item.split(":")[1]);
			appendAssistAttr(cell,"<li>"+message+"唯一</li>");
		}
		if(item == 'url'){
			cell.attr("url",'url');
			appendAssistAttr(cell,"<li>以'http://'开头</li>");
		}
		if(item == 'mobilephone'){
			cell.attr("mobilephone",'mobilephone');
			appendAssistAttr(cell,"<li>输入手机号</li>");
		}
		if(item == 'telephone'){
			cell.attr("telephone",'telephone');
			appendAssistAttr(cell,"<li>输入座机号</li>");
		}
		if(item == 'integer'){
			cell.attr("integer",'integer');
			appendAssistAttr(cell,"<li>只接受数字</li>");
		}
		if(item == 'num_alpha'){
			cell.attr("num_alpha",'num_alpha');
			appendAssistAttr(cell,"<li>只接受数字和字母</li>");
		}
	});
}

function updateTooltip(cell){
	cell.tooltip({
		items: '[isAssist]',
		content: function(){
			var element = $(this);
			if (element.is('[isAssist]')) {
			var text = element.attr('isAssist');
			return text;}
		},
		position: {
		my: "left bottom-10",
		at: "left top",
		using: function( position, feedback ) {
					$( this ).css( position );
					$( "<div>" )
						.addClass( "arrow" )
						.addClass( feedback.vertical )
						.addClass( feedback.horizontal )
						.appendTo( this );
				}
		}
	});
}

function addMaxLen(id){
	$("[id^='"+id+"']").each(function(){
			var maxLen = $(this).attr("maxlength");
			if(typeof(maxLen) == "undefined"){
				return;
			}
			appendAssistAttr($(this),'<li>最多可输入'+maxLen+'个字符</li>');
		});
}

function appendAssistAttr(cell,message){
	if(cell.attr('isAssist') == ''){
		cell.attr('isAssist',"<ol>"+message);
	}else{
		cell.attr("isAssist",cell.attr('isAssist')+message);
	}
	updateTooltip(cell);
}

function dataCheck(jsonArr,keys,widthPer) {
	var passed = true;
	if(!widthPer){
		widthPer = '100%';
	}
	var styleStr = "border: 2px inset #DC143C; width:"+widthPer;
	$.each(jsonArr, function (i,item) {
		var rid = item.id;
		for(var j = 0,size = keys.length; j<size ;j++) {
			var objVal = eval('item.'+keys[j]);
			var obj= $("#"+rid+"_"+keys[j]);
			obj.attr('style', 'width:'+widthPer);
			if(obj.attr("required") == 'required' && $.trim(objVal) == ''){
				obj.attr('style', styleStr);
				passed = false;
			}
			
			if(passed && obj.attr("maxlength") != undefined && getByteLen(objVal) > obj.attr("maxlength")*1){
				obj.attr('style', styleStr);
				passed = false;
			}
			
			//验证url
			if(passed && obj.attr("url") != undefined && !checkURL(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证手机号
			if(passed && obj.attr("mobilephone") != undefined && !checkMobilePhone(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证座机号
			if(passed && obj.attr("telephone") != undefined && !checkTelephone(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证整数字
			if(passed && obj.attr("integer") != undefined  && !checkInteger(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证是否只包含数字字母
			if(passed && obj.attr("num_alpha") != undefined && !checkNumAlpha(objVal)){	
				obj.attr('style', styleStr);
				passed = false;
			}
			
			if(passed && obj.attr("unique") != undefined){
				passed = checkUnique(obj.attr("unique"),rid,keys[j],objVal,widthPer);
			}
		}
	});
	return passed;
}

function getByteLen(val){
	if(val){
		var cnLen = (val.replace(/\w/g,"")).length;
		var enLen = val.length - cnLen;
		return cnLen*2 + enLen;
	}
	return 0;
}

function checkUnique2(checkUrl,oid,nid,eleName,val,widthPer){
	var unique = true;
	var data = {};
	data[eleName] = val;
	data['id'] = nid;
	$.ajax({type: 'POST',
		url : rootPath+checkUrl,
		dataType : "json",async : false,cache : false,
		data:{'jsonStr' : JSON.stringify(data)},
		success : function(result) {
			if(true == result.success){
				setObjAlarmStyle($("#"+oid+"_"+eleName),widthPer);
				unique = false;
			}
		}
	});
	return unique;
}


function checkUnique(checkUrl,id,eleName,val,widthPer){
	var unique = true;
	var data = {};
	data[eleName] = val;
	data['id'] = id;
	$.ajax({type: 'POST',
		url : rootPath+checkUrl,
		dataType : "json",async : false,cache : false,
		data:{'jsonStr' : JSON.stringify(data)},
		success : function(result) {
			if(true == result.success){
				setObjAlarmStyle($("#"+id+"_"+eleName),widthPer);
				unique = false;
			}
		}
	});
	return unique;
}

function setObjAlarmStyle(obj, widthPer){
	obj.attr('style', 'border: 2px inset #DC143C; width:'+widthPer);
}

function dataCheck2(jsonArr,keys,widthPer,pId) {
	var passed = true;
	if(!widthPer){
		widthPer = '100%';
	}
	var styleStr = "border: 2px inset #DC143C; width:"+widthPer;
	$.each(jsonArr, function (i,item) {
		var oid = item.id;
		var nid = oid;
		if(pId && pId=='pId'){
			nid +=','+item.pId;
		}else if(pId && pId=='parentId'){
			nid +=','+item.parentId;
		}else if(pId && pId == 'deviceType'){
			nid +=','+item.deviceType;
		}else if(pId && pId == 'clientId'){
			nid +=','+item.clientId;
		}else if(pId && pId == 'modelId'){
			nid +=','+item.modelId;
		}else if(pId && pId == 'version'){
			nid +=','+item.version;
		}
		for(var j = 0,size = keys.length; j<size ;j++) {
			var objVal = eval('item.'+keys[j]);
			var obj= $("#"+oid+"_"+keys[j]);
			obj.attr('style', 'width:'+widthPer);
			if(obj.attr("required") == 'required' && $.trim(objVal) == ''){
				obj.attr('style', styleStr);
				passed = false;
			}
			
			if(passed && obj.attr("maxlength") != undefined && getByteLen(objVal) > obj.attr("maxlength")*1){
				obj.attr('style', styleStr);
				passed = false;
			}
			
			//验证url
			if(passed && obj.attr("url") != undefined && !checkURL(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证手机号
			if(passed && obj.attr("mobilephone") != undefined && !checkMobilePhone(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证座机号
			if(passed && obj.attr("telephone") != undefined && !checkTelephone(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证整数字
			if(passed && obj.attr("integer") != undefined  && !checkInteger(objVal)){
				obj.attr('style', styleStr);
				passed = false;
			}
			//验证是否只包含数字字母
			if(passed && obj.attr("num_alpha") != undefined && !checkNumAlpha(objVal)){	
				obj.attr('style', styleStr);
				passed = false;
			}
			if(passed && obj.attr("unique") != undefined){
				passed = checkUnique2(obj.attr("unique"),oid,nid,keys[j],objVal,widthPer);
			}
		}
	});
	return passed;
}

function genUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x7|0x8)).toString(16);
    });
    return uuid;
}

function showBigImg(src){
    imgShow("#outerdiv", "#innerdiv", "#bigimg", src);
    return false;
}

function imgShow(outerdiv, innerdiv, bigimg, src){
	
var realWidth, realHeight; 
var imgReady = (function () {
	var list = [], intervalId = null,

	// 用来执行队列
	tick = function () {
		var i = 0;
		for (; i < list.length; i++) {
			list[i].end ? list.splice(i--, 1) : list[i]();
		};
		!list.length && stop();
	},

	// 停止所有定时器队列
	stop = function () {
		clearInterval(intervalId);
		intervalId = null;
	};

	return function (url, ready, load, error) {
		var onready, width, height, newWidth, newHeight,
		img = new Image();
		img.src = url;

		// 如果图片被缓存，则直接返回缓存数据
		if (img.complete) {
			ready.call(img);
			load && load.call(img);
			return;
		};

		width = img.width;
		height = img.height;

		// 加载错误后的事件
		img.onerror = function () {
			error && error.call(img);
			onready.end = true;
			img = img.onload = img.onerror = null;
		};

		// 图片尺寸就绪
		onready = function () {
			newWidth = img.width;
			newHeight = img.height;
			if (newWidth !== width || newHeight !== height || newWidth * newHeight > 1024 ) {  // 如果图片已经在其他地方加载可使用面积检测
				ready.call(img);
				onready.end = true;
			}
		};
		onready();

		// 完全加载完毕的事件
		img.onload = function () {
		// onload在定时器时间差范围内可能比onready快
		// 这里进行检查并保证onready优先执行
			!onready.end && onready();

			load && load.call(img);

			// IE gif动画会循环执行onload，置空onload即可
			img = img.onload = img.onerror = null;
		};

		// 加入队列中定期执行
		if (!onready.end) {
			list.push(onready);
			// 无论何时只允许出现一个定时器，减少浏览器性能损耗
			if (intervalId === null) intervalId = setInterval(tick, 40);
		};
	};
})();

imgReady(src, function () {
	realWidth = this.width;   //获取图片真实宽度
	realHeight = this.height; //获取图片真实高度
});

$(bigimg).attr("src", src).load(function(){
	var windowW = $(window).width();//获取当前窗口宽度
	//alert(windowW);
	var windowH = $(window).height();//获取当前窗口高度
	//alert(windowH);

	var imgWidth, imgHeight;
	var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放
 
	if(realHeight>windowH*scale) {//判断图片高度
		imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
		imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
		if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
			imgWidth = windowW*scale;//再对宽度进行缩放
		}
	} else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
		imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
        imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
	} else {//如果图片真实高度和宽度都符合要求，高宽不变
		imgWidth = realWidth;
		imgHeight = realHeight;
	}

	$(bigimg).css("width",imgWidth);//以最终的宽度对图片缩放
 
	var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
	var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
	$(innerdiv).css({"top":h, "left":w});//设置#innerdiv的top和left属性
	$(outerdiv).modal();
});

$(outerdiv).click(function(){//再次点击淡出消失弹出层
	$(this).modal('hide');
});

}


function closeWindow(){
	return window.close();
}

function downloadAttach(fileName){
	location = publicPath+"/attach/download?fileName="+fileName;
	return false;
}
