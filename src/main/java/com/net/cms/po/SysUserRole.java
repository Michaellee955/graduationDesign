/**
 * 
 */
package com.net.cms.po;

import java.io.Serializable;

/**
 * @author xiaoyang
 *
 */
public class SysUserRole implements Serializable {
	private String id; //主键
	
	private String roleId; //角色ID 表T_sys_role字段f_id
	
	private String userId; //用户ID 表T_sys_user字段F_ID
	
	private String createTime; //创建日期

	
	public SysUserRole(){}
	public SysUserRole(String id,String userId,String roleId){
		this.id = id;
		this.userId = userId;
		this.roleId = roleId;
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
