package com.net.cms.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	public static String getMonth(Date d){
		DateFormat df=new SimpleDateFormat("M");
		return df.format(d);
	}
	public static String dateParseStr(Date d){
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(d);
	}
	
	public static Date StrParseDate(String s){
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d=null;
		try {
			d= df.parse(s);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	public static String getCurrYear(){
		DateFormat df=new SimpleDateFormat("yyyy");
		return df.format(new Date());
	}
}
