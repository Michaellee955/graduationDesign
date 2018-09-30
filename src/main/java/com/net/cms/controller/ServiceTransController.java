package com.net.cms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.ServiceTransFilter;
import com.net.cms.po.ServiceTrans;
import com.net.cms.service.ServiceTransService;
import com.net.cms.util.StatusResponse;

/**
 * <pre>
 * 功能说明：服务交易
 * </pre>
 * 
 * @version 1.0
 */
@Controller
@RequestMapping("/serviceTrans")
public class ServiceTransController {
	
	@Autowired
	private ServiceTransService serviceTransService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String portal(Model model) {
        return "serviceTrans/list";
    }
    
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ServiceTrans> retrieve(ServiceTransFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ServiceTrans> list = serviceTransService.findListByFilter(filter);
		//初始化jqGrid响应实体
		JqgridResponse<ServiceTrans> response = new JqgridResponse<ServiceTrans>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	

	@RequestMapping(value = "openmodal", method = RequestMethod.GET)
	public ModelAndView info(String id) {
		ModelAndView mav = new ModelAndView("serviceTrans/form");
		mav.addObject("id", id);
		return mav;
	}	
	
	
	@RequestMapping( value = "/updateStatus", method = RequestMethod.POST )
	public @ResponseBody StatusResponse updateStatus(String id,Integer status) {
		Boolean result =true;
		try{
				serviceTransService.updateStatusById(id, status);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		return new StatusResponse(result);
	}
}
