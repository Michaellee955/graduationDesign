/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.RequireMatch;
import com.net.cms.po.RequireResolution;





/**
 * @author xiaoyang
 *
 */
public interface RequireMatchDao extends BaseDao<RequireMatch>{
	void generRmData(@Param("rr") RequireResolution rr, @Param("ids") String[] ids);
	
	List<RequireMatch> queryRmListByRrId(String resolutionId);
}
