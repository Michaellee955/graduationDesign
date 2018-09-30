package com.net.cms.controller;


import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.po.ProductStruct;
import com.net.cms.service.ProductSerialService;
import com.net.cms.service.ProductStructService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/productStruct" })
public class ProductStructController {

	@Autowired
	private ProductStructService productStructService;
	
	@Autowired
	private ProductSerialService productSerialService;
	
	
	@RequestMapping(value = "/list")
	public ModelAndView getSinglePage(Model model){
		ModelAndView mav = new ModelAndView("productStruct/list");
		
		mav.addObject("cvList", productSerialService.findAllPsCodeVersion());
		return  mav;
	}
	
	
	@RequestMapping(value="getPsListTree",method = { RequestMethod.POST })
	public @ResponseBody String getSysPermisListTree(@RequestParam String sid){
		StringBuilder treeSb = new StringBuilder();
		
		if(StringUtils.isNotEmpty(sid)){
				List<ProductStruct> psList = productStructService.findAllPsListBySid(sid);
				if(psList.size() > 0 ){
					treeSb.append("[");
					String ftStr = "{id:'%s',name:'%s',pId:'%s',open:'true'}";
					
					int i = 0;
					for(ProductStruct ps : psList){
						if(i!=0){
							treeSb.append(",");
						}
						treeSb.append(String.format(ftStr, ps.getId(), ps.getProductName(), ps.getPid()));
						i++;
					}
					
					treeSb.append("]");
				}
		}
		
		return treeSb.toString();
	}
	
	@RequestMapping( value = "/saveOrUpdatePs", method = RequestMethod.POST )
	public @ResponseBody StatusResponse saveOrUpdatePs(ProductStruct ps) {
		Boolean result =true;
		try{
			productStructService.saveOrUpdatePs(ps);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}

}
