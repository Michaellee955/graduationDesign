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
	<form id="psForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12 psForm">
		<input type="hidden" id="ps_id" name="id" value="${ps.id }">
			<div class="form-group">
		        <label class="control-label labelCss" for="serialCode">编  码：</label>
		        <input type="text" id="ps_serialCode" maxlength="20" name="serialCode" class="form-control input-sm inputCss" placeholder="编  码" value="${ps.serialCode}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serialName">名  称：</label>
		        <input type="text" id="ps_serialName" maxlength="20" name="serialName" class="form-control input-sm inputCss" placeholder="名  称" value="${ps.serialName}">
		        <span style="color: red">*</span>
			</div>
     		<div class="form-group">
		        <label class="control-label labelCss" for="version">版本号：</label>
		        <input type="text" id="ps_version" maxlength="20" name="version" class="form-control input-sm inputCss" placeholder="版本号" value="${ps.version}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="isEnable">状  态：</label>
				<input type="radio" name="isEnable"  value="1" <c:out value="${(ps.isEnable==1 || ps.isEnable==null)?'checked':'' }"/>>有效
	     		<input type="radio" name="isEnable"  value="0" <c:out value="${ps.isEnable==0?'checked':'' }"/>>无效
     		</div>
		</div>
	</div>
	</form>
<script>
$(document).ready(function(){
	var id = '${ps.id}' == '' ? genUUID()+addFlag : '${ps.id}';
	$("#ps_id").val(id);
	$("[id^='ps_']").each(function(){
		$(this).attr("id",$(this).attr("id").replace('ps_',id+"_"));
	});
	$("[id^='"+id+"']").attr("isAssist",'');
	assistAttr($("#"+id+"_serialCode"), '编码',['required','unique:/productSerial/checkSerialCode']);
	assistAttr($("#"+id+"_serialName"), '名称',['required']);
	assistAttr($("#"+id+"_version"), '版本号',['required']);
	addMaxLen(id);
});
</script>