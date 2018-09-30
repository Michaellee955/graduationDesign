<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<form id="sysRoleForm" class="form-horizontal">
<input type="hidden" id="sysRoleFormId" value="${id}"/>
<div class="row">
	<div class="col-md-6 role-info">
		<label class=" control-label" for="organizationId"><span style="color: red"></span>权限Tree：</label>
		  		<div id="permissionTree" class="ztree" style="height:300px;overflow:auto;">
		  		</div>
	</div>
	</div>
</form>
<script>
var setting = {
		check: {enable: true},
		data: {simpleData: {enable: true}}
	};

$(function(){
	 zTreeObj=null;
	 $.ajax({
	        type: "POST",
	        url: "${ctx}/sysPermis/getRolePermisList",
	        data:{'roleId':"${id}"},
	        dataType: "text",
	        success: function(data) {
	        var json=eval("("+data+")");
	    		zTreeObj = $.fn.zTree.init($("#permissionTree"), setting, json);
	    		zTreeObj.expandAll(true);
	        },
	        error: function(xhr, msg, e) { alert(msg); }
	    });
});
</script>