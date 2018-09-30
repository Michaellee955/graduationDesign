package com.net.cms.util;

import org.apache.commons.lang3.StringUtils;

public class UnicodeUtil {
	/**
	 * 把中文转成Unicode码
	 * @param str
	 * @return
	 */
	public static String chinaToUnicode(String str){
		if(StringUtils.isEmpty(str)) return "";
		StringBuffer sbStr = new StringBuffer();
		int strLen = str.length();
		for (int i = 0; i < strLen; i++){
            int chr1 = (char) str.charAt(i);
            if(chr1>=19968&&chr1<=171941){//汉字范围 \u4e00-\u9fa5 (中文)
            	sbStr.append("\\u");
            	sbStr.append(Integer.toHexString(chr1));
            }else{
            	sbStr.append(str.charAt(i));
            }
        }
		return sbStr.toString();
	}
}
