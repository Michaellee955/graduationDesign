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
<input type="hidden" value="${ids}" name="ids"/>
<input type="hidden" value="${srId}" name="srId"/>
<table width="100%">
	<tr>
		<td width="30%">
			选择匹配类型：<select id="s_type" name="type" class="input-sm">
				<option value="0">价格优先</option>
				<option value="1">质量优先</option>
			</select>
			&nbsp;&nbsp;
		</td>
		<td width="40%">
			
		</td>
		<td width="20%">
			&nbsp;&nbsp;<button type="button" id="btnBack" class="btn btn-primary btn-sm">返回</button>
			&nbsp;&nbsp;<button type="button" id="btnSave" class="btn btn-warning btn-sm">保存方案</button>
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
<form id="postForm" method="post" action="${ctx}/providingResources/showSelectPrList">
	
</form>
<script type="text/javascript">
	$(function(){
		$("#currPos").html("我的需求<label class='icon-double-angle-right'/>服务匹配");
		var option = {
				url : 'selectSearchSrListData', 
				datatype : 'json', 
				mtype : 'post',
				postData:{ids:'${ids}', srId:'${srId}'},
				colNames:['id', '生产产品','厂商名称','资源名称','时间','单价','数量','价格','质量','评价','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'productName',index:'productName',width:'80'},
	                {name:'manufacturerCode',index:'manufacturerCode',width:'150'},
	                {name:'providingName',index:'providingName',width:'150'},
		             {name:'serviceStarttime',index:'serviceStarttime',width:'60',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.serviceStarttime+"<br/>"+rowObjects.serviceEndtime;
		             }},
	                {name:'servicePrive',index:'servicePrive',width:'50'},
	                {name:'serviceAbility',index:'serviceAbility',width:'50'},
	                {name:'resourcesCost',index:'resourcesCost',width:'80'},
			   		{name:'productQualify',index:'productQualify',width:'50',formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'3C认证',3:'rosh认证'}[cellvalue];
		             }},
		             {name:'commentScore',index:'commentScore',width:'50'},
		             {name:'id',index:'id',width:'50',sortable:false,search:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
				   			var rid = rowObjects.id;
				   			var operate="<a href='#' style='color:#f60'  onClick='return view(\""+rid+"\")'>详情</a>";
				   			return operate;
				   		}}],
				height : "100%",
				autowidth : true, 
				altRows:true,
				hidegrid : false, 
				rownumbers: true,
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
		
		//自适应
		jqgridResponsive("grid",false);
		
		$("#s_type").bind("change",function(){
			if($(this).val() == '1'){
				$("#grid").jqGrid("clearGridData");
			}else{
				PLG.gridSearch('searchForm','grid');
			}
		});
		
		$("#btnBack").click(function(){
			location = "${ctx}/providingResources/searchSrList?srId=${srId}&level=${level}&timestamp="+(new Date()).valueOf();
		});
		
		$("#btnSave").click(function(){
			var _ids = $(grid).jqGrid('getGridParam', 'selarrrow');
			 if($.isArray(_ids)&&_ids.length>0){
				   $("#postForm").html('');//防止元素重复
				   $("#postForm").attr("target","newWin");
				   $("#postForm").append('<input type="hidden" name="ids" value="'+_ids+'"/>');
				   $("#postForm").append('<input type="hidden" name="srId" value="${srId}"/>');
				   $("#postForm").append('<input type="hidden" name="level" value="${level}"/>');
				   window.open("about:blank","newWin","");//newWin 是上面form的target
				   $("#postForm").submit();
			 }else{
				 alert('请选择一条数据！');
				 return;
			 }
		});
	});
	
	
	function view(id){
		window.open("${ctx}/providingResources/view?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
</script>
</body>
</html>