/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import com.net.cms.base.BaseDao;
import com.net.cms.po.ProductStruct;





/**
 * @author xiaoyang
 *
 */
public interface ProductStructDao extends BaseDao<ProductStruct>{
	void saveOrUpdatePs(ProductStruct ps);
	List<ProductStruct> findAllPsListBySid(String sid);
	
	List<String> findIdListByPid(String ... pid);
}
