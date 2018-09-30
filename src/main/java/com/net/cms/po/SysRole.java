/**
 * 
 */
package com.net.cms.po;

import com.net.cms.constant.Constants.EnableStatus;

/**
 * @author xiaoyang
 *
 */
public class SysRole {
	private String id; //主键
	
	private String roleName; //角色名
	
	private String remark; //备注
	
	private Integer status; //状态(0:不启用 1：启用)
	
	private String createTime; //创建日期
	private String isChecked;

	public String getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	public String getStatusTxt() {
		if(status != null){
			return EnableStatus.getStatusTxt(status);
		}
		return "";
	}
	
}
