/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class RequireResolutionFilter extends BaseFilter {
	
	private String requireName;
	private String serviceCode;
	private String resolutionName;
	private Integer resolutionLevel;
	private String resolutionCost;
	private String resolutionQualify;
	private String resolutionStarttime;
	private String resolutionCount;
	
	private String commentScore;
	public String getServiceCode() {
		return serviceCode;
	}
	public void setServiceCode(String serviceCode) {
		this.serviceCode = serviceCode;
	}
	public String getResolutionName() {
		return resolutionName;
	}
	public void setResolutionName(String resolutionName) {
		this.resolutionName = resolutionName;
	}
	public Integer getResolutionLevel() {
		return resolutionLevel;
	}
	public void setResolutionLevel(Integer resolutionLevel) {
		this.resolutionLevel = resolutionLevel;
	}
	public String getResolutionCost() {
		return resolutionCost;
	}
	public void setResolutionCost(String resolutionCost) {
		this.resolutionCost = resolutionCost;
	}
	public String getResolutionQualify() {
		return resolutionQualify;
	}
	public void setResolutionQualify(String resolutionQualify) {
		this.resolutionQualify = resolutionQualify;
	}
	public String getResolutionStarttime() {
		return resolutionStarttime;
	}
	public void setResolutionStarttime(String resolutionStarttime) {
		this.resolutionStarttime = resolutionStarttime;
	}
	public String getResolutionCount() {
		return resolutionCount;
	}
	public void setResolutionCount(String resolutionCount) {
		this.resolutionCount = resolutionCount;
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
}
