/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.SysRoleFilter;
import com.net.cms.po.SysRole;




/**
 * @author xiaoyang
 *
 */
public interface SysRoleService{
	List<SysRole> query(SysRoleFilter filter);
	List<SysRole> getUserRoleList(String userId);
	int updateSysRole(SysRole sysRole) throws Exception;
	int insertSysRole(SysRole sysRole) throws Exception;
	SysRole findSysRoleById(String id);
	int batchDelSysRole(List<String> list) throws Exception;
	int updateRolePermis(String id,String checkedId) throws Exception;
	
}
