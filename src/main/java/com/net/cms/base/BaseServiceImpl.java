package com.net.cms.base;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;

import com.net.cms.service.SysLogService;

public class BaseServiceImpl implements Serializable
{
  @Autowired
  protected SysLogService sysLogService;
}
