/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.ServiceMatchFilter;
import com.net.cms.po.ServiceMatch;


/**
 * @author xiaoyang
 *
 */
public interface MatchSrPrService {
	
	void saveOrUpdateMsp(String srId, List<String> prIds, int level) throws Exception;
	
	List<ServiceMatch> query(ServiceMatchFilter filter);
}
