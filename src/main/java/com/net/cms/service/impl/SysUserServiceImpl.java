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

import com.net.cms.constant.Constants;
import com.net.cms.dao.SysUserDao;
import com.net.cms.filter.SysUserFilter;
import com.net.cms.po.ManuBasicInfo;
import com.net.cms.po.SysUser;
import com.net.cms.po.SysUserRole;
import com.net.cms.service.SysUserRoleService;
import com.net.cms.service.SysUserService;
import com.net.cms.shiro.ShiroUser;
import com.net.cms.shiro.util.Securitys;
import com.net.cms.util.IDUtil;
import com.net.cms.util.MD5Util;

/**
 * @author xiaoyang
 *
 */
@Transactional
@Service
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserDao sysUserDao;
    @Autowired
    private SysUserRoleService sysUserRoleService;
    
	public ShiroUser login(final String loginName,final String loginPwd){
		Map<String,String> paramMap = new HashMap<String,String>(){{
			put("loginName", loginName);
			put("loginPwd", loginPwd);
		}};
		return sysUserDao.login(paramMap);
	}
	
	public List<String> findRoleIdsByUserId(String userId){
		return sysUserDao.findRoleIdsByUserId(userId);
	}

	@Override
	public List<SysUser> query(SysUserFilter filter) {
		return sysUserDao.query(filter);
	}

	@Override
	public int updateSysUser(SysUser sysUser) throws Exception {
		if(sysUser == null) return 0;
		if(StringUtils.isNotEmpty(sysUser.getLoginPwd())){
			sysUser.setLoginPwd(MD5Util.encrypt(sysUser.getLoginPwd()));
		}
		sysUser.setUpdateUser(Securitys.getUserName());
		return sysUserDao.updateByPrimaryKey(sysUser);
	}

	@Override
	public int insertSysUser(SysUser sysUser) throws Exception {
		if(sysUser == null) return 0;
		if(StringUtils.isEmpty(sysUser.getId())){
			sysUser.setId(IDUtil.getId());
		}
		sysUser.setLoginPwd(MD5Util.encrypt(sysUser.getLoginPwd()));
		sysUser.setCreateUser(Securitys.getUserName());
		return sysUserDao.insert(sysUser);
	}

	@Override
	public SysUser findSysUserById(String id) {
		if(StringUtils.isEmpty(id)) return null;
		return sysUserDao.selectByPrimaryKey(id);
	}

	@Override
	public int batchDelSysUser(List<String> list) throws Exception {
		if(list == null || list.size() == 0) return 0;
		int row = sysUserRoleService.deleteUserRoleByUserIdList(list);
		row += sysUserDao.batchDelSysUser(list);
		return row;
	}

	@Override
	public int updateUserRole(final String userId, String checkedId) throws Exception {
		if(StringUtils.isEmpty(userId)) return 0;
		int row = sysUserRoleService.deleteUserRoleByUserIdList(new ArrayList<String>(){{add(userId);}});
		
		if(StringUtils.isNotEmpty(checkedId)){
			String [] roleIdArr = StringUtils.split(checkedId,",");
			int arrLen = roleIdArr.length;
			int count = 0 ;
			List<SysUserRole> userRoleList = new ArrayList<SysUserRole>();
			for(String roleId : roleIdArr){
				userRoleList.add(new SysUserRole(IDUtil.getId(), userId, StringUtils.trim(roleId)));
				
				count++;
				if(count % Constants.BATCH_COMMIT_SIZE == 0 || count==arrLen){
					row += sysUserRoleService.saveUserRole(userRoleList);
					
					userRoleList = new ArrayList<SysUserRole>();
				}
			}
		}
		return row;
	}

	@Override
	public boolean checkLoginName(final String id,final String loginName) {
		Map<String,String> paramMap = new HashMap<String,String>(){{
			put("id", id);
			put("loginName", loginName);
		}};
		return sysUserDao.checkLoginName(paramMap) > 0;
	}

	@Override
	public String getLoginPwdById(String id) {
		return sysUserDao.getLoginPwdById(id);
	}

	@Override
	public int updateLoginPwdById(final String newLoginPwd, final String id) {
		Map<String,String> paramMap = new HashMap<String,String>(){{
			put("loginPwd", MD5Util.encrypt(newLoginPwd));
			put("id", id);
		}};
		return sysUserDao.updateLoginPwdById(paramMap);
	}

	@Override
	public void saveOrUpdateUser(ManuBasicInfo mbi) throws Exception {
		SysUser user = new SysUser();
		final String userId = IDUtil.getId();
		user.setId(userId);
		user.setLoginName(mbi.getCode());
		user.setLoginPwd(Constants.RESET_PWD);//123456
		user.setUserName(mbi.getName());
		user.setStatus(mbi.getStatus() == 1 ? 1 : 0);
		user.setCreateUser(Securitys.getUserName());
		user.setManuId(mbi.getId());
		
		sysUserDao.saveOrUpdateUser(user);
		
		
		if(mbi.getStatus() == 1){
			sysUserRoleService.saveUserRole(new ArrayList<SysUserRole>(){{
				add(new SysUserRole(IDUtil.getId(), userId, Constants.ROLE_ID));
			}});
		}
	}
}
