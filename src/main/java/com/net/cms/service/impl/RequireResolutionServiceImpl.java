/**
 * 
 */
package com.net.cms.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.RequireResolutionDao;
import com.net.cms.filter.RequireResolutionFilter;
import com.net.cms.po.RequireResolution;
import com.net.cms.po.ServiceRequire;
import com.net.cms.service.RequireMatchService;
import com.net.cms.service.RequireResolutionService;
import com.net.cms.service.ServiceRequireService;
import com.net.cms.util.IDUtil;

@Transactional
@Service
public class RequireResolutionServiceImpl implements RequireResolutionService {

   @Autowired
   private RequireResolutionDao requireResolutionDao;
   
   @Autowired
   private RequireMatchService requireMatchService;
   
   @Autowired
   private ServiceRequireService serviceRequireService;
   
	@Override
	public List<RequireResolution> queryRrListByRequireId(String requireId) {
		if(StringUtils.isEmpty(requireId)) return new ArrayList<RequireResolution>();
		
		return requireResolutionDao.queryRrListByRequireId(requireId);
	}

	@Override
	public void generateRrData(int level, String ... values) throws Exception{
		String srId = values[0], resolutionName = values[2];
		String[] prIds = StringUtils.split(values[1], ",");
		ServiceRequire sr = serviceRequireService.findSrById(srId);
		//查询出总费用、平均分数
		RequireResolution rr = requireResolutionDao.findCostAndScore(sr.getRequireCount(), prIds);
		
		rr.setId(IDUtil.getId());
		rr.setResolutionName(resolutionName);
		rr.setRequireId(srId);
		rr.setRequireName(sr.getRequireName());
		rr.setResolutionLevel(level);
		rr.setIsSucceed(0);
		rr.setResolutionQualify(sr.getRequireQualify());
		rr.setResolutionStarttime(sr.getRequireStarttime());
		rr.setResolutionEndtime(sr.getRequireEndtime());
		rr.setResolutionCount(sr.getRequireCount());
		
		saveRrData(rr);
		
		requireMatchService.generRmData(rr, prIds);
	}
	
	
	private void saveRrData(final RequireResolution rr){
		if(rr == null) return;
		
		saveRrData(new ArrayList<RequireResolution>(){{
			add(rr);
		}});
	}
	
	
	private void saveRrData(List<RequireResolution> rrList){
		if(rrList == null || rrList.size() == 0) return;
		
		requireResolutionDao.saveRrData(rrList);
		rrList.clear();
	}

	@Override
	public void updateResolution(String id, String requireId) throws Exception {
		requireResolutionDao.updateSuccessById(id);
		serviceRequireService.updateStatusById(1, requireId);
	}

	@Override
	public List<RequireResolution> querySuRrListByFilter(RequireResolutionFilter filter) {
		return requireResolutionDao.query(filter);
	}
		
}
