/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import com.net.cms.base.BaseDao;
import com.net.cms.po.SysRole;

/**
 * @author xiaoyang
 *
 */
public interface SysRoleDao extends BaseDao<SysRole>{
	int batchDelSysRole(List<String> list);
	List<SysRole> getUserRoleList(String userId);
}
