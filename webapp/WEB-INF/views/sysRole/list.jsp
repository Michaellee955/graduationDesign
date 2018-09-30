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
			<label>系统角色列表</label>
		</td> 
		<td width="70%" align="right">
			<button type="button" id="searchQuery" class="btn btn-primary btn-sm">查询</button>
			<shiro:hasPermission name="systemRole:add">
			<button type="button" id="btnAdd" class="btn btn-primary btn-sm">添加</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="systemRole:edit">
			<button type="button" id="btnEdit" class="btn btn-primary btn-sm">编辑</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="systemRole:del">
			<button type="button" id="btnDel" class="btn btn-primary btn-sm">删除</button>
			</shiro:hasPermission>
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
<div id='jqgrid'>
	<table id='grid'>
	</table>
	<div id='pager'></div>
</div> 
<script type="text/javascript">
var zTreeObj=null;
var openFlag = '';
	$(function(){
		$("#currPos").html("系统管理<label class='icon-double-angle-right'/>系统角色");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','角色名称','备注','状态','创建时间','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
			   		{name:'roleName',width:'150',index:'roleName'},
			   		{name:'remark',width:'400',index:'remark'},
			   		{name:'statusTxt',width:'100',index:'status',stype:'select',searchoptions:{value:':全部;1:启用;0:不启用'}},
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
			   		{name:'operate',index:'id',width:'130',align:"center",sortable:false,search:false,cellattr:function(){return " title=''";}}],
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
				gridComplete:function(){
					var ids = $("#grid").jqGrid('getDataIDs');
					for(var i=0;i<ids.length;i++){
						var operate="";
						<shiro:hasPermission name="systemRole:assignPermis">
						operate +="<a href='#' style='color:#f60'  onClick='assignPermis(\""+ids[i]+"\")'>分配权限</a>";
						</shiro:hasPermission>
						$("#grid").jqGrid('setRowData',ids[i],{operate:operate});
					}
				},
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
		
		
		//绑定添加按钮
		$("#btnAdd").click(function(){  
			openDialog("${ctx}/sysRole/openmodal?timestamp="+(new Date()).valueOf(),'角色信息');
			openFlag = '1';
		}); 
		
		
		//新增或修改操作
		$('#do_save').click(function(){
			if(openFlag == '1'){
				var myform = $("#dialog-confirm").find("form").serializeArray();
				var keysArr = new Array();
				var data = {};
				$.each(myform, function(i, field){
					data[field.name] = field.value;
					keysArr.push(field.name);
				});
				var jsonArr= new Array();
				jsonArr.push(data);
			 	if(!dataCheck(jsonArr,keysArr,'50%')){
				   return;
			   	}
				$("#do_save").attr("disabled",true);
				updateData('${ctx}/sysRole/addOrUpdate/',data,1);
			}else if(openFlag == '2'){
				if(!zTreeObj){
					return false;
				}
				var nodes = zTreeObj.getCheckedNodes();
				var checkedId = "";
				for(var i=0;i<nodes.length;i++){
					if(checkedId){
						checkedId += ",";
					}
					checkedId +=nodes[i].id;
				}
				var data = {'id':$("#sysRoleFormId").val(),'checkedId':checkedId};
				updateData('${ctx}/sysRole/updateRolePermis/',data,-1);
			}
		});
		
		//修改数据
		function updateData(url,data,page){	
			$.ajax({
				type: 'POST',
				url : url,
				dataType : "json",
				data : {'jsonStr':JSON.stringify(data)},
				cache : false,
				success : function(result, textStatus) {
					$('#dialog-confirm').modal('hide');			
					var message = "提交数据失败！";
					if(true == result.success){
	    				message = "提交数据成功！";
					}
					showMsg(message,2000,page);
				}
			});
		}
		
		//绑定删除按钮
		$("#btnDel").bind("click",function(){
			var _ids = $("#grid").jqGrid('getGridParam','selarrrow');
			if($.isEmptyObject(_ids)) {
				showMsg('请选择一条数据！',2000,-1);
				return;
			}
			
			if(!confirm("您确定要删除选中数据吗？")){
				return false;
			}
			//开始执行删除动作
			$.ajax({
				type: 'POST',
				url : "${ctx}/sysRole/delete/",
				data : {'jsonStr':JSON.stringify(_ids)},
				dataType: 'json',
				cache : false,
				success : function(result, textStatus) {
					var message = "删除数据失败！";
					if(true == result.success){
	    				message = "删除数据成功！";
					}
					showMsg(message,2000,1);
				}
			});
		});
		
		$("#btnEdit").click(function(){
			var ids = $("#grid").jqGrid('getGridParam','selarrrow');
			if($.isEmptyObject(ids)||ids.length >1) {
				showMsg('请选择一条数据,且仅选择一条数据',2000,-1);
				return;
			}
			var oneData = $("#grid").jqGrid('getRowData',ids[0]); 
			openDialog("${ctx}/sysRole/openmodal?id="+oneData.id+"&timestamp="+(new Date()).valueOf(),'角色信息');
			openFlag = '1';
		});
		
		//查询
		$("#searchQuery").bind("click",function(){
			searchFun(1);
		});
		
		$("#refreshQuery").bind("click",function(){
			setRefresh();;
		});
	});
	
	function assignPermis(id){
		openDialog("${ctx}/sysRole/openmodal/assignPermis?id="+id+"&timestamp="+(new Date()).valueOf(),'分配权限');
		openFlag = '2';
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
	
	
	function searchFun(page){
		var postData = $("#grid").jqGrid("getGridParam", "postData");  
		 var myData = {};
		 var roleName = $("#gs_roleName").val();
		 var remark = $("#gs_remark").val();
		 var createTime = $("#gs_createTime").val();
		 if(roleName && ''!= roleName){
			 myData.roleName = roleName;
		 }else{
			 delete postData.roleName;
		 }	 
		 if(remark && ''!= remark){
			 myData.remark = remark;
		 }else{
			 delete postData.remark;
		 }
		 if(createTime && ''!= createTime){
			 myData.createTime = createTime;
		 }else{
			 delete postData.createTime;
		 }	 
		 $.extend(postData,myData);
		$("#grid").jqGrid("setGridParam", 
				{search: true }).trigger("reloadGrid", [{page:page}]);
	}
	
	function setRefresh(page){
		if(page){
			searchFun(page);
		}else{
			document.location.href = '${ctx}/sysRole/list';
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