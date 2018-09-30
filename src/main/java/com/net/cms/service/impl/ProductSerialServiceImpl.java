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
import com.net.cms.dao.ProductSerialDao;
import com.net.cms.filter.ProductSerialFilter;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.ProductSerial;
import com.net.cms.service.ProductSerialService;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class ProductSerialServiceImpl implements ProductSerialService {

   @Autowired
   private ProductSerialDao productSerialDao;

	@Override
	public void saveOrUpdatePs(ProductSerial ps) throws Exception {
		if(StringUtils.isEmpty(ps.getId()) || StringUtils.contains(ps.getId(), Constants.JSP_ADD_FLAG)){
			ps.setId(IDUtil.getId());
		}
		
		productSerialDao.saveOrUpdatePs(ps);
	}
	
	@Override
	public ProductSerial findPsById(String id) {
		return productSerialDao.selectByPrimaryKey(id);
	}
	
	@Override
	public List<ProductSerial> query(ProductSerialFilter filter) {
		return productSerialDao.query(filter);
	}

	@Override
	public void updateStatusById(String id, Integer isEnable) throws Exception {
		productSerialDao.updateStatusById(id, isEnable);
	}

	@Override
	public boolean checkSerialCode(String id, String serialCode, String version) {
		return productSerialDao.checkSerialCode(id, serialCode, version) > 0;
	}

	@Override
	public List<KeyValueBean> findAllPsCodeVersion() {
		return productSerialDao.findAllPsCodeVersion();
	}
	   
	
}
