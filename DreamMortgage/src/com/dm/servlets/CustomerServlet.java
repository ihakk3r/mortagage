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

public class CustomerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RequestDispatcher dispatcher = null;
		String role = "Customer";
		String action = req.getParameter("action");
		RestServiceClientServlet client = new RestServiceClientServlet();
		DreamMortgageUtils utils = new DreamMortgageUtils();
	
		if (action.equals("get")) {
			//This module retrieves a single mortgage application based on input of mortgage Number
			String customerSelect = req.getParameter("customerSelect");
			int mortgageNumber = Integer.parseInt(customerSelect.substring(customerSelect.indexOf("-") + 1));
			CustomerDetails customerDetails =  utils.getCustomerDetails(mortgageNumber);

			req.setAttribute("customerName", customerDetails.getCustomerName());
			req.setAttribute("customerAddress", customerDetails.getCustomerAddress());
			req.setAttribute("customerSSN", customerDetails.getCustomerSSN());
			req.setAttribute("customerDOB", customerDetails.getCustomerDOB());
			req.setAttribute("loanAmount", customerDetails.getReqLoanAmount());
			req.setAttribute("grantedloanAmount", customerDetails.getGrantedLoanAmount());
			req.setAttribute("mPAdress", customerDetails.getMortgagePropertyAddress());
			req.setAttribute("mrtgageStage", customerDetails.getMortgageStage());
			req.setAttribute("mrtgageType", customerDetails.getMortgageType());
			req.setAttribute("mrtgageDate", customerDetails.getMortgageStartDate());
			req.setAttribute("mrtgageDuration", customerDetails.getMortgageDuration());
			req.setAttribute("mrtgageNumber", customerDetails.getMortgageNumber());
			req.setAttribute("mrtgageOwnership", customerDetails.getMortgagePropertyOwnership());
			
			
			// Need to write conditional readonly here
			req.setAttribute("readonly", "readonly");
			req.setAttribute("disabled", "disabled");
			req.setAttribute("customerStatus", "existing");
			req.setAttribute("mrtgageStatus", "existing");
			// Need to write conditional readonly above

			dispatcher = req.getRequestDispatcher("/newcustomer.jsp");

		} else if(action.equals("put")) {
		    //This module creates a single mortgage application based on inputs of a customer
			String customerStatus = req.getParameter("customerStatus");
			
			if (customerStatus.equals("new")) // Inserting new customer data
												// into JSON blockchain
			{
				String customerName = req.getParameter("customerName");
				String customerAddress = req.getParameter("customerAddress");
				int customerSSN = Integer.parseInt(req.getParameter("customerSSN"));
				String customerDOB = req.getParameter("customerDOB");
				int loanAmount = Integer.parseInt(req.getParameter("loanAmount"));
				String mPAdress = req.getParameter("mPAdress");
				String mrtgageStage = req.getParameter("mrtgageStage");
				String mrtgageType = req.getParameter("mrtgageType");
				String mrtgageDate = req.getParameter("mrtgageDate");
				int mrtgageDuration = Integer.parseInt(req.getParameter("mrtgageDuration"));
				mrtgageDuration = mrtgageDuration * 365;

				String payLoad = "{\"jsonrpc\": \"2.0\",\"method\": \"invoke\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"create_mortgage_application\",\"args\":[\"{\\\"CustomerName\\\":\\\""
						+ customerName + "\\\",\\\"ModifiedBy\\\":\\\"" + role + "\\\",\\\"CustomerAddress\\\":\\\""
						+ customerAddress + "\\\",\\\"CustomerSSN\\\":" + customerSSN + ",\\\"CustomerDOB\\\":\\\""
						+ customerDOB + "\\\",\\\"ReqLoanAmount\\\":" + loanAmount
						+ ",\\\"MortgagePropertyAddress\\\":\\\"" + mPAdress + "\\\",\\\"MortgageType\\\":\\\""
						+ mrtgageType + "\\\",\\\"MortgageStartDate\\\":\\\"" + mrtgageDate
						+ "\\\",\\\"MortgageDuration\\\":" + mrtgageDuration
						+ "}\"]},\"secureContext\": \"admin\" }, \"id\": 0 }";

				// New Customer dummy data below

				// String payLoad = "{\"jsonrpc\": \"2.0\",\"method\":
				// \"invoke\", \"params\": {\"type\": 1, \"chaincodeID\": {
				// \"name\": \"\"},\"ctorMsg\": {\"function\":
				// \"create_mortgage_application\",\"args\":[\"{\\\"CustomerName\\\":\\\"Vishal
				// Patil\\\",\\\"ModifiedBy\\\":\\\"customer\\\",\\\"CustomerAddress\\\":\\\"Flat
				// No.503\\\",\\\"CustomerSSN\\\":874845666,\\\"CustomerDOB\\\":\\\"03/05/1992\\\",\\\"ReqLoanAmount\\\":10000,\\\"MortgagePropertyAddress\\\":\\\"Bloomington\\\",\\\"MortgageType\\\":\\\"FIXED\\\",\\\"MortgageStartDate\\\":\\\"03/02/2017\\\",\\\"MortgageDuration\\\":20}\"]},\"secureContext\":
				// \"admin\" }, \"id\": 0 }";

				
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				String status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

				req.setAttribute("customerName", customerName);
				req.setAttribute("customerAddress", customerAddress);
				req.setAttribute("customerSSN", customerSSN);
				req.setAttribute("customerDOB", customerDOB);
				req.setAttribute("loanAmount", loanAmount);
				req.setAttribute("mPAdress", mPAdress);
				req.setAttribute("mrtgageStage", mrtgageStage);
				req.setAttribute("mrtgageType", mrtgageType);
				req.setAttribute("mrtgageDate", mrtgageDate);
				req.setAttribute("mrtgageDuration", mrtgageDuration);
				

				req.setAttribute("readonly", "readonly");
				req.setAttribute("disabled", "disabled");
				req.setAttribute("customerStatus", "existing");
				req.setAttribute("mrtgageStatus", "created");
				
				if (status.equals("OK"))
					req.setAttribute("successMsg",
							"You've applied for mortgagee succesfully! You can come back at any time and update your details here.");
				else
					req.setAttribute("failureMsg", "Error! You can come back at any time and update your details here.");

				dispatcher = req.getRequestDispatcher("/newcustomer.jsp");
			}
		

			else if (customerStatus.equals("existing")) { 
				
				//This module retrieves a updates a mortgage application based on input of mortgage Number
				String customerName = req.getParameter("customerName");
				String customerAddress = req.getParameter("customerAddress");
				int mortgageNumber = Integer.parseInt(req.getParameter("mortgageNumber"));
		
				CustomerDetails customerData = utils.getCustomerDetails(mortgageNumber);
				boolean anyChange = false;
				String payLoadParameters = "";
				String status = "";
				if (!customerName.equals(customerData.getCustomerName())) {
					payLoadParameters += ",\\\"CustomerName\\\" : \\\"" + customerName + "\\\"";
					anyChange = true;
				}
				if (!customerAddress.equals(customerData.getCustomerAddress())) {
					payLoadParameters += ",\\\"CustomerAddress\\\" : \\\"" + customerAddress + "\\\"";
					anyChange = true;
				}
				// payLoadParameters += ",\\\"RemainingMortgageAmount\\\" : 20000";
				if(anyChange){
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageStage\\\":\\\"Pending-Bank:\\\",\\\"MortgageNumber\\\":"
						+ mortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role + "\\\"" + payLoadParameters
						+ "}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";

				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

				try {
					Thread.sleep(3000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				if (status.equals("OK"))
					req.setAttribute("successMsg", "Data updated succesfully for Mortgage Number: " + mortgageNumber);
				else
					req.setAttribute("failureMsg", "Error! Please come back and try again later");
				
				}
				else
					req.setAttribute("failureMsg", "No changes made to the form, To update please edit the details and submit the form.");
				
				CustomerDetails customerDetails = utils.getCustomerDetails(mortgageNumber);
				
				req.setAttribute("customerName", customerDetails.getCustomerName());
				req.setAttribute("customerAddress", customerDetails.getCustomerAddress());
				req.setAttribute("customerSSN", customerDetails.getCustomerSSN());
				req.setAttribute("customerDOB", customerDetails.getCustomerDOB());
				req.setAttribute("loanAmount", customerDetails.getReqLoanAmount());
				req.setAttribute("mPAdress", customerDetails.getMortgagePropertyAddress());
				req.setAttribute("mrtgageStage", customerDetails.getMortgageStage());
				req.setAttribute("mrtgageType", customerDetails.getMortgageType());
				req.setAttribute("mrtgageDate", customerDetails.getMortgageStartDate());
				req.setAttribute("mrtgageDuration", customerDetails.getMortgageDuration());
				req.setAttribute("mrtgageNumber", customerDetails.getMortgageNumber());
				req.setAttribute("mrtgageOwnership", customerDetails.getMortgagePropertyOwnership());
				
				
				// Need to write conditional readonly here
				req.setAttribute("readonly", "readonly");
				req.setAttribute("disabled", "disabled");
				req.setAttribute("customerStatus", "existing");
				// Need to write conditional readonly above
				
				dispatcher = req.getRequestDispatcher("/newcustomer.jsp");

			}
			
		}

			else if(action.equals("getAll")){
				
				//This module retrieves all mortgage applications

				List<String> customersData = new ArrayList<String>();

				String payLoad = "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgage_portfolio\"},\"secureContext\": \"admin\"},\"id\": 0}";

				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				String allCustomersData = chainCodeReponseJson.getJSONObject("result").get("message").toString();
				JSONObject chainCodeReponseJsonResult = new JSONObject(allCustomersData);
				String tempMortgageObject = chainCodeReponseJsonResult.get("MortgageNumbers").toString();
				System.out.println();
				if (!tempMortgageObject.equals("null")) {
					JSONArray allCustomersMortgageNumbers = (JSONArray) chainCodeReponseJsonResult
							.get("MortgageNumbers");
					JSONArray allCustomersCustomerNames = (JSONArray) chainCodeReponseJsonResult.get("CustomerNames");

					for (int iterator = 0; iterator < allCustomersMortgageNumbers.length(); iterator++) {
						String customerName = allCustomersCustomerNames.getString(iterator);
						int mortgageNumber = allCustomersMortgageNumbers.getInt(iterator);

						String customerName_mortgageNumber = customerName + "-" + mortgageNumber;
						customersData.add(customerName_mortgageNumber);

					}
					req.setAttribute("customersData", customersData);
				} else {
					req.setAttribute("failureMsg"
							+ "", "Sorry! No data available for your query");
				}

				dispatcher = req.getRequestDispatcher("/existingcustomer.jsp");
			}
		
			else
			{
				//Default error message displayed for invalid action parameters
				req.setAttribute("errorMsg", "Error! Invalid query");
				dispatcher = req.getRequestDispatcher("/existingcustomer.jsp");
			}

		
		dispatcher.forward(req, resp);
	}
	
	

}
