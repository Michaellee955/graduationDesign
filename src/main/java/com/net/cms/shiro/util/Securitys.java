package com.net.cms.shiro.util;

import org.apache.shiro.SecurityUtils;

import com.net.cms.shiro.ShiroUser;

public class Securitys extends SecurityUtils{
	  public static String getLoginName()
	  {
	    return getUser().getLoginName();
	  }

	  public static ShiroUser getUser()
	  {
	    return (ShiroUser)getSubject().getPrincipal();
	  }

	  public static String getUserId()
	  {
	    return getUser().getId();
	  }

	  public static String getUserName()
	  {
	    return getUser().getUserName();
	  }
	  
	  public static String getManuCode(){
		  return getUser().getManuCode();
	  }
}
