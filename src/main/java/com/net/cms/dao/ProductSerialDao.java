/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.net.cms.base.BaseDao;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.ProductSerial;





/**
 * @author xiaoyang
 *
 */
public interface ProductSerialDao extends BaseDao<ProductSerial>{
	void saveOrUpdatePs(ProductSerial ps);
	void updateStatusById(@Param("id") String id, @Param("isEnable") Integer isEnable);
	int checkSerialCode(@Param("id") String id, @Param("serialCode") String serialCode, @Param("version") String version);
	List<KeyValueBean> findAllPsCodeVersion();
}
