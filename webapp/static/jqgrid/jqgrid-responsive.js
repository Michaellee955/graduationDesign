$.jgrid = $.jgrid || {};
(function($){
	$.extend(true, $.jgrid,{
	    defaults : {
	    //*******start**********
            autowidth : true,
			cmTemplate:{
				resizable:false,
                sortable: false,
				align:'center',
				title:true
			},
			gridComplete: function(){
				var tableId = $(this).attr("id");
				$("#refresh_"+tableId).off("click").on("click",function(e){
					$("#"+tableId).trigger("reloadGrid");
				});
				window.setTimeout(function () {jqgridResponsive(tableId,jg_grp_headers?true:false,jg_grp_headers);}, 100);
				
				bdivScroll($("#"+tableId));
				
				var rowNum=parseInt($(this).getGridParam("records"),10);
				if(rowNum>0){    
						 $(".ui-jqgrid-sdiv").show();
						 var count=$(this).getCol("resourcesCost",false,"sum"); 
						 $(this).footerData("set",{"serviceAbility":'价格合计：',"resourcesCost":count}); //将合计值显示出来
				      }else{
				          $(".ui-jqgrid-sdiv").hide();
				      }
			}
         //*******end***********
	    }
	 });
})(jQuery);


/**
 * 处理隐藏frozen-bdiv滚动条后对齐的问题
 */
function  bdivScroll(grid){
	grid.parents().find(".ui-jqgrid-bdiv:eq(0)").scroll(function(){
		var fbDiv = grid.parents().find(".frozen-bdiv");
		if($(this).scrollTop() >= fbDiv.height() || fbDiv.scrollTop() == 0){
			$(this).scrollTop(fbDiv.scrollTop());
		}
	});
}

/**默认原则gird宽度要和父宽度一致
 * 对比grid父的宽度的变化，动态改变grid宽度
 * @param gridId
 * @param groupFlag
 * @param groupHeaders
 */
function jqgridResponsive(gridId,groupFlag,groupHeaders){
	//ie9以下
	/*var _result = navigator.userAgent.toLowerCase().match(/msie ([\d.]+)/);
	if(_result &&_result[1]<'9.0' ){
		setGridWidthByTimeout(gridId,groupFlag,groupHeaders);
	}*/
	//在ie9|firefox中也存在父宽度变化的情况
	setGridWidthByTimeout(gridId,groupFlag,groupHeaders);
    $(window).resize(function(){
    	setGridWidthByTimeout(gridId,groupFlag,groupHeaders);
    });
}

/**
 * ie8 @media 无法使用 ，所以用respond.js修复；
 * respond.js在设置页面宽度的时候会有延迟，所以轮询一定时间，检查gird的父宽度是否变化
 * @param gridId
 * @param groupFlag
 * @param groupHeaders
 */
function setGridWidthByTimeout(gridId,groupFlag,groupHeaders){
	//轮询间隔
	var interval = 200;
	//轮询时间
	var polling_times = 50;
	//最大轮询时间
	var polling_times_max = 4*1000;
	//
	var polling_func = function(){
		setTimeout(function(){
			//超过轮询时间限制
			if(polling_times>=polling_times_max)
				return ;

			polling_times+=interval;

			var $gbox = $("#gbox_"+gridId);
			if(!$gbox.length){
				polling_func();
	    		return ;
	    	}
	    	var nowParentW = $gbox.parent().width();
	    	//父宽度不为0（有时在监控阶段会有隐藏表格的操作）并且表格与父宽度不一致
	    	if(nowParentW){
				//设置宽度
				_setGridWidth(nowParentW,gridId,groupFlag,groupHeaders);
			}

			polling_func();
		},50);
	}

	polling_func();

}

function _setGridWidth(mediawidth,gridId,groupFlag,groupHeaders){
		if(true == groupFlag){
			$("#"+gridId).jqGrid('destroyGroupHeader');
            $("#"+gridId).jqGrid('setGroupHeaders', {
    			useColSpanStyle: true,
    			groupHeaders:groupHeaders
    		});
		}
		$("#"+gridId).setGridWidth(mediawidth-2);
}

