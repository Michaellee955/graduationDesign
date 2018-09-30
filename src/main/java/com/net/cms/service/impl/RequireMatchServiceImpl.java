/**
 * 
 */
package com.net.cms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.RequireMatchDao;
import com.net.cms.po.RequireMatch;
import com.net.cms.po.RequireResolution;
import com.net.cms.service.RequireMatchService;

@Transactional
@Service
public class RequireMatchServiceImpl implements RequireMatchService {

   @Autowired
   private RequireMatchDao requireMatchDao;

	@Override
	public List<RequireMatch> queryRmListByRrId(String resolutionId) {
		return requireMatchDao.queryRmListByRrId(resolutionId);
	}


	@Override
	public void generRmData(RequireResolution rr, String[] ids) throws Exception {
		requireMatchDao.generRmData(rr, ids);
	}
		
}
