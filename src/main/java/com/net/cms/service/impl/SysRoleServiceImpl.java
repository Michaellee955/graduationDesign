/**
 * 
 */
package com.net.cms.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.constant.Constants;
import com.net.cms.dao.SysRoleDao;
import com.net.cms.filter.SysRoleFilter;
import com.net.cms.po.SysRole;
import com.net.cms.po.SysRolePermis;
import com.net.cms.service.SysRolePermisService;
import com.net.cms.service.SysRoleService;
import com.net.cms.service.SysUserRoleService;
import com.net.cms.util.IDUtil;

/**
 * @author xiaoyang
 *
 */
@Transactional
@Service
public class SysRoleServiceImpl implements SysRoleService {
	@Autowired
	private SysRoleDao sysRoleDao;
	@Autowired
	private SysRolePermisService sysRolePermisService;
	@Autowired
	private SysUserRoleService sysUserRoleService;

	@Override
	public List<SysRole> query(SysRoleFilter filter) {
		return sysRoleDao.query(filter);
	}

	@Override
	public int updateSysRole(SysRole sysRole) throws Exception {
		if(sysRole == null) return 0;
		return sysRoleDao.updateByPrimaryKey(sysRole);
	}

	@Override
	public int insertSysRole(SysRole sysRole) throws Exception {
		if(sysRole == null) return 0;
		if(StringUtils.isEmpty(sysRole.getId())){
			sysRole.setId(IDUtil.getId());
		}
		return sysRoleDao.insert(sysRole);
	}

	@Override
	public SysRole findSysRoleById(String id) {
		if(StringUtils.isEmpty(id)) return null;
		return sysRoleDao.selectByPrimaryKey(id);
	}

	@Override
	public int batchDelSysRole(List<String> list) throws Exception {
		if(list == null || list.size() == 0) return 0;
		int row =  sysRolePermisService.deleteRolePermisByRoleIdList(list);
		row += sysUserRoleService.deleteUserRoleByRoleIdList(list);
		row += sysRoleDao.batchDelSysRole(list);
		return row;
	}

	@Override
	public int updateRolePermis(String roleId, String checkedId) throws Exception {
		if(StringUtils.isEmpty(roleId)) return 0;
		int row = sysRolePermisService.deleteByRoleId(roleId);
		
		if(StringUtils.isNotEmpty(checkedId)){
			String []permissionIdArr = StringUtils.split(checkedId,",");
			int arrLen = permissionIdArr.length;
			int count = 0 ;
			List<SysRolePermis> rolePermissList = new ArrayList<SysRolePermis>();
			for(String permissionId : permissionIdArr){
				rolePermissList.add(new SysRolePermis(IDUtil.getId(), roleId, StringUtils.trim(permissionId)));
				
				count++;
				if(count % Constants.BATCH_COMMIT_SIZE == 0 || count==arrLen){
					row += sysRolePermisService.saveRolePermis(rolePermissList);
					
					rolePermissList = new ArrayList<SysRolePermis>();
				}
			}
		}
		return row;
	}

	@Override
	public List<SysRole> getUserRoleList(String userId) {
		return sysRoleDao.getUserRoleList(userId);
	}
	
	
	
	
}
