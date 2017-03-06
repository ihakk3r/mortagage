package com.dm.servlets;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.CustomerDetails;
import com.dm.utils.DreamMortgageUtils;
import com.google.gson.Gson;

public class RestServiceClientServlet {
	
	private String chainCodeId;
	private String vip;
	static DreamMortgageUtils utils = new DreamMortgageUtils();
	
	
	public void initClient() {
		InputStream inputStream = null;
		try {
			Properties prop = new Properties();
			String propFileName = "blockchain.properties";
 
			inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
 
			if (inputStream != null) {
				prop.load(inputStream);
			} else {
				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
			}
 
			 chainCodeId = prop.getProperty("ChaincodeID");
			 vip = prop.getProperty("Vip");
			
		} catch (Exception e) {
			System.out.println("Exception: " + e);
		} finally {
			try {
				inputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public String invokeChainCode(String payLoad) throws IOException{
		
		initClient();
		
		String chainCodeResponseString = null;
		HttpURLConnection connection = null;
		BufferedReader in = null;
		OutputStreamWriter out = null;
		
		
		JSONObject jsonPayLoad = new JSONObject(payLoad);
		JSONObject paramsObject = jsonPayLoad.getJSONObject("params");
		JSONObject chaincodeIDObject = paramsObject.getJSONObject("chaincodeID");
		chaincodeIDObject.put("name", chainCodeId);
		paramsObject.put("chaincodeID", chaincodeIDObject);
		jsonPayLoad.put("params", paramsObject);
		
		try {			
		URL url = new URL(vip+"/chaincode");
		System.setProperty("https.protocols", "TLSv1,TLSv1.1,TLSv1.2");
		 connection = (HttpURLConnection)url.openConnection();
		connection.setDoOutput(true);
		connection.setRequestProperty("Content-Type", "application/json");
		connection.setConnectTimeout(10000);
		connection.setReadTimeout(5000);
		out = new OutputStreamWriter(connection.getOutputStream());
		out.write(jsonPayLoad.toString());
		out.close();
		
		in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		chainCodeResponseString=in.readLine();		
		
		
		}
		catch (Exception e) {
			System.out.println("Exception : "+e.toString());
		}
		
			finally {
			    if (in != null) {
			        try {
			        	in.close();
			        	out.close();
			        } catch (IOException e) {
			        }
			    }
			    if (connection != null) {
			    	connection.disconnect();
			   }
			}
		
		
		return chainCodeResponseString;
		
	}
	





public String invokeChainCodeAuditor() throws IOException{
	
	initClient();
	
	String chainCodeResponseString = null;
	HttpURLConnection connection = null;
	BufferedReader in = null;
	
	try {			
	URL url = new URL(vip+"/chain");
	System.setProperty("https.protocols", "TLSv1,TLSv1.1,TLSv1.2");
	 connection = (HttpURLConnection)url.openConnection();
	connection.setDoOutput(true);
	connection.setRequestProperty("Content-Type", "Application/json");
	connection.setConnectTimeout(10000);
	connection.setReadTimeout(5000);
	
	in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	chainCodeResponseString=in.readLine();		
	
	
	}
	catch (Exception e) {
		System.out.println("Exception : "+e.toString());
	}
	
		finally {
		    if (in != null) {
		        try {
		        	in.close();
		        	//out.close();
		        } catch (IOException e) {
		        }
		    }
		    if (connection != null) {
		    	connection.disconnect();
		   }
		}
	return chainCodeResponseString;
	
}


public String invokeChainCodeAuditorCustomer(String i) throws IOException {
	
	initClient();
	
	String chainCodeResponseString = null;
	HttpURLConnection connection = null;
	BufferedReader in = null;
	
	try {			
	URL url = new URL(vip+"/chain/blocks/"+i);
	System.setProperty("https.protocols", "TLSv1,TLSv1.1,TLSv1.2");
	connection = (HttpURLConnection)url.openConnection();
	connection.setDoOutput(true);
	connection.setRequestProperty("Content-Type", "Application/json");
	
	in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	chainCodeResponseString=in.readLine();		
	
	
	}
	catch (Exception e) {
		System.out.println("Exception : "+e.toString());
	}
	
		finally {
		    if (in != null) {
		        try {
		        	in.close();
		        	/*out.close();*/
		        } catch (IOException e) {
		        }
		    }
		    if (connection != null) {
		    	connection.disconnect();
		   }
		}
	
	
	return chainCodeResponseString;
	
}


}











