/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class ServiceRequireFilter extends BaseFilter {
	private String requireCode;
	private Integer serviceType;
	private String requireName;
	private Integer requireCount;
	private Integer requireUint;
	private Integer requireQualify;
	private Integer requirePrive;
	private String requireStarttime;
	private Integer isEnable;
	public String getRequireCode() {
		return requireCode;
	}
	public void setRequireCode(String requireCode) {
		this.requireCode = requireCode;
	}
	public Integer getServiceType() {
		return serviceType;
	}
	public void setServiceType(Integer serviceType) {
		this.serviceType = serviceType;
	}
	public String getRequireName() {
		return requireName;
	}
	public void setRequireName(String requireName) {
		this.requireName = requireName;
	}
	public Integer getRequireCount() {
		return requireCount;
	}
	public void setRequireCount(Integer requireCount) {
		this.requireCount = requireCount;
	}
	public Integer getRequireUint() {
		return requireUint;
	}
	public void setRequireUint(Integer requireUint) {
		this.requireUint = requireUint;
	}
	public Integer getRequireQualify() {
		return requireQualify;
	}
	public void setRequireQualify(Integer requireQualify) {
		this.requireQualify = requireQualify;
	}
	public Integer getRequirePrive() {
		return requirePrive;
	}
	public void setRequirePrive(Integer requirePrive) {
		this.requirePrive = requirePrive;
	}
	public String getRequireStarttime() {
		return requireStarttime;
	}
	public void setRequireStarttime(String requireStarttime) {
		this.requireStarttime = requireStarttime;
	}
	public Integer getIsEnable() {
		return isEnable;
	}
	public void setIsEnable(Integer isEnable) {
		this.isEnable = isEnable;
	}

}
