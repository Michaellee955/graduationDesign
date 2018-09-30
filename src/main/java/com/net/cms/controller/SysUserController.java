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
import com.net.cms.filter.SysUserFilter;
import com.net.cms.po.SysUser;
import com.net.cms.service.SysUserService;
import com.net.cms.shiro.util.Securitys;
import com.net.cms.util.MD5Util;
import com.net.cms.util.StatusResponse;
import com.net.cms.vo.JSONResponse;

@Controller
@RequestMapping({ "/sysUser" })
public class SysUserController {

	@Autowired
	private SysUserService sysUserService;
	@RequestMapping( value = "/list",method = { RequestMethod.POST })
	@ResponseBody
	public JqgridResponse<SysUser> retrieve(SysUserFilter filter){
		//执行完该方法后，filter其他参数会被拦截器自动初始化
		List<SysUser> list = sysUserService.query(filter);
		//初始化jqGrid响应实体
		JqgridResponse<SysUser> response = new JqgridResponse<SysUser>(filter.getPage(),
								filter.getTotal(),filter.getRecords(),list);
		return response;
	}
	
	@RequestMapping(value = "/list",method = { RequestMethod.GET })
	public String getSinglePage(Model model){
		return "sysUser/list";
	}
	
	@RequestMapping(value = "/openmodal/assignRole", method = RequestMethod.GET)
	public ModelAndView assignRole(@RequestParam (value = "id",required = true)String id) {
		ModelAndView mav = new ModelAndView("sysUser/role");
		mav.addObject("id",id);
		return mav;
	}	
	
	@RequestMapping(value = "openmodal", method = RequestMethod.GET)
	public ModelAndView info(@RequestParam (value = "id",required = false)String id) {
		ModelAndView mav = new ModelAndView("sysUser/form");
		if (StringUtils.isNotEmpty(id)) {
			mav.addObject("sysUser", sysUserService.findSysUserById(id));
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
				sysUserService.batchDelSysUser(list);
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
					SysUser sysUser = new SysUser();
					BeanUtils.copyProperties(sysUser, jsonObj);
					if(StringUtils.contains(sysUser.getId(),Constants.JSP_ADD_FLAG)){//编号是通过页面生成的
						sysUser.setId(null);
						sysUserService.insertSysUser(sysUser);
					}else{
						sysUserService.updateSysUser(sysUser);
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
	@RequestMapping( value = "/updateUserRole", method = RequestMethod.POST )
	public @ResponseBody StatusResponse updateUserRole(@RequestParam String jsonStr) {
		Boolean result =true;
		if(StringUtils.isNotEmpty(jsonStr)){
			try {
				JSONObject jsonObj = JSONObject.fromObject(jsonStr);
				String id= jsonObj.getString("id");
				String checkedId = jsonObj.getString("checkedId");
			
				sysUserService.updateUserRole(id,checkedId);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		}
		return new StatusResponse(result);
	}
	
	

	@RequestMapping(value = "/checkLoginName",method = RequestMethod.POST)
	public @ResponseBody StatusResponse checkLoginName(@RequestParam String jsonStr){
		boolean result = false;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject json = JSONObject.fromObject(jsonStr);
			String id = json.getString("id");
			String loginName = json.getString("loginName");
			result = sysUserService.checkLoginName(id,loginName);
		}
		return new StatusResponse(result);
	}
	
	@RequestMapping(value = "/changePwd",method = { RequestMethod.GET })
	public String changeLoginPwd(){
		return "sysUser/changePwd";
	}
	
	@RequestMapping(value = { "checkConfirmOldPassword" }, method = { RequestMethod.POST })
    public @ResponseBody JSONResponse checkConfirmOldPassword(@RequestParam String jsonStr){
    	if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject json = JSONObject.fromObject(jsonStr);
			String oldPassword = json.getString("oldPassword");
			String newPassword = json.getString("newPassword");
			
			String dbPassword = sysUserService.getLoginPwdById(Securitys.getUserId());
           
			if(dbPassword.equals(MD5Util.encrypt(oldPassword))){
				sysUserService.updateLoginPwdById(newPassword,Securitys.getUserId());
				return new JSONResponse(true);
			}
    	}
    	return new JSONResponse(false, "旧密码错误");
    	
    }   
}
