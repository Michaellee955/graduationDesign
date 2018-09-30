/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.po.SysUserRole;





/**
 * @author xiaoyang
 *
 */
public interface SysUserRoleService{
	int deleteUserRoleByRoleIdList(List<String> roleIdList)throws Exception;
	int deleteUserRoleByUserIdList(List<String> userIdList)throws Exception;
	int saveUserRole(List<SysUserRole> userRoleList) throws Exception;
}
