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
			<label>
			<c:if test="${not empty type}">
				服务发现
			</c:if>
			<c:if test="${empty type}">
				我的需求
			</c:if>
			</label>
		</td> 
		<td width="70%" align="right">
			<button type="button" id="searchQuery" class="btn btn-primary btn-sm">查询</button>
			<button type="button" id="refreshQuery" class="btn btn-primary btn-sm">刷新</button>
		</td>
	</tr>
</table>
<div id='dialog-confirm' class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="modelTitle">信息</h4>
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
		if('${type}'){
			$("#currPos").html("服务大厅<label class='icon-double-angle-right'/>服务发现");
		}else{
			$("#currPos").html("服务需求<label class='icon-double-angle-right'/>我的需求");
		}
		
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','编号', '名称','类型','数量','认证','价格','时间','状态','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'requireCode',index:'requireCode',width:'100'},
	                {name:'requireName',index:'requireName',width:'100'},
			   		{name:'serviceType',width:'80',index:'serviceType',stype:'select',searchoptions:{value:':全部;1:设计;2:制造;3:测试;4:仿真;5:软件'},formatter:function(cellvalue,option,rowObjects){
		            	return {1:'设计',2:'制造',3:'测试',4:'仿真',5:'软件'}[cellvalue];
		             }},
			   		{name:'requireCount',index:'requireCount',width:'100',formatter:function(cellvalue,option,rowObjects){
			   			return cellvalue + "" +({1:'个/月',2:'个/日',3:'人.月',4:'个'}[rowObjects.requireUint]);
			   		}},
			   		{name:'requireQualify',index:'requireQualify',width:'80',stype:'select',searchoptions:{value:':全部;1:GE认证;2:3C认证;3:rosh认证'},
			   			formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'3C认证',3:'rosh认证'}[cellvalue];
		             }},
		             {name:'requirePrive',index:'requirePrive',width:'80'},
		             {name:'requireStarttime',index:'requireStarttime',width:'80',formatter:function(cellvalue,option,rowObjects){
		            	 return rowObjects.requireStarttime+"<br/>"+rowObjects.requireEndtime;
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
	                {name:'isEnable',index:'isEnable',width:'80',stype:'select',searchoptions:{value:':全部;0:无效;1:有效'},formatter:function(cellvalue,option,rowObjects){
		            	return {0:'无效',1:'有效'}[cellvalue];
		             }},
			   		{name:'id',index:'id',width:'120',sortable:false,search:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var rid = rowObjects.id;
			   			var operate="<a href='#' style='color:#f60'  onClick='return view(\""+rid+"\")'>详情</a>";
			   			if(rowObjects.status == '0'){
			   				operate += "  <a href='#' style='color:#f60'  onClick='return edit(\""+rid+"\")'>修改</a>";
			   				operate += "  <a href='#' style='color:#f60'  onClick='return del(\""+rid+"\")'>删除</a>";
			   				operate += "  <a href='#' style='color:#f60'  onClick='return viewResources(\""+rid+"\")'>匹配方案</a>";
			   			}else{
			   				operate += "  <a href='#' style='color:#f60'  onClick='return viewResources(\""+rid+"\")'>查看进度</a>";
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
				multiselect:false,
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
		
		
		//查询
		$("#searchQuery").bind("click",function(){
			searchFun(1);
		});
		
		$("#refreshQuery").bind("click",function(){
			setRefresh();;
		});
	});
	
	
	function view(id){
		window.open("${ctx}/serviceRequire/view?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
	
	function edit(id){
		window.open("${ctx}/serviceRequire/edit?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
	
	function viewResources(srId){
		location = "${ctx}/providingResources/searchSrList?srId="+srId+"&level=0&timestamp="+(new Date()).valueOf();
		return false;
	}

	function del(id){
		if(!confirm("您确定要删除选中数据吗？")){
			return false;
		}
		
		$.post( "${ctx}/serviceRequire/delete/",{id:id},function(result){
			var message = "删除数据失败！";
			if(true == result.success){
				message = "删除数据成功！";
			}
			showMsg(message,2000,1);
		});
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
	
	
	function searchFun(){
		PLG.gridSearch('searchForm','grid');
	}
	
	function setRefresh(page){
		if(page){
			searchFun(page);
		}else{
			document.location.href = '${ctx}/serviceRequire/list';
		}
	}
	
	//弹出对话框
	function openDialog(url,title){
		$( "#dialog-confirm" ).modal({
			 backdrop: 'static'
		});
		$( "#do_save").attr("disabled",false);
		$("#modelTitle").text(title);
		//使用此方法防止js缓存不加载
		$("#dialog-confirm p" ).text("加载中...");
		$("#dialog-confirm p" ).load(url);
	}
</script>
</body>
</html>