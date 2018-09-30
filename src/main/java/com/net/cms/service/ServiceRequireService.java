/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.ServiceRequireFilter;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.ServiceRequire;


/**
 * @author xiaoyang
 *
 */
public interface ServiceRequireService {
	void saveOrUpdateSr(ServiceRequire sr) throws Exception;
	ServiceRequire findSrById(String id);
	
	List<ServiceRequire> query(ServiceRequireFilter filter);
	boolean checkCode(String id, String requireCode);
	void deleteSrById(String id) throws Exception;
	
	List<KeyValueBean> findNotChooseResolutionSr();
	void updateStatusById(int status, String id) throws Exception;
}
