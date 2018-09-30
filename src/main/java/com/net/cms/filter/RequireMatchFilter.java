/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class RequireMatchFilter extends BaseFilter {
	
	private String resolutionId;
	private String manufacturerCode;
	private String productNumber;
	private String productCost;
	private String productQualify;
	private String taskStarttime;
	private String taskScore;
	private String taskComment;
	private Integer taskStatus;
	
	private String resourceCode;
	private String resourceName;
	
	

	public String getResolutionId() {
		return resolutionId;
	}

	public void setResolutionId(String resolutionId) {
		this.resolutionId = resolutionId;
	}

	public String getManufacturerCode() {
		return manufacturerCode;
	}

	public void setManufacturerCode(String manufacturerCode) {
		this.manufacturerCode = manufacturerCode;
	}

	public String getProductNumber() {
		return productNumber;
	}

	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}

	public String getProductCost() {
		return productCost;
	}

	public void setProductCost(String productCost) {
		this.productCost = productCost;
	}

	public String getProductQualify() {
		return productQualify;
	}

	public void setProductQualify(String productQualify) {
		this.productQualify = productQualify;
	}

	public String getTaskScore() {
		return taskScore;
	}

	public void setTaskScore(String taskScore) {
		this.taskScore = taskScore;
	}

	public String getTaskComment() {
		return taskComment;
	}

	public void setTaskComment(String taskComment) {
		this.taskComment = taskComment;
	}

	public Integer getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getTaskStarttime() {
		return taskStarttime;
	}

	public void setTaskStarttime(String taskStarttime) {
		this.taskStarttime = taskStarttime;
	}

	public String getResourceCode() {
		return resourceCode;
	}

	public void setResourceCode(String resourceCode) {
		this.resourceCode = resourceCode;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}

	
}
