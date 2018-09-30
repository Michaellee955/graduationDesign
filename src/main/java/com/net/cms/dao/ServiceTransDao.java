/**
 * 
 */
package com.net.cms.dao;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.ServiceTrans;






/**
 * @author xiaoyang
 *
 */
public interface ServiceTransDao extends BaseDao<ServiceTrans>{
	void updateStatusById(@Param("id") String id,@Param("status") Integer status); 
}
