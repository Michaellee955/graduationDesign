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
			<button type="button" id="btnBack" class="btn btn-primary btn-sm">返回</button>
		</td>
	</tr>
</table>
<br/>
<form id="searchForm">
<c:if test="${not empty resolutionId}">
	<input type="hidden" value="${resolutionId}" name="resolutionId"/>
</c:if>
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
</form>
<script type="text/javascript">
	$(function(){
		$("#currPos").html("选择方案<label class='icon-double-angle-right'/>方案明细");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				postData:{resolutionId:'${resolutionId}'},
				colNames:['id','生产产品','厂商名称','资源名称','时间','费用','数量','质量','评分','状态'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'productId',index:'productId',width:'80'},
	                {name:'manufacturerCode',index:'manufacturerCode',width:'140'},
	                {name:'resourceId',index:'resourceId',width:'140'},
		             {name:'taskStarttime',index:'taskStarttime',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.taskStarttime+"<br/>"+rowObjects.taskEndtime;
		             }},
		             {name:'productCost',index:'productCost',width:'50'},
		             {name:'productNumber',index:'productNumber',width:'50'},
		             {name:'productQualify',index:'productQualify',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'3C认证',3:'rosh认证'}[cellvalue];
		             }},
				   	{name:'commentScore',index:'commentScore',width:'50'},
				   	{name:'taskStatus',index:'taskStatus',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return {0:'未开始',1:'进行中',2:'任务延时',3:'任务完成',4:'任务取消'}[cellvalue];
		             }}
			   		],
				rowNum : 15, 
				rowList : [ 15, 30, 50 ], 
				height : "100%",
				autowidth : true, 
				altRows:true,
				hidegrid : false, 
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
			searchFun(1);
		});
		
		$("#btnBack").click(function(){
			if('${requireId}'){
				location = "${ctx}/requireResolution/list?requireId=${requireId}";
			}else{
				location = "${ctx}/requireResolution/successList";
			}
		});
	});
</script>
</body>
</html>