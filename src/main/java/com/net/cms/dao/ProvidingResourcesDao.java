/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.ProvidingResources;
import com.net.cms.po.ServiceRequire;





/**
 * @author xiaoyang
 *
 */
public interface ProvidingResourcesDao extends BaseDao<ProvidingResources>{
	void saveOrUpdatePr(ProvidingResources pr);
	
	int checkCode(@Param("id") String id, @Param("resourcesCode") String resourcesCode);
	List<ProvidingResources> querySrList(ServiceRequire sr);
	
	List<ProvidingResources> queryPrListByIds(@Param("ids") String[] ids, @Param("sr") ServiceRequire sr);
}
