/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.PortalDao;
import com.net.cms.filter.PortalFilter;
import com.net.cms.po.PortalBean;
import com.net.cms.service.PortalService;

/**
 * @author xiaoyang
 *
 */
@Transactional
@Service
public class PortalServiceImpl implements PortalService {

	@Autowired
	private PortalDao portalDao;
	
	@Override
	public List<PortalBean> findPbListByFilter(PortalFilter filter) {
		if(StringUtils.equals("serviceRequire", filter.getDataType())){
			return portalDao.querySrByFilter(filter);
		}else{
			return portalDao.queryPrByFilter(filter);
		}
	}

}
