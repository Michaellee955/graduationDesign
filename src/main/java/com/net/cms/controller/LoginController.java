package com.net.cms.controller;

import javax.servlet.ServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.net.cms.shiro.MyFormAuthenticationFilter;
import com.net.cms.util.MD5Util;

/**
 * <pre>
 * 功能说明：LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)
 * </pre>
 * 
 * @version 1.0
 */
@Controller
public class LoginController {

	Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String fail(@RequestParam(MyFormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username,
			@RequestParam(MyFormAuthenticationFilter.DEFAULT_PASSWORD_PARAM) String password,
			ServletRequest request,
			Model model) {
		logger.info("username["+username+"]password["+password+"]");
		Subject subject = SecurityUtils.getSubject();
		String jumpUrl = "login";
		if (subject.isAuthenticated()) {
			try {
				UsernamePasswordToken token = new UsernamePasswordToken(username, MD5Util.encrypt(password));
				subject.login(token);
				jumpUrl = "redirect:/";
			} catch (AuthenticationException e) {
				model.addAttribute("errorMessage", e.toString());
			}
		} else {
			model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
			model.addAttribute("errorMessage", "认证失败");
		}
		return jumpUrl;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		return "login";
	}
}
