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
<form id="mbiForm" class="form-horizontal">
	<div class="row">
		<div class="col-md-12 dictForm">
		<input type="hidden" id="mbi_id" name="id" value="${mbi.id }">
			<div class="form-group">
		        <label class="control-label labelCss" for="code">企业代码：</label>
		       	${mbi.code}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="name">企业名称：</label>
		       	${mbi.name}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="addr">企业地址：</label>
		       	${mbi.addr}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="type">企业类型：</label>
		        <c:choose>
		        	<c:when test="${mbi.type eq 1}">资源提供</c:when>
		        	<c:when test="${mbi.type eq 2}">服务需求</c:when>
		        	<c:when test="${mbi.type eq 3}">两者都有</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="contactPerson">联系人：</label>
		       	${mbi.contactPerson}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="contactNumber">联系电话：</label>
		       	${mbi.contactNumber}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="enterpriseQualification">企业资质：</label>
		       	 <c:choose>
		        	<c:when test="${mbi.enterpriseQualification eq 1}">GE认证</c:when>
		        	<c:when test="${mbi.enterpriseQualification eq 2}">IOS900</c:when>
		        	<c:when test="${mbi.enterpriseQualification eq 3}">高新技术企业</c:when>
		        	<c:when test="${mbi.enterpriseQualification eq 4}">一级设计企业</c:when>
		        	<c:when test="${mbi.enterpriseQualification eq 5}">二级设计企业</c:when>
		        </c:choose>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="enterpriseProfile">企业简介：</label>
		       	${mbi.enterpriseProfile}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="enterprisePhoto">企业照片：</label>
		       	<div id="enterprisePhotoDiv" style="display: inline;"></div>
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="commentScore">企业评分：</label>
		       	${mbi.commentScore}
			</div>
			<div class="form-group">
		        <label class="control-label labelCss" for="createTime">注册时间：</label>
		       	${mbi.createTime}
			</div>
		</div>
	</div>
</form>
 <div class="modal-footer">
		<div class="bootstrap-dialog-footer">
			<div class="bootstrap-dialog-footer-buttons">
				<c:if test="${not empty audit}">
					<button class="btn btn-primary" id="btnAudit" onClick="audit();">审核已确认</button>
				</c:if>
				<button class="btn btn-default" onClick="closeWindow();">关闭</button>
			</div>
		</div>
<script type="text/javascript">
	$("#currPos").html("企业(个人)管理<label class='icon-double-angle-right'/>详情");
	var enterprisePhoto = '${mbi.enterprisePhoto}';
	$(function(){
		if(enterprisePhoto){
			var photoArr = enterprisePhoto.split(",");
			$(photoArr).each(function(i, val){
				$("#enterprisePhotoDiv").append("<a href='#' onclick=\"return  downloadAttach('"+val+"')\">照片"+(i+1)+"</a>&nbsp;&nbsp;");
			});
		}
	});

	function audit(){
		$.ajax({
			type: 'POST',
			url : "${ctx}/manuBasicInfo/updateStatus",
			data : {'id':'${mbi.id }','status':1},
			dataType: 'json',
			cache : false,
			success : function(result, textStatus) {
				var message = "操作失败！";
				if(true == result.success){
    				message = "操作成功！";
				}
				showMsg(message,2000);
			}
		});
	}
	
	function showMsg(message,delay){
    	$("#messageAlert").modal();
    	$("#textP").text(message);
    	window.setTimeout(function() {
    		$('#messageAlert').modal('hide');
    		$("#btnAudit").hide();
    	}, delay);
    }
</script>