/**
 * 
 */
package com.net.cms.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xiaoyang
 *
 */
public class BaseVo {
	List<Map> jsonArr;
	String data;
	String xmdm;
	String station1Sel;
	String station2Sel;

	public String getXmdm() {
		return xmdm;
	}

	public void setXmdm(String xmdm) {
		this.xmdm = xmdm;
	}

	public String getStation1Sel() {
		return station1Sel;
	}

	public void setStation1Sel(String station1Sel) {
		this.station1Sel = station1Sel;
	}

	public String getStation2Sel() {
		return station2Sel;
	}

	public void setStation2Sel(String station2Sel) {
		this.station2Sel = station2Sel;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public List<Map> getJsonArr() {
		return jsonArr;
	}

	public void setJsonArr(List<Map> jsonArr) {
		this.jsonArr = jsonArr;
	}



}
