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
<form id="prForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
		        <label class="control-label labelCss" for="requireCode">需求编号：</label>
		       	${sr.requireCode}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireName">需求名称：</label>
		       	${sr.requireName}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="productName">需求产品：</label>
		       	${sr.productName}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceType">服务类型：</label>
		        <c:choose>
		        	<c:when test="${sr.serviceType eq 1}">设计</c:when>
		        	<c:when test="${sr.serviceType eq 2}">制造</c:when>
		        	<c:when test="${sr.serviceType eq 3}">测试</c:when>
		        	<c:when test="${sr.serviceType eq 4}">仿真</c:when>
		        	<c:when test="${sr.serviceType eq 5}">软件</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireCount">需求数量：</label>
		       	${sr.requireCount}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireUint">需求单位：</label>
		       	 <c:choose>
		        	<c:when test="${sr.requireUint eq 4}">个</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireQualify">需求质量：</label>
		         <c:choose>
		        	<c:when test="${sr.requireQualify eq 1}">GE认证</c:when>
		        	<c:when test="${sr.requireQualify eq 2}">3C认证</c:when>
		        	<c:when test="${sr.requireQualify eq 3}">rosh认证</c:when>
		        	</c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requirePrive">采购价格：</label>
		       	${sr.requirePrive}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireStarttime">需求开始时间：</label>
		     	${sr.requireStarttime}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireEndtime">需求结束时间：</label>
		      ${sr.requireEndtime}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireArea">需求区域：</label>
		       ${sr.requireArea}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="requireProfile">服务简介：</label>
		      ${sr.requireProfile}
			</div>
		</div>
	</div>
</form>
 <div class="modal-footer">
		<div class="bootstrap-dialog-footer">
			<div class="bootstrap-dialog-footer-buttons">
				<button class="btn btn-default" onClick="closeWindow();">关闭</button>
			</div>
		</div>
<script type="text/javascript">
$("#currPos").html("需求详情");
</script>
