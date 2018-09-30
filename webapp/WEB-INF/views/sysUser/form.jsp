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
	<form id="sysUserForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12 sysUserForm">
		<input type="hidden" id="sysUser_id" name="id" value="${sysUser.id }">
			<div class="form-group">
		        <label class="control-label labelCss" for="loginName">登录名：</label>
		        <input type="text" id="sysUser_loginName" maxlength="20" name="loginName" class="form-control input-sm inputCss" placeholder="登录名" value="${sysUser.loginName}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
				<label class="control-label labelCss" for="loginPwd">密   码：</label>
	            <input type="password" id="sysUser_loginPwd" maxlength="10" name="loginPwd" class="form-control input-sm inputCss" placeholder="密码" value="">
	             <c:if test="${empty sysUser.id}">
	            	<span style="color: red">*</span>
	             </c:if>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="userName">用户姓名：</label>
		        <input type="text" id="sysUser_userName" maxlength="20" name="userName" class="form-control input-sm inputCss" placeholder="用户姓名" value="${sysUser.userName}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="status">状  态：</label>
				<input type="radio" name="status"  value="1" <c:out value="${(sysUser.status==1 || sysUser.status==null)?'checked':'' }"/>>启用
	     		<input type="radio" name="status"  value="0" <c:out value="${sysUser.status==0?'checked':'' }"/>>不启用
     		</div>
		</div>
	</div>
	</form>
<script>
var id ='';

$(document).ready(function(){
	id = '${sysUser.id}' == '' ? genUUID()+addFlag : '${sysUser.id}';
	$("#sysUser_id").val(id);
	$("[id^='sysUser_']").each(function(){
		$(this).attr("id",$(this).attr("id").replace('sysUser_',id+"_"));
	});
	$("[id^='"+id+"']").attr("isAssist",'');
	assistAttr($("#"+id+"_loginName"), '登录名',['required','unique:/sysUser/checkLoginName']);
	if('${sysUser.id}' == ''){
		assistAttr($("#"+id+"_loginPwd"), '密码',['required']);
	}
	assistAttr($("#"+id+"_userName"), '用户姓名',['required']);
	addMaxLen(id);
});

</script>