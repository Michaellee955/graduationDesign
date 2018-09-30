/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.filter.ServiceMatchFilter;
import com.net.cms.po.MatchSrPr;
import com.net.cms.po.ServiceMatch;





/**
 * @author xiaoyang
 *
 */
public interface MatchSrPrDao extends BaseDao<MatchSrPr>{
	void saveOrUpdateMsp(@Param("srId") String srId, @Param("prIds") List<String> prIds, @Param("level") int level);
	
	List<ServiceMatch> querySmListByFilter(ServiceMatchFilter filter);
}
