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
		<td width="30%" style="text-align: right;">
			方案名称：
		</td>
		<td width="20%">
			<input type="text" id="resolutionName" name="resolutionName" style="display: inline;" class="form-control input-sm inputCss" placeholder="方案名称">
		</td>
		<td width="20%">
			
		</td>
		<td width="20%">
			&nbsp;&nbsp;<button type="button" id="btnClose" class="btn btn-primary btn-sm">关闭</button>
			&nbsp;&nbsp;<button type="button" id="btnSave" class="btn btn-warning btn-sm">保存</button>
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
<form id="postForm" method="post" action="${ctx}/requireResolution/showResolution">
	
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
		$("#currPos").html("我的需求<label class='icon-double-angle-right'/>服务匹配");
		var option = {
				url : 'selectSearchSrListData', 
				datatype : 'json', 
				mtype : 'post',
				postData:{ids:'${ids}', srId:'${srId}'},
				colNames:['id', '发现方式','匹配方式','生产产品','厂商名称','资源名称','时间','单价','数量','价格','质量','评价','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'id',index:'id',width:'60',sortable:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
	                	return {0:'无拆分',1:'一级拆分',2:'二级拆分'}['${level}'];
			   		}},
	                {name:'id',index:'id',width:'60',sortable:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			return '价格优先';
			   		}},
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
		             {name:'id',index:'id',width:'50',sortable:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
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
				footerrow : true,
				userDataOnFooter : true,
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
		
		$("#btnClose").click(function(){
			window.close();
			return false;
		});
		
		$("#btnSave").click(function(){
			$.post("${ctx}/requireResolution/saveRr/",{prIds:'${ids}',level:'${level}',srId:'${srId}',resolutionName:$("#resolutionName").val()},function(result){
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
	
	function showMsg(message,delay){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		window.close();
    	}, delay);
    }
</script>
</body>
</html>