package com.dm.servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.TimeZone;
import java.util.TreeSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.AuditorBean;
/**
 * Servlet implementation class AuditorsServlet
 */

public class AuditorsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuditorsServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		RequestDispatcher dispatcher = null;
		String decodedRes = null;
		RestServiceClientServlet client = new RestServiceClientServlet();
		String chainCodeResponse = client.invokeChainCodeAuditor();
		JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
		String height = chainCodeReponseJson.get("height").toString();
		
		if(request.getParameter("action") != null) {
			List<AuditorBean> customerDetailsList = new ArrayList<AuditorBean>();
			if(height != null) {
				AuditorBean customerDtls = null;
				for(int i = 0; i <= Integer.parseInt(height)-1 ; i++) {
					customerDtls = new AuditorBean();
					
					String customer = client.invokeChainCodeAuditorCustomer(Integer.toString(i));
					JSONObject customerJson = new JSONObject(customer);
					long timestamp = ((JSONObject)((JSONObject)customerJson.get("nonHashData")).get("localLedgerCommitTimestamp")).getInt("seconds");
					long timestampInMillis = timestamp*1000;
					TimeZone utc = TimeZone.getTimeZone("UTC");							
					SimpleDateFormat isoFormatter = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
					isoFormatter.setTimeZone(utc);
					String date = isoFormatter.format(new Date(timestampInMillis)).toString();
				   	if(customerJson.has("stateHash") && customerJson.has("previousBlockHash")) {
						customerDtls.setNum(i);
						customerDtls.setTimeStamp(date+" UTC");
						customerDtls.setCurrentBlockHask(customerJson.get("stateHash").toString());
						customerDtls.setPreviousBlockHash(customerJson.get("previousBlockHash").toString());
						customerDetailsList.add(customerDtls);
					}					
				}
			}
			
			request.setAttribute("customerDetailsList", customerDetailsList);
			dispatcher = request.getRequestDispatcher("/BlockChainHome.jsp");
		}
		
		else {
			List<AuditorBean> customerDetailsList = new ArrayList<AuditorBean>();
			
			TreeSet<String> allsortedMortgageNumbers = new TreeSet<String>();
			
		int mrtNum = 1000000;
		
		if(height != null) {
			AuditorBean customerDtls = null;
			for(int i = 0; i <= Integer.parseInt(height)-1 ; i++) {
				customerDtls = new AuditorBean();
				
				String customer = client.invokeChainCodeAuditorCustomer(Integer.toString(i));
				JSONObject customerJson = new JSONObject(customer);
				if(customerJson.has("transactions")) {
				JSONArray custJsonArray = customerJson.getJSONArray("transactions");
				
				for(int j = 0; j < custJsonArray.length(); j++) {
					if(custJsonArray.getJSONObject(j).has("type")) {
						
						if("2".equals(custJsonArray.getJSONObject(j).get("type").toString()) && custJsonArray.getJSONObject(j).has("payload")) {
							decodedRes = new String(DatatypeConverter.parseBase64Binary(custJsonArray.getJSONObject(j).get("payload").toString()));
							
							long timestamp = ((JSONObject)((JSONObject)customerJson.get("nonHashData")).get("localLedgerCommitTimestamp")).getInt("seconds");
							long timestampInMillis = timestamp*1000;
							TimeZone utc = TimeZone.getTimeZone("UTC");							
							SimpleDateFormat isoFormatter = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
							isoFormatter.setTimeZone(utc);
							String date = isoFormatter.format(new Date(timestampInMillis)).toString();
						    customerDtls.setTimeStamp(date+" UTC");
							
							if(decodedRes.contains("create_mortgage_application")) {
								mrtNum += 1;
								String sJson = decodedRes.substring(decodedRes.lastIndexOf("{"), decodedRes.lastIndexOf("}")+1);
								JSONObject json = new JSONObject(sJson);
								
								customerDtls.setParticipant(json.getString("ModifiedBy"));
								String data = "";
								if(json.has("CustomerName")) {
									data += "Customer Name : "+json.get("CustomerName")+"; ";
								}
								if(json.has("MortgageStage")) {
									data += "Mortgage Stage : "+json.get("MortgageStage")+"; ";
								}
								if(json.has("CustomerAddress")) {
									data += "Customer Address : "+json.get("CustomerAddress")+"; ";
								}
								if(json.has("CustomerSSN")) {
									data += "Customer SSN : "+json.get("CustomerSSN")+"; ";
								}
								if(json.has("CustomerDOB")) {
									data += "Date Of Birth : "+json.get("CustomerDOB")+"; ";
								}
								if(json.has("MortgagePropertyAddress")) {
									data += "Mortgage Property Address : "+json.get("MortgagePropertyAddress")+"; ";
								}
								if(json.has("MortgageType")) {
									data += "Mortgage Type : "+json.get("MortgageType")+"; ";
								}
								if(json.has("MortgageStartDate")) {
									data += "Mortgage StartDate : "+json.get("MortgageStartDate")+"; ";
								}
								if(json.has("MortgageDuration")) {
									data += "Mortgage Duration : "+json.get("MortgageDuration")+"; ";
								}
								if(json.has("GrantedLoanAmount")) {
									data += "Granted LoanAmount : "+json.get("GrantedLoanAmount")+"; ";
								}
								if(json.has("RateofInterest")) {
									data += "Rate of Interest : "+json.get("RateofInterest")+"; ";
								}
								if(json.has("PropertyValuation")) {
									data += "Property Valuation : "+json.get("PropertyValuation")+"; ";
								}
								if(json.has("CreditScore")) {
									data += "Credit Score : "+json.get("CreditScore")+"; ";
								}
								if(json.has("FinancialWorth")) {
									data += "Financial Worth : "+json.get("FinancialWorth")+"; ";
								}
								if(json.has("Ownershipcost")) {
									data += "Ownership Cost : "+json.get("Ownershipcost")+"; ";
								}
								customerDtls.setData(data);
								customerDtls.setAction("Created Mortgage Application");
								customerDtls.setMortgageNumber(Integer.toString(mrtNum));								
								customerDetailsList.add(customerDtls);
								allsortedMortgageNumbers.add(customerDtls.getMortgageNumber());
							}
							else if(decodedRes.contains("modify_mortgage")) {
								String sJson = decodedRes.substring(decodedRes.lastIndexOf("{"), decodedRes.lastIndexOf("}")+1);
								JSONObject json = new JSONObject(sJson);
								
								customerDtls.setParticipant(json.getString("ModifiedBy"));
								String data = "";
								if(json.has("CustomerName")) {
									data += "Customer Name : "+json.get("CustomerName")+"; ";
								}
								if(json.has("MortgageStage")) {
									data += "Mortgage Stage : "+json.get("MortgageStage")+"; ";
								}
								if(json.has("CustomerAddress")) {
									data += "Customer Address : "+json.get("CustomerAddress")+"; ";
								}
								if(json.has("CustomerSSN")) {
									data += "Customer SSN : "+json.get("CustomerSSN")+"; ";
								}
								if(json.has("CustomerDOB")) {
									data += "Date Of Birth : "+json.get("CustomerDOB")+"; ";
								}
								if(json.has("MortgagePropertyAddress")) {
									data += "Mortgage Property Address : "+json.get("MortgagePropertyAddress")+"; ";
								}
								if(json.has("MortgageType")) {
									data += "Mortgage Type : "+json.get("MortgageType")+"; ";
								}
								if(json.has("MortgageStartDate")) {
									data += "Mortgage StartDate : "+json.get("MortgageStartDate")+"; ";
								}
								if(json.has("MortgageDuration")) {
									data += "Mortgage Duration : "+json.get("MortgageDuration")+"; ";
								}
								if(json.has("GrantedLoanAmount")) {
									data += "Granted LoanAmount : "+json.get("GrantedLoanAmount")+"; ";
								}
								if(json.has("RateofInterest")) {
									data += "Rate of Interest : "+json.get("RateofInterest")+"; ";
								}
								if(json.has("PropertyValuation")) {
									data += "Property Valuation : "+json.get("PropertyValuation")+"; ";
								}
								if(json.has("CreditScore")) {
									data += "Credit Score : "+json.get("CreditScore")+"; ";
								}
								if(json.has("FinancialWorth")) {
									data += "Financial Worth : "+json.get("FinancialWorth")+"; ";
								}
								if(json.has("Ownershipcost")) {
									data += "Ownership Cost : "+json.get("Ownershipcost")+"; ";
								}
								customerDtls.setData(data);
								customerDtls.setAction("Modified Mortgage Application");
								customerDtls.setMortgageNumber(Integer.toString(json.getInt("MortgageNumber")));
								customerDetailsList.add(customerDtls);
								allsortedMortgageNumbers.add(customerDtls.getMortgageNumber());
							}
						}
					}
				}
				}
			}
		}
		request.setAttribute("customerDtls", customerDetailsList);
		request.setAttribute("size", customerDetailsList.size()-1);
		
		request.setAttribute("allUniqueMortgageNumbers", allsortedMortgageNumbers);
		dispatcher = request.getRequestDispatcher("/auditorCustomerDetails.jsp");
		}
		
		dispatcher.forward(request, response);
	}
}
