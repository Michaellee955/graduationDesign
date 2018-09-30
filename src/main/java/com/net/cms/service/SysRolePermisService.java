/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.po.SysRolePermis;





/**
 * @author xiaoyang
 *
 */
public interface SysRolePermisService{
	int deleteByRoleId(String roleId) throws Exception;
	int saveRolePermis(List<SysRolePermis> rolePermissList)throws Exception;
	int deleteRolePermisByRoleIdList(List<String> roleIdList)throws Exception;
	int deleteRolePermisByPermisIdList(List<String> permisIdList)throws Exception;
}
