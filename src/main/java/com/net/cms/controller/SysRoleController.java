package com.net.cms.controller;


import java.lang.reflect.InvocationTargetException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
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
import com.net.cms.constant.Constants;
import com.net.cms.filter.SysRoleFilter;
import com.net.cms.po.SysRole;
import com.net.cms.service.SysRoleService;
import com.net.cms.util.StatusResponse;

@Controller
@RequestMapping({ "/sysRole" })
public class SysRoleController {

	@Autowired
	private SysRoleService sysRoleService;
	
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<SysRole> retrieve(SysRoleFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<SysRole> list = sysRoleService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<SysRole> response = new JqgridResponse<SysRole>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list",method = { RequestMethod.GET })
	public String getSinglePage(Model model){
		return "sysRole/list";
	}
	
	@RequestMapping(value="getUserRoleList",method = { RequestMethod.POST })
	public @ResponseBody String getUserRoleList(@RequestParam(value = "userId",required = true)String userId){
		List<SysRole> roleList = sysRoleService.getUserRoleList(userId);
		return JSONArray.fromObject(roleList).toString();
	}
	
	@RequestMapping(value = "/openmodal/assignPermis", method = RequestMethod.GET)
	public ModelAndView assignPermis(@RequestParam (value = "id",required = true)String id) {
		ModelAndView mav = new ModelAndView("sysRole/permis");
		mav.addObject("id",id);
		return mav;
	}	
	
	@RequestMapping(value = "openmodal", method = RequestMethod.GET)
	public ModelAndView info(@RequestParam (value = "id",required = false)String id) {
		ModelAndView mav = new ModelAndView("sysRole/form");
		if (StringUtils.isNotEmpty(id)) {
			mav.addObject("sysRole", sysRoleService.findSysRoleById(id));
		} 
		return mav;
	}	

	
	@RequestMapping( value = "/delete", method = RequestMethod.POST )
	public @ResponseBody StatusResponse delete(@RequestParam String jsonStr) {
		Boolean result =true;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONArray jsonArr = JSONArray.fromObject(jsonStr);
			List<String> list = (List<String>)JSONArray.toCollection(jsonArr, String.class);
			try {
				sysRoleService.batchDelSysRole(list);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		}
		return new StatusResponse(result);
	}
	
	@RequestMapping( value = "/addOrUpdate", method = RequestMethod.POST )
	public @ResponseBody StatusResponse addOrUpdate(@RequestParam String jsonStr) {
		Boolean result =true;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject jsonObj = JSONObject.fromObject(jsonStr);
			try {
					SysRole sysRole = new SysRole();
					BeanUtils.copyProperties(sysRole, jsonObj);
					if(StringUtils.contains(sysRole.getId(),Constants.JSP_ADD_FLAG)){//编号是通过页面生成的
						sysRole.setId(null);
						sysRoleService.insertSysRole(sysRole);
					}else{
						sysRoleService.updateSysRole(sysRole);
					}
			} catch (IllegalAccessException e) {
				e.printStackTrace();
				result = false;
			} catch (InvocationTargetException e) {
				e.printStackTrace();
				result = false;
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		}
		return new StatusResponse(result);
	}
	@RequestMapping( value = "/updateRolePermis", method = RequestMethod.POST )
	public @ResponseBody StatusResponse updateRolePermis(@RequestParam String jsonStr) {
		Boolean result =true;
		if(StringUtils.isNotEmpty(jsonStr)){
			try {
				JSONObject jsonObj = JSONObject.fromObject(jsonStr);
				String id= jsonObj.getString("id");
				String checkedId = jsonObj.getString("checkedId");
			
				sysRoleService.updateRolePermis(id,checkedId);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		}
		return new StatusResponse(result);
	}
}
