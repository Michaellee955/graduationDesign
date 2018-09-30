/**
 * 
 */
package com.net.cms.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.net.cms.dao.SysLogDao;
import com.net.cms.po.SysLog;
import com.net.cms.service.SysLogService;
import com.net.cms.shiro.util.Securitys;

@Transactional
@Service
public class SysLogServiceImpl implements SysLogService {

    @Autowired
    private SysLogDao sysLogDao;

	@Override
	public void insertSysLog(SysLog sysLog) {
		if(sysLog == null) return;
		if(StringUtils.isEmpty(sysLog.getOperatorId())){
			sysLog.setOperator(Securitys.getUserName());
			sysLog.setOperatorId(Securitys.getUserId());
		}
		sysLogDao.insertSysLog(sysLog);
	}
    
	
	
}
