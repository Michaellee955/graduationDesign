/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.ProductSerialFilter;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.ProductSerial;


/**
 * @author xiaoyang
 *
 */
public interface ProductSerialService {
	void saveOrUpdatePs(ProductSerial ps) throws Exception;
	ProductSerial findPsById(String id);
	
	List<ProductSerial> query(ProductSerialFilter filter);
	void updateStatusById(String id, Integer isEnable)throws Exception;
	boolean checkSerialCode(String id ,String serialCode, String version);
	
	List<KeyValueBean> findAllPsCodeVersion();
}
