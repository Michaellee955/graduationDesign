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
			<label>方案列表</label>
		</td> 
		<td width="70%" align="right">
			<button type="button" id="searchQuery" class="btn btn-primary btn-sm">查询</button>
			<button type="button" id="refreshQuery" class="btn btn-primary btn-sm">刷新</button>
		</td>
	</tr>
</table>
<br/>
<form id="searchForm">
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
</form>
<script type="text/javascript">
	$(function(){
		$("#currPos").html("服务需求<label class='icon-double-angle-right'/>进度查看");
		var option = {
				url : 'successList', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','方案名称','需求名称','数量','发现方式', '匹配方式','生产时间','匹配价格','匹配质量','评价','状态','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'resolutionName',index:'resolutionName',width:'120'},
	                {name:'requireName',index:'requireName',width:'120'},
	                {name:'resolutionCount',index:'resolutionCount',width:'50'},
			   		{name:'resolutionLevel',width:'60',index:'resolutionLevel',stype:'select',searchoptions:{value:':全部;0:无拆分;1:一级拆分;2:二级拆分'},formatter:function(cellvalue,option,rowObjects){
		            	return {0:'无拆分',1:'一级拆分',2:'二级拆分'}[cellvalue];
		             }},
		             {name:'id',index:'id',width:'40',search:false,formatter:function(cellvalue,option,rowObjects){
			            	return '价格优先';
			             }},
		             {name:'resolutionStarttime',index:'resolutionStarttime',width:'60',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.resolutionStarttime+"<br/>"+rowObjects.resolutionEndtime;
		             },searchoptions:{
				   			dataInit:function(element){
				   				$(element).datetimepicker({
				   					autoclose: 1,
				   					minView: 2,
				   					format: "yyyy-mm-dd",
				   					todayBtn:  1,
				   					language:'zh-CN'
				   				});
				   			}
				   		}},
		             {name:'resolutionCost',index:'resolutionCost',width:'50'},
		             {name:'resolutionQualify',index:'resolutionQualify',width:'60',stype:'select',searchoptions:{value:':全部;1:GE认证;2:3C认证;3:rosh认证'},formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'3C认证',3:'rosh认证'}[cellvalue];
		             }},
		             {name:'commentScore',index:'commentScore',width:'50'},
		             {name:'taskStatus',index:'taskStatus',width:'50',search:false,formatter:function(cellvalue,option,rowObjects){
		            	return {0:'待审核',1:'进行中',2:'延时',3:'完成',4:'取消'}[cellvalue];
		             }},
			   		{name:'id',index:'id',width:'50',sortable:false,search:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var id = rowObjects.id;
			   			var operate="<a href='#' style='color:#f60'  onClick='return viewMatchList(\""+id+"\")'>明细</a>";
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
		
		//查询
		$("#searchQuery").bind("click",function(){
			PLG.gridSearch('searchForm','grid');
		});
		
		$("#refreshQuery").bind("click",function(){
			location.href = '${ctx}/requireResolution/list';
		});
	});
	
	
	function viewMatchList(id){
		location = "${ctx}/requireMatch/list?resolutionId=" +id;
		return false;
	}
</script>
</body>
</html>