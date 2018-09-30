<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		$("#currPos").html('系统管理<label class="icon-double-angle-right"/>系统权限');
		$("#btn_delete").hide();
		$("#btn_submit").hide();
		//参数设置
		var setting={
		        async: {
        		enable: true,
        		url:"${ctx}/sysPermis/getSysPermisListTree",
       		 	autoParam:["id=pid"],
       		 	dataFilter:function(treeId, parentNode, rd){
       		 		return eval(rd.data.tree);
       		 		}
		        },simpleData: {
						enable:true,
		           		idKey:"id",
		           		pIdKey:"parentId",
		           		rootPId:'0'
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
			<shiro:hasPermission name="systemPermis:add">
			var sObj = $("#" + treeNode.tId + "_span");
			if ($("#addBtn_"+treeNode.id).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.id
				+ "' title='新增下级权限' onfocus='this.blur();'></span>";			
			sObj.append(addStr);
			var btn = $("#addBtn_"+treeNode.id);
			if (btn) btn.bind("click", function(){
				var newNode = {id:(100 + newCount), pId:treeNode.id, name:"新增权限" + (newCount++),grade:(treeNode.grade+1),tId:treeId+'_new'+(newCount++)};
				addNode(treeId, newNode,treeNode);
				return false
			});
			</shiro:hasPermission>
		
			<shiro:hasPermission name="systemPermis:edit">
			var editStr = "<span class='button edit' id='editBtn_" + treeNode.id	
				+ "' title='修改权限信息' onfocus='this.blur();'></span>";
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
			$("#pLevel").val(parent.pLevel*1+1);
			$("#parentId").val(treeNode.pId);
			$("#parentName").val(parent.name);
			$("#id").val('-byadd');
			$("#pCode").val('');
			$("#pName").val('');
			$("#pIndex").val('');
			$("#pCode").attr("readonly",false);
			$("#pIndex").attr("readonly",false);
			$("#pName").attr("readonly",false);
			$("input[name='status']").attr("disabled",false);
			$("input[name='status']").get(0).checked = true; 
			
			$("#remark").val('');
			$("#remark").attr("readonly",false);
			$("#createTime").val('<%=date%>');
			$("#btn_submit").text('添加').show();
			
			$("#btn_delete").hide();
		}
		
		
		//修改数据
		function updateData(data){	
			$.ajax({
				type: 'POST',
				url : "${ctx}/sysPermis/addOrUpdate/",
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
					pCode:$("#pCode").val(),
					pName:$("#pName").val(),
					pIndex:$("#pIndex").val(),
					pLevel:$("#pLevel").val(),
					parentId:$("#parentId").val(),
					status:$("input[name='status']:checked").val(),
					remark:$("#remark").val()
				};
			if('添加'==btn.text()){
				param['createTime']=$("#createTime").val();
			}
			 var keysArr = ['pCode','pName','pIndex','remark'];
			 var jsonArr= new Array();
			 jsonArr.push(param);
			 if(!dataCheck2(jsonArr,keysArr,'60%','parentId')){
				   return;
			  }
			updateData(param);
		});
		
	   function editOnClick(event, treeId, treeNode) {
		    isParent = treeNode.isParent;
	    	$("#pCode").attr("readonly",false);
	    	$("#remark").attr("readonly",false);
	    	$("#pIndex").attr("readonly",false);
	    	$("#parentName").val(treeNode.parentName);
	    	$("#pName").attr("readonly",false);
	    	$("input[name='status']").attr("disabled",false);
	    	 $.ajax({
					type: 'POST',
					url : "${ctx}/sysPermis/getInfo/",
					data : {'id':treeNode.id},
					dataType : "json",
					cache : false,
					error : function(textStatus, errorThrown) {
						showMsg(message,2000);
					},
					success : function(result, textStatus) {
						if("success"==result.status){
							var permis=result.data.permis;
						   	$("#id").val(permis.id);
							$("#parentId").val(permis.parentId);
					    	$("#pCode").val(permis.pCode);
					    	$("#pName").val(permis.pName);
					    	$("input[name='status'][value='"+permis.status+"']").prop("checked",true);
					    	$("#remark").val(permis.remark);
							$("#createTime").val(permis.createTime);
							$("#pIndex").val(permis.pIndex);
					    	if($("#pCode")!=''){
								$("#btn_delete").show();
					    	}else{
								$("#btn_delete").hide();
					    	}
							$("#btn_submit").text('更新').show();
						}else{
							var message = "获取权限信息失败！";
							message = result.msg+'!';
							showMsg(message,2000);
						}
					}
				});
	    }
	   
	   function onClickFun(event, treeId, treeNode) {
		    isParent = treeNode.isParent;
	    	$("#pCode").attr("readonly",true);
	    	$("#remark").attr("readonly",true);
	    	$("#pIndex").attr("readonly",true);
	    	$("#parentName").val(treeNode.parentName);
	    	$("#pName").attr("readonly",true);
	    	$("input[name='status']").attr("disabled",true);
	    	 $.ajax({
					type: 'POST',
					url : "${ctx}/sysPermis/getInfo/",
					data : {'id':treeNode.id},
					dataType : "json",
					cache : false,
					error : function(textStatus, errorThrown) {
						showMsg(message,2000);
					},
					success : function(result, textStatus) {
						if("success"==result.status){
							var permis=result.data.permis;
						   	$("#id").val(permis.id);
							$("#parentId").val(permis.parentId);
					    	$("#pCode").val(permis.pCode);
					    	$("#pName").val(permis.pName);
					    	$("input[name='status'][value='"+permis.status+"']").prop("checked",true);
					    	$("#remark").val(permis.remark);
							$("#createTime").val(permis.createTime);
							$("#pIndex").val(permis.pIndex);
							$("#btn_submit").hide();
							$("#btn_delete").hide();
						}else{
							var message = "获取权限信息失败！";
							message = result.msg+'!';
							showMsg(message,2000);
						}
					}
				});
	    }
		$.fn.zTree.init($("#permissionTree"), setting);
		
		
		function setRefresh(){
			document.location.href = '${ctx}/sysPermis/list';
		}
		
		$("#btn_delete").click(function(){
			if(isParent){
				showMsg('请先删除下级权限信息！',2000,'y');
				return;
			}
			if(!confirm("您确定要删除当前权限数据吗？")){
				return false;
			}
			$.ajax({
				type: 'POST',
				url : "${ctx}/sysPermis/delete/",
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
		
		$("#pCode").attr("isAssist",'');
		$("#pName").attr("isAssist",'');
		$("#pIndex").attr("isAssist",'');
		$("#remark").attr("isAssist",'');
		assistAttr($("#pCode"), '权限Code',['required',
						'unique:/sysPermis/checkPcode']);
		assistAttr($("#pName"), '权限名称',['required']);
		assistAttr($("#pIndex"), '序号',['required','integer']);
		
   		addMaxLen("pCode");
   		addMaxLen("pName");
   		addMaxLen("pIndex");
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
	<ul id="permissionTree" class="ztree"  style="height:500px; overflow-y:auto;overflow-x:auto;overflow：auto; border:1px solid #E7E7E7;background-color:#F5F5F5"></ul>
	</div>
	<div class="col-lg-8 col-md-8">
		<div id="form_div">
			<form id="deptForm" class="form-horizontal">
				<input type="hidden" id="id" name="id" />
				<input type="hidden" id="parentId" name="parentId" />
				<input type="hidden" id="pLevel" name="pLevel" />
				<div class="form-group">
					<label for="deptName" class="col-sm-3 labelCss">父级权限：</label>
					<input type="text" class="form-control input-sm inputCss" id="parentName" name="parentName"  readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="pCode" class="col-sm-3 labelCss">权限Code：</label>
					<input type="text" class="form-control input-sm inputCss" id="pCode" name="pCode" placeholder="权限CODE" maxlength="50" readonly="readonly"/>
					<span style="color:red">*</span>
				</div>
				<div class="form-group">
					<label for="pName" class="col-sm-3 labelCss">权限名称：</label>
					<input type="text" class="form-control input-sm inputCss" id="pName" name="pName" placeholder="权限名称" maxlength="50" readonly="readonly"/>
					<span style="color:red">*</span>
				</div>
				<div class="form-group">
					<label for="pIndex" class="col-sm-3 labelCss">序  号：</label>
					<input type="text" class="form-control input-sm inputCss" id="pIndex" name="pIndex" placeholder="序号" maxlength="3" readonly="readonly"/>
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
					<label for="id" class="col-sm-3 labelCss">创建时间：</label>
					<input type="text" class="form-control input-sm inputCss" id="createTime" name="createTime" readonly="readonly" />
				</div>
				<div class="control col-md-2 col-md-offset-3">
					<button type="button" id="btn_submit" class="btn btn-primary btn-sm btn-block">更新</button>
				</div>
				<div class="control col-md-2">
					<shiro:hasPermission name="systemPermis:del">
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