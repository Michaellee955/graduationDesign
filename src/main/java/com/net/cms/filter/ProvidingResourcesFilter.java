/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class ProvidingResourcesFilter extends BaseFilter {
	private String resourcesCode;
	private String providingName;
	private Integer serviceType;
	private Integer isEnable;
	private Integer productQualify;
	private Integer serviceAbility;
	private Integer servicePrive;
	private Integer pricingMode;
	private String serviceStarttime;
	public String getResourcesCode() {
		return resourcesCode;
	}
	public void setResourcesCode(String resourcesCode) {
		this.resourcesCode = resourcesCode;
	}
	public String getProvidingName() {
		return providingName;
	}
	public void setProvidingName(String providingName) {
		this.providingName = providingName;
	}
	public Integer getServiceType() {
		return serviceType;
	}
	public void setServiceType(Integer serviceType) {
		this.serviceType = serviceType;
	}
	public Integer getIsEnable() {
		return isEnable;
	}
	public void setIsEnable(Integer isEnable) {
		this.isEnable = isEnable;
	}
	public Integer getProductQualify() {
		return productQualify;
	}
	public void setProductQualify(Integer productQualify) {
		this.productQualify = productQualify;
	}
	public Integer getServiceAbility() {
		return serviceAbility;
	}
	public void setServiceAbility(Integer serviceAbility) {
		this.serviceAbility = serviceAbility;
	}
	public Integer getServicePrive() {
		return servicePrive;
	}
	public void setServicePrive(Integer servicePrive) {
		this.servicePrive = servicePrive;
	}
	public Integer getPricingMode() {
		return pricingMode;
	}
	public void setPricingMode(Integer pricingMode) {
		this.pricingMode = pricingMode;
	}
	public String getServiceStarttime() {
		return serviceStarttime;
	}
	public void setServiceStarttime(String serviceStarttime) {
		this.serviceStarttime = serviceStarttime;
	}
	

}
