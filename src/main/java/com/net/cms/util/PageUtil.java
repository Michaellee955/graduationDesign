package com.net.cms.util;

public class PageUtil {
	
	/**
	 * 获取分页总页数
	 * @param total 总记录数
	 * @param pageSize 单位记录数
	 * */
	public static int getPageRecords(int total,int pageSize){
		int temp = total%pageSize;
		int count = total/pageSize;
		return temp==0?count:count+1; // 总页数
	}
}
