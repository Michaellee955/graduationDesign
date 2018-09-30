/**
 * 
 */
package com.net.cms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.ServiceMatchFilter;
import com.net.cms.po.ServiceMatch;
import com.net.cms.service.MatchSrPrService;

/**
 * @author xiaoyang
 *
 */
@Controller
@RequestMapping({ "/serviceMatch" })
public class ServiceMatchController {

	@Autowired
	private MatchSrPrService matchSrPrService;
	
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ServiceMatch> retrieve(ServiceMatchFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ServiceMatch> list = matchSrPrService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<ServiceMatch> response = new JqgridResponse<ServiceMatch>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public String getSinglePage(Model model){
		return "serviceMatch/list";
	}
}
