package com.net.cms.dao;




import java.util.List;

import com.net.cms.base.BaseDao;
import com.net.cms.po.SysUserRole;




public interface SysUserRoleDao extends BaseDao<SysUserRole>{
  public Integer deleteByUserId(String userId);
  public Integer deleteByRoleId(String roleId);
 int deleteUserRoleByRoleIdList(List<String> roleIdList) throws Exception;
 int deleteUserRoleByUserIdList(List<String> userIdList) throws Exception;
 int saveUserRole(List<SysUserRole> userRoleList) throws Exception ;
}