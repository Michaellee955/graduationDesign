<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 

<script type="text/javascript" src="${ctx}/static/highcharts-stock/3.0.9-1.3.9/js/highstock.js"></script>

<script type="text/javascript">	
	//定义全局的变量
	var webPath = "${ctx}";
</script> 
<script type="text/javascript" src="${ctx}/static/highcharts-stock/3.0.9-1.3.9/js/highcharts-more.js"></script>
<script type="text/javascript" src="${ctx}/static/highcharts-stock/3.0.9-1.3.9/js/modules/exporting.src.js"></script>
<script type="text/javascript" src="${ctx}/static/highcharts-stock/chart-plugins.js"></script>   