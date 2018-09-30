/**
 * 
 */
package com.net.cms.dao;

import java.util.List;
import java.util.Map;

import com.net.cms.base.BaseDao;
import com.net.cms.po.SysPermis;

/**
 * @author xiaoyang
 *
 */
public interface SysPermisDao extends BaseDao<SysPermis>{
	List<String> findAllPermisCode();
	List<String> findRolePermisCode(List<String> roleIds);
	
	List<SysPermis> getChildNodes(String pid);
	int checkPcode(Map<String,String> paramMap);
	List<SysPermis> getRolePermisList(String roleId);
}
