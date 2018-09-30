/**
 * 
 */
package com.net.cms.po;

/**
 * @author xiaoyang
 *	key-value bean
 */
public class KeyValueBean {
	private String fkey;
	private String fvalue;
	
	public KeyValueBean(){}
	public KeyValueBean(String fkey,String fvalue){
		this.fkey = fkey;
		this.fvalue = fvalue;
	}
	public String getFkey() {
		return fkey;
	}
	public void setFkey(String fkey) {
		this.fkey = fkey;
	}
	public String getFvalue() {
		return fvalue;
	}
	public void setFvalue(String fvalue) {
		this.fvalue = fvalue;
	}
}
