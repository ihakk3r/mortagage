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


public class PartnerBankServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public PartnerBankServlet() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
					
		RequestDispatcher dispatcher = null;		
		String role = "Partner Bank";
		DreamMortgageUtils utils = new DreamMortgageUtils();
		RestServiceClientServlet client = new RestServiceClientServlet();
		String action = request.getParameter("action");

		if (action.equals("getPurchase")) {
			
			List<CustomerDetails> getCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Sell",false,false);
			
			if (getCustomerList.size() != 0)
				request.setAttribute("getCustomerList", getCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/partnerBankPurchase.jsp");

		}


		else if (action.equals("viewPurchased")) {

			List<CustomerDetails> purchasedCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Sold",false,false);
			List<CustomerDetails> parterBankpurchasedCustomerList = new ArrayList<CustomerDetails>();
			for(CustomerDetails each : purchasedCustomerList){
				
				if(each.getMortgagePropertyOwnership().equals("PARTNER_BANK"))
					parterBankpurchasedCustomerList.add(each);
			}
			
			if (purchasedCustomerList.size() != 0)
				request.setAttribute("purchasedCustomerList", parterBankpurchasedCustomerList);
			else
				request.setAttribute("errorMsg", "Sorry! No data available for your query");
			dispatcher = request.getRequestDispatcher("/partnerBankViewPurchases.jsp");

		}
		
		else if (action.equals("requestPurchase")) {

			String status = "";
			String[] requestPurchaseMortgageNumbers = request.getParameterValues("customer");

			for (String eachRequestPurchaseMortgage : requestPurchaseMortgageNumbers) {
				int eachRequestPurchaseMortgageNumber = Integer.parseInt(eachRequestPurchaseMortgage);
				String payLoad = "{\"jsonrpc\": \"2.0\", \"method\": \"invoke\", \"params\": { \"type\": 1, \"chaincodeID\": { \"name\": \"\" }, \"ctorMsg\": { \"function\": \"modify_mortgage\", \"args\": [ \"{\\\"MortgageNumber\\\":"
						+ eachRequestPurchaseMortgageNumber + ",\\\"ModifiedBy\\\":\\\"" + role
						+ "\\\",\\\"MortgageStage\\\":\\\"Disbursed:Request to Purchase\\\"}\" ] },  \"secureContext\": \"admin\" }, \"id\": 0 }";
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
				
				List<CustomerDetails> getCustomerList = utils.getAllMortgageeDetailsByStageAndConformedMortgage("Disbursed:Ready to Sell",false,false);
				request.setAttribute("successMsg", "Purchase requested successfully for selected mortgages.");
				
				if (getCustomerList.size() != 0){
					request.setAttribute("getCustomerList", getCustomerList);
				}
		
			}
			else
				request.setAttribute("failureMsg", "Error! Please come back and try again later.");
			dispatcher = request.getRequestDispatcher("/partnerBankPurchase.jsp");

		}
				
		else {
			
			request.setAttribute("errorMsg", "Error! Please try again later.");
			dispatcher = request.getRequestDispatcher("/partnerBankPurchase.jsp");
		
		}

		dispatcher.forward(request, response);	
		
	}
	

}
