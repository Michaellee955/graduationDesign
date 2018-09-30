package com.net.cms.shiro;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.net.cms.constant.Constants;
import com.net.cms.service.AuthenticationService;
import com.net.cms.service.SysPermisService;
import com.net.cms.service.SysUserService;

/**  
 * @Description: 系统认证Realm
 * @auhtor xiaoyang
 * @date 2013-6-24 下午1:42:18
 * @version V1.0  
 */
public class ShiroDbRealm extends AuthorizingRealm {

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysPermisService sysPermisService;
	@Autowired
	private AuthenticationService authenticationService;
	
	
	/**
	 * 授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {
		ShiroUser su = (ShiroUser) pc.getPrimaryPrincipal();
		SimpleAuthorizationInfo sai = new SimpleAuthorizationInfo();
		if(su != null){
				//系统管理员
				if(StringUtils.equals(su.getLoginName(), Constants.ADMIN_NAME)){
					sai.addStringPermissions(sysPermisService.findAllPermisCode());
				}else{
					List<String> roleIds = sysUserService.findRoleIdsByUserId(su.getId());
					if(roleIds.size() == 0){
						throw new AuthenticationException("用户:[" + su.getLoginName() + "]没有任何权限,请联系管理员");
					}
					sai.addStringPermissions(sysPermisService.findRolePermisCode(roleIds));
				}
		}
		return sai;
	}

	/**
	 * 认证方法
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken at) throws AuthenticationException {
		UsernamePasswordToken upt = (UsernamePasswordToken)at;
		if(StringUtils.isEmpty(upt.getUsername()) || StringUtils.isEmpty(new String(upt.getPassword()))){
			return null;
		}
		try
	    {
			return authenticationService.login(upt.getUsername(),new String(upt.getPassword()));
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new AuthenticationException("", e);
	    }
	}
}
