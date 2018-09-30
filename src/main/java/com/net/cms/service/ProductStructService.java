/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.ProductStructFilter;
import com.net.cms.po.ProductStruct;


/**
 * @author xiaoyang
 *
 */
public interface ProductStructService {
	void saveOrUpdatePs(ProductStruct ps) throws Exception;
	ProductStruct findPsById(String id);
	
	List<ProductStruct> query(ProductStructFilter filter);
	
	List<ProductStruct> findAllPsListBySid(String sid);
	
	List<String> findIdListByPid(String ... pid);
}
