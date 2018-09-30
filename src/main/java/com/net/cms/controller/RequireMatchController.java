package com.net.cms.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.base.JqgridResponse;
import com.net.cms.po.RequireMatch;
import com.net.cms.service.RequireMatchService;
@Controller
@RequestMapping({ "/requireMatch" })
public class RequireMatchController {

	@Autowired
	private RequireMatchService requireMatchService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<RequireMatch> retrieve(String resolutionId){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<RequireMatch> list = requireMatchService.queryRmListByRrId(resolutionId);
		//初始化jqGrid响应实体
		JqgridResponse<RequireMatch> response = new JqgridResponse<RequireMatch>(0,0,0,list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView getSinglePage(@RequestParam(required = false) String resolutionId, @RequestParam( required = false) String requireId){
		ModelAndView mav = new ModelAndView("requireMatch/list");
		
		mav.addObject("resolutionId", resolutionId);
		mav.addObject("requireId", requireId);
		return mav;
	}
}
