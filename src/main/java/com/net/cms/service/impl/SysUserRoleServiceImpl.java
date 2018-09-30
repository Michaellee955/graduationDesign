/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.SysUserRoleDao;
import com.net.cms.po.SysUserRole;
import com.net.cms.service.SysUserRoleService;

@Transactional
@Service
public class SysUserRoleServiceImpl implements SysUserRoleService {

    @Autowired
    private SysUserRoleDao sysUserRoleDao;

	@Override
	public int deleteUserRoleByRoleIdList(List<String> roleIdList)
			throws Exception {
		if(roleIdList == null || roleIdList.size() == 0) return 0;
		return sysUserRoleDao.deleteUserRoleByRoleIdList(roleIdList);
	}

	@Override
	public int deleteUserRoleByUserIdList(List<String> userIdList)
			throws Exception {
		if(userIdList == null || userIdList.size() == 0) return 0;
		return sysUserRoleDao.deleteUserRoleByUserIdList(userIdList);
	}

	@Override
	public int saveUserRole(List<SysUserRole> userRoleList) throws Exception {
		if(userRoleList == null || userRoleList.size() == 0) return 0;
		return sysUserRoleDao.saveUserRole(userRoleList);
	}

	
}
	
