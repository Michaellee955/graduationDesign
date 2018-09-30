/**
 * 
 */
package com.net.cms.po;


/**
 * @author xiaoyang
 * 服务发现清单（通过下一步保存进来的）
 */
public class MatchSrPr {
    private String prId;
    private String srId;
    private Integer level;
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
}
