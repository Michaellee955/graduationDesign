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
<input type="hidden" value="${srId}" name="srId"/>
<table width="100%">
	<tr>
		<td width="30%">
			选择服务发现方式：<select id="s_level" name="level" class="input-sm">
				<option value="0">无拆分</option>
				<option value="1">一级拆分</option>
				<option value="2">二级拆分</option>
			</select>
			&nbsp;&nbsp;
		</td>
		<td width="40%">
			
		</td>
		<td width="20%">
			&nbsp;&nbsp;<button type="button" id="btnBack" class="btn btn-primary btn-sm">返回</button>
			&nbsp;&nbsp;<button type="button" id="btnNext" class="btn btn-warning btn-sm">下一步</button>
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
<form id="postForm" method="post" action="${ctx}/providingResources/selectSearchSrList">
	
</form>
<script type="text/javascript">
	$(function(){
		$("#currPos").html("我的需求<label class='icon-double-angle-right'/>服务发现");
		var option = {
				url : 'searchSrList', 
				datatype : 'json', 
				mtype : 'post',
				postData:{srId:'${srId}',level:'${level}'},
				colNames:['id', '生产产品','厂商名称','资源名称','时间','数量','价格','质量','评价','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'productName',index:'productName',width:'80'},
	                {name:'manufacturerCode',index:'manufacturerCode',width:'150'},
	                {name:'providingName',index:'providingName',width:'150'},
		             {name:'serviceStarttime',index:'serviceStarttime',width:'60',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.serviceStarttime+"<br/>"+rowObjects.serviceEndtime;
		             }},
	                {name:'serviceAbility',index:'serviceAbility',width:'50'},
	                {name:'servicePrive',index:'servicePrive',width:'80'},
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
		
		//取消按钮操作
		$('#btnNext').click(function(){
			var _ids = $(grid).jqGrid('getGridParam', 'selarrrow');
			 if($.isArray(_ids)&&_ids.length>0){
			   $("#postForm").html('');//防止元素重复
			   $("#postForm").append('<input type="hidden" name="ids" value="'+_ids+'"/>');
			   $("#postForm").append('<input type="hidden" name="srId" value="${srId}"/>');
			   $("#postForm").append('<input type="hidden" name="level" value="'+$("#s_level").val()+'"/>');
			   $("#postForm").submit();
			 }else{
				 alert('请选择一条数据！');
				 return;
			 }
		});	
		
		
		//下拉
		$("#s_level").bind("change",function(){
			PLG.gridSearch('searchForm','grid');
		});
		
		$("#btnBack").click(function(){
			location = "${ctx}/serviceRequire/list";
		});
	});
	
	
	function view(id){
		window.open("${ctx}/providingResources/view?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
</script>
</body>
</html>