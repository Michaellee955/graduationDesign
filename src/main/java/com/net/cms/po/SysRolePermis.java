/**
 * 
 */
package com.net.cms.po;

/**
 * @author xiaoyang
 *
 */
public class SysRolePermis {
	private String id; //主键
	
	private String roleId; //角色ID表T_sys_role字段f_id
	
	private String permissionId; //系统权限表ID 表T_SYS_PERMIS字段f_id
	
	private String createTime; //创建日期

	public SysRolePermis(){}
	public SysRolePermis(String id,String roleId,String permissionId){
		this.id = id;
		this.roleId = roleId;
		this.permissionId = permissionId;
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

	public String getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
