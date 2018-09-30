/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.ServiceTransFilter;
import com.net.cms.po.ServiceTrans;


/**
 * @author xiaoyang
 *
 */
public interface ServiceTransService {
	
	List<ServiceTrans> findListByFilter(ServiceTransFilter filter);
	
	void updateStatusById(String id, Integer status) throws Exception;
}
