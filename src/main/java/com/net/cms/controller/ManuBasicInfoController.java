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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.ManuBasicInfoFilter;
import com.net.cms.po.ManuBasicInfo;
import com.net.cms.service.ManuBasiceInfoService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/manuBasicInfo" })
public class ManuBasicInfoController {

	@Autowired
	private ManuBasiceInfoService manufacturerBasicInfoService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ManuBasicInfo> retrieve(ManuBasicInfoFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ManuBasicInfo> list = manufacturerBasicInfoService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<ManuBasicInfo> response = new JqgridResponse<ManuBasicInfo>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public String getSinglePage(Model model){
		return "manuBasicInfo/list";
	}
	
	@RequestMapping(value = "/register")
	public String register(Model model){
		return "manuBasicInfo/register";
	}
	
	@RequestMapping(value = "/register2")
	public String register2(Model model){
		return "manuBasicInfo/register2";
	}
	
	
	
	@RequestMapping(value = "/view")
	public ModelAndView view(@RequestParam String id,@RequestParam(required = false) String audit){
		ModelAndView mav = new ModelAndView("manuBasicInfo/view");
		mav.addObject("mbi", manufacturerBasicInfoService.findMbiById(id));
		mav.addObject("audit",audit);
		return mav;
	}
	
	@RequestMapping( value = "/updateStatus", method = RequestMethod.POST )
	public @ResponseBody StatusResponse updateStatus(@RequestParam String id,@RequestParam Integer status) {
		Boolean result =true;
		try{
				manufacturerBasicInfoService.updateStatusById(id, status);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		return new StatusResponse(result);
	}
	
	@RequestMapping( value = "/saveOrUpdateMbi", method = RequestMethod.POST )
	public @ResponseBody StatusResponse saveOrUpdateMbi(ManuBasicInfo mbi,MultipartHttpServletRequest mrequest) {
		Boolean result =true;
		try{
			List<MultipartFile> files = mrequest.getFiles("files");
			manufacturerBasicInfoService.saveOrUpdateMbi(mbi, files);
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
			String code = json.getString("code");
			result = manufacturerBasicInfoService.checkCode(id,code);
		}
		return new StatusResponse(result);
	}

}
