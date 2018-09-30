<%@page import="com.net.cms.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sitemesh"	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="${ctx}/static/cms/images/favicon.ico" />
<title>云制造平台</title> 
<%@ include file="/WEB-INF/common/common-js-style.jsp"%>
<%@ include file="/WEB-INF/common/table-js-style.jsp"%>  
<%@ include file="/WEB-INF/common/less-common-js-style.jsp"%> 
<%@ include file="/WEB-INF/common/tree-js-style.jsp"%> 
<%@ include file="/WEB-INF/common/custom-js-style.jsp"%> 
<%@ include file="/WEB-INF/common/backtop.jsp"%> 	
<link rel="shortcut icon" type="image/x-icon" href="${ctx}/static/cms/images/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<sitemesh:head />
</head>
<body>
<div id="screenWidth" class="container">
	<sitemesh:body />
	<footer class="footer" style="text-align: center">
			  Copyright ©<%=DateUtil.getCurrYear()%>. All Rights Reserved 上海领轩起重设备有限公司版权所有
		</footer>
</div>
</body>
</html>