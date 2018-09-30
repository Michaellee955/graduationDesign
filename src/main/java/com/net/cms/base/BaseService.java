package com.net.cms.base;

import java.util.List;

/**
 * 服务接口超类，定义了基本增删改查方法
 * T代表模型
 * E代表分页过滤器
 * @author Jin Xv
 * @version 0.1
 * */
public interface BaseService<T,E> {
	
	Boolean insert(T t);

	Boolean update(T t);

	Boolean delete(String id);
	
	List<T> query(E e);

	T selectByPrimaryKey(String id);
}
