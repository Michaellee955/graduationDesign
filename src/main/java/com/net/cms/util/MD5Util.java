/**
 * 
 */
package com.net.cms.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.lang3.StringUtils;
import org.apache.tomcat.util.buf.HexUtils;

/**
 * @author xiaoyang
 *
 */
public class MD5Util {
	
	public static char[] charArr = null;
	static{
		charArr = new char[]{
							'4','7','1','9','a','z','u','t','0','e',
							'5','i','6','3','2','g','j','a','l',';',
							'2','w','1','^','h','.','y','d','s',':',
							'4','p',']','@','$','g','z','n','l','+',
							'8','[','&','!','q','m','c','x','e','-'
							};
	}
	
	public static  String encrypt(String str){
		return encrypt(str,"utf-8");
	}
	
	public static  String encrypt(String str,String charsetName){
		String defaultStr = "c21f969b5f03d33d43e04f8f136e7682";
		if(StringUtils.isEmpty(str)) return defaultStr;//default
		MessageDigest messageDigest;
		try {
			charsetName = StringUtils.isNotEmpty(charsetName) ? charsetName : "utf-8";
			messageDigest = MessageDigest.getInstance("MD5");
			
			str = replaceStr(str);
			messageDigest.update(str.getBytes(charsetName));
			String encryptStr = new String(HexUtils.toHexString(messageDigest.digest()));
			return encryptStr;
		} catch (UnsupportedEncodingException e) {
			return defaultStr;
		}catch (NoSuchAlgorithmException e) {
			return defaultStr;
		}
	}
	
	private static String replaceStr(String str){
		char[] cArr = str.toCharArray();
		for(int i = 0;i < cArr.length;i++){
			int ti = (int)cArr[i]-47;
			ti = (ti < 0 || ti > 49) ? 0 : ti;
			cArr[i] = charArr[ti];
		}
		
		return new String(cArr);
	}
	
	public static void main(String[] args) {
			System.out.println(MD5Util.encrypt("admin"));
	}
	
	 
	
	
	
}
