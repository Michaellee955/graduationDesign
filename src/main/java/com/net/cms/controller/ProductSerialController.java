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
import com.net.cms.filter.ProductSerialFilter;
import com.net.cms.po.ProductSerial;
import com.net.cms.service.ProductSerialService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/productSerial" })
public class ProductSerialController {

	@Autowired
	private ProductSerialService productSerialService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ProductSerial> retrieve(ProductSerialFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ProductSerial> list = productSerialService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<ProductSerial> response = new JqgridResponse<ProductSerial>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public String getSinglePage(Model model){
		return "productSerial/list";
	}
	
	
	@RequestMapping(value = "openmodal", method = RequestMethod.GET)
	public ModelAndView info(@RequestParam (value = "id",required = false)String id) {
		ModelAndView mav = new ModelAndView("productSerial/form");
		if (StringUtils.isNotEmpty(id)) {
			mav.addObject("ps", productSerialService.findPsById(id));
		} 
		return mav;
	}	

	
	@RequestMapping( value = "/saveOrUpdatePs", method = RequestMethod.POST )
	public @ResponseBody StatusResponse saveOrUpdatePs(ProductSerial ps) {
		Boolean result =true;
		try{
			productSerialService.saveOrUpdatePs(ps);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}
	
	@RequestMapping( value = "/updateStatus", method = RequestMethod.POST )
	public @ResponseBody StatusResponse updateStatus(@RequestParam String id,@RequestParam Integer isEnable) {
		Boolean result =true;
		try{
			productSerialService.updateStatusById(id, isEnable);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		return new StatusResponse(result);
	}

	@RequestMapping(value = "/checkSerialCode",method = RequestMethod.POST)
	public @ResponseBody StatusResponse checkSerialId(@RequestParam String jsonStr){
		boolean result = false;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject json = JSONObject.fromObject(jsonStr);
			String id = json.getString("id");
			String serialCode = json.getString("serialCode");
			String[] idArr = StringUtils.split(id,",");
			String version = idArr.length > 1 ? idArr[1] : null ;
			result = productSerialService.checkSerialCode(idArr[0],serialCode,version);
		}
		return new StatusResponse(result);
	}
}
