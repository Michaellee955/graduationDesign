/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.net.cms.filter.ProvidingResourcesFilter;
import com.net.cms.po.ProvidingResources;


/**
 * @author xiaoyang
 *
 */
public interface ProvidingResourcesService {
	void saveOrUpdatePr(ProvidingResources pr, List<MultipartFile> files) throws Exception;
	ProvidingResources findPrById(String id);
	
	List<ProvidingResources> query(ProvidingResourcesFilter filter);
	List<ProvidingResources> querySrList(String srId, int level);
	List<ProvidingResources> queryPrListByIds(String[] ids, String srId);
	
	boolean checkCode(String id, String resourcesCode);
	void deletePrById(String id) throws Exception;
}
