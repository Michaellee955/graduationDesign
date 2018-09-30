/** 
 * @namespace PLG
 * @author chengkun
*/

(typeof(PLG) === "undefined")?window.PLG={}:PLG;

(function(T){
	/** IIFE(Immediately-Invoked Function Expression) */
	//打开回调窗口
	var smartOpen = function(option,callbackOrOption){
		if(!option) return ;
		var opt = {
			url:null	
			//,height:"700"
			//,weight:"1000"
			//子窗口返回数据，要调用的父窗口function
			,callback:null
		};
		
		if('string' == typeof option){
			opt.url= option;
		}else{
			$.extend(true, opt, option);
		}
		
		if(callbackOrOption){
			if('function' == typeof callbackOrOption){
				opt.callback = callbackOrOption;
			}else if('object' == typeof callbackOrOption){
				opt = $.extend(true,opt,callbackOrOption);
			}
		}

		opt.name = 'win_'+new Date().getTime();

		var features = '';
		if(opt.height)
			features += 'height='+opt.height+',';
		if(opt.width)
			features += 'width='+opt.width;
		
		if(opt.callback){
			if('object' != typeof window.smartOpenCallbackMap){
				window.smartOpenCallbackMap = {};
			}
			window.smartOpenCallbackMap[opt.name] = opt.callback;
		}
		
		return window.open(opt.url,opt.name ,features);
		
	};
	
	//回调窗口数据
	var smartOpenCallback = function(data){
		var windowName = window.name;
		if(!windowName){
			return ;
		}
		var _opener = window.opener;
		if(!_opener){
			return ;
		}
		
		if(_opener.smartOpenCallbackMap&&_opener.smartOpenCallbackMap[windowName]){
			var callback = _opener.smartOpenCallbackMap[windowName];
			callback(data);
			delete _opener.smartOpenCallbackMap[windowName];
			window.close();
		}
	};	
		

	/**  获取最高z-index */
	var getMaxZindex = function (father){
		var index_highest = 1;
		var searchSpace= father ? father : 'div';
		$(searchSpace).each(function () {
			var index_current = parseInt($(this).css("zIndex"), 10);
			if (index_current > index_highest) {
				index_highest = index_current;
			}
		});
		return index_highest + 1;
	};
	
	var formToJson = function(form){
        var $form = typeof(form) === "string" ? $("#"+form): form;
		var inputDisvisible = {}; //'非提交参数'
		var didvisible = $form.find(':input:hidden');
		$.each(didvisible, function(i, field){
			if(field.type!='hidden'){
				inputDisvisible[field.name]= 1;
			}
		});
		
		var o = {};
	    var fields = $form.serializeArray();
	    //去掉值为空的对象
	    $.each(fields, function(i, field){
	    	var VL= (field.value=="") ? null : field.value;
	    	var nm = field.name;
	    	if(!inputDisvisible[nm]){//如果不在'非提交参数'内
	        	if (o[nm]) {
	                if (!o[nm].push) {//不是数组时
	                	if(VL) {
	                		o[nm] = [ o[nm] ];
	                		o[nm].push(VL);
	                	}
	                }else{
	                	if(VL) o[nm].push(VL);
	                }
	        	}else{
	        		if(VL) o[nm] = VL;             
	            }
	    	}
	    });
	    //把对象里的数组-》字符串
	    $.each(o, function(n, v){
	    	if(v!=null && v.push)  o[n] = v.toString();
	    });
	    return o;	
	};

	var jsonToForm = function(formId, json){
		$(formId).find(':input').each(function(i, o){
			if(o.name in json){
				$(this).val(json[o.name]).change();
			}
		});
	}

	//清空postData
	var cleanPostData=function (postData){
		$.each(postData, function (k, v) {
	        delete postData[k];
	    });

	};

	//跳转到想要去的页面
	var goTo = function(href, name){
		if(name){
			window.open(href, name);
		}else{
			window.location.href = href;
		}
	};

	//每次(重新打开一个新窗口)或(覆盖同名窗口)
	var windowOpen= function (url, winName, paramObj ) {
		if (paramObj) {
			if(url.indexOf('?')!=-1){
				url += $.param(paramObj);			
			}else{
				url += '?'+ $.param(paramObj);			
			}
		}
		var timestamp = new Date().getTime();

		window.open(url, winName || timestamp);
	};
	
	
	//先关闭再打开
	var winOpenGroup= function (url, group, tooltipName){
		 if(tooltipName){
			var rowId = $('#'+tooltipName).data('legId');
			group += rowId;
		 }
	     window.open(url, group);
	};
	
	var gridSearch =function(searchForm, gridId,additionalParamas){
		var postData = $("#"+gridId).jqGrid("getGridParam", "postData");
		var mydata = formToJson(searchForm);
        $.extend(mydata,additionalParamas);
	    cleanPostData(postData);
	    $("#"+gridId).jqGrid("setGridParam", {'postData':mydata}).trigger("reloadGrid", [{page:1}]);
	};
	T.smartOpen = smartOpen;
	T.smartOpenCallback = smartOpenCallback;
	T.getMaxZindex=getMaxZindex;
	T.formToJson=formToJson;
	T.jsonToForm=jsonToForm;
	T.cleanPostData=cleanPostData;
	T.goTo=goTo;
	T.windowOpen=windowOpen;
	T.winOpenGroup=winOpenGroup;
	T.gridSearch=gridSearch;
}(PLG));


