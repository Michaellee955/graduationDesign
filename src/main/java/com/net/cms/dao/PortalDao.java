/**
 * 
 */
package com.net.cms.dao;

import java.util.List;

import com.net.cms.base.BaseDao;
import com.net.cms.filter.PortalFilter;
import com.net.cms.po.PortalBean;





/**
 * @author xiaoyang
 *
 */
public interface PortalDao extends BaseDao<PortalBean>{
	List<PortalBean> queryPrByFilter(PortalFilter filter);
	List<PortalBean> querySrByFilter(PortalFilter filter);
}
