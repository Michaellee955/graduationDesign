/**
 * 
 */
package com.net.cms.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.net.cms.filter.ManuBasicInfoFilter;
import com.net.cms.po.ManuBasicInfo;


/**
 * @author xiaoyang
 *
 */
public interface ManuBasiceInfoService {
	void saveOrUpdateMbi(ManuBasicInfo mbi, List<MultipartFile> files) throws Exception;
	ManuBasicInfo findMbiById(String id);
	
	List<ManuBasicInfo> query(ManuBasicInfoFilter filter);
	void updateStatusById(String id, Integer status) throws Exception;
	boolean checkCode(String id, String code);
}
