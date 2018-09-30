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
	<form id="dictForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12 dictForm">
		<input type="hidden" id="dict_id" name="id" value="${dict.id }">
		<input type="hidden" id="dict_pid" name="pid" value="">
			<div class="form-group">
		        <label class="control-label labelCss" for="code">编  码：</label>
		        <input type="text" id="dict_code" maxlength="20" name="code" class="form-control input-sm inputCss" placeholder="编码" value="${dict.code}">
		        <span style="color: red">*</span>
			</div>
			<div class="form-group">
				<label class="control-label labelCss" for="value">显示值：</label>
	            <input type="text" id="dict_value" maxlength="100" name="value" class="form-control input-sm inputCss" placeholder="显示值" value="${dict.value}">
	            <span style="color: red">*</span>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="status">状  态：</label>
				<input type="radio" name="status"  value="1" <c:out value="${(dict.status==1 || dict.status==null)?'checked':'' }"/>>启用
	     		<input type="radio" name="status"  value="0" <c:out value="${dict.status==0?'checked':'' }"/>>不启用
     		</div>
     		<div class="form-group">
		        <label class="control-label labelCss" for="remark">备  注：</label>
		        <textarea id="dict_remark"  maxlength="100" rows="3" name="remark"  class="form-control input-sm inputCss" placeholder="备注" >${dict.remark}</textarea>
			</div>
		</div>
	</div>
</form>
<script>
var id ='';
$(function(){
	id = '${dict.id}' == '' ? genUUID()+addFlag : '${dict.id}';
	$("#dict_id").val(id);
	$("#dict_pid").val(pid);
	if(pid != '0'){
		$("#dict_code").attr("readonly",true);
		$("#dict_code").val(pcode);
	}
	$("[id^='dict_']").each(function(){
		$(this).attr("id",$(this).attr("id").replace('dict_',id+"_"));
	});
	$("[id^='"+id+"']").attr("isAssist",'');
	if(pid == '0'){
		assistAttr($("#"+id+"_code"), '编码',['required','unique:/dict/checkCode']);
	}
	assistAttr($("#"+id+"_value"), '显示值',['required']);
	addMaxLen(id);
});
</script>