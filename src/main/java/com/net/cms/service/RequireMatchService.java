/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.po.RequireMatch;
import com.net.cms.po.RequireResolution;


/**
 * @author xiaoyang
 *
 */
public interface RequireMatchService {
	List<RequireMatch> queryRmListByRrId(String resolutionId);
	
	void generRmData(RequireResolution rr, String[] ids)throws Exception;
}
