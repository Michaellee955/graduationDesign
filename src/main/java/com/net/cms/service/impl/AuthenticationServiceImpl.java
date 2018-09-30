package com.net.cms.service.impl;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.base.BaseServiceImpl;
import com.net.cms.service.AuthenticationService;
import com.net.cms.service.SysUserService;
import com.net.cms.shiro.ShiroUser;
@Transactional
@Service
public class AuthenticationServiceImpl extends BaseServiceImpl implements AuthenticationService {
	@Autowired
	private SysUserService sysUserService;
	@Override
	public SimpleAuthenticationInfo login(String loginName, String loginPwd)
			throws AuthenticationException {
		ShiroUser su =  sysUserService.login(loginName, loginPwd);
		if (null == su) {
		     throw new AuthenticationException("用户名:" + loginName + "登录失败");
		}
		if(su.getStatus() == 0){
		     throw new AuthenticationException("用户名:" + loginName + "未启用，请联系管理员");
		}
		//sysLogService.insertSysLog(new SysLog("用户登录", "登录", "用户登录系统", su.getUserName(), su.getId()));
		return new SimpleAuthenticationInfo(su, loginPwd, su.getUserName());
	}
}
