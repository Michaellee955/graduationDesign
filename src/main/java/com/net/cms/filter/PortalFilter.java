/**
 * 
 */
package com.net.cms.filter;

import com.net.cms.base.BaseFilter;

/**
 * @author xiaoyang
 *
 */
public class PortalFilter extends BaseFilter {
	private String data;
	private String dataType;
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

}
