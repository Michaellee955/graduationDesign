/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.RequireResolutionFilter;
import com.net.cms.po.RequireResolution;
import com.net.cms.po.ServiceRequire;


/**
 * @author xiaoyang
 *
 */
public interface RequireResolutionService_V1 {
	List<RequireResolution> query(RequireResolutionFilter filter);
	
	void generateRrData(ServiceRequire sr) throws Exception;
}
