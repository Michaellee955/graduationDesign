<%@page import="com.net.cms.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.LockedAccountException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>云制造平台</title>   
<link type="text/css" rel="stylesheet" href="${ctx}/static/bootstrap/3.1.0/css/bootstrap.min.css" />   
<link type="text/css" rel="stylesheet" href="${ctx}/static/cms/css/login.css" />
<link rel="shortcut icon" type="image/x-icon" href="${ctx}/static/cms/images/favicon.ico" />
<link type="text/css" rel="stylesheet" href="${ctx}/static/jquery-validation/1.11.1/validate.css"  />  
<!--[if lt IE 9]> 
<span class="versionRemind">您的IE浏览器版本较低，建议使用<a href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie" target="_blank">IE9.0及以上版本浏览器</a>或者<a href="http://firefox.com.cn/download/" target="_blank">Firefox4.0及以上版本浏览器</a>访问本系统。</span> 
<![endif]-->  

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script type="text/javascript" src="${ctx}/static/jquery/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${ctx}/static/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/static/jquery-validation/1.11.1/jquery.validate.min.js" ></script>
<script type="text/javascript" src="${ctx}/static/jquery-validation/1.11.1/messages_zh.js" ></script>
<script type="text/javascript">
 	$(document).ready(function() {
 		$("#userName").focus();
 		$("#userName").val('');
 		$("#loginForm").validate({
 			rules:{
 				username:{
 					required:true,
 					minlength:3,
 					maxlength:30
 				},
 				password:{
 					required:true,
 					maxlength:30,
 					minlength:5
 				}
 			},
 			messages:{
	 			username:{
	 				required:'请输入用户名'
	 			},password:{
					required:'请输入密码'
	 			}
 			}
 		});
 		<c:if test="${ not empty errorMessage}">
			     $('#error').show();
		</c:if>
		
		//取消按钮操作
		$('#cancel').click(function(){
			$('#dialog-confirm').modal('hide');
		});	
		
		$("#confirm").click(function(){
			location=$("#targetUrl").val();
		});
 	});
 	
 	function register(){
 		$( "#dialog-confirm" ).modal({
			 backdrop: 'static'
		});
		$( "#confirm").attr("disabled",false);
 	}
	</script>  
</head>
  <body>
  <div id='dialog-confirm' class="modal fade bs-example-modal-sm">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="modelTitle">选择注册类型</h4>
      </div>
      <div class="modal-body">
        <p>
        <select id="targetUrl" name="targetUrl" class="input-sm">
        	<option value="${ctx}/personal/register">个人</option>
        	<option value="${ctx}/manuBasicInfo/register2">企业</option>
        </select>
        </p>
      </div>
      <div class="modal-footer">
		<button type="button" id ='cancel' class="btn btn-default btn-sm" tabindex="1001">取消</button>
        <button type="button" id ='confirm' class="btn btn-primary btn-sm" tabindex="1000">确定</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
  	<div class="login_area">
		<form id="loginForm" action="${ctx}/login"" method="post">
			<table width="100%" border="0" cellspacing="6" cellpadding="0">
				<tr><td height="105">&nbsp;</td><td colspan="2">&nbsp;</td></tr>
				<tr><td width="36%" height="30">&nbsp;</td>
				    <td colspan="2" class="login_areaFail"><div id="error" style="display: none;">登录名或密码错误</div></td>
			    </tr>
				<tr>
					<td height="30" align="right" class="username">用户名：</td>
					<td colspan="2" align="left"><input name="username" value="" type="text" title="用户名" class="loginTextarea required" id="userName" size="33" /></td>
				</tr>
				<tr>
					<td height="30" align="right" class="username">密 &nbsp;码：</td>
					<td colspan="2" align="left"><input name="password" value="" type="password" title="密码" class="loginTextarea required" id="password" size="33"/></td>
				</tr>
				<tr><td height="35"></td><td width="28%" align="left" style="font-size:12px;">&nbsp;&nbsp;</td>
					<td width="36%" align="left">
						<input style="cursor: pointer;font-size: 12px;" type="submit" id="submit_btn" name="Submit" value="登录" />
						&nbsp;&nbsp;<a href="#" onclick="return register()">注册</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
       	<div id="loginBottom" >
       			<span>
			  		Copyright ©<%=DateUtil.getCurrYear()%>. All Rights Reserved 上海领轩起重设备有限公司版权所有
			  </span>
		</div>
  </body>
</html>
