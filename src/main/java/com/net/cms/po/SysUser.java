/**
 * 
 */
package com.net.cms.po;

import com.net.cms.constant.Constants.EnableStatus;


/**
 * @author xiaoyang
 *
 */
public class SysUser {
	private String id; //主键
	
	private String loginName; //登录名
	
	private String loginPwd; //登录密码
	
	private String userName; //用户姓名
	
	private Integer status; //状态(0:不启用 1：启用)
	
	private String createUser; //创建人
	
	private String createTime; //创建时间
	
	private String updateUser; //更新人
	
	private String updateTime; //更新时间
	
	private String manuId;
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	

	public String getStatusTxt() {
		if(status != null){
			return EnableStatus.getStatusTxt(status);
		}
		return "";
	}

	public String getManuId() {
		return manuId;
	}

	public void setManuId(String manuId) {
		this.manuId = manuId;
	}
	
}
