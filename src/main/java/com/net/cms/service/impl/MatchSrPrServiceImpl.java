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

import com.net.cms.dao.MatchSrPrDao;
import com.net.cms.filter.ServiceMatchFilter;
import com.net.cms.po.ServiceMatch;
import com.net.cms.service.MatchSrPrService;

/**
 * @author xiaoyang
 *
 */
@Transactional
@Service
public class MatchSrPrServiceImpl implements MatchSrPrService {

	@Autowired
	private MatchSrPrDao matchSrPrDao;

	@Override
	public void saveOrUpdateMsp(String srId, List<String> prIds, int level) throws Exception {
		if(StringUtils.isEmpty(srId) || prIds.size() == 0 || prIds == null) return;
		
		matchSrPrDao.saveOrUpdateMsp(srId, prIds, level);
	}

	@Override
	public List<ServiceMatch> query(ServiceMatchFilter filter) {
		if(filter.getType() == 1){
			return new ArrayList<ServiceMatch>();
		}
		
		return matchSrPrDao.querySmListByFilter(filter);
	}
	

}
