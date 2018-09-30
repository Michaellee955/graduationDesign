/**
 * 
 */
package com.net.cms.dao;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.ManuBasicInfo;





/**
 * @author xiaoyang
 *
 */
public interface ManuBasicInfoDao extends BaseDao<ManuBasicInfo>{
	void saveOrUpdateMbi(ManuBasicInfo mbi);
	void updateStatusById(@Param("id") String id, @Param("status") Integer status);
	int checkCode(@Param("id") String id, @Param("code") String code);
}
