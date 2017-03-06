	package com.dm.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.CustomerDetails;
import com.dm.utils.DreamMortgageUtils;
import com.google.gson.Gson;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CityCouncilServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		RestServiceClientServlet client = new RestServiceClientServlet();
		if( req.getParameter("mortagaePropertyAddress")!=null  && req.getParameter("mortagaePropertyAddress")!=""){
		List<CustomerDetails> customerDetails = new ArrayList<CustomerDetails>();
		String payLoad="{\"jsonrpc\": \"2.0\",\"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\":\"6e96be66c2c7db053f45ec57174783dd1ecf3d3009d8418016919a251d1180b8274be187377996eff2f0e90f2d7523cccf39173464fcbe6c337fff8caeea3be8\"},\"ctorMsg\": {\"function\": \"retrieve_mortgages\"},\"secureContext\": \"admin\"},\"id\": 0}";
		String chainCodeResponse = null;
		try {
		chainCodeResponse = client.invokeChainCode(payLoad);
		} catch (IOException e) {
		e.printStackTrace();
		}
		JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
		JSONObject chainCodeReponseJsonResult= chainCodeReponseJson.getJSONObject("result");
		String customerData = chainCodeReponseJsonResult.get("message").toString();
		JSONArray customerDataArray = new JSONArray(customerData);							
		for (int iterator = 0; iterator < customerDataArray.length(); iterator++) {
			JSONObject eachCustomerDetailsString = customerDataArray.getJSONObject(iterator);
			CustomerDetails customerDetailsObj = new Gson().fromJson(eachCustomerDetailsString.toString(), CustomerDetails.class);
			String address=customerDetailsObj.getMortgagePropertyAddress();
			
			if(address.matches("(?i:.*"+req.getParameter("mortagaePropertyAddress").trim()+".*)"))
			{
				customerDetails.add(customerDetailsObj);
				}
		} 
		if(customerDetails.size()<1)
		{
		req.setAttribute("errorMsg", "Sorry! No data available for your query");
		}
		req.setAttribute("customersDetails", customerDetails);
		}
		dispatcher = req.getRequestDispatcher("/cityCouncilSelect.jsp");
		dispatcher.forward(req, resp);
}
	}
