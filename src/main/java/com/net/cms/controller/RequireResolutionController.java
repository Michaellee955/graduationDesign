package com.net.cms.controller;


import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.RequireResolutionFilter;
import com.net.cms.po.KeyValueBean;
import com.net.cms.po.RequireResolution;
import com.net.cms.service.RequireResolutionService;
import com.net.cms.service.ServiceRequireService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/requireResolution" })
public class RequireResolutionController {

	@Autowired
	private RequireResolutionService requireResolutionService;
	
	
	@Autowired
	private ServiceRequireService serviceRequireService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<RequireResolution> retrieve(String requireId){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<RequireResolution> list = requireResolutionService.queryRrListByRequireId(requireId);
		//初始化jqGrid响应实体
		JqgridResponse<RequireResolution> response = new JqgridResponse<RequireResolution>(0,0,0,list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView getSinglePage(@RequestParam(required = false) String requireId){
		ModelAndView mav = new ModelAndView("requireResolution/list");
		
		
		List<KeyValueBean> srList = serviceRequireService.findNotChooseResolutionSr();
		
		mav.addObject("srList", srList);
		
		if(StringUtils.isNotEmpty(requireId)){
			mav.addObject("requireId", requireId);
		}else if(srList.size() > 0){
			mav.addObject("requireId", srList.get(0).getFkey());
		}
		return mav;
	}
	
	@RequestMapping(value = "/successList")
	public ModelAndView getSuccessPage(){
		ModelAndView mav = new ModelAndView("requireResolution/successList");
		return mav;
	}
	
	@RequestMapping( value = "/successList",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<RequireResolution> successList(RequireResolutionFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<RequireResolution> list = requireResolutionService.querySuRrListByFilter(filter);
		//初始化jqGrid响应实体
		JqgridResponse<RequireResolution> response = new JqgridResponse<RequireResolution>(filter.getPage(),
				filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping( value = "/saveRr", method = RequestMethod.POST )
	public @ResponseBody StatusResponse saveRr(int level, String srId, String prIds, String resolutionName) {
		Boolean result =true;
		try{
			requireResolutionService.generateRrData(level, srId, prIds, resolutionName);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}
	@RequestMapping( value = "/updateResolution", method = RequestMethod.POST )
	public @ResponseBody StatusResponse updateResolution(String id, String requireId) {
		Boolean result =true;
		try{
			requireResolutionService.updateResolution(id, requireId);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}
}
