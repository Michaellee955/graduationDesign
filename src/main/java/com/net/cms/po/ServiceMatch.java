/**
 * 
 */
package com.net.cms.po;


/**
 * @author xiaoyang
 * 服务大厅-服务匹配
 */
public class ServiceMatch extends ProvidingResources{
    private String prId;
    private String srId;
    private Integer level;
    
    private String requireName;
	public String getPrId() {
		return prId;
	}
	public void setPrId(String prId) {
		this.prId = prId;
	}
	public String getSrId() {
		return srId;
	}
	public void setSrId(String srId) {
		this.srId = srId;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public String getRequireName() {
		return requireName;
	}
	public void setRequireName(String requireName) {
		this.requireName = requireName;
	}
}
