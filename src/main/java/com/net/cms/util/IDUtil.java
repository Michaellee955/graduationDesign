package com.net.cms.util;

import java.util.UUID;

/**
 * 主键生成器
 * @author jinxv
 * */
public class IDUtil {

	public static String  getId(){
		return UUID.randomUUID().toString().replace("-", "");
	}
}
