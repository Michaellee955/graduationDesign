/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.po.SysPermis;

/**
 * @author xiaoyang
 *
 */
public interface SysPermisService {
	List<String> findAllPermisCode();
	List<String> findRolePermisCode(List<String> roleIds);
	
	SysPermis selectByPrimaryKey(String id);
	boolean insertSysPermis(SysPermis sysPermis) throws Exception;
	boolean updateSysPermis(SysPermis sysPermis) throws Exception;
	boolean deleteSysPermis(String id) throws Exception;
	List<SysPermis> getChildNodes(String pid);
	boolean checkPcode(String id,String pId,String pCode);
	List<SysPermis> getRolePermisList(String roleId);
}
