/**
 * 
 */
package com.net.cms.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.net.cms.po.KeyValueBean;

/**
 * @author xiaoyang
 *
 */
public class KeyValueBeanUtil {
	
	public static String toString(List<KeyValueBean> list){
		StringBuffer sb = new StringBuffer();
		if(list != null && list.size() > 0){
			boolean isNotNull = false;
			for(KeyValueBean kv : list){
				if(StringUtils.isEmpty(kv.getFkey()) || StringUtils.isEmpty(kv.getFvalue())){
					continue;
				}
				
				if(isNotNull){
					sb.append(",");
				}
				sb.append("'").append(kv.getFkey()).append("':'").append(kv.getFvalue()).append("'");
				isNotNull = true;
			}
		}
		return sb.toString();
	}
}
