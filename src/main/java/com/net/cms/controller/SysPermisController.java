package com.net.cms.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.net.cms.constant.Constants;
import com.net.cms.po.SysPermis;
import com.net.cms.service.SysPermisService;
import com.net.cms.util.StatusResponse;
import com.net.cms.vo.JSONResponse;

@Controller
@RequestMapping({ "/sysPermis" })
public class SysPermisController {

	@Autowired
	private SysPermisService sysPermisService;
	
	@RequestMapping(value="getSysPermisListTree",method = { RequestMethod.POST })
	public @ResponseBody JSONResponse getSysPermisListTree(@RequestParam(required = false) String pid){
		JSONArray jsonArr=new JSONArray();
		List<SysPermis> permisList = sysPermisService.getChildNodes(pid);
		for(SysPermis permis:permisList){
			JSONObject json=new JSONObject();
			json.put("id",permis.getId());
			json.put("name", permis.getpName());
			json.put("parentId", permis.getParentId());
			json.put("parentName",permis.getParentName());
			json.put("pLevel", permis.getpLevel());
			json.put("pIndex", permis.getpIndex());
			
			if(permis.getChildCount() > 0){
				json.put("isParent", true);
			}
			jsonArr.add(json);
		}
		JSONResponse result = new JSONResponse(true);
		result.put("tree", jsonArr.toString());
		return result;
	}
	@RequestMapping(value="getRolePermisList",method = { RequestMethod.POST })
	public @ResponseBody String getRolePermisList(@RequestParam(required = false) String roleId){
		List<SysPermis> permisList = sysPermisService.getRolePermisList(roleId);
		StringBuffer treeSb=new StringBuffer("");
		if(permisList.size() > 0){
			treeSb.append("[");
			String ftStr = "{id:'%s',name:'%s',pId:'%s',open:'true',checked:'%s'}";
			int i = 0;
			for(SysPermis permis:permisList){
				if(i!=0){
					treeSb.append(",");
				}
				i++;
				treeSb.append(String.format(ftStr, permis.getId(),permis.getpName(),
						permis.getParentId(),permis.getIsChecked()));
			}
			treeSb.append("]");
		}
		return treeSb.toString();
	}
	
	@RequestMapping(value="list",method = { RequestMethod.GET })
	public String init() {
		return "sysPermis/list";
	}

	@RequestMapping(value = "getInfo", method = { RequestMethod.POST })
	public @ResponseBody JSONResponse getSysPermisInfo(@RequestParam String id) {
		try {
			SysPermis sysPermis = sysPermisService.selectByPrimaryKey(id);
			if (null != sysPermis) {
				JSONResponse result = new JSONResponse(true);
				result.put("permis", sysPermis);
				return result;
			} else {
				return new JSONResponse(false, "Id为[" + id + "]的权限不存在");
			}
		} catch (Exception e) {
			return new JSONResponse(false, "查询权限信息失败" + e.getMessage());
		}
	}

	@RequestMapping( value = "/addOrUpdate", method = RequestMethod.POST )
	public @ResponseBody StatusResponse addOrUpdate(@RequestParam String jsonStr) {
		Boolean result =true;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject jsonObj = JSONObject.fromObject(jsonStr);
			try {
					SysPermis sysPermis = new SysPermis();
					BeanUtils.copyProperties(sysPermis, jsonObj);
					if(StringUtils.contains(sysPermis.getId(),Constants.JSP_ADD_FLAG)){//编号是通过页面生成的
						sysPermis.setId(null);
						sysPermisService.insertSysPermis(sysPermis);
					}else{
						sysPermisService.updateSysPermis(sysPermis);
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
	
	@RequestMapping( value = "/delete", method = RequestMethod.POST )
	public @ResponseBody StatusResponse delete(@RequestParam String id) {
		Boolean result =true;
		if(StringUtils.isNotEmpty(id)){
			try {
				sysPermisService.deleteSysPermis(id);
			}catch (Exception e) {
				e.printStackTrace();
				result = false;
			}
		}
		return new StatusResponse(result);
	}
	

	@RequestMapping(value = "/checkPcode",method = RequestMethod.POST)
	public @ResponseBody StatusResponse checkPcode(@RequestParam String jsonStr){
		boolean result = false;
		if(StringUtils.isNotEmpty(jsonStr)){
			JSONObject json = JSONObject.fromObject(jsonStr);
			String id = json.getString("id");
			String pCode = json.getString("pCode");
			String pId = StringUtils.split(id,",")[1];
			id = StringUtils.split(id,",")[0];
			if(StringUtils.contains(id,Constants.JSP_ADD_FLAG)){//编号是通过页面生成的(新增)
				result = sysPermisService.checkPcode(null,pId,pCode);
			}else{
				result = sysPermisService.checkPcode(id,pId,pCode);
			}
		}
		return new StatusResponse(result);
	}
}
