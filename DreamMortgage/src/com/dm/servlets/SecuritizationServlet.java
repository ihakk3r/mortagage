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

public class SecuritizationServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		DreamMortgageUtils utils = new DreamMortgageUtils();
		String role = "GSE";
		RestServiceClientServlet client = new RestServiceClientServlet();
		String action = request.getParameter("action");

		if (action.equals("get")) {
			
			List<CustomerDetails> requestPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:",true,true);

			if (requestPurchaseCustomerList.size() != 0)
				request.setAttribute("requestPurchaseCustomerList", requestPurchaseCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/securitizationPurchaseRequest.jsp");

		}


		else if (action.equals("requestPurchase")) {

			String status = "";
			String[] requestPurchaseMortgageNumbers = request.getParameterValues("customer");

			for (String eachRequestPurchaseMortgage : requestPurchaseMortgageNumbers) {
				int eachRequestPurchaseMortgageNumber = Integer.parseInt(eachRequestPurchaseMortgage);
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ eachRequestPurchaseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role
						+ "\\\",\\\"MortgageStage\\\":\\\"Disbursed:Ready to Purchase\\\"}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
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
				
				List<CustomerDetails> requestPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:",true,true);
				request.setAttribute("successMsg", "Purchase requested successfully for selected mortgages.");
				
				if (requestPurchaseCustomerList.size() != 0){
						request.setAttribute("requestPurchaseCustomerList", requestPurchaseCustomerList);
				}
	
				
			}
			else
				request.setAttribute("failureMsg", "Error! Please come back and try again later.");
			dispatcher = request.getRequestDispatcher("/securitizationPurchaseRequest.jsp");

		}
		else if(action.equals("getPending")){
	
			List<CustomerDetails> pendingPurchaseCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Purchase",true,true);
	
			if (pendingPurchaseCustomerList.size() != 0)
				request.setAttribute("pendingPurchaseCustomerList", pendingPurchaseCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/securitizationPendingPurchase.jsp");

		}
		
		else if(action.equals("getPurchased")){

			List<CustomerDetails> purchasedCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Sold",true,true);
		
			List<CustomerDetails> gsepurchasedCustomerList = new ArrayList<CustomerDetails>();
			for(CustomerDetails each : purchasedCustomerList){
				
				if(each.getMortgagePropertyOwnership().equals("GSE"))
					gsepurchasedCustomerList.add(each);
			}
			
			
			if (purchasedCustomerList.size() != 0)
				request.setAttribute("purchasedCustomerList", gsepurchasedCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/securitizationPurchasedMortgages.jsp");

		}
		
		else {
			
			request.setAttribute("errorMsg", "Error! Please try again later.");
			dispatcher = request.getRequestDispatcher("/securitizationPurchaseRequest.jsp");
		
		}

		dispatcher.forward(request, response);
	}

}
