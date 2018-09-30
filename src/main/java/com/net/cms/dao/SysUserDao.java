/**
 * 
 */
package com.net.cms.dao;

import java.util.List;
import java.util.Map;

import com.net.cms.base.BaseDao;
import com.net.cms.po.SysUser;
import com.net.cms.shiro.ShiroUser;
/**
 * @author xiaoyang
 *
 */
public interface SysUserDao extends BaseDao<SysUser>{
	
	int batchDelSysUser(List<String> list);
	
	ShiroUser login(Map<String,String> paramMap);
	List<String> findRoleIdsByUserId(String userId);
	int checkLoginName(Map<String,String> paramMap);
	String getLoginPwdById(String id);
	int updateLoginPwdById(Map<String,String> paramMap);
	int saveOrUpdateUser(SysUser user);
}
