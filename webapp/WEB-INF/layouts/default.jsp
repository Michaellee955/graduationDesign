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

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" /> 
<sitemesh:head />
<script type="text/javascript">
function changePwd(url){
	$( "#dialog-changePassWD" ).modal({
		 backdrop: 'static'
	});
	//使用此方法防止js缓存不加载
	$("#dialog-changePassWD p" ).text("加载中...");
	$("#dialog-changePassWD p" ).load(url);
}
</script>
<style type="text/css">
		.dropdown-menu>li>a:hover, .dropdown-menu>li>a:focus{
			background-color: #007FBF;
			color: white;
			font-weight: bold;
		}
        .dropdown-submenu {
            position: relative;
        }
        .dropdown-submenu > .dropdown-menu {
            top: 0px;
            left: 100%;
            margin-top: -6px;
            margin-left: -1px;
            -webkit-border-radius: 0 6px 6px 6px;
            -moz-border-radius: 0 6px 6px;
            border-radius: 0 6px 6px 6px;
        }
        .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }
        .dropdown-submenu > a:after {
            display: block;
            content: " ";
            float: right;
            width: 0;
            height: 0;
            border-color: transparent;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            border-left-color: #ccc;
            margin-top: 5px;
            margin-right: -10px;
        }
        .dropdown-submenu:hover > a:after {
            border-left-color: black; 
        }
        .dropdown-submenu.pull-left {
            float: none;
        }
        .dropdown-submenu.pull-left > .dropdown-menu {
            left: -100%;
            margin-left: 10px;
            -webkit-border-radius: 6px 0 6px 6px;
            -moz-border-radius: 6px 0 6px 6px;
            border-radius: 6px 0 6px 6px;
        }
