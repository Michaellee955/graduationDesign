/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.RequireResolution;
import com.net.cms.po.ServiceRequire;





/**
 * @author xiaoyang
 *
 */
public interface RequireResolutionDao extends BaseDao<RequireResolution>{
	
	
	List<RequireResolution> findRrListBySr(@Param("sr") ServiceRequire sr, @Param("productId") String productId, @Param("limit") int limit);
	
	
	//add at 12.29
	RequireResolution findCostAndScore(@Param("requireCount") Integer requireCount, @Param("ids") String[] ids);
	void saveRrData(@Param("rrList") List<RequireResolution> rrList);
	//add at 12.30
	List<RequireResolution> queryRrListByRequireId(String requireId);
	void updateSuccessById(String id);
	
}
