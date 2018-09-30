/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class ManuBasicInfoFilter extends BaseFilter {
	private String code;
	private String name;
	private String type;
	private String status;
	private String addr;
	private String contactPerson;
	private String contactNumber;
	private String enterpriseQualification;
	private String createTime;
	private Float commentScore;
	private Integer dataType;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getEnterpriseQualification() {
		return enterpriseQualification;
	}
	public void setEnterpriseQualification(String enterpriseQualification) {
		this.enterpriseQualification = enterpriseQualification;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Float getCommentScore() {
		return commentScore;
	}
	public void setCommentScore(Float commentScore) {
		this.commentScore = commentScore;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public Integer getDataType() {
		return dataType;
	}
	public void setDataType(Integer dataType) {
		this.dataType = dataType;
	}
	public String getContactNumber() {
		return contactNumber;
	}

}
