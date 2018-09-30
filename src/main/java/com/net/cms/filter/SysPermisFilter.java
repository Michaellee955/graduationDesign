/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class SysPermisFilter extends BaseFilter {
private String id; //主键
	
	private String pCode; //系统权限表code
	
	private String pName; //权限名称
	
	private String Status; //状态(0:不可用 1可用)
	
	private String createTime; //创建时间
	
	private String parentId; //父级ID(最顶级为0)
	
	private String remark; //备注
	
	private String pLevel; //最顶级为1
	
	private String pIndex; //从1开始，是根据每个父级开始的

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getpLevel() {
		return pLevel;
	}

	public void setpLevel(String pLevel) {
		this.pLevel = pLevel;
	}

	public String getpIndex() {
		return pIndex;
	}

	public void setpIndex(String pIndex) {
		this.pIndex = pIndex;
	}
}
