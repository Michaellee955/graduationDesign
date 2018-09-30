/**
 * 
 */
package com.net.cms.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.RequireResolutionDao;
import com.net.cms.filter.RequireResolutionFilter;
import com.net.cms.po.RequireMatch;
import com.net.cms.po.RequireResolution;
import com.net.cms.po.ServiceRequire;
import com.net.cms.service.ProductStructService;
import com.net.cms.service.RequireMatchService;
import com.net.cms.service.RequireResolutionService_V1;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class RequireResolutionServiceImpl_V1 implements RequireResolutionService_V1 {

   @Autowired
   private RequireResolutionDao requireResolutionDao;
   
   @Autowired
   private RequireMatchService requireMatchService;
   
   @Autowired
   private ProductStructService productStructService;
   
	@Override
	public List<RequireResolution> query(RequireResolutionFilter filter) {
		return requireResolutionDao.query(filter);
	}

	@Override
	public void generateRrData(ServiceRequire sr) throws Exception {
		//查询出 第一级 符合条件的
		String serviceCode = sr.getRequireCode();
		String productId = sr.getProductId();
		Integer requireCount = sr.getRequireCount();
		List<RequireResolution> rrList = requireResolutionDao.findRrListBySr(sr, productId, 5);
		List<RequireMatch> rmList = new ArrayList<RequireMatch>();
		int res_num = 1;
		if(rrList.size() > 0){
			for(RequireResolution rr : rrList){
				rr.setId(IDUtil.getId());
				rr.setResolutionLevel(1);
				rr.setResolutionCount(1);
				rr.setRequireName(sr.getRequireName());
				rr.setResolutionName(serviceCode+"_方案"+res_num);
				
				RequireMatch rm = new RequireMatch();
				rm.setId(IDUtil.getId());
				rm.setResolutionId(rr.getId());
				rm.setProductId(productId);
				rm.setProductNumber(requireCount);
				rm.setManufacturerCode(rr.getManufacturerCode());
				rm.setProductCost(rr.getResolutionCost());
				rm.setTaskStarttime(rr.getResolutionStarttime());
				rm.setTaskEndtime(rr.getResolutionEndtime());
				//rm.setServiceCode(serviceCode);
				//rm.setResourceCode(rr.getResourceCode());
				
				rmList.add(rm);
				
				res_num ++;
			}
		}
		

		List<String> childIds = productStructService.findIdListByPid(productId);
		//查询出 第二级符合条件
		res_num = genernateMatchData(childIds, sr, res_num, 2, rmList, rrList);
		
		if(childIds.size() > 0){
			//查询出 第三级符合条件
			childIds = productStructService.findIdListByPid(childIds.toArray(new String[childIds.size()]));
			genernateMatchData(childIds, sr, res_num, 3, rmList, rrList);
		}
		
		//requireMatchService.saveRmData(rmList);
		saveRrData(rrList, serviceCode);
		
	}
	
	private void saveRrData(List<RequireResolution> rrList, String serviceCode){
		if(rrList == null || rrList.size() == 0) return;
		
		requireResolutionDao.saveRrData(rrList);
		rrList.clear();
	}
	
	private int genernateMatchData(List<String> childIds, ServiceRequire sr, int res_num, int level, List<RequireMatch> rmList, List<RequireResolution> rrList) throws Exception{
		int childIdSize = childIds.size();
		if(childIdSize == 0) return res_num;
		
		
		List<RequireMatch> rmList2 = new ArrayList<RequireMatch>();
		List<RequireResolution> rrList2 = new ArrayList<RequireResolution>();
		Integer requireCount = sr.getRequireCount();
		String serviceCode = sr.getRequireCode();
		Integer totalCost = 0;
		String resoluId = IDUtil.getId();
		String productId = null;
		for(int s = 0; s < childIdSize; s++){
			productId = childIds.get(s);
			List<RequireResolution> childRrList = requireResolutionDao.findRrListBySr(sr, productId, 1);
			if(childRrList.size() == 0 ){//由于第level级 有些产品 还未有服务 所以第level级方案匹配失败
				rmList2.clear();
				rrList2.clear();
				break;
			}
			RequireResolution rr  = childRrList.get(0);
			
			totalCost+=rr.getResolutionCost();
			
			RequireMatch rm = new RequireMatch();
			rm.setId(IDUtil.getId());
			rm.setResolutionId(resoluId);
			rm.setProductId(productId);
			rm.setProductNumber(requireCount);
			rm.setManufacturerCode(rr.getManufacturerCode());
			rm.setProductCost(rr.getResolutionCost());
			rm.setTaskStarttime(rr.getResolutionStarttime());
			rm.setTaskEndtime(rr.getResolutionEndtime());
			//rm.setServiceCode(serviceCode);
			//rm.setResourceCode(rr.getResourceCode());
			
			if(s == childIdSize - 1){
				rr.setId(resoluId);
				rr.setResolutionCost(totalCost);
				rr.setResolutionLevel(level);
				rr.setResolutionCount(childIdSize);
				rr.setRequireName(sr.getRequireName());
				rr.setResolutionName(serviceCode+"_方案"+res_num);
				
				res_num ++;
				
				rrList2.add(rr);
			}
			rmList2.add(rm);
		}
		
		
		rmList.addAll(rmList2);
		rrList.addAll(rrList2);
		return res_num;
	}
		
}