function formToJson(formId){				
	var o = {};				
    var fields = $(formId).serializeArray();
    $.each(fields, function(i, field){
    	if (o[field.name]) {
            if (!o[field.name].push) {
                o[field.name] = [ o[field.name] ];
            }
            o[field.name].push(field.value || '');
        } else {
            o[field.name] = field.value || '';
        }			    	 			    	  
    });		    				       
    return o;	
}

/**
 * jgGrid插件封装。请在ready事件内调用。封装函数会提供一些默认配置，但options可以覆盖。
 * @param elementId 
 * @param options jqGrid的标准参数。
 */
function smartJgrid(elementId,options){
	$(function(){
		var defaultOpts={
				datatype : 'json',
				mtype : 'post',
				rowNum : 15,
				rowList : [15, 30, 50 ],
				height : '100%',
				autowidth : true,
				altRows : true,//隔行变色--斑马线
				viewrecords : true, //1 - 10　共 15 条
				recordpos : 'left', //viewrecords显示在左边
				emptyrecords : "没有可显示记录",
				sortorder : "asc",				
				loadonce : false,//非本地化数据
				jsonReader : {
					root : "rows",
					page : "page",
					total : "total",
					records : "records",
					repeatitems : false,
					cell : "cell",
					id : "id"
				}
				//caption:'表头',
				//hidegrid : false,
				//multiselect:true,//是否多选
				//shrinkToFit : false,//自动扩展,设置false,列太长则出现滚动条（可以在colModel中设置frozen:true）
				//editurl:"",
				
		}
		
		
		$.extend(defaultOpts,options);
		
		$("#"+elementId).jqGrid(defaultOpts);
		
		jqgridResponsive(elementId,false);
		
		
	});
}


 
/**
 * 自动刷新jqgrid
 * @param id
 * @param time
 */
function autoRefreshGrid(id,time){
	setTimeout(function(){
		$("#"+id).trigger("reloadGrid");
	},time);
}

/**
 * jqgrid效果化表格
 * @param id
 */
function  boingTable(grid){
	$(grid+"_subgrid" ).css({ "border-right-style": "none"}) ;
	$("span[class*='ui-icon-minus']").hide().parent().parent().unbind("click");
	$("span[class*='ui-icon-carat-1-sw']").hide();
	$(grid).children('tbody').children('tr').css({ "border-style": "none"}) ;
	$(grid).children('tbody').children('tr').children('td').css({ "border-style": "none"}) ;
}

/**
 * jqgrid追加行
 * @param id
 * @param time
 */
function  addTableRows(grid, url){
	var allData = {};
	var postData = $(grid).jqGrid("getGridParam", "postData");			
	var pages = Number($(grid).jqGrid("getGridParam", "page"));
	var records = $(grid).jqGrid("getGridParam", "records");

	var totlePage = Math.ceil(records / postData.rows) ;
	if(postData.page < totlePage){
		postData.page = pages + 1;
	}
	
	 $(grid).jqGrid('setGridParam',{page: pages });
	  $.ajax({
			url: url ,
			type: "get",
			dataType: 'json',
			async: false,
			data: postData,	  			
			success:function(data){
				var oldRecords = $(grid).jqGrid("getGridParam", "records");
				if(data.records > oldRecords){
					$(grid).jqGrid('setGridParam',{treeANode: -1} );//刷新,设置treeANode(-1),能追加
					//刷新所有的数据
					allData = refreshAllData(grid);					
				}else{
					
					$(grid).jqGrid('setGridParam',{treeANode: 0} );//追加,设置treeANode非(-1),才能追加
					$(grid)[0].addJSONData(data);
					allData = data;
				}				
		  	}
		});
	 return allData; 
}

function  refreshAllData(grid ){
	var param={};
	var postData = $(grid).jqGrid("getGridParam", "postData");
	$.each(postData, function(name, value){
		param[name] = value;
	});
	
	param.rows = postData.rows * postData.page;
	param.page = 1;
	
	var allData={};
	 $.ajax({
			url: $(grid).jqGrid("getGridParam", "url") ,
			type: "get",
			dataType: 'json',
			async: false,
			data: param,	  			
			success:function(data){
				$(grid).jqGrid("setGridParam", {rowNum: param.rows, page:1 });
				$(grid)[0].addJSONData(data);				
				allData= data;				

				$(grid).jqGrid("setGridParam", {rowNum: postData.rows, page:postData.page });
		  		}
		});
	 
	 return allData;
}

/******************************************************jqGrid END*********************************/