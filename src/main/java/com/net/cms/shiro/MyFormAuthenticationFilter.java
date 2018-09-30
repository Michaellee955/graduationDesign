package com.net.cms.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import com.net.cms.util.MD5Util;

/**
 * esp-表单验证过滤器
 * @auhtor xiaoyang
 * @version 1.0
 */
public class MyFormAuthenticationFilter extends FormAuthenticationFilter {
    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
    	String username = request.getParameter("username");
		String password = request.getParameter("password");
		return super.createToken(username, MD5Util.encrypt(password), request, response);
    }
}
