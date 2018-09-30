package com.net.cms.controller;


import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.ServiceRequireFilter;
import com.net.cms.po.ServiceRequire;
import com.net.cms.service.ProductSerialService;
import com.net.cms.service.ServiceRequireService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/serviceRequire" })
public class ServiceRequireController {

	@Autowired
	private ServiceRequireService serviceRequireService;
	
	@Autowired
	private ProductSerialService productSerialService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ServiceRequire> retrieve(ServiceRequireFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ServiceRequire> list = serviceRequireService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<ServiceRequire> response = new JqgridResponse<ServiceRequire>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public ModelAndView getSinglePage(Model model, String type){
		ModelAndView mav = new ModelAndView("serviceRequire/list");
		mav.addObject("type", type);
		
		return mav;
	}
	
	
	@RequestMapping(value = "/release")
	public ModelAndView register(Model model){
		ModelAndView mav = new ModelAndView("serviceRequire/release");
		mav.addObject("cvList", productSerialService.findAllPsCodeVersion());
		return mav;
	}
	
	@RequestMapping( value = "/saveOrUpdateSr", method = RequestMethod.POST )
	public @ResponseBody StatusResponse saveOrUpdateSr(ServiceRequire sr) {
		Boolean result =true;
		try{
			serviceRequireService.saveOrUpdateSr(sr);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}
	

	@RequestMapping(value = "/checkCode",method = RequestMethod.POST)
	public @ResponseBody StatusResponse checkCode(@RequestParam String jsonStr){
		boolean result = false;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject json = JSONObject.fromObject(jsonStr);
			String id = json.getString("id");
			String requireCode = json.getString("requireCode");
			result = serviceRequireService.checkCode(id,requireCode);
		}
		return new StatusResponse(result);
	}
	

	@RequestMapping(value = "/view")
	public ModelAndView view(@RequestParam String id){
		ModelAndView mav = new ModelAndView("serviceRequire/view");
		mav.addObject("sr", serviceRequireService.findSrById(id));
		return mav;
	}
	
	@RequestMapping(value = "/edit")
	public ModelAndView edit(@RequestParam String id){
		ModelAndView mav = new ModelAndView("serviceRequire/edit");
		
		mav.addObject("cvList", productSerialService.findAllPsCodeVersion());
		mav.addObject("sr", serviceRequireService.findSrById(id));
		return mav;
	}
	
	
	@RequestMapping( value = "/delete", method = RequestMethod.POST )
	public @ResponseBody StatusResponse delete(@RequestParam String id) {
		Boolean result =true;
		try {
			serviceRequireService.deleteSrById(id);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}

}
