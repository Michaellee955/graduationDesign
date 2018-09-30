import java.io.BufferedReader;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.commons.lang3.StringUtils;


public class Test {
	
	public static void main(String[] args) {
		//System.out.println("\\u82F1");
		//ping ip
		//getPingUrlStatus("http://192.168.0.147:8019/rmpcenter?commandid=1&uuid=0a900jx90000000000000&collterminal_id=SHICBC_CddOLL001&pingip=192.168.0.4");
		//ping url
		//getPingUrlStatus("http://192.168.0.147:8019/rmpcenter?commandid=1&uuid=0a900jx9000000000000220&collterminal_id=SHICBC_COLL001&testurl=http://192.168.0.147");
		// 3-	调整设备 4-	调整数据项
		//System.out.println(getPingUrlStatus("http://1s92.168.0.147:8019/rmpcenter?commandid=3"));
		String arr[] = StringUtils.split(",1,2,3,4", ",");
		System.out.println(arr);
	}
	
	private static int getPingUrlStatus(String urlStr){
		BufferedReader in = null;
		int status = 500;
		try {
			URL url = new URL(urlStr);
			HttpURLConnection  urlConn = (HttpURLConnection)url.openConnection();
			urlConn.setConnectTimeout(3000);
			urlConn.connect();
			status = urlConn.getResponseCode();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(in != null){
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return status;
	}
}
