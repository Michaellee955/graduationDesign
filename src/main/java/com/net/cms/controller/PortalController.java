package com.net.cms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.PortalFilter;
import com.net.cms.po.PortalBean;
import com.net.cms.service.PortalService;

/**
 * <pre>
 * 功能说明：工作台
 * </pre>
 * 
 * @version 1.0
 */
@Controller
@RequestMapping("/index")
public class PortalController {
	
	@Autowired
	private PortalService portalService;

    @RequestMapping(method = RequestMethod.GET)
    public String portal(Model model) {
        return "portal";
    }
    
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<PortalBean> retrieve(PortalFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<PortalBean> list = portalService.findPbListByFilter(filter);
		//初始化jqGrid响应实体
		JqgridResponse<PortalBean> response = new JqgridResponse<PortalBean>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
}
