package com.net.cms.controller;


import java.util.Arrays;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.net.cms.base.JqgridResponse;
import com.net.cms.filter.ProvidingResourcesFilter;
import com.net.cms.po.ProvidingResources;
import com.net.cms.service.MatchSrPrService;
import com.net.cms.service.ProductSerialService;
import com.net.cms.service.ProvidingResourcesService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/providingResources" })
public class ProvidingResourcesController {

	@Autowired
	private ProvidingResourcesService providingResourcesService;
	
	@Autowired
	private ProductSerialService productSerialService;
	
	
	@Autowired
	private MatchSrPrService matchSrPrService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ProvidingResources> retrieve(ProvidingResourcesFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ProvidingResources> list = providingResourcesService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<ProvidingResources> response = new JqgridResponse<ProvidingResources>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list")
	public String getSinglePage(Model model){
		return "providingResources/list";
	}
	
	@RequestMapping(value = "/searchSrList")
	public ModelAndView searchSrList(String srId, int level){
		ModelAndView mav = new ModelAndView("providingResources/searchSrList");
		mav.addObject("srId", srId);
		mav.addObject("level", level);
		return mav;
	}
	
	@RequestMapping(value = "/selectSearchSrList", method={RequestMethod.POST})
	public ModelAndView selectSearchSrList(String ids, String srId, int level){
		ModelAndView mav = new ModelAndView("providingResources/selectSearchSrList");
		mav.addObject("ids", ids);
		mav.addObject("srId", srId);
		mav.addObject("level", level);
		
		try{
			matchSrPrService.saveOrUpdateMsp(srId, Arrays.asList(StringUtils.split(ids, ",")), level);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping( value = "/selectSearchSrListData",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ProvidingResources> selectSearchSrListData(String ids, String srId){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ProvidingResources> list = providingResourcesService.queryPrListByIds(StringUtils.split(ids, ","), srId);
		//初始化jqGrid响应实体
		JqgridResponse<ProvidingResources> response = new JqgridResponse<ProvidingResources>(0, 0, 0, list);
		return response;
	}
	

	@RequestMapping( value = "/searchSrList",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<ProvidingResources> searchSrListData(String srId, int level){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<ProvidingResources> list = providingResourcesService.querySrList(srId, level);
		//初始化jqGrid响应实体
		JqgridResponse<ProvidingResources> response = new JqgridResponse<ProvidingResources>(0, 0, 0, list);
		return response;
	}
	
	@RequestMapping(value = "/register")
	public ModelAndView register(Model model){
		ModelAndView mav = new ModelAndView("providingResources/register");
		mav.addObject("cvList", productSerialService.findAllPsCodeVersion());
		return mav;
	}
	
	
	@RequestMapping( value = "/saveOrUpdatePr", method = RequestMethod.POST )
	public @ResponseBody StatusResponse saveOrUpdatePr(ProvidingResources pr,MultipartHttpServletRequest mrequest) {
		Boolean result =true;
		try{
			List<MultipartFile> files = mrequest.getFiles("files");
			providingResourcesService.saveOrUpdatePr(pr, files);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}
	

	@RequestMapping(value = "/edit")
	public ModelAndView edit(String id){
		ModelAndView mav = new ModelAndView("providingResources/edit");
		
		mav.addObject("cvList", productSerialService.findAllPsCodeVersion());
		mav.addObject("pr", providingResourcesService.findPrById(id));
		return mav;
	}
	
	
	@RequestMapping(value = "/checkCode",method = RequestMethod.POST)
	public @ResponseBody StatusResponse checkCode(String jsonStr){
		boolean result = false;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject json = JSONObject.fromObject(jsonStr);
			String id = json.getString("id");
			String resourcesCode = json.getString("resourcesCode");
			result = providingResourcesService.checkCode(id,resourcesCode);
		}
		return new StatusResponse(result);
	}
	
	@RequestMapping(value = "/view")
	public ModelAndView view(String id){
		ModelAndView mav = new ModelAndView("providingResources/view");
		mav.addObject("pr", providingResourcesService.findPrById(id));
		return mav;
	}

	
	@RequestMapping( value = "/delete", method = RequestMethod.POST )
	public @ResponseBody StatusResponse delete(String id) {
		Boolean result =true;
		try {
			providingResourcesService.deletePrById(id);
		}catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return new StatusResponse(result);
	}
	
	
	@RequestMapping(value = "/showSelectPrList", method={RequestMethod.POST})
	public ModelAndView showSelectPrList(String ids, String srId, int level){
		ModelAndView mav = new ModelAndView("providingResources/showSelectPrList");
		mav.addObject("ids", ids);
		mav.addObject("srId", srId);
		mav.addObject("level", level);
		return mav;
	}
}
