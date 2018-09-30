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
	var setting = {
	        data: {simpleData:{enable: true}}};
	$(function(){
		$("#currPos").html('产品管理<label class="icon-double-angle-right"/>产品结构');
		
		
		$("#serialId").change(function(){
			var sid = $(this).val();
			if(!sid){
				$("#structTree").html('');
				return false;
			}
			 $.ajax({
			        type: "POST",
			        url: "${ctx}/productStruct/getPsListTree",
			        data:{'sid':sid},
			        dataType: "text",
			        success: function(result) {
			        	if(result){
			            	zTreeObj = $.fn.zTree.init($("#structTree"), setting, eval("("+result+")"));
			        	}else{
			        		$("#structTree").html('');
			        	}
			        },
			        error: function(xhr, msg, e) { alert(msg); }
			    });
		});
		
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
	<ul id="structTree" class="ztree"  style="height:500px; overflow-y:auto;overflow-x:auto;overflow：auto; border:1px solid #E7E7E7;background-color:#F5F5F5"></ul>
	</div>
	<div class="col-lg-8 col-md-8">
		产品类型：
		 <select id="serialId" name="serialId" class="input-sm">
		 	<option value="">--Select--</option>
        	<c:forEach items="${cvList}" var="cv">
        		<option value="${cv.fkey}">${cv.fvalue}</option>
        	</c:forEach>
        </select>
	</div>
</div>
</body>
</html>