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
<table width="100%">
	<tr>
		<td width="30%">
			选择需求：
			<select id="s_requireId" name="requireId" class="input-sm">
				<c:forEach items="${srList}" var="sr">
					<option value="${sr.fkey}">${sr.fvalue}</option>
				</c:forEach>
			</select>
		</td> 
		<td width="70%" align="right">
		</td>
	</tr>
</table>
<br/>
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
</form>
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
		$("#currPos").html("服务需求<label class='icon-double-angle-right'/>选择方案");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				postData:{requireId:'${requireId}'},
				colNames:['id','方案名称','需求名称','数量','发现方式', '匹配方式','生产时间','匹配价格','匹配质量','评价','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'resolutionName',index:'resolutionName',width:'120'},
	                {name:'requireName',index:'requireName',width:'160'},
	                {name:'resolutionCount',index:'resolutionCount',width:'50'},
			   		{name:'resolutionLevel',width:'50',index:'resolutionLevel',formatter:function(cellvalue,option,rowObjects){
		            	return {0:'无拆分',1:'一级拆分',2:'二级拆分'}[cellvalue];
		             }},
		             {name:'id',index:'id',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return '价格优先';
		             }},
		             {name:'resolutionStarttime',index:'resolutionStarttime',width:'60',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.resolutionStarttime+"<br/>"+rowObjects.resolutionEndtime;
		             }},
		             {name:'resolutionCost',index:'resolutionCost',width:'80'},
		             {name:'resolutionQualify',index:'resolutionQualify',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'3C认证',3:'rosh认证'}[cellvalue];
		             }},
		             {name:'commentScore',index:'commentScore',width:'50'},
			   		{name:'id',index:'id',width:'50',sortable:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var id = rowObjects.id;
			   			var operate="<a href='#' style='color:#f60'  onClick='return viewMatchList(\""+id+"\")'>明细</a>";
			   			operate += "&nbsp;&nbsp;<a href='#' style='color:#f60'  onClick='return updateResolution(\""+id+"\")'>选择</a>";
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
		
		
		$("#s_requireId").change(function(){
			PLG.gridSearch('searchForm','grid');
		});
		
		if('${requireId}'){
			$("#s_requireId").val('${requireId}');
		}
	});
	
	
	function viewMatchList(id){
		location = "${ctx}/requireMatch/list?resolutionId=" +id+"&requireId="+$("#s_requireId").val();
		return false;
	}
	
	function updateResolution(id){
		if(!confirm("您确定要选择当前方案吗？")){
			return false;
		}
		$.post( "${ctx}/requireResolution/updateResolution/",{id:id,requireId:$("#s_requireId").val()},function(result){
			var message = "操作失败！";
			if(true == result.success){
				message = "操作成功！";
			}
			showMsg(message,2000);
		});
	}
	
	function showMsg(message,delay){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		document.location.href = '${ctx}/requireResolution/list';
    	}, delay);
    }
</script>
</body>
</html>