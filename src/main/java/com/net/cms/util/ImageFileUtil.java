
package com.net.cms.util;


import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import sun.misc.BASE64Encoder;

/**
 * 绝对路径复制web路径
 * @author xiaoyang
 *
 */
public class ImageFileUtil {

	
	/**
	 * 
	 * @param imgUrl 绝对路径
	 * @param fileName 文件名
	 * @return url
	 */
	public static String getImageUrl(String imgUrl, String fileName){
		String url="images/"+fileName;
		String webPath =  getWebImageUrl()+"images"; //web路径
		String path = imgUrl+fileName; //绝对路径
		File directory = new File(webPath); //判断目录是否存在 
		if(!directory.exists() && !directory.isDirectory()){
			directory.mkdir(); //不存在 创建目录
		}
		
		if(!isFileExists(webPath,fileName)){ //没有文件则从绝对路径复制过去
			String sourceUrl =path; //绝对路径原文件
			String targetUrl = webPath+"/"+fileName;
//			copyFile(sourceUrl, targetUrl);
			
			int width = 600; 
			int height = 800;
			setImage(sourceUrl, targetUrl, width, height);
		}

		return url;
	}

	/**
	 * 获取web 路径
	 * @return webPath
	 */
	private static String  getWebImageUrl(){
		String webPath="";
		URL url = ImageFileUtil.class.getResource("/");
		webPath = (url.toString()).substring(6,(url.toString()).lastIndexOf("WEB-INF"));
		return webPath;
	}
	
	/**
	 * 判断文件是否存在 
	 * @param webPath
	 * @param fileName
	 * @return isExists
	 */
	public static boolean isFileExists(String webPath, String fileName){
		boolean isExists = false;
		String path = webPath+"/"+fileName;
		File file = new File(path);
		if(file.exists()){ //文件存在返回true
			isExists = true;
		}
		return isExists;
	}
	
	/**
	 * 复制文件
	 * @param sourceUrl
	 * @param targetUrl
	 */
	
	public static void copyFile(String sourceUrl, String targetUrl){
		BufferedInputStream in = null;  //输入流
		BufferedOutputStream out = null; //输出流
		File sourceFile =  new File(sourceUrl);
		File targetFile = new File(targetUrl);
		try{
			if(sourceFile.exists()){ //目标文件存在进行复制
				//新建原文件输入流
				in = new BufferedInputStream(new FileInputStream(sourceFile));
				//新建目标文件输出流
				out = new BufferedOutputStream(new FileOutputStream(targetFile));
		
			
	            byte[] b = new byte[1024 * 5];
	            int len;
	            while ((len = in.read(b)) != -1) {
					out.write(b, 0, len);
				}
				
	            out.flush();
			}
			}catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(in != null){
				try {
					in.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(out != null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}
	/**
	 * 处理后保存图片 
	 * @param sourceUrl //源文件路径
	 * @param targetUrl //目标文件路径
	 * @param width //宽度
	 * @param height //高度
	 */
	public static void setImage(String sourceUrl, String targetUrl,int width, int height){
		ImageZoom zoom = new ImageZoom();
        BufferedImage sourceImage;
        BufferedImage targetImage;
		try {
			sourceImage = ImageIO.read(new File(sourceUrl));
			targetImage = zoom.imageZoomOut(sourceImage, width, height, true);
	        FileOutputStream out = new FileOutputStream(targetUrl);
	        ImageIO.write(targetImage, "jpeg", out);
	
		} catch (IOException e) {
			
			e.printStackTrace();
		} 
    
	}
	
	
	public static  String getIconBase64(File file) throws FileNotFoundException,IOException{
		FileInputStream fis = new FileInputStream(file);
		byte[] buffer = new byte[(int)file.length()];
		fis.read(buffer);
		return new BASE64Encoder().encode(buffer);
	}
	public static  String getIconBase64(CommonsMultipartFile file) throws FileNotFoundException,IOException{
		InputStream fis = file.getInputStream();
		byte[] buffer = new byte[(int)file.getSize()];
		fis.read(buffer);
		return new BASE64Encoder().encode(buffer);
	}
	public static void main(String args[]){
		//System.out.println(ImageFileUrl.getWebImageUrl());
	}
}
