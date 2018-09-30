/**
 * 
 */
package com.net.cms.po;

/**
 * @author xiaoyang
 *
 */
public class ProductStruct {
		  private String id;
		  private String productId;
		  private String serialId;
		  private String productName;
		  private String pid;
		  private String functionType;
		  private String functionPos;
		  private Integer isEnable;
		  private String updateTime;
		  
		  private String parentName;
		  private Integer childCount;
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getProductName() {
			return productName;
		}
		public void setProductName(String productName) {
			this.productName = productName;
		}
		public String getFunctionType() {
			return functionType;
		}
		public void setFunctionType(String functionType) {
			this.functionType = functionType;
		}
		public String getFunctionPos() {
			return functionPos;
		}
		public void setFunctionPos(String functionPos) {
			this.functionPos = functionPos;
		}
		public Integer getIsEnable() {
			return isEnable;
		}
		public void setIsEnable(Integer isEnable) {
			this.isEnable = isEnable;
		}
		public String getUpdateTime() {
			return updateTime;
		}
		public void setUpdateTime(String updateTime) {
			this.updateTime = updateTime;
		}
		public String getSerialId() {
			return serialId;
		}
		public void setSerialId(String serialId) {
			this.serialId = serialId;
		}
		public String getPid() {
			return pid;
		}
		public void setPid(String pid) {
			this.pid = pid;
		}
		public String getProductId() {
			return productId;
		}
		public void setProductId(String productId) {
			this.productId = productId;
		}
		public String getParentName() {
			return parentName;
		}
		public void setParentName(String parentName) {
			this.parentName = parentName;
		}
		public Integer getChildCount() {
			return childCount;
		}
		public void setChildCount(Integer childCount) {
			this.childCount = childCount;
		}

}
