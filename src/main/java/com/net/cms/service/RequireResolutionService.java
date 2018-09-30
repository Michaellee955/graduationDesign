/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.RequireResolutionFilter;
import com.net.cms.po.RequireResolution;


/**
 * @author xiaoyang
 *
 */
public interface RequireResolutionService {
	List<RequireResolution> queryRrListByRequireId(String requireId);
	List<RequireResolution> querySuRrListByFilter(RequireResolutionFilter filter);
	
	/**
	 * (保存)生成 方案数据及 匹配数据
	 * @param level 方案层级
	 * @param values 值 [0]- srId  [1]-prIds [2]-resolutionName
	 * @throws Exception
	 */
	void generateRrData(int level, String ... values) throws Exception;
	
	void updateResolution(String id, String requireId) throws Exception;
}
