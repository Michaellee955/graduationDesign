/**
 * 
 */
package com.net.cms.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.SysPermisDao;
import com.net.cms.po.SysPermis;
import com.net.cms.service.SysPermisService;
import com.net.cms.service.SysRolePermisService;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class SysPermisServiceImpl implements SysPermisService {

    @Autowired
    private SysPermisDao sysPermisDao;
    @Autowired
    private SysRolePermisService sysRolePermisService;
  
	public List<String> findAllPermisCode(){
		return sysPermisDao.findAllPermisCode();
	}
	public List<String> findRolePermisCode(List<String> roleIds){
		return sysPermisDao.findRolePermisCode(roleIds);
	}
	@Override
	public SysPermis selectByPrimaryKey(String id) {
		return sysPermisDao.selectByPrimaryKey(id);
	}
	@Override
	public boolean insertSysPermis(SysPermis sysPermis)throws Exception {
		sysPermis.setId(IDUtil.getId());
		return sysPermisDao.insert(sysPermis) > 0;
	}
	@Override
	public boolean updateSysPermis(SysPermis sysPermis)throws Exception {
		return sysPermisDao.updateByPrimaryKey(sysPermis) > 0;
	}
	@Override
	public boolean deleteSysPermis(final String id) throws Exception {
		int row = sysRolePermisService.deleteRolePermisByPermisIdList(new ArrayList<String>(){{add(id);}});
		row += sysPermisDao.deleteByPrimaryKey(id);
		return row > 0 ;
	}
	@Override
	public List<SysPermis> getChildNodes(String pid) {
		if(StringUtils.isEmpty(pid)) pid = "0";
		return sysPermisDao.getChildNodes(pid);
	}
	@Override
	public boolean checkPcode(final String id,final String pId,final String pCode) {
		Map<String,String> paramMap = new HashMap<String,String>(){{
			put("id", id);
			put("pId", pId);
			put("pCode", pCode);
		}};
		return sysPermisDao.checkPcode(paramMap) > 0;
	}
	@Override
	public List<SysPermis> getRolePermisList(String roleId) {
		return sysPermisDao.getRolePermisList(roleId);
	}
}
