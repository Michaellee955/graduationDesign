/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.SysRolePermisDao;
import com.net.cms.po.SysRolePermis;
import com.net.cms.service.SysRolePermisService;

@Transactional
@Service
public class SysRolePermisServiceImpl implements SysRolePermisService {

    @Autowired
    private SysRolePermisDao sysRolePermisDao;

	@Override
	public int deleteByRoleId(String roleId) throws Exception {
		return sysRolePermisDao.deleteByRoleId(roleId);
	}

	@Override
	public int saveRolePermis(List<SysRolePermis> rolePermissList)
			throws Exception {
		if(rolePermissList == null || rolePermissList.size() == 0) return 0;
		return sysRolePermisDao.saveRolePermis(rolePermissList);
	}

	@Override
	public int deleteRolePermisByRoleIdList(List<String> roleIdList)
			throws Exception {
		if(roleIdList == null || roleIdList.size() == 0) return 0;
		return sysRolePermisDao.deleteRolePermisByRoleIdList(roleIdList);
	}

	@Override
	public int deleteRolePermisByPermisIdList(List<String> permisIdList)
			throws Exception {
		if(permisIdList == null || permisIdList.size() == 0) return 0;
		return sysRolePermisDao.deleteRolePermisByPermisIdList(permisIdList);
	}
  
}
	
