package com.net.cms.dao;



import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.SysRolePermis;




public interface SysRolePermisDao extends BaseDao<SysRolePermis>{
	int deleteByRoleId(@Param("roleId") String roleId) throws Exception;
	int deleteByPermisId(@Param("permisId") String permisId) throws Exception;
	int saveRolePermis(List<SysRolePermis> rolePermissList) throws Exception;
	int deleteRolePermisByRoleIdList(List<String> roleIdList) throws Exception;
	int deleteRolePermisByPermisIdList(List<String> permisIdList) throws Exception;
}