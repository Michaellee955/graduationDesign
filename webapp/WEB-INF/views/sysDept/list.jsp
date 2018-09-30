<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="com.net.cms.shiro.util.Securitys" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String date = df.format(new Date());

%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	var isParent = false;
	$(function(){
		$("#currPos").html('系统管理<label class="icon-double-angle-right"/>系统机构');
		$("#btn_delete").hide();
		$("#btn_submit").hide();
		//参数设置
		var setting={
		        async: {
        		enable: true,
        		url:"${ctx}/sysDept/getSysDeptListTree",
       		 	autoParam:["id=pid"],
       		 	dataFilter:function(treeId, parentNode, rd){
       		 		return eval(rd.data.tree);
       		 		}
		        },simpleData: {
						enable:true,
		           		idKey:"id",
		           		idPKey:"parentId",
		           		rootPid:'0'
		       	},view:{
					addHoverDom: addHoverDom,
					removeHoverDom: removeHoverDom,
					selectedMulti: false,
			        showIcon: true
				},callback:{
					onClick:onClickFun
				}
		   };
		var newCount = 1;
		function addHoverDom(treeId, treeNode) {
			<shiro:hasPermission name="systemDept:add">
			var sObj = $("#" + treeNode.tId + "_span");
			if ($("#addBtn_"+treeNode.id).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.id
				+ "' title='新增下级机构' onfocus='this.blur();'></span>";			
			sObj.append(addStr);
			var btn = $("#addBtn_"+treeNode.id);
			if (btn) btn.bind("click", function(){
				var newNode = {id:(100 + newCount), pId:treeNode.id, name:"新增机构" + (newCount++),grade:(treeNode.grade+1),tId:treeId+'_new'+(newCount++)};
				addNode(treeId, newNode,treeNode);
				return false;
			});
			</shiro:hasPermission>
		
			<shiro:hasPermission name="systemDept:edit">
			var editStr = "<span class='button edit' id='editBtn_" + treeNode.id	
				+ "' title='修改机构信息' onfocus='this.blur();'></span>";
			sObj.append(editStr);
			var ebtn = $("#editBtn_"+treeNode.id);
			if(ebtn) ebtn.bind('click',function(e){
				var zTree = $.fn.zTree.getZTreeObj(treeId);
				zTree.selectNode(treeNode);
				editOnClick(e,treeId,treeNode);
				return false;
			});
			</shiro:hasPermission>
		}
		
		function removeHoverDom(treeId, treeNode) {
			var addbtn = $("#addBtn_"+treeNode.id);
			if(addbtn) addbtn.unbind().remove();
			var editbtn = $("#editBtn_"+treeNode.id);
			if(editbtn) editbtn.unbind().remove();
		}
		
		function addNode(treeId,treeNode,parent){
			$("#pId").val(treeNode.pId);
			$("#parentName").val(parent.name);
			$("#id").val('-byadd');
			$("#deptName").val('');
			$("#deptName").attr("readonly",false);
			$("input[name='status']").attr("disabled",false);
			$("input[name='status']").get(0).checked = true; 
			
			$("#remark").val('');
			$("#remark").attr("readonly",false);
			$("#createUser").val('<%=Securitys.getUserName() %>');
			$("#createTime").val('<%=date%>');
			$("#updateTime").val('');
			$("#updateUser").val('');
			$("#btn_submit").text('添加').show();
			
			$("#btn_delete").hide();
		}
		
		
		//修改数据
		function updateData(data){	
			$.ajax({
				type: 'POST',
				url : "${ctx}/sysDept/addOrUpdate/",
				dataType : "json",
				data : {'jsonStr':JSON.stringify(data)},
				cache : false,
				success : function(result, textStatus) {
					var message = "提交数据失败！";
					if(true == result.success){
	    				message = "提交数据成功！";
					}
					$('#btn_submit').attr("disabled",false);
					showMsg(message,2000);
				}
			});
		}
		
		 function showMsg(message,delay,notRefresh){
		    	$("#messageAlert").modal();
		    	$("#textP").text(message);
		    	window.setTimeout(function() {
		    		$('#messageAlert').modal('hide');
		    		if(notRefresh){
		    			return;
		    		}
		    		setRefresh();
		    	}, delay);
		  }
		
		$("#btn_submit").click(function(){
			var btn = $("#btn_submit");
			var param={
					id:$("#id").val(),
					pId:$("#pId").val(),
					deptName:$("#deptName").val(),
					status:$("input[name='status']:checked").val(),
					remark:$("#remark").val()
				};
			if('添加'==btn.text()){
				param['createTime']=$("#createTime").val();
			}
			 var keysArr = ['deptName','remark'];
			 var jsonArr= new Array();
			 jsonArr.push(param);
			 if(!dataCheck2(jsonArr,keysArr,'60%','pId')){
				   return;
			  }
			updateData(param);
		});
		
	   function editOnClick(event, treeId, treeNode) {
		    isParent = treeNode.isParent;
	    	$("#deptName").attr("readonly",false);
	    	$("#remark").attr("readonly",false);
	    	$("#parentName").val(treeNode.parentName);
	    	$("input[name='status']").attr("disabled",false);
	    	 $.ajax({
					type: 'POST',
					url : "${ctx}/sysDept/getInfo/",
					data : {'id':treeNode.id},
					dataType : "json",
					cache : false,
					error : function(textStatus, errorThrown) {
						showMsg(message,2000);
					},
					success : function(result, textStatus) {
						if("success"==result.status){
							var dept=result.data.dept;
						   	$("#id").val(dept.id);
							$("#pId").val(dept.pId);
					    	$("#deptName").val(dept.deptName);
					    	$("input[name='status'][value='"+dept.status+"']").prop("checked",true);
					    	$("#remark").val(dept.remark);
							$("#createUser").val(dept.createUser);
							$("#createTime").val(dept.createTime);
							$("#updateUser").val(dept.updateUser);
							$("#updateTime").val(dept.updateTime);
					    	if($("#deptName")!=''){
								$("#btn_delete").show();
					    	}else{
								$("#btn_delete").hide();
					    	}
							$("#btn_submit").text('更新').show();
						}else{
							var message = "获取机构信息失败！";
							message = result.msg+'!';
							showMsg(message,2000);
						}
					}
				});
	    }
	   function onClickFun(event, treeId, treeNode) {
		    isParent = treeNode.isParent;
	    	$("#deptName").attr("readonly",true);
	    	$("#remark").attr("readonly",true);
	    	$("#parentName").val(treeNode.parentName);
	    	$("input[name='status']").attr("disabled",true);
	    	 $.ajax({
					type: 'POST',
					url : "${ctx}/sysDept/getInfo/",
					data : {'id':treeNode.id},
					dataType : "json",
					cache : false,
					error : function(textStatus, errorThrown) {
						showMsg(message,2000);
					},
					success : function(result, textStatus) {
						if("success"==result.status){
							var dept=result.data.dept;
						   	$("#id").val(dept.id);
							$("#pId").val(dept.pId);
					    	$("#deptName").val(dept.deptName);
					    	$("input[name='status'][value='"+dept.status+"']").prop("checked",true);
					    	$("#remark").val(dept.remark);
							$("#createUser").val(dept.createUser);
							$("#createTime").val(dept.createTime);
							$("#updateUser").val(dept.updateUser);
							$("#updateTime").val(dept.updateTime);
							$("#btn_delete").hide();
							$("#btn_submit").hide();
						}else{
							var message = "获取机构信息失败！";
							message = result.msg+'!';
							showMsg(message,2000);
						}
					}
				});
	    }
		$.fn.zTree.init($("#deptTree"), setting);
		
		
		function setRefresh(){
			document.location.href = '${ctx}/sysDept/list';
		}
		
		$("#btn_delete").click(function(){
			if(isParent){
				showMsg('请先删除下级机构信息！',2000,'y');
				return;
			}
			if(!confirm("您确定要删除当前机构数据吗？")){
				return false;
			}
			$.ajax({
				type: 'POST',
				url : "${ctx}/sysDept/delete/",
				data : {'id':$("#id").val()},
				dataType: 'json',
				cache : false,
				success : function(result, textStatus) {
					var message = "删除数据失败！";
					if(true == result.success){
	    				message = "删除数据成功！";
					}
					showMsg(message,2000);
				}
			});
		});
		
		$("#deptName").attr("isAssist",'');
		$("#remark").attr("isAssist",'');
		assistAttr($("#deptName"), '机构名称',['required',
						'unique:/sysDept/checkDeptName']);
 		addMaxLen("deptName");
 		addMaxLen("remark");
	});
</script>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
	.inputCss{
	width:60%;display:inline;
}
.labelCss{
	width: 30%;
}
</style> 
</head>
<body>
<div class="row">
	<div class="col-lg-4 col-md-4">
	<ul id="deptTree" class="ztree"  style="height:500px; overflow-y:auto;overflow-x:auto;overflow：auto; border:1px solid #E7E7E7;background-color:#F5F5F5"></ul>
	</div>
	<div class="col-lg-8 col-md-8">
		<div id="form_div">
			<form id="deptForm" class="form-horizontal">
				<input type="hidden" id="id" name="id" />
				<input type="hidden" id="pId" name="pId" />
				<div class="form-group">
					<label for="deptName" class="col-sm-3 labelCss">父级机构：</label>
					<input type="text" class="form-control input-sm inputCss" id="parentName" name="parentName"  readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="deptName" class="col-sm-3 labelCss">机构名称：</label>
					<input type="text" class="form-control input-sm inputCss" id="deptName" name="deptName" placeholder="机构名称" maxlength="20" readonly="readonly"/>
					<span style="color:red">*</span>
				</div>
				<div class="form-group">
						<label for="status" class="col-sm-3 labelCss">状态：</label>
						<input type="radio" name="status" disabled="disabled"  value="1">启用&nbsp;&nbsp;
	     				<input type="radio" name="status"  disabled="disabled"  value="0" >不启用
				</div>
				<div class="form-group">
                    <label for="remark" class="col-sm-3 labelCss">备注：</label>
                   	<textarea rows="3" name="remark" class="form-control inputCss" id="remark" maxlength="200" placeholder="备注" readonly="readonly"></textarea>
                </div>
              <div class="form-group">
					<label for="id" class="col-sm-3 labelCss">创建人：</label>
					<input type="text" class="form-control input-sm inputCss" id="createUser" name="createUser" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="id" class="col-sm-3 labelCss">创建时间：</label>
					<input type="text" class="form-control input-sm inputCss" id="createTime" name="createTime" readonly="readonly" />
				</div>
              	<div class="form-group">
					<label for="id" class="col-sm-3 labelCss">最近更新人：</label>
					<input type="text" class="form-control input-sm inputCss" id="updateUser" name="updateUser" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="id" class="col-sm-3 labelCss">最近更新时间：</label>
					<input type="text" class="form-control input-sm inputCss" id="updateTime" name="updateTime" readonly="readonly" />
				</div>
				<div class="control col-md-2 col-md-offset-3">
					<button type="button" id="btn_submit" class="btn btn-primary btn-sm btn-block">更新</button>
				</div>
				<div class="control col-md-2">
					<shiro:hasPermission name="systemDept:del">
					<button type="button" id="btn_delete" class="btn btn-primary btn-sm btn-block btn-danger">删除</button>
					</shiro:hasPermission>
				</div>
			</form>
		</div>
	</div>
</div>
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
</body>
</html>