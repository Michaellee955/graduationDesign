/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import com.net.cms.filter.PortalFilter;
import com.net.cms.po.PortalBean;


/**
 * @author xiaoyang
 *
 */
public interface PortalService {
	
	List<PortalBean> findPbListByFilter(PortalFilter filter);
}
