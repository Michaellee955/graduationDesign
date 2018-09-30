package com.net.cms.base;

import java.util.List;

/**
 * 持久层接口超类，定义了基本增删改查方法
 * T代表模型
 * @author xiaoyng
 * @version 0.1
 * */
public interface BaseDao<T> {
	/**
	 * 返回分页后的数据
	 * @param pageView
	 * @param t
	 * @return
	 */
	public List<T> query(BaseFilter filter);
	/**
	 * 返回所有数据
	 * @param t
	 * @return
	 */
	public List<T> queryAll(T t);
	public Integer deleteByPrimaryKey(String id);
	public Integer updateByPrimaryKey(T t);
	public T selectByPrimaryKey(String id);
	public Integer insert(T t);
}