</style>
</head>
<body data-offset="50" data-target=".subnav" data-spy="scroll">
<div id='dialog-changePassWD' class="modal fade" >
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">修改密码</h4>
      </div>
      <div class="modal-body">
        <p>加载中……</p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
	<div id="screenWidth" class="container" > 
		<div id="fixTopDiv" class="bs-navbar-fixed-top" >
			<div><img alt="云制造平台" src="${ctx}/static/cms/images/topPic.jpg" style="width: 100%"></div>
			<div class="navbar navbar-default">  
				<!-- .navbar-toggle is used as the toggle for collapsed navbar content -->
					<div class="collapse navbar-collapse navbar-ex1-collapse  nav nav-pills" style="position: static;font-weight:bold">
						<ul class="nav navbar-nav" >
						 <shiro:hasPermission name="menu:index"><li><a href="javascript:{}" onclick="goTo('${ctx}/index');">首页</a></li></shiro:hasPermission>
						 
						 <shiro:hasPermission name="module:resourcesProviding">
                         <li class="dropdown">
	                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">资源提供<b class="caret"></b></a>
	                            <ul class="dropdown-menu">
	                             <shiro:hasPermission name="menu:manuRegister">
	                           	 	<li><a href="javascript:{}" onclick="goTo('${ctx}/manuBasicInfo/register');">企业注册</a></li>
	                           	 </shiro:hasPermission>
	                           	  <shiro:hasPermission name="menu:serviceRegister">
	                           	 	<li><a href="javascript:{}" onclick="goTo('${ctx}/providingResources/register');">服务注册</a></li>
	                           	 </shiro:hasPermission>
	                           	  <shiro:hasPermission name="menu:myResources">
	                           	 	<li><a href="javascript:{}" onclick="goTo('${ctx}/providingResources/list');">我的资源</a></li>
	                           	 </shiro:hasPermission>
	                           	  <shiro:hasPermission name="menu:serviceTrans">
	                           	 	<li><a href="javascript:{}" onclick="goTo('${ctx}/serviceTrans/list');">服务交易</a></li>
	                           	 </shiro:hasPermission>
	                            </ul>
                        </li>
                        </shiro:hasPermission>
                        
                        <shiro:hasPermission name="module:serviceRequire">
                         <li class="dropdown">
	                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">服务需求<b class="caret"></b></a>
	                            <ul class="dropdown-menu">
	                             <shiro:hasPermission name="menu:requireRegister">
		                            	<li><a href="javascript:{}" onclick="goTo('${ctx}/serviceRequire/release');">需求发布</a></li>
		                          </shiro:hasPermission>
		                          <shiro:hasPermission name="menu:myRequires">
	                           	 		<li><a href="javascript:{}" onclick="goTo('${ctx}/serviceRequire/list');">我的需求</a></li>
	                           	   </shiro:hasPermission>
	                           	   <shiro:hasPermission name="menu:chooseResolution">
	                           	 		<li><a href="javascript:{}" onclick="goTo('${ctx}/requireResolution/list');">选择方案</a></li>
	                           	   </shiro:hasPermission>
	                           	   <shiro:hasPermission name="menu:ProgressView">
		                           		 <li><a href="javascript:{}" onclick="goTo('${ctx}/requireResolution/successList');">进度查看</a></li>
		                           </shiro:hasPermission>
	                            </ul>
                        </li>
                        </shiro:hasPermission>
                        
                        <shiro:hasPermission name="module:serviceHall">
                         <li class="dropdown">
	                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">服务大厅<b class="caret"></b></a>
	                            <ul class="dropdown-menu">
	                            	<shiro:hasPermission name="menu:serviceDiscovery">
		                           	 	<li><a href="javascript:{}" onclick="goTo('${ctx}/serviceRequire/list?type=1');">服务发现</a></li>
		                            </shiro:hasPermission>
		                            <shiro:hasPermission name="menu:serviceMatch">
	                           	 		<li><a href="javascript:{}" onclick="goTo('${ctx}/serviceMatch/list');">服务匹配</a></li>
	                           	 	</shiro:hasPermission>
	                            </ul>
                        </li>
                        </shiro:hasPermission>
                        
                         <shiro:hasPermission name="module:systemManage">
                         <li class="dropdown">
	                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">系统管理<b class="caret"></b></a>
	                            <ul class="dropdown-menu">
	                           	 	<shiro:hasPermission name="menu:manuInfo">
	                            		<li><a href="javascript:{}" onclick="goTo('${ctx}/manuBasicInfo/list');">企业(个人)管理</a></li>
	                            	</shiro:hasPermission>
	                            	
	                           	 <shiro:hasPermission name="menu:productMgt">
	                            	<li class="dropdown-submenu"><a href="javascript:{}">产品管理</a>
	                            		<ul class="dropdown-menu">
	                            			<shiro:hasPermission name="menu:productType">
	                            			<li><a href="javascript:{}" onclick="goTo('${ctx}/productSerial/list');">产品类型</a></li>
	                            			</shiro:hasPermission>
	                            			<shiro:hasPermission name="menu:productStruct">
	                            			<li><a href="javascript:{}" onclick="goTo('${ctx}/productStruct/list');">产品结构</a></li>
	                            			</shiro:hasPermission>
	                            		</ul>
	                            	</li>
	                           	 </shiro:hasPermission>
	                           	 
	                           	 <shiro:hasPermission name="menu:systemRole">
	                           	 	<li><a href="javascript:{}" onclick="goTo('${ctx}/sysUser/list');">系统用户</a></li>
	                           	 </shiro:hasPermission>
	                           	 <shiro:hasPermission name="menu:systemRole">
		                            <li><a href="javascript:{}" onclick="goTo('${ctx}/sysRole/list');">系统角色</a></li>
		                         </shiro:hasPermission>
		                         <shiro:hasPermission name="menu:systemPermis">
		                            <li><a href="javascript:{}" onclick="goTo('${ctx}/sysPermis/list');">系统权限</a></li>
		                         </shiro:hasPermission>
	                            </ul>
                        </li>
                        </shiro:hasPermission>
						</ul>
						<ul class="nav navbar-nav pull-right">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<i class="glyphicon glyphicon-user"></i>
									<shiro:principal property="userName" /> 
									<b class="caret"></b>
								</a>
								<ul class="dropdown-menu">
									<li><a href="javascript:{}" onclick="changePwd('${ctx}/sysUser/changePwd');"><lable class="icon-key"/>修改密码</a></li>
									<li><a href="javascript:{}" onclick="goTo('${ctx}/logout');"><lable class="icon-signout"/>退出系统</a></li>
								</ul>
							</li> 
						</ul> 
					</div>
				</div>
 		<div style="position: absolute;top: 80px;
  					height: 25px;width: 100%; color: #999; 
  					background-color: #f5f5f5;border:1px solid #e7e7e7; 
 					vertical-align: middle;padding-left: 10px;font-size: 14px;">
 			<label class="glyphicon glyphicon-hand-right"></label>
 			当前位置：<label id="currPos" style="font-size: 14px;color: #999;font-weight: normal;"></label>
		</div>
 		</div>
 		<br/>
		<!-- /navbar --> 
		<div id="clearFixTop">
			<sitemesh:body /> 
		</div> 
		<footer class="footer" style="text-align: center">
			 Copyright ©<%=DateUtil.getCurrYear()%>. All Rights Reserved 上海领轩起重设备有限公司版权所有
		</footer>
	</div>  
</body>
</html>