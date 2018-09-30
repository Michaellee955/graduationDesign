<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
<!--
.inputCss{
	width:50%;display:inline;
}
.labelCss{
	width: 20%;
}
-->
</style>
	<form id="sysRoleForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12 sysRoleForm">
		<input type="hidden" id="sysRole_id" name="id" value="${sysRole.id }">
			<div class="form-group">
		        <label class="control-label labelCss" for="roleName">角色名称：</label>
		        <input type="text" id="sysRole_roleName" maxlength="20" name="roleName" class="form-control input-sm inputCss" placeholder="角色名称" value="${sysRole.roleName}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="status">状  态：</label>
				<input type="radio" name="status"  value="1" <c:out value="${(sysRole.status==1 || sysRole.status==null)?'checked':'' }"/>>启用
	     		<input type="radio" name="status"  value="0" <c:out value="${sysRole.status==0?'checked':'' }"/>>不启用
     		</div>
     		<div class="form-group">
		        <label class="control-label labelCss" for="remark">备  注：</label>
		        <textarea id="sysRole_remark" maxlength="200"  rows="5" name="remark" class="form-control inputCss"  placeholder="备注" >${sysRole.remark}</textarea>
			</div>
            <c:if test="${not empty sysRole.id}">
			<div class="form-group">
	            <label class="control-label labelCss" for="createTime">创建时间：</label>
	            <input type="text" id="createTime" name="createTime" readonly class="form-control input-sm inputCss" value="${sysRole.createTime}">
            </div>
			</c:if>
			
		</div>
	</div>
	</form>
<script>
$(document).ready(function(){
	var id = '${sysRole.id}' == '' ? genUUID()+addFlag : '${sysRole.id}';
	$("#sysRole_id").val(id);
	$("[id^='sysRole_']").each(function(){
		$(this).attr("id",$(this).attr("id").replace('sysRole_',id+"_"));
	});
	$("[id^='"+id+"']").attr("isAssist",'');
		assistAttr($("#"+id+"_roleName"), '角色名称',['required']);
		addMaxLen(id);
});
</script>