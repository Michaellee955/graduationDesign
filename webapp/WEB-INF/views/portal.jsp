<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(function(){
		$("#currPos").html('首页');
		
		var option = {
				url : 'index/list', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','编码', '名称','类型','数量','质量','价格','服务时间','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'code',index:'code',width:'100'},
	                {name:'name',index:'name',width:'200'},
	                {name:'type',width:'50',index:'type',formatter:function(cellvalue,option,rowObjects){
		            	return {1:'设计',2:'制造',3:'测试',4:'仿真',5:'软件'}[cellvalue];
		             }},
			   		{name:'count',width:'50',index:'count'},
			   		{name:'qualify',index:'qualify',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'3C认证',3:'rosh认证'}[cellvalue];
		             }},
		             {name:'prive',index:'prive',width:'50'},
		             {name:'startTime',index:'startTime',width:'80',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.startTime+"<br/>"+rowObjects.endTime;
		             }},
			   		{name:'id',index:'id',width:'80',sortable:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var status = rowObjects.status,rid = rowObjects.id;
			   			var operate="<a href='#' style='color:#f60'  onClick='return view(\""+rid+"\")'>详情</a>";
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
		
		//自适应
		jqgridResponsive("grid",false);
		
		//查询
		$("#searchQuery").bind("click",function(){
			PLG.gridSearch('searchForm','grid');
		});
		
	});
	
	function view(id){
		window.open("${ctx}/"+$("#dataType").val()+"/view?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
</script>
</head>
<body>
<form id="searchForm">
<table width="100%">
	<tr>
		<td width="30%" style="text-align: right;">
			搜索类型：<select id="dataType" name="dataType" class="input-sm" >
				<option value="providingResources">资源</option>
				<option value="serviceRequire">需求</option>
			</select>
			&nbsp;&nbsp;
		</td>
		<td width="40%" style="text-align: center;">
			<input type="text" id="data" name="data" class="form-control input-sm inputCss" placeholder="资源(需求)名称">
		</td>
		<td width="20%">
			&nbsp;&nbsp;<button type="button" id="searchQuery" class="btn btn-primary btn-sm">搜索</button>
		</td>
	</tr>
</table>
<br>
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
</form>
</body>
</html>