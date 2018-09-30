package com.net.cms.controller;


import java.io.File;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.net.cms.constant.Constants;

@Controller
@RequestMapping("/attach")
public class AttachController {

	@RequestMapping("download")
	public void download(@RequestParam String fileName,HttpServletResponse response){
		if(StringUtils.isEmpty(fileName)){
			return;
		}
		
		OutputStream os = null;
		try{
			os =  response.getOutputStream();
			response.reset();
			response.setCharacterEncoding("utf-8");;
			response.setContentType("application/octet-stream");  
			response.setHeader("Content-Disposition", "attachment; fileName="+new String(fileName.getBytes("gbk"),"iso-8859-1"));  
	        os.write(FileUtils.readFileToByteArray(new File(Constants.UPLOAD_FLODER + fileName)));
	        os.flush();  
		}catch(IOException ex){
			
		}finally{
			if(os != null){
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
