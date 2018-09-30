<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<table width="100%">
	<tr>
		<td width="30%">
			<label>产品类型</label>
		</td> 
		<td width="70%" align="right">
			<button type="button" id="searchQuery" class="btn btn-primary btn-sm">查询</button>
			<button type="button" id="btnAdd" class="btn btn-primary btn-sm">添加</button>
			<button type="button" id="btnEdit" class="btn btn-primary btn-sm">编辑</button>
			<button type="button" id="refreshQuery" class="btn btn-primary btn-sm">刷新</button>
		</td>
	</tr>
</table>
<div id='dialog-confirm' class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="modelTitle">产品类型信息</h4>
      </div>
      <div class="modal-body">
        <p>加载中……</p>
      </div>
      <div class="modal-footer">
		<button type="button" id ='cancel' class="btn btn-default btn-sm" tabindex="1001">取消</button>
        <button type="button" id ='do_save' class="btn btn-primary btn-sm" tabindex="1000">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id='messageAlert' class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      	 <h4 class="modal-title">提示</h4>
      </div>
      <div class="modal-body">
        <p id="textP">...</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<br/>
<form id="searchForm">
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
</form>
<script type="text/javascript">
var zTreeObj=null;
var openFlag = '';
	$(function(){
		$("#currPos").html("产品管理<label class='icon-double-angle-right'/>产品类型");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','编码','名称','版本','状态','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
			   		{name:'serialCode',index:'serialCode'},
			   		{name:'serialName',index:'serialName'},
			   		{name:'version',index:'version'},
			   		{name:'isEnable',width:'100',index:'isEnable',stype:'select',searchoptions:{value:':全部;1:有效;0:无效'},formatter:function(cellvalue,option,rowObjects){
			   			return {1:'有效',0:'无效'}[cellvalue];
			   		}},
			   		{name:'operate',index:'id',width:'130',align:"center",sortable:false,search:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var isEnable = rowObjects.isEnable,rid = rowObjects.id;
			   			var operate="";
			   				if(isEnable == '1'){
			   					operate += "  <a href='#' style='color:#f60'  onClick='return changeStatus(\""+rid+"\",0)'>停用</a>";
			   				}else{
			   					operate += "  <a href='#' style='color:#f60'  onClick='return changeStatus(\""+rid+"\",1)'>启用</a>";
			   				}
			   			return operate;
			   		}}],
				rowNum : 15, 
				rowList : [ 15, 30, 50 ], 
				height : "100%",
				autowidth : true, 
				pager : '#pager', 
				altRows:true,
				hidegrid : false, 
				viewrecords : true, 
				recordpos : 'left', 
				sortorder : "desc",
				emptyrecords : "没有可显示记录", 
				loadonce : false,
				multiselect:true,
				jsonReader : {
					root : "rows", 
					page : "page", 
					total : "total", 
					records : "records",
					repeatitems : false, 
					cell : "cell",
					id : "id"
				}
		};
		$("#grid").jqGrid(option);
		$("#grid").jqGrid('filterToolbar');
		
		//自适应
		jqgridResponsive("grid",false);
		
		//取消按钮操作
		$('#cancel').click(function(){
			$('#dialog-confirm').modal('hide');
		});	
		
		
		//绑定添加按钮
		$("#btnAdd").click(function(){  
			openDialog("${ctx}/productSerial/openmodal?timestamp="+(new Date()).valueOf());
			openFlag = '1';
		}); 
		
	
		$("#btnEdit").click(function(){
			var ids = $("#grid").jqGrid('getGridParam','selarrrow');
			if($.isEmptyObject(ids)||ids.length >1) {
				showMsg('请选择一条数据,且仅选择一条数据',2000,-1);
				return;
			}
			var oneData = $("#grid").jqGrid('getRowData',ids[0]); 
			openDialog("${ctx}/productSerial/openmodal?id="+oneData.id+"&timestamp="+(new Date()).valueOf());
			openFlag = '1';
		});
		
		//新增或修改操作
		$('#do_save').click(function(){
				var myform = $("#dialog-confirm").find("form").serializeArray();
				var keysArr = new Array();
				var data = {};
				$.each(myform, function(i, field){
					data[field.name] = field.value;
					keysArr.push(field.name);
				});
				var jsonArr= new Array();
				jsonArr.push(data);
			 	if(!dataCheck2(jsonArr,keysArr,'50%','version')){
				   return;
			   	}
				$("#do_save").attr("disabled",true);
				saveOrUpdateData(data);
		});
		
		//查询
		$("#searchQuery").bind("click",function(){
			searchFun();
		});
		
		$("#refreshQuery").bind("click",function(){
			setRefresh();;
		});
		
		
	});
	
	//修改数据
	function saveOrUpdateData(data){	
		$.post("${ctx}/productSerial/saveOrUpdatePs",data,function(result){
			$('#dialog-confirm').modal('hide');
			var message = "提交数据失败！";
			if(true == result.success){
				message = "提交数据成功！";
			}
			showMsg(message,2000);
		},'json');
	}
	
    function showMsg(message,delay,page){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		if(page == -1) return;
    		setRefresh(page);
    	}, delay);
    }
	
	
    function changeStatus(id, val){
		var txtArr = {0:"停用",1:"启用"};
		if(!confirm("您确定要"+txtArr[val]+"吗？")){
			return false;
		}
		$.ajax({
			type: 'POST',
			url : "${ctx}/productSerial/updateStatus",
			data : {'id':id,'isEnable':val},
			dataType: 'json',
			cache : false,
			success : function(result, textStatus) {
				var message = "操作失败！";
				if(true == result.success){
    				message = "操作成功！";
				}
				showMsg(message,2000,1);
			}
		});
	}
	
    function searchFun(){
    	PLG.gridSearch('searchForm','grid');
    }
    
	function setRefresh(page){
		if(page){
			searchFun();
		}else{
			document.location.href = '${ctx}/productSerial/list';
		}
	}
	
	//弹出对话框
	function openDialog(url){
		$( "#dialog-confirm" ).modal({
			 backdrop: 'static'
		});
		$( "#do_save").attr("disabled",false);
		//使用此方法防止js缓存不加载
		$("#dialog-confirm p" ).text("加载中...");
		$("#dialog-confirm p" ).load(url);
	}
</script>
</body>
</html>