package com.net.cms.base;

import java.util.HashMap;
import java.util.Map;

public class JqgridResponseContext {
	private static ThreadLocal<Map<String, Object>> context = new ThreadLocal();

	  protected static Object get(String key) {
	    Map map = (Map)context.get();
	    if (null == map) {
	      map = new HashMap();
	      context.set(map);
	    }
	    return map.get(key);
	  }

	  public static <T> JqgridResponse<T> getJqgridResponse(Class<T> clazz) {
	    JqgridResponse jqgridResponse = (JqgridResponse)get("jqgridResponse");
	    if (jqgridResponse == null) {
	      jqgridResponse = new JqgridResponse();
	      set("jqgridResponse", jqgridResponse);
	    }
	    return jqgridResponse;
	  }

	  protected static void set(String key, Object value) {
	    Map map = (Map)context.get();
	    map.put(key, value);
	  }
}
