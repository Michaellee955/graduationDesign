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
		<td width="10%">
			<label>企业(个人)列表</label>
		</td> 
		<td width="20%">
			<select id="s_dataType" name="dataType" class="input-sm" >
				<option value="1">企业</option>
				<option value="2">个人</option>
			</select>
		</td>
		<td width="70%" align="right">
			<button type="button" id="searchQuery" class="btn btn-primary btn-sm">查询</button>
			<button type="button" id="refreshQuery" class="btn btn-primary btn-sm">刷新</button>
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
<script type="text/javascript">
var zTreeObj=null;
var openFlag = '';
	$(function(){
		$("#currPos").html("系统管理<label class='icon-double-angle-right'/>企业(个人)管理");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','代码', '名称','类型','地址','资质','联系人','联系电话','注册日期','评分','状态','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'code',index:'code',width:'100'},
	                {name:'name',index:'name',width:'100'},
			   		{name:'type',width:'80',index:'type',stype:'select',searchoptions:{value:':全部;1:资源提供;2:服务需求;3:两者都有'},formatter:function(cellvalue,option,rowObjects){
		            	return {1:'资源提供',2:'服务需求',3:'两者都有'}[cellvalue];
		             }},
			   		{name:'addr',index:'addr',width:'80'},
			   		{name:'enterpriseQualification',index:'enterpriseQualification',width:'80',stype:'select',searchoptions:{value:':全部;1:GE认证;2:IOS900;3:高新技术企业;4:一级设计企业;5:二级设计企业'},
			   			formatter:function(cellvalue,option,rowObjects){
		            	return {1:'GE认证',2:'IOS900',3:'高新技术企业',4:'一级设计企业',5:'二级设计企业'}[cellvalue];
		             }},
		             {name:'contactPerson',index:'contactPerson',width:'80'},
		             {name:'contactNumber',index:'contactNumber',width:'80'},
			   		{name:'createTime',width:'100',index:'createTime',searchoptions:{
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
	                {name:'commentScore',index:'commentScore',width:'80'},
	                {name:'status',index:'status',width:'80',stype:'select',searchoptions:{value:':全部;0:待审核;1:正常;2:暂停服务'},formatter:function(cellvalue,option,rowObjects){
		            	return {0:'待审核',1:'正常',2:'暂停服务'}[cellvalue];
		             }},
			   		{name:'id',index:'id',width:'80',sortable:false,search:false,cellattr:function(){return " title=''";},formatter:function(cellvalue,option,rowObjects){
			   			var status = rowObjects.status,rid = rowObjects.id;
			   			var operate="<a href='#' style='color:#f60'  onClick='return view(\""+rid+"\")'>详情</a>";
			   			if(status == '0'){
			   				operate += "  <a href='#' style='color:#f60'  onClick='return audit(\""+rid+"\")'>审核</a>";
			   			}else if(status == '1'){
			   				operate += "  <a href='#' style='color:#f60'  onClick='return changeStatus(\""+rid+"\",2)'>停用</a>";
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
		
		
		//查询
		$("#searchQuery").bind("click",function(){
			searchFun();
		});
		
		$("#refreshQuery").bind("click",function(){
			setRefresh();;
		});
		
		$("#s_dataType").change(function(){
			PLG.gridSearch('searchForm','grid');
		});
	});
	
	function audit(id){
		window.open("${ctx}/manuBasicInfo/view?id="+id+"&audit=1&timestamp="+(new Date()).valueOf());
		return false;
	}
	
	function view(id){
		window.open("${ctx}/manuBasicInfo/view?id="+id+"&timestamp="+(new Date()).valueOf());
		return false;
	}
	
	function changeStatus(id, val){
		var txtArr = {2:"停用",1:"启用"};
		if(!confirm("您确定要"+txtArr[val]+"吗？")){
			return false;
		}
		//开始执行删除动作
		$.ajax({
			type: 'POST',
			url : "${ctx}/manuBasicInfo/updateStatus",
			data : {'id':id,'status':val},
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
			searchFun();
		}else{
			document.location.href = '${ctx}/manuBasicInfo/list';
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