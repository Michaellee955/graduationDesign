/**
 * 
 */
package com.net.cms.po;


/**
 * @author xiaoyang
 *
 */
public class ServiceTrans {
     private String id;
     private String resourcesCode;
     private String providingName;
     private String requireName;
     private String manuName;
     private Integer productCost;
     private Integer productNumber;
     private String taskStarttime;
     private String taskEndtime;
     private Float taskScore;
     private Integer taskStatus;
     
     private String resourceId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

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

	public String getRequireName() {
		return requireName;
	}

	public void setRequireName(String requireName) {
		this.requireName = requireName;
	}

	public String getManuName() {
		return manuName;
	}

	public void setManuName(String manuName) {
		this.manuName = manuName;
	}

	public Integer getProductCost() {
		return productCost;
	}

	public void setProductCost(Integer productCost) {
		this.productCost = productCost;
	}

	public Integer getProductNumber() {
		return productNumber;
	}

	public void setProductNumber(Integer productNumber) {
		this.productNumber = productNumber;
	}

	public String getTaskStarttime() {
		return taskStarttime;
	}

	public void setTaskStarttime(String taskStarttime) {
		this.taskStarttime = taskStarttime;
	}

	public String getTaskEndtime() {
		return taskEndtime;
	}

	public void setTaskEndtime(String taskEndtime) {
		this.taskEndtime = taskEndtime;
	}

	public Float getTaskScore() {
		return taskScore;
	}

	public void setTaskScore(Float taskScore) {
		this.taskScore = taskScore;
	}

	public Integer getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getResourceId() {
		return resourceId;
	}

	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}
}
