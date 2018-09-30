/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *服务大厅-服务匹配
 */
public class ServiceMatchFilter extends BaseFilter {
	private String productName;
	private String manuName;
	private String servicePrive;
	private String serviceAbility;
	private String providingName;
	private String requireName;
	private String commentScore;
	private String serviceStarttime;
	private Integer productQualify;
	private Integer level;
	
	private String resourcesCost;
	
	private Integer type;
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getManuName() {
		return manuName;
	}
	public void setManuName(String manuName) {
		this.manuName = manuName;
	}
	public String getServicePrive() {
		return servicePrive;
	}
	public void setServicePrive(String servicePrive) {
		this.servicePrive = servicePrive;
	}
	public String getServiceAbility() {
		return serviceAbility;
	}
	public void setServiceAbility(String serviceAbility) {
		this.serviceAbility = serviceAbility;
	}
	public String getProvidingName() {
		return providingName;
	}
	public void setProvidingName(String providingName) {
		this.providingName = providingName;
	}
	public String getRequireName() {
		return requireName;
	}
	public void setRequireName(String requireName) {
		this.requireName = requireName;
	}
	public String getCommentScore() {
		return commentScore;
	}
	public void setCommentScore(String commentScore) {
		this.commentScore = commentScore;
	}
	public String getServiceStarttime() {
		return serviceStarttime;
	}
	public void setServiceStarttime(String serviceStarttime) {
		this.serviceStarttime = serviceStarttime;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public Integer getProductQualify() {
		return productQualify;
	}
	public void setProductQualify(Integer productQualify) {
		this.productQualify = productQualify;
	}
	public String getResourcesCost() {
		return resourcesCost;
	}
	public void setResourcesCost(String resourcesCost) {
		this.resourcesCost = resourcesCost;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}

}
