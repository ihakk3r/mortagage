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

public class ServiceProviderServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		RestServiceClientServlet client = new RestServiceClientServlet();  //Object for accessing blockchain and this includes common methods
		String customerDetails = req.getParameter("customerSelect");
		String role = "Data Service Provider";
		String action = req.getParameter("action");
		DreamMortgageUtils utils = new DreamMortgageUtils();
		
		if(action.equals("get")){
			/* This module is for retrieving a single mortagage application data */
			
			int mortgageNumber = Integer.parseInt(customerDetails.substring(customerDetails.indexOf("-")+1));					
			CustomerDetails customerData = utils.getCustomerDetails(mortgageNumber);		
			req.setAttribute("customerDetails", customerData);
			dispatcher = req.getRequestDispatcher("/serviceProviderCustomer.jsp");
			
		}
		else if(action.equals("put")){
			/* This module is for modifying a mortagage application data */
				
				int pValuation = Integer.parseInt(req.getParameter("pValuation"));
				int creditScore =Integer.parseInt(req.getParameter("creditScore"));
				int fNetworth = Integer.parseInt(req.getParameter("fNetworth"));			
				int mortgageNumber = Integer.parseInt(req.getParameter("mortgageNumber"));
				
				CustomerDetails customerData = utils.getCustomerDetails(mortgageNumber);
				boolean anyChange = false;
				String payLoadParameters = "";
				
						
					if((Integer)customerData.getPropertyValuation()!=pValuation){
						payLoadParameters+=",\\\"PropertyValuation\\\" :"+pValuation;
						anyChange = true;
					}
					if((Integer)customerData.getCreditScore()!=creditScore){
						payLoadParameters+=",\\\"CreditScore\\\" :"+creditScore;
						anyChange = true;
					}
					if((Integer)customerData.getFinancialWorth()!=fNetworth){
						payLoadParameters+=",\\\"FinancialWorth\\\" :"+fNetworth;
						anyChange = true;
					}
					
				
				
				if(anyChange){
				
			    String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"+mortgageNumber+",\\\"ModifiedBy\\\":\\\""+role+"\\\""+payLoadParameters+"}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";							
				String chainCodeResponse = client.invokeChainCode(payLoad);
				
				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				String status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

				if(status.equals("OK"))	
					req.setAttribute("successMsg", "Data updated succesfully for Mortgage Number: "+mortgageNumber);
				else
					req.setAttribute("failureMsg", "Error! Please come back and try again later");
					
						
				}
				else{
					req.setAttribute("failureMsg", "No changes made to the form, To update please edit the details and submit the form.");
					
				}
				
				try {
					Thread.sleep(3000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				customerData = utils.getCustomerDetails(mortgageNumber);
				
				req.setAttribute("customerDetails", customerData);
		
				dispatcher = req.getRequestDispatcher("/serviceProviderCustomer.jsp");

			
	    }
		
		else if(action.equals("getAll")){
			/* This module is for retrieving all mortgage applications */
			
			List<String> customersData = new ArrayList<String>();
			
			String payLoad =  "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgage_portfolio\"},\"secureContext\": \"admin\"},\"id\": 0}";
			String chainCodeResponse = client.invokeChainCode(payLoad);

			JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
			String allCustomersData = chainCodeReponseJson.getJSONObject("result").get("message").toString();
			JSONObject chainCodeReponseJsonResult = new JSONObject(allCustomersData);
			
			String tempMortgageObject = chainCodeReponseJsonResult.get("MortgageNumbers").toString();				
					if (!tempMortgageObject.equals("null")) {

						JSONArray allCustomersMortgageNumbers = (JSONArray) chainCodeReponseJsonResult
								.get("MortgageNumbers");
						JSONArray allCustomersCustomerNames = (JSONArray) chainCodeReponseJsonResult.get("CustomerNames");

						for (int iterator = 0; iterator < allCustomersMortgageNumbers.length(); iterator++) {

							String customerName_mortgageNumber = allCustomersCustomerNames.getString(iterator) + "-"
									+ allCustomersMortgageNumbers.getInt(iterator);
							customersData.add(customerName_mortgageNumber);

						}
						if(customersData.size()!=0)
							req.setAttribute("customersData", customersData);
						else
							req.setAttribute("errorMsg", "Sorry! No data available for your query");
					}
					else
						req.setAttribute("errorMsg", "Sorry! No data available for your query");
					
					dispatcher = req.getRequestDispatcher("/serviceProviderSelect.jsp");			
			
		}
		
		else
		{
			//Default error message displayed for invalid action parameters
			req.setAttribute("errorMsg", "Error! Invalid query");
			dispatcher = req.getRequestDispatcher("/serviceProviderSelect.jsp");
		}
		
		dispatcher.forward(req, resp);
	
}
	
}
