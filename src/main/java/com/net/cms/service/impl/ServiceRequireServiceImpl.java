/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.constant.Constants;
import com.net.cms.dao.ServiceRequireDao;
import com.net.cms.filter.ServiceRequireFilter;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.ServiceRequire;
import com.net.cms.service.ServiceRequireService;
import com.net.cms.shiro.util.Securitys;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class ServiceRequireServiceImpl implements ServiceRequireService {

   @Autowired
   private ServiceRequireDao serviceRequireDao;

	@Override
	public void saveOrUpdateSr(ServiceRequire sr) throws Exception {
		if(StringUtils.isEmpty(sr.getId()) || StringUtils.contains(sr.getId(), Constants.JSP_ADD_FLAG)){
			sr.setId(IDUtil.getId());
		}
		
		serviceRequireDao.saveOrUpdateSr(sr);
	}
	
	@Override
	public ServiceRequire findSrById(String id) {
		return serviceRequireDao.selectByPrimaryKey(id);
	}
	
	@Override
	public List<ServiceRequire> query(ServiceRequireFilter filter) {
		return serviceRequireDao.query(filter);
	}

	@Override
	public boolean checkCode(String id, String requireCode) {
		return serviceRequireDao.checkCode(id, requireCode) > 0 ;
	}

	@Override
	public void deleteSrById(String id) throws Exception {
		serviceRequireDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<KeyValueBean> findNotChooseResolutionSr() {
		return serviceRequireDao.findNotChooseResolutionSr(Securitys.getManuCode());
	}

	@Override
	public void updateStatusById(int status, String id) throws Exception {
		serviceRequireDao.updateStatusById(status, id);
	}
		   
	
}
