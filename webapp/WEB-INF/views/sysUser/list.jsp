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
			<label>系统用户列表</label>
		</td> 
		<td width="70%" align="right">
			<button type="button" id="searchQuery" class="btn btn-primary btn-sm">查询</button>
			<shiro:hasPermission name="systemUser:add">
			<button type="button" id="btnAdd" class="btn btn-primary btn-sm">添加</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="systemUser:edit">
			<button type="button" id="btnEdit" class="btn btn-primary btn-sm">编辑</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="systemUser:del">
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
		$("#currPos").html("系统管理<label class='icon-double-angle-right'/>系统用户");
		var option = {
				url : 'list', 
				datatype : 'json', 
				mtype : 'post',
				colNames:['id','登录名', '用户姓名','状态','创建人','创建时间','更新人','更新时间','操作'],
			   	colModel:[
					{name:'id',index:'id',hidden:true},
	                {name:'loginName',index:'loginName',width:'100',align:"center"},
	                {name:'userName',index:'userName',width:'100',align:"center"},
			   		{name:'statusTxt',width:'80',index:'status',stype:'select',searchoptions:{value:':全部;1:启用;0:不启用'}},
			   		{name:'createUser',index:'createUser',width:'80',align:"center"},
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
	                {name:'updateUser',index:'updateUser',width:'80',align:"center"},
	                {name:'updateTime',width:'110',index:'updateTime',searchoptions:{
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
			   		{name:'operate',index:'id',width:'80',align:"center",sortable:false,search:false,cellattr:function(){return " title=''";}}],
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
						<shiro:hasPermission name="systemUser:assignRole">
						operate +="<a href='#' style='color:#f60'  onClick='assignRole(\""+ids[i]+"\")'>分配角色</a>";
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
			openDialog("${ctx}/sysUser/openmodal?timestamp="+(new Date()).valueOf(),'用户信息');
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
				updateData('${ctx}/sysUser/addOrUpdate/',data,1);
			}else if(openFlag == '2'){
				var valArr = new Array;
		        $("[name='roleId']").each(function(i){
		        	if($(this).prop("checked")){
		        		valArr.push($(this).val());
		        	}
		        });
				var data = {'id':$("#sysUserId").val(),'checkedId':valArr.join(',')};
				updateData('${ctx}/sysUser/updateUserRole/',data,-1);
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
				url : "${ctx}/sysUser/delete/",
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
			openDialog("${ctx}/sysUser/openmodal?id="+oneData.id+"&timestamp="+(new Date()).valueOf(),'用户信息');
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
	
	function assignRole(id){
		openDialog("${ctx}/sysUser/openmodal/assignRole?id="+id+"&timestamp="+(new Date()).valueOf(),'分配角色');
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
		 var loginName = $("#gs_loginName").val();
		 var userName = $("#gs_userName").val();
		 var createUser = $("#gs_createUser").val();
		 var updateUser = $("#gs_updateUser").val();
		 var createTime = $("#gs_createTime").val();
		 var updateTime = $("#gs_updateTime").val();
		 if(loginName && ''!= loginName){
			 myData.loginName = loginName;
		 }else{
			 delete postData.loginName;
		 }	 
		 if(userName && ''!= userName){
			 myData.userName = userName;
		 }else{
			 delete postData.userName;
		 }
		 if(createUser && ''!= createUser){
			 myData.createUser = createUser;
		 }else{
			 delete postData.createUser;
		 }
		 if(updateUser && ''!= updateUser){
			 myData.updateUser = updateUser;
		 }else{
			 delete postData.updateUser;
		 }
		 if(createTime && ''!= createTime){
			 myData.createTime = createTime;
		 }else{
			 delete postData.createTime;
		 }	 
		 if(updateTime && ''!= updateTime){
			 myData.updateTime = updateTime;
		 }else{
			 delete postData.updateTime;
		 }
		 $.extend(postData,myData);
		$("#grid").jqGrid("setGridParam", 
				{search: true }).trigger("reloadGrid", [{page:page}]);
	}
	
	function setRefresh(page){
		if(page){
			searchFun(page);
		}else{
			document.location.href = '${ctx}/sysUser/list';
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