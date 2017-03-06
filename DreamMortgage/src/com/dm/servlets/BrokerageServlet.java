package com.dm.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.CustomerDetails;
import com.dm.beans.GraphObjectBean;
import com.dm.utils.DreamMortgageUtils;

public class BrokerageServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = null;
		DreamMortgageUtils utils = new DreamMortgageUtils();
		String role = "Brokerage";
		RestServiceClientServlet client = new RestServiceClientServlet();
		String action = req.getParameter("action");
	
	
		if(action.equals("get")){
		List<GraphObjectBean> graphObjs = new ArrayList<GraphObjectBean>();
		List<CustomerDetails> customersDetails = utils.getAllMortgageeDetails();
		HashSet<String> years = new HashSet<String>();
		HashSet<String> riskClassifications = new HashSet<String>();
		for(CustomerDetails eachCustomer : customersDetails){
			String startDate = eachCustomer.getMortgageStartDate();			
			years.add(startDate.substring(startDate.length()-4));
			if(eachCustomer.getRiskClassification().length()!=0)
				riskClassifications.add(eachCustomer.getRiskClassification());			
		}
		
		for(String eachRC : riskClassifications){
			
			for(String eachYear : years){
				int sumOfGranted = 0;
				int sumofRemaning = 0;
				int sumofCashFlow = 0;
				
				for(CustomerDetails eachCustomer : customersDetails){
					String thisyear = eachCustomer.getMortgageStartDate().substring(eachCustomer.getMortgageStartDate().length()-4);
					String riskCategory = eachCustomer.getRiskClassification();
					if(riskCategory.equals(eachRC)&&thisyear.equals(eachYear)){
						sumOfGranted+= eachCustomer.getGrantedLoanAmount();
						sumofRemaning+=eachCustomer.getRemainingMortgageAmount();
						sumofCashFlow+=eachCustomer.getExpectedAnnualCashflow();
					}
					
				}
				
				GraphObjectBean graphObj = new GraphObjectBean(eachRC, sumOfGranted, sumofRemaning, eachYear, sumofCashFlow);
				graphObjs.add(graphObj);
			
			}
		}
		
		
		
				if ((graphObjs.size()!=0)) {
					req.setAttribute("graphObjs", graphObjs);
					req.setAttribute("yearsList", years);
					req.setAttribute("riskClassifications", riskClassifications);
				}
				else
					req.setAttribute("errorMsg", "Sorry! No data available for your query");
				dispatcher = req.getRequestDispatcher("/brokerageEntity.jsp");

		}
		dispatcher.forward(req, resp);
	}
	
}