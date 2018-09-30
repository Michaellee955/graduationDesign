/**
 * 
 */
package com.net.cms.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.net.cms.constant.Constants;
import com.net.cms.dao.ProvidingResourcesDao;
import com.net.cms.filter.ProvidingResourcesFilter;
import com.net.cms.po.ProvidingResources;
import com.net.cms.po.ServiceRequire;
import com.net.cms.service.ProductStructService;
import com.net.cms.service.ProvidingResourcesService;
import com.net.cms.service.ServiceRequireService;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class ProvidingResourcesServiceImpl implements ProvidingResourcesService {

   @Autowired
   private ProvidingResourcesDao providingResourcesDao;
   
   @Autowired
   private ProductStructService productStructService;
   
   @Autowired
   private ServiceRequireService serviceRequireService;

	@Override
	public void saveOrUpdatePr(ProvidingResources pr, List<MultipartFile> files) throws Exception {
		if(StringUtils.isEmpty(pr.getId()) || StringUtils.contains(pr.getId(), Constants.JSP_ADD_FLAG)){
			pr.setId(IDUtil.getId());
		}
		
        if (files != null && files.size()>0){
        	StringBuffer photoSb = new StringBuffer();
        	for(MultipartFile file : files){
        		if(file != null){
        			String ofn = file.getOriginalFilename();
        			String fileName = IDUtil.getId() + "." + ofn.substring(ofn.lastIndexOf(".") + 1);
        			FileUtils.writeByteArrayToFile(new File(Constants.UPLOAD_FLODER + fileName), file.getBytes());
        			
        			
        			if(photoSb.length() > 0){
        				photoSb.append(",");
        			}
        			photoSb.append(fileName);
        		}
        	}
        	pr.setServicePhoto(photoSb.toString());
        }
        
		
		providingResourcesDao.saveOrUpdatePr(pr);
	}
	
	@Override
	public ProvidingResources findPrById(String id) {
		return providingResourcesDao.selectByPrimaryKey(id);
	}
	
	@Override
	public List<ProvidingResources> query(ProvidingResourcesFilter filter) {
		return providingResourcesDao.query(filter);
	}

	@Override
	public boolean checkCode(String id, String resourcesCode) {
		return providingResourcesDao.checkCode(id, resourcesCode) > 0 ;
	}

	@Override
	public void deletePrById(String id) throws Exception {
		providingResourcesDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<ProvidingResources> querySrList(String srId, int level) {
		ServiceRequire sr = serviceRequireService.findSrById(srId);
		List<String> productIds = new ArrayList<String>();
		
		
		if(level == 0){
			productIds.add(sr.getProductId());
		}else if(level == 1){
			productIds.addAll(productStructService.findIdListByPid(sr.getProductId()));
		}else if(level == 2){
			List<String> childIds = productStructService.findIdListByPid(sr.getProductId());
			productIds.addAll(productStructService.findIdListByPid(childIds.toArray(new String[childIds.size()])));
		}
		
		
		
		if(productIds.size() == 0){
			return new ArrayList<ProvidingResources>();
		}
		sr.setProductIds(productIds);
		return providingResourcesDao.querySrList(sr);
	}

	@Override
	public List<ProvidingResources> queryPrListByIds(String[] ids, String srId) {
		ServiceRequire sr = serviceRequireService.findSrById(srId);
		return providingResourcesDao.queryPrListByIds(ids, sr);
	}
	   
		
}
