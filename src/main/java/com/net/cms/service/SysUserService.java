/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.SysUserFilter;
import com.net.cms.po.ManuBasicInfo;
import com.net.cms.po.SysUser;
import com.net.cms.shiro.ShiroUser;

import com.net.cms.shiro.ShiroUser;

/**
 * @author xiaoyang
 *
 */
public interface SysUserService {
	
	List<SysUser> query(SysUserFilter filter);
	int updateSysUser(SysUser sysUser) throws Exception;
	int insertSysUser(SysUser sysUser) throws Exception;
	SysUser findSysUserById(String id);
	int batchDelSysUser(List<String> list) throws Exception;
	int updateUserRole(String id,String checkedId) throws Exception;
	
	ShiroUser login(String loginName,String loginPwd);
	List<String> findRoleIdsByUserId(String userId);
	boolean checkLoginName(String id,String loginName);
	String getLoginPwdById(String id);
	int updateLoginPwdById(String newLoginPwd,String id);
	
	void saveOrUpdateUser(ManuBasicInfo mbi) throws Exception;
	
}
