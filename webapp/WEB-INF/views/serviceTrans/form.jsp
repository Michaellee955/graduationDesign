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
		<input type="hidden" id="st_id" name="id" value="${id}">
			<div class="form-group">
		        <label class="control-label labelCss" for="taskStatus">审核结果：</label>
				<input type="radio" name="taskStatus"  value="1" checked="checked">通过
	     		<input type="radio" name="taskStatus"  value="4">不通过		       
			</div>
		</div>
	</div>
	</form>
