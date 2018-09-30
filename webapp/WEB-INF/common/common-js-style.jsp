<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 

<link type="text/css" rel="stylesheet" href="${ctx}/static/jquery/css/jquery-ui-1.10.3.custom.css" />    
<link type="text/css" rel="stylesheet" href="${ctx}/static/bootstrap/3.1.0/css/bootstrap.min.css" />   
<link type="text/css" rel="stylesheet" href="${ctx}/static/bootstrap/switch/css/bootstrap-switch.min.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/fontawesome3.2.1/css/font-awesome-ie7.min.css" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/fontawesome3.2.1/css/font-awesome.min.css" />

<%-- <link type="text/css" rel="stylesheet" href="${ctx}/static/bootstrap/3.0.3/css/bootstrap-theme.css" /> --%>

<script type="text/javascript" src="${ctx}/static/jquery/js/jquery-1.10.2.min.js"></script>

<script type="text/javascript" src="${ctx}/static/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/static/bootstrap/switch/js/bootstrap-switch.min.js"></script>
<script type="text/javascript" src="${ctx}/static/bootstrap/filestyle/bootstrap-filestyle.js"></script>
<!-- 请在bootstrap.min.js文件后引入 。两者插件有冲突（如：tooltip），后者覆盖前者 。-->
<script type="text/javascript" src="${ctx}/static/jquery/js/jquery-ui-1.10.3.custom.min.js"></script>


<script type="text/javascript">
 	 var topHeight = 0;
  </script>
<!--[if lt IE 9]>
  <script src="${ctx}/static/assets/js/html5shiv.js"></script>
  <script src="${ctx}/static/assets/js/respond.min.js"></script>
   <script type="text/javascript">
 	  topHeight = 1;
 </script> 
<![endif]--> 
<script type="text/javascript">	
	//定义全局的变量
	var publicPath = "${ctx}";
	
	//跳转到想要去的页面
	function goTo(href,flag){
		var f = 0;
		if(flag)
			f = flag;
		if(f==0)
			window.location.href = href;
		else
			window.open(href);
	} 
	
	function fixTop(){  
			$('#clearFixTop').css('padding-top',$('#fixTopDiv').height());  
	} 
	$(document).ready(function(){ 
		if(topHeight==0){
			 fixTop();
			$(window).resize(function(){ fixTop();});
		} 
		
		 
	 }); 
</script> 
    