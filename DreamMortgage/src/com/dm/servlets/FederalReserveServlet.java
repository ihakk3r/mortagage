package com.dm.servlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.TreeSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.CustomerDetails;
import com.dm.beans.FederalReserveBean;
import com.dm.utils.DreamMortgageUtils;

public class FederalReserveServlet extends HttpServlet{

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
		
		List<CustomerDetails> customerDetails = utils.getAllMortgageeDetails();
		TreeSet<String> years = new TreeSet<String>();
		HashMap<String,FederalReserveBean> federalReserveMapByYears = new HashMap<String,FederalReserveBean>();
		
		
		for(CustomerDetails eachCustomer : customerDetails){
			String startDate = eachCustomer.getMortgageStartDate();			
			years.add(startDate.substring(startDate.length()-4));						
		}
		
	
		
		
		
		for(String eachYear : years){
			
			int approvedCount = 0;
			int disbursedCount = 0;
			int deniedCount = 0;
			int pendingBankCount = 0;
			int pendingCustomerCount = 0;
			int totalCount = 0;
			
			 int notAquiredCount = 0;	
			 int lendingBankCount= 0;
			 int gseCount= 0;
			 int partnerBankCount= 0;
			 
			 int average10Count= 0;
			 int average15Count= 0;
			 int average20Count = 0;
			 int average30Count= 0;
			 
			 int armCount = 0;
			 int fixedCount= 0;
			 
			 int distributionBylessThan100KCount= 0;
			 int betweek100kAnd250k= 0;
			 int between250kAnd500k= 0;
			 int between500kAnd750k= 0;
			 int between750kAndoneMillion= 0;
			 int greaterthanOneMillion= 0;
			
			 int risClassificationACount= 0;
			 int risClassificationBCount= 0;
			 int risClassificationCCount= 0;
			 int risClassificationDCount= 0;
			
			 int roilessthan3point= 0;
			 int roibetween3point1And5Point0= 0;
			 int roibetween5point0And7Point5= 0;
			 int roibetween7point6And10= 0;
			 int roigreaterThan10point1= 0;
		
			 int quarter1Count= 0;
			 int quarter2Count= 0;
			 int quarter3Count= 0;
			 int quarter4Count= 0;
			 
			
			 long averageRequestedLoanAmount=0;
			 long averageGrantedLoanAmount=0;
			 long averageOwnershipCost=0;
			 long averageRemainingLoanAmount=0;
			 long averageECashFlow=0;
			 int count = 0;
		for(CustomerDetails eachCustomer : customerDetails){
			    
				String thisYear = eachCustomer.getMortgageStartDate().substring(eachCustomer.getMortgageStartDate().length()-4);
				if(thisYear.equalsIgnoreCase(eachYear)){
					count++;
					if(eachCustomer.getMortgageStage().equalsIgnoreCase("Approved:")){
						approvedCount++;
					}
					if(eachCustomer.getMortgageStage().contains("Disbursed:")){
						disbursedCount++;
					}
					if(eachCustomer.getMortgageStage().contains("Pending-Bank")){
						pendingBankCount++;
					}
					if(eachCustomer.getMortgageStage().equalsIgnoreCase("Pending-Customer:")){
						pendingCustomerCount++;
					}
					if(eachCustomer.getMortgageStage().equalsIgnoreCase("Denied:")){
						deniedCount++;
					}
					if(eachCustomer.getMortgagePropertyOwnership().equalsIgnoreCase("NOT_ACQUIRED")){
						notAquiredCount++;
					}
					if(eachCustomer.getMortgagePropertyOwnership().equalsIgnoreCase("LENDING_BANK")){
						lendingBankCount++;
					}
					if(eachCustomer.getMortgagePropertyOwnership().equalsIgnoreCase("GSE")){
						gseCount++;
					}
					if(eachCustomer.getMortgagePropertyOwnership().equalsIgnoreCase("PARTNER_BANK")){
						partnerBankCount++;											
					}

					averageRequestedLoanAmount += eachCustomer.getReqLoanAmount();
					averageGrantedLoanAmount += eachCustomer.getGrantedLoanAmount();
					averageOwnershipCost += eachCustomer.getOwnershipcost();
					averageRemainingLoanAmount += eachCustomer.getRemainingMortgageAmount();
					averageECashFlow += eachCustomer.getExpectedAnnualCashflow();
					
					if(eachCustomer.getMortgageStage().contains("Disbursed:")){
						
						if(eachCustomer.getMortgageDuration()==10)
							average10Count++;
						if(eachCustomer.getMortgageDuration()==15)
							average15Count++;
						if(eachCustomer.getMortgageDuration()==20)
							average20Count++;
						if(eachCustomer.getMortgageDuration()==30)
							average30Count++;
						
						if(eachCustomer.getMortgageType().equalsIgnoreCase("ARM"))
							armCount++;
						if(eachCustomer.getMortgageType().equalsIgnoreCase("FIXED"))
							fixedCount++;
						
						if(eachCustomer.getGrantedLoanAmount()<100000)
							distributionBylessThan100KCount++;
						if(eachCustomer.getGrantedLoanAmount()>100000 && eachCustomer.getGrantedLoanAmount()<250000)
							betweek100kAnd250k++;
						if(eachCustomer.getGrantedLoanAmount()>250000 && eachCustomer.getGrantedLoanAmount()<500000)
							between250kAnd500k++;
						if(eachCustomer.getGrantedLoanAmount()>500000 && eachCustomer.getGrantedLoanAmount()<750000)
							between500kAnd750k++;
						if(eachCustomer.getGrantedLoanAmount()>750000 && eachCustomer.getGrantedLoanAmount()<1000000)
							between750kAndoneMillion++;
						if(eachCustomer.getGrantedLoanAmount()>1000000)
							greaterthanOneMillion++;
						
						if(eachCustomer.getRiskClassification().equalsIgnoreCase("A"))
							risClassificationACount++;
						if(eachCustomer.getRiskClassification().equalsIgnoreCase("B"))
							risClassificationBCount++;
						if(eachCustomer.getRiskClassification().equalsIgnoreCase("C"))
							risClassificationCCount++;
						if(eachCustomer.getRiskClassification().equalsIgnoreCase("D"))
							risClassificationDCount++;
					
						 
						if(eachCustomer.getRateofInterest()<3.0)
							roilessthan3point++;
						if(eachCustomer.getRateofInterest()>3.0 && eachCustomer.getRateofInterest()>5.0)
							roibetween3point1And5Point0++;
						if(eachCustomer.getRateofInterest()>5.0 && eachCustomer.getRateofInterest()>7.5)
							roibetween5point0And7Point5++;
						if(eachCustomer.getRateofInterest()>7.6 && eachCustomer.getRateofInterest()>10.0)
							roibetween7point6And10++;
						if(eachCustomer.getRateofInterest()>10.1)
							roigreaterThan10point1++;
					
						
						int month = 0;
						DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy"); 
						try {
							Date startDate = (Date)formatter.parse(eachCustomer.getMortgageStartDate());
							month = startDate.getMonth();
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						
						if(month<4)
							quarter1Count++;
						if(month>=3 && month<7)
							quarter2Count++;
						if(month>=6 && month<10)
							quarter3Count++;
						if(month>=9 && month<=12)
							quarter4Count++;
					}
					
					
					totalCount = approvedCount+pendingBankCount+deniedCount+disbursedCount+pendingCustomerCount;
					
				}
			
			}
		averageRequestedLoanAmount/=count;
		averageGrantedLoanAmount/=count;
		averageOwnershipCost/=count;
		averageRemainingLoanAmount/=count;
		averageECashFlow/=count;
		
		FederalReserveBean federalReserveDetails = new FederalReserveBean(eachYear, approvedCount, disbursedCount, deniedCount, pendingBankCount, pendingCustomerCount, totalCount, notAquiredCount, lendingBankCount, gseCount, partnerBankCount, average10Count, average15Count, average20Count, average30Count, armCount, fixedCount, distributionBylessThan100KCount, betweek100kAnd250k, between250kAnd500k, between500kAnd750k, between750kAndoneMillion, greaterthanOneMillion, risClassificationACount, risClassificationBCount, risClassificationCCount, risClassificationDCount, roilessthan3point, roibetween3point1And5Point0, roibetween5point0And7Point5, roibetween7point6And10, roigreaterThan10point1, quarter1Count, quarter2Count, quarter3Count, quarter4Count, averageRequestedLoanAmount, averageGrantedLoanAmount, averageOwnershipCost, averageRemainingLoanAmount, averageECashFlow);
		federalReserveMapByYears.put(eachYear, federalReserveDetails);
		}
		
		req.setAttribute("federalReserveMapByYears", federalReserveMapByYears);
		dispatcher = req.getRequestDispatcher("/federalReserveCustomer.jsp");
		dispatcher.forward(req, resp);
	}
	
	
}
	

