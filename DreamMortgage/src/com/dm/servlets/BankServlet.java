package com.dm.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.CustomerDetails;
import com.dm.utils.DreamMortgageUtils;

public class BankServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BankServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = null;
		DreamMortgageUtils utils = new DreamMortgageUtils();
		String role = "Lending Bank";
		String action = request.getParameter("action");
		RestServiceClientServlet client = new RestServiceClientServlet();

		if (action.equals("get")) {
		//This module retrieves a single mortgage application from blockchain json
			String customerSelect = request.getParameter("customerSelect");
			String type= request.getParameter("type");

			int mortgageNumber = Integer.parseInt(customerSelect.substring(customerSelect.indexOf("-") + 1));
			CustomerDetails customerDetails = utils.getCustomerDetails(mortgageNumber);

			String mortgageStage = customerDetails.getMortgageStage();
			
			// Write and readonly conditions go here
			
			 if(mortgageStage.contains("Disbursed:")){
				request.setAttribute("makeDisbursedFieldsReadonly", "readonly");
				request.setAttribute("makeDisbursedSelectDisabled", "disabled");
			}
			
			
			request.setAttribute("customerDetails", customerDetails);
				
				if(type.equals("mortgages"))	
						dispatcher = request.getRequestDispatcher("/bankCustomerDetails.jsp");
				if(type.equals("monthlyservice"))
					dispatcher = request.getRequestDispatcher("/bankMonthlyMServicing.jsp");
		}

		else if (action.equals("put")) {
			//This module modifies a mortagage application based on mortgage number and other inputs
			String actionType = request.getParameter("type");
			int currentmortgageNumber = Integer.parseInt(request.getParameter("mrtgageNumber"));
			CustomerDetails customerDetails = utils.getCustomerDetails(currentmortgageNumber);

			String mortgageStage = customerDetails.getMortgageStage();
			
			boolean anyChange = false;
			
			/* Building the mortgageStage based on the put action 'type' parameter. */
			if (actionType.equals("additional")){
				anyChange = true;
				mortgageStage = "Pending-Customer:";
			}
			else if (actionType.equals("approve")){
				anyChange = true;
				mortgageStage = "Approved:";
			}
			else if (actionType.equals("deny")){
				anyChange = true;
				mortgageStage = "Denied:";
			}
			// mortgageStage = "Disbursed:Ready to Purchase"; --Used as
			// hardcoded data when inserting customer data manually
			int gloanAmount = 0;
			double rateOfInterest = 0.0;
			int mrtgageDuration = 0;
			int mortgageNumber = 0;
			int ownershipCost =0;
			
			
			String mPAdress = request.getParameter("mPAdress");
			String mrtgageStartDate = request.getParameter("mrtgageStartDate");
			
			if(request.getParameter("gloanAmount")!=null)
				gloanAmount = Integer.parseInt(request.getParameter("gloanAmount"));
			if(request.getParameter("rateOfInterest")!=null)
				rateOfInterest = Double.parseDouble(request.getParameter("rateOfInterest"));
			if(request.getParameter("mrtgageDuration")!=null)
				mrtgageDuration = Integer.parseInt(request.getParameter("mrtgageDuration"));
			if(request.getParameter("mrtgageNumber")!=null)
				mortgageNumber = Integer.parseInt(request.getParameter("mrtgageNumber"));
			if(request.getParameter("ownershipCost")!=null)
				ownershipCost = Integer.parseInt(request.getParameter("ownershipCost"));

			CustomerDetails customerData = utils.getCustomerDetails(mortgageNumber);
			String payLoadParameters = "";
			String currentMrtgageStage = customerData.getMortgageStage();
			
			if(actionType.equals("approve")||actionType.equals("update")){
			
	
				if (!mPAdress.equals(customerData.getMortgagePropertyAddress())) {
					payLoadParameters += ",\\\"MortgagePropertyAddress\\\" : \\\"" + mPAdress + "\\\"";
					anyChange = true;
				}
				
				if(!currentMrtgageStage.contains("Disbursed:")){
							
				
					if (ownershipCost!=customerData.getOwnershipcost()) {
						payLoadParameters += ",\\\"Ownershipcost\\\" :" + ownershipCost;
						anyChange = true;
					}
				
			
					
					if ((Integer) customerData.getGrantedLoanAmount() != gloanAmount) {
						payLoadParameters += ",\\\"GrantedLoanAmount\\\" :" + gloanAmount;
						anyChange = true;
					}
					if ((Double) customerData.getRateofInterest() != rateOfInterest) {
						payLoadParameters += ",\\\"RateofInterest\\\" :" + rateOfInterest;
						anyChange = true;
					}
		
					if ((Integer) customerData.getMortgageDuration() != mrtgageDuration) {
						payLoadParameters += ",\\\"MortgageDuration\\\" :" + mrtgageDuration;
						anyChange = true;
					}
						if (!mrtgageStartDate.equals(customerData.getMortgageStartDate())) {
						payLoadParameters += ",\\\"MortgageStartDate\\\" : \\\"" + mrtgageStartDate + "\\\"";
						anyChange = true;
					}
	
				}
				
			}
			if (anyChange) {

				payLoadParameters += ",\\\"MortgageStage\\\" : \\\"" + mortgageStage + "\\\"";
				
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ mortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role + "\\\"" + payLoadParameters
						+ "}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				String status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

				if (status.equals("OK"))
					request.setAttribute("successMsg",
							"Data updated succesfully for Mortgage Number: " + mortgageNumber);
				else
					request.setAttribute("failureMsg", "Error! Please come back and try again later");

			} else {
				request.setAttribute("errorMsg",
						"No changes made to the form, To update please edit the details and submit the form.");

			}

			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			customerData = utils.getCustomerDetails(mortgageNumber);

			request.setAttribute("customerDetails", customerData);
			
			if(customerData.getMortgageStage().contains("Disbursed:")){
				request.setAttribute("makeDisbursedFieldsReadonly", "readonly");
				request.setAttribute("makeDisbursedSelectDisabled", "disabled");
			}
			
			dispatcher = request.getRequestDispatcher("/bankCustomerDetails.jsp");

		} else if (action.equals("getAll")) {
			
			// This module retrieves all mortgage applications with "Pending-Bank:" , "Pending-Customer" , and "Approved:" mortageStages.
			List<String> customersData = new ArrayList<String>();

			String payLoad = "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgage_portfolio\"},\"secureContext\": \"admin\"},\"id\": 0}";

			String chainCodeResponse = client.invokeChainCode(payLoad);

			JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
			String allCustomersData = chainCodeReponseJson.getJSONObject("result").get("message").toString();
			JSONObject chainCodeReponseJsonResult = new JSONObject(allCustomersData);

			String tempMortgageObject = chainCodeReponseJsonResult.get("MortgageNumbers").toString();
			if (!tempMortgageObject.equals("null")) {

				JSONArray allCustomersMortgageNumbers = (JSONArray) chainCodeReponseJsonResult.get("MortgageNumbers");
				JSONArray allCustomersCustomerNames = (JSONArray) chainCodeReponseJsonResult.get("CustomerNames");
				JSONArray allMortgageStages = (JSONArray) chainCodeReponseJsonResult.get("MortgageStages");

				for (int iterator = 0; iterator < allCustomersMortgageNumbers.length(); iterator++) {
					String customerName = allCustomersCustomerNames.getString(iterator);
					int mortgageNumber = allCustomersMortgageNumbers.getInt(iterator);
					String mortgageStage = allMortgageStages.getString(iterator);

					if ((customerName != null) && (mortgageStage.contains("Pending-Bank")
							|| mortgageStage.equals("Pending-Customer:") || mortgageStage.equals("Approved:"))) {

						String customerName_mortgageNumber = customerName + "-" + mortgageNumber;
						customersData.add(customerName_mortgageNumber);
					}
				}
				if (customersData.size() != 0)
					request.setAttribute("customersData", customersData);
				else
					request.setAttribute("errorMsg", "Sorry! No data available for your query");
				dispatcher = request.getRequestDispatcher("/bankSelectCustomer.jsp");
			} else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
		}

		else if (action.equals("getGse")) {
			// This module retrieves all mortgage applications with "Disbursed:Ready to Purchase" mortageStage.
			
			List<CustomerDetails> gseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Purchase",false,false);
	
			if (gseCustomerList.size() != 0)
				request.setAttribute("gseCustomerList", gseCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/bankGseApprovals.jsp");

		} else if (action.equals("sellGSE")) {
			//This module writes ownership cost for a individual mortgage
			String status = "";
			String[] selectCustomerMortgageNumbers = request.getParameterValues("customer");
			int discountPercentage = Integer.parseInt(request.getParameter("discountPercentage"));

			for (String eachGseMortgage : selectCustomerMortgageNumbers) {
				int eachGseMortgageNumber = Integer.parseInt(eachGseMortgage);
				CustomerDetails customerDetails = utils.getCustomerDetails(Integer.parseInt(eachGseMortgage));
				int ownershipCost = (customerDetails.getRemainingMortgageAmount() * (100 - discountPercentage)) / 100;
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ eachGseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role + "\\\",\\\"Ownershipcost\\\":"
						+ ownershipCost + "}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

			}
			
			if (status.equals("OK")){
				
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				request.setAttribute("successMsg", "GSE Request approved successfully.");
				
				List<CustomerDetails> gseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Purchase",false,false);
				
				if (gseCustomerList.size() != 0)
					request.setAttribute("gseCustomerList", gseCustomerList);
			
			}
			else
				request.setAttribute("failureMsg", "Error! Please come back and try again later.");
			dispatcher = request.getRequestDispatcher("/bankGseApprovals.jsp");
			
			
		} else if (action.equals("getAuction")) {
			// This module retrieves all mortgage applications with "Disbursed:" mortageStage.
			
			List<CustomerDetails> sortedAuctionCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:",false,false);			

			if (sortedAuctionCustomerList.size() != 0)
				request.setAttribute("auctionCustomerList", sortedAuctionCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/bankAuctionMortgages.jsp");

		}

		else if (action.equals("auction")) {

			// This module posts a mortgage for sale with by modyfying mortgageStage as "Disbursed:Ready to Sell" in blockchain JSON.
			
			String status = "";
			String[] selectCustomerMortgageNumbers = request.getParameterValues("customer");

			for (String eachAuctionMortgage : selectCustomerMortgageNumbers) {
				int eachGseMortgageNumber = Integer.parseInt(eachAuctionMortgage);
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ eachGseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role
						+ "\\\",\\\"MortgageStage\\\":\\\"Disbursed:Ready to Sell\\\"}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

			}
			if (status.equals("OK")){
				
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				List<CustomerDetails> sortedAuctionCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:",false,false);			
				request.setAttribute("successMsg", "Auction updated successfully.");
				
				if (sortedAuctionCustomerList.size() != 0){
					request.setAttribute("auctionCustomerList", sortedAuctionCustomerList);
				}
				
				
			}
			else
				request.setAttribute("failureMsg", "Error! Please come back and try again later.");
			dispatcher = request.getRequestDispatcher("/bankAuctionMortgages.jsp");

		} else if (action.equals("reviewAuction")) {

			// This module get all mortgages with mortgageStage as "Disbursed:Ready to Sell" in blockchain JSON.
			
		List<CustomerDetails> sortedReviewCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Sell",false,false);

			if (sortedReviewCustomerList.size()!=0)
				request.setAttribute("reviewAuctionCustomerList", sortedReviewCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/bankReviewAuction.jsp");

		}


		else if (action.equals("reviewSell")) {
			//This module reviews the sell auction and writes ownership cost to blockchain JSON
			
			String status = "";		
			String[] selectCustomerMortgageNumbers = request.getParameterValues("customer");
			int discountPercentage = Integer.parseInt(request.getParameter("discountPercentage"));

			for (String eachGseMortgage : selectCustomerMortgageNumbers) {
				int eachGseMortgageNumber = Integer.parseInt(eachGseMortgage);
				CustomerDetails customerDetails = utils.getCustomerDetails(Integer.parseInt(eachGseMortgage));
				int ownershipCost = (customerDetails.getRemainingMortgageAmount() * (100 - discountPercentage)) / 100;
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ eachGseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role + "\\\",\\\"Ownershipcost\\\":"
						+ ownershipCost + "}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

			}
			if (status.equals("OK")){
				
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				List<CustomerDetails> sortedReviewCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Sell",false,false);
				request.setAttribute("successMsg", "Auction updated successfully.");
				if (sortedReviewCustomerList.size()!=0){

					request.setAttribute("reviewAuctionCustomerList", sortedReviewCustomerList);
				}

			}
			else
				request.setAttribute("failureMsg", "Error! Please come back and try again later.");

			dispatcher = request.getRequestDispatcher("/bankReviewAuction.jsp");

		} else if (action.equals("closeAuction")) {

			//This module closes the auction and changes mortgageStage to "Disbursed:"
			String type = request.getParameter("type");
			String status = "";
			String[] selectCustomerMortgageNumbers = request.getParameterValues("customer");

			for (String eachCloseAuctionMortgage : selectCustomerMortgageNumbers) {
				int eachGseMortgageNumber = Integer.parseInt(eachCloseAuctionMortgage);
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ eachGseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role
						+ "\\\",\\\"MortgageStage\\\":\\\"Disbursed:\\\"}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

			}
			List<CustomerDetails> requestPurchaseCustomerList = new ArrayList<CustomerDetails>();
			if (status.equals("OK")){
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(type.equals("purchase")){
				requestPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Request to Purchase",false,false);
				}
				else
				{
					requestPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Sell",false,false);				
				}
				request.setAttribute("successMsg", "Auction closed successfully.");
				
			}
			else
				request.setAttribute("failureMsg", "Error! Please come back and try again later.");
			
			
			if(type.equals("purchase")){
				if (requestPurchaseCustomerList.size() != 0)
					request.setAttribute("requestPurchaseCustomerList", requestPurchaseCustomerList);	
				
				dispatcher = request.getRequestDispatcher("/bankApproveAuction.jsp");
			}
			else{
				if (requestPurchaseCustomerList.size() != 0)
					request.setAttribute("reviewAuctionCustomerList", requestPurchaseCustomerList);	
				
				dispatcher = request.getRequestDispatcher("/bankReviewAuction.jsp");
			}

		}
		else if(action.equals("getDisbursed")){
			
			// This module retrieves all mortgage applications with "Pending-Bank:" , "Pending-Customer" , and "Approved:" mortageStages.
						List<String> customersData = new ArrayList<String>();

						String payLoad = "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgage_portfolio\"},\"secureContext\": \"admin\"},\"id\": 0}";

						String chainCodeResponse = client.invokeChainCode(payLoad);

						JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
						String allCustomersData = chainCodeReponseJson.getJSONObject("result").get("message").toString();
						JSONObject chainCodeReponseJsonResult = new JSONObject(allCustomersData);

						String tempMortgageObject = chainCodeReponseJsonResult.get("MortgageNumbers").toString();
						if (!tempMortgageObject.equals("null")) {

							JSONArray allCustomersMortgageNumbers = (JSONArray) chainCodeReponseJsonResult.get("MortgageNumbers");
							JSONArray allCustomersCustomerNames = (JSONArray) chainCodeReponseJsonResult.get("CustomerNames");
							JSONArray allMortgageStages = (JSONArray) chainCodeReponseJsonResult.get("MortgageStages");

							for (int iterator = 0; iterator < allCustomersMortgageNumbers.length(); iterator++) {
								String customerName = allCustomersCustomerNames.getString(iterator);
								int mortgageNumber = allCustomersMortgageNumbers.getInt(iterator);
								String mortgageStage = allMortgageStages.getString(iterator);

								if ((customerName != null) && (mortgageStage.contains("Disbursed:"))) {

									String customerName_mortgageNumber = customerName + "-" + mortgageNumber;
									customersData.add(customerName_mortgageNumber);
								}
							}
							if (customersData.size() != 0)
								request.setAttribute("customersData", customersData);
							else
								request.setAttribute("errorMsg", "Sorry! No data available for your query");
							dispatcher = request.getRequestDispatcher("/bankDisbursedCustomers.jsp");
						} else
							request.setAttribute("errorMsg", "Sorry! No data available for your query");

		}
		else if(action.equals("monthlyService")){
			
			int mortgageNumber = Integer.parseInt(request.getParameter("mortgageNumber"));
			int lpAmount = Integer.parseInt(request.getParameter("applylpAmount"));

			CustomerDetails customerData = utils.getCustomerDetails(mortgageNumber);
			boolean anyChange = false;
			String payLoadParameters = "";

			if ((Integer) customerData.getLastPaymentAmount() != lpAmount) {
				payLoadParameters += ",\\\"LastPaymentAmount\\\" :" + lpAmount;
				anyChange = true;
			}


			if (anyChange) {

				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ mortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role + "\\\"" + payLoadParameters
						+ "}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
				String chainCodeResponse = client.invokeChainCode(payLoad);

				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
				String status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

				if (status.equals("OK"))
					request.setAttribute("successMsg",
							"Data updated succesfully for Mortgage Number: " + mortgageNumber);
				else
					request.setAttribute("failureMsg", "Error! Please come back and try again later");

			} else {
				request.setAttribute("errorMsg",
						"No changes made to the form, To update please edit the details and submit the form.");

			}

			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			customerData = utils.getCustomerDetails(mortgageNumber);

			request.setAttribute("customerDetails", customerData);

			dispatcher = request.getRequestDispatcher("/bankMonthlyMServicing.jsp");

			
		}
	else if(action.equals("getPurchaseRequest")){
			
		// This module retrieves all mortgage applications with "Disbursed:Ready to Purchase" mortageStage.
		
					List<CustomerDetails> requestPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Request to Purchase",false,false);
			
					if (requestPurchaseCustomerList.size() != 0)
						request.setAttribute("requestPurchaseCustomerList", requestPurchaseCustomerList);
					else
						request.setAttribute("errorMsg", "Sorry! No data available for your query");
					dispatcher = request.getRequestDispatcher("/bankApproveAuction.jsp");

			
		}
		
	else if (action.equals("approvePurchase")) {
		//This module reviews the sell auction and writes ownership cost to blockchain JSON
		
		String status = "";		
		String[] selectCustomerMortgageNumbers = request.getParameterValues("customer");
		int discountPercentage = Integer.parseInt(request.getParameter("discountPercentage"));

		for (String eachGseMortgage : selectCustomerMortgageNumbers) {
			int eachGseMortgageNumber = Integer.parseInt(eachGseMortgage);
			CustomerDetails customerDetails = utils.getCustomerDetails(Integer.parseInt(eachGseMortgage));
			int ownershipCost = (customerDetails.getRemainingMortgageAmount() * (100 - discountPercentage)) / 100;
			String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
					+ eachGseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role + "\\\",\\\"Ownershipcost\\\":"
					+ ownershipCost + "}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
			String chainCodeResponse = client.invokeChainCode(payLoad);

			JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
			status = chainCodeReponseJson.getJSONObject("result").get("status").toString();

		}
		
		if (status.equals("OK")){
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			List<CustomerDetails> requestPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Request to Purchase",false,false);
			request.setAttribute("successMsg", "Request approved successfully.");
			
			if (requestPurchaseCustomerList.size() != 0){
				request.setAttribute("requestPurchaseCustomerList", requestPurchaseCustomerList);
				
			}
	
			
		}
		else
			request.setAttribute("failureMsg", "Error! Please come back and try again later.");

		dispatcher = request.getRequestDispatcher("/bankApproveAuction.jsp");
		
	}
		else
		{
			//Default error message displayed for invalid action parameters
			request.setAttribute("errorMsg", "Error! Invalid query");
			dispatcher = request.getRequestDispatcher("/bankSelectCustomer.jsp");
		}

		dispatcher.forward(request, response);

	}

}
