package com.net.cms.constant;

import com.net.cms.util.ConfigUtil;


/**
 * 
 * <pre>
 * 功能说明：系统常用字段变量(非自动生成)
 * </pre>
 * 
 * @author xiaoyang
 * @version 1.0
 */
public class Constants {
	
	public static final String JSP_ADD_FLAG = "-byadd";
	public static final String RESET_PWD = "5cd76e19c6dfd7a14906e7999252693b";//123456
	public static final int BATCH_COMMIT_SIZE = 200;
	
	public static final String ROLE_ID = "8c15abaf54a2403d91e455f2c28dc941";//默认角色id
	public static final String ADMIN_NAME = "admin";
	
	public static final String UPLOAD_FLODER = ConfigUtil.getConfig("upload_floder");
	
	  public static class EnableStatus{
		   	 /* 启用 */
		       public static final int ENABLE = 1;
		       /* 不启用 */
		       public static final int NOT_ENABLE = 0;
		       /* 已删除 */
		       public static final int DELETED = -1;
		       
		       /* 启用 */
		       public static final String ENABLE_TXT = "启用";
		       /* 不启用 */
		       public static final String NOT_ENABLE_TXT = "不启用";
		       /*已删除*/
		       public static final String DELETED_TXT = "已删除";
		       
		       public static String getStatusTxt(int status){
		       	if(ENABLE == status){
		       		return ENABLE_TXT;
		       	}else if(NOT_ENABLE == status){
		       		return NOT_ENABLE_TXT;
		       	}else{
		       		return DELETED_TXT;
		       	}
		       }
		   }
    
    
}
