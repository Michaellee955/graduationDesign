/**
 * 
 */
package com.net.cms.po;


/**
 * @author xiaoyang
 *
 */
public class ManuBasicInfo {
     private String id;
     private String code;
     private String name;
     private String addr;
     private Integer type;
     private String contactPerson;
     private String contactNumber;
     private String enterpriseProfile;
     private String enterpriseQualification;
     private Float commentScore;
     private String createTime;
     private String enterprisePhoto;
     private Integer dataType;
     
     private Integer status;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getEnterpriseProfile() {
		return enterpriseProfile;
	}
	public void setEnterpriseProfile(String enterpriseProfile) {
		this.enterpriseProfile = enterpriseProfile;
	}
	public String getEnterpriseQualification() {
		return enterpriseQualification;
	}
	public void setEnterpriseQualification(String enterpriseQualification) {
		this.enterpriseQualification = enterpriseQualification;
	}
	public Float getCommentScore() {
		return commentScore;
	}
	public void setCommentScore(Float commentScore) {
		this.commentScore = commentScore;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getEnterprisePhoto() {
		return enterprisePhoto;
	}
	public void setEnterprisePhoto(String enterprisePhoto) {
		this.enterprisePhoto = enterprisePhoto;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getDataType() {
		return dataType;
	}
	public void setDataType(Integer dataType) {
		this.dataType = dataType;
	}
}
