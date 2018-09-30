/**
 * 
 */
package com.net.cms.service.impl;

import java.io.File;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.net.cms.constant.Constants;
import com.net.cms.dao.ManuBasicInfoDao;
import com.net.cms.filter.ManuBasicInfoFilter;
import com.net.cms.po.ManuBasicInfo;
import com.net.cms.po.SysUser;
import com.net.cms.service.ManuBasiceInfoService;
import com.net.cms.service.SysUserService;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class ManuBasicInfoServiceImpl implements ManuBasiceInfoService {

   @Autowired
   private ManuBasicInfoDao manufacturerBasicInfoDao;
   
   
   @Autowired
   private SysUserService sysUserService;
	   
	@Override
	public void saveOrUpdateMbi(ManuBasicInfo mbi, List<MultipartFile> files) throws Exception{
		if(StringUtils.isEmpty(mbi.getId()) || StringUtils.contains(mbi.getId(),Constants.JSP_ADD_FLAG)){
			mbi.setId(IDUtil.getId());
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
        	 mbi.setEnterprisePhoto(photoSb.toString());
        }
        
		manufacturerBasicInfoDao.saveOrUpdateMbi(mbi);
	}

	@Override
	public List<ManuBasicInfo> query(ManuBasicInfoFilter filter) {
		return manufacturerBasicInfoDao.query(filter);
	}

	@Override
	public ManuBasicInfo findMbiById(String id) {
		return manufacturerBasicInfoDao.selectByPrimaryKey(id);
	}

	@Override
	public void updateStatusById(String id, Integer status) throws Exception {
		 manufacturerBasicInfoDao.updateStatusById(id, status);
		 
		 sysUserService.saveOrUpdateUser(manufacturerBasicInfoDao.selectByPrimaryKey(id));
	}

	@Override
	public boolean checkCode(String id, String code) {
		return manufacturerBasicInfoDao.checkCode(id, code) > 0;
	}
}
