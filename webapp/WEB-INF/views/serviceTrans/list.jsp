<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<form id="searchForm">
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
</form>
<div id='dialog-confirm' class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="modelTitle">交易审核</h4>
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
<script type="text/javascript">
	$(function(){
		$("#currPos").html("资源提供<label class='icon-double-angle-right'/>服务交易");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				postData:{requireId:'${requireId}'},
				colNames:['id','资源编号','资源名称','需求名称','需求方','数量','匹配价格','匹配时间','状态','评价','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'resourcesCode',index:'resourcesCode',width:'80'},
	                {name:'providingName',index:'providingName',width:'120'},
	                {name:'requireName',index:'requireName',width:'120'},
	                {name:'manuName',index:'manuName',width:'120'},
	                {name:'productNumber',index:'productNumber',width:'50'},
	                {name:'productCost',index:'productCost',width:'50'},
		             {name:'taskStarttime',index:'taskStarttime',width:'60',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.taskStarttime+"<br/>"+rowObjects.taskEndtime;
		             }},
		             {name:'taskStatus',index:'taskStatus',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return {0:'待审核',1:'进行中',2:'任务延时',3:'完成',4:'取消'}[cellvalue];
		             }},
		             {name:'taskScore',index:'taskScore',width:'50'},
			   		{name:'id',index:'id',width:'50',sortable:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var id = rowObjects.id;
			   			var operate="<a href='#' style='color:#f60'  onClick='return view(\""+rowObjects.resourceId+"\")'>详情</a>";
			   			if(rowObjects.taskStatus == '0'){
			   				operate += "&nbsp;&nbsp;<a href='#' style='color:#f60'  onClick='return audit(\""+id+"\")'>审核</a>";
			   			}
			   			return operate;
			   		}}],
				rowNum : 15, 
				rowList : [ 15, 30, 50 ], 
				height : "100%",
				autowidth : true, 
				altRows:true,
				hidegrid : false, 
				viewrecords : true, 
				recordpos : 'left', 
				sortorder : "desc",
				emptyrecords : "没有可显示记录", 
				loadonce : false,
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
		
		//自适应
		jqgridResponsive("grid",false);
		
		
		//取消按钮操作
		$('#cancel').click(function(){
			$('#dialog-confirm').modal('hide');
		});	
		
		//新增或修改操作
		$('#do_save').click(function(){
				$("#do_save").attr("disabled",true);
		 		$.post( "${ctx}/serviceTrans/updateStatus/",{id:$("#st_id").val(),status:$('input[name="taskStatus"]:checked ').val()},function(result){
			 		$('#dialog-confirm').modal('hide');
		 			var message = "操作失败！";
		 			if(true == result.success){
		 				message = "操作成功！";
		 			}
		 			showMsg(message,2000);
	 		});
		});
	});
	
	
	function view(id){
		window.open("${ctx}/providingResources/view?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
	
	function audit(id){
		openDialog("${ctx}/serviceTrans/openmodal?id="+id+"&timestamp="+(new Date()).valueOf());
	}
	
	function showMsg(message,delay){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		PLG.gridSearch('searchForm','grid');
    	}, delay);
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