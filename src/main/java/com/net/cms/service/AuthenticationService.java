package com.net.cms.service;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;

/**
 * @author liuq
 * @createTime 2014/09/01
 * */
public interface AuthenticationService {
	
	 public abstract SimpleAuthenticationInfo login(String loginName, String loginPwd)
			    throws AuthenticationException;

}
