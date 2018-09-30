/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.ServiceTransDao;
import com.net.cms.filter.ServiceTransFilter;
import com.net.cms.po.ServiceTrans;
import com.net.cms.service.ServiceTransService;

/**
 * @author xiaoyang
 *
 */
@Transactional
@Service
public class ServiceTransServiceImpl implements ServiceTransService {

	@Autowired
	private ServiceTransDao serviceTransDao;

	@Override
	public List<ServiceTrans> findListByFilter(ServiceTransFilter filter) {
		return serviceTransDao.query(filter);
	}

	@Override
	public void updateStatusById(String id, Integer status) throws Exception {
		serviceTransDao.updateStatusById(id, status);
	}
	

}
