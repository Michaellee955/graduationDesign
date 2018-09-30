/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.ServiceRequire;





/**
 * @author xiaoyang
 *
 */
public interface ServiceRequireDao extends BaseDao<ServiceRequire>{
	void saveOrUpdateSr(ServiceRequire sr);
	
	int checkCode(@Param("id") String id, @Param("requireCode") String requireCode);
	
	List<KeyValueBean> findNotChooseResolutionSr(@Param("manuCode") String manuCode) ;
	void updateStatusById(@Param("status") int status, @Param("id") String id);
}
