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
		        <label class="control-label labelCss" for="resourcesCode">服务编号：</label>
		       	${pr.resourcesCode}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="providingName">服务名称：</label>
		       	${pr.providingName}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="productId">服务产品：</label>
		       	${pr.productName}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceType">服务类型：</label>
		        <c:choose>
		        	<c:when test="${pr.serviceType eq 1}">设计</c:when>
		        	<c:when test="${pr.serviceType eq 2}">制造</c:when>
		        	<c:when test="${pr.serviceType eq 3}">测试</c:when>
		        	<c:when test="${pr.serviceType eq 4}">仿真</c:when>
		        	<c:when test="${pr.serviceType eq 5}">软件</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceAbility">服务能力：</label>
		       	${pr.serviceAbility}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="abilityUint">服务能力单位：</label>
		       	 <c:choose>
		        	<c:when test="${pr.abilityUint eq 4}">个</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="productQualify">产品认证：</label>
		         <c:choose>
		        	<c:when test="${pr.productQualify eq 1}">GE认证</c:when>
		        	<c:when test="${pr.productQualify eq 2}">3C认证</c:when>
		        	<c:when test="${pr.productQualify eq 3}">rosh认证</c:when>
		        	</c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="servicePrive">产品价格：</label>
		       	${pr.servicePrive}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="pricingMode">计价方式：</label>
		       <c:choose>
		        	<c:when test="${pr.pricingMode eq 1}">按数量计价</c:when>
		        	<c:when test="${pr.pricingMode eq 2}">按时间计价</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceStarttime">服务开始时间：</label>
		     	${pr.serviceStarttime}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceEndtime">服务结束时间：</label>
		      ${pr.serviceEndtime}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceArea">服务区域：</label>
		       ${pr.serviceArea}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="serviceProfile">服务简介：</label>
		      ${pr.serviceProfile}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="servicePhoto">服务照片：</label>
		       	<div id="servicePhotoDiv" style="display: inline;"></div>
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
	$("#currPos").html("资源详情");
	
	var servicePhoto = '${pr.servicePhoto}';
	$(function(){
		if(servicePhoto){
			var photoArr = servicePhoto.split(",");
			$(photoArr).each(function(i, val){
				$("#servicePhotoDiv").append("<a href='#' onclick=\"return  downloadAttach('"+val+"')\">照片"+(i+1)+"</a>&nbsp;&nbsp;");
			});
		}
	});
</script>