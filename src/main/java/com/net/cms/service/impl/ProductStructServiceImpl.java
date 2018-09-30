/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.ProductStructDao;
import com.net.cms.filter.ProductStructFilter;
import com.net.cms.po.ProductStruct;
import com.net.cms.service.ProductStructService;

@Transactional
@Service
public class ProductStructServiceImpl implements ProductStructService {

   @Autowired
   private ProductStructDao productStructDao;

	@Override
	public void saveOrUpdatePs(ProductStruct ps) throws Exception {
		
	}
	
	@Override
	public ProductStruct findPsById(String id) {
		return null;
	}
	
	@Override
	public List<ProductStruct> query(ProductStructFilter filter) {
		return null;
	}

	@Override
	public List<ProductStruct> findAllPsListBySid(String sid) {
		return productStructDao.findAllPsListBySid(sid);
	}

	@Override
	public List<String> findIdListByPid(String ... pid) {
		return productStructDao.findIdListByPid(pid);
	}
	
}
