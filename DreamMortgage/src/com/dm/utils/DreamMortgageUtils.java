package com.dm.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dm.beans.CustomerDetails;
import com.dm.servlets.RestServiceClientServlet;
import com.google.gson.Gson;

public class DreamMortgageUtils{
	static RestServiceClientServlet client;
	
	public DreamMortgageUtils() {
		this.client = new RestServiceClientServlet();
	}
	
	public static HashMap sortByValues(HashMap map) { 
	       List list = new LinkedList(map.entrySet());
	       // Defined Custom Comparator here
	       Collections.sort(list, new Comparator() {
	            public int compare(Object o1, Object o2) {
	               return ((Comparable) ((Map.Entry) (o1)).getValue())
	                  .compareTo(((Map.Entry) (o2)).getValue());
	            }
	       });

	       // Here I am copying the sorted list in HashMap
	       // using LinkedHashMap to preserve the insertion order
	       HashMap sortedHashMap = new LinkedHashMap();
	       for (Iterator it = list.iterator(); it.hasNext();) {
	              Map.Entry entry = (Map.Entry) it.next();
	              sortedHashMap.put(entry.getKey(), entry.getValue());
	       } 
	       return sortedHashMap;
	  }
	
	public List<CustomerDetails> getAllMortgageeDetails(){
		
		String payLoad = "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgages\"},\"secureContext\": \"admin\"},\"id\": 0}";

				List<CustomerDetails> customerDetails = new ArrayList<CustomerDetails>();
				String chainCodeResponse = null;
				try {
				chainCodeResponse = client.invokeChainCode(payLoad);
				} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}
				
				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
			
				JSONObject chainCodeReponseJsonResult= chainCodeReponseJson.getJSONObject("result");
				if(chainCodeReponseJsonResult.get("status").equals("OK")){
				chainCodeReponseJsonResult.remove("status");
				String customerData = chainCodeReponseJsonResult.get("message").toString();
				
				JSONArray customerDataArray = new JSONArray(customerData);							
				
		
				for (int iterator = 0; iterator < customerDataArray.length(); iterator++) {
					
					JSONObject eachCustomerDetailsString = customerDataArray.getJSONObject(iterator);
					
					CustomerDetails customerDetailsObj = new Gson().fromJson(eachCustomerDetailsString.toString(), CustomerDetails.class);
					customerDetails.add(customerDetailsObj);
					
				} 
				}
							 
				return customerDetails;
	}

	public List<CustomerDetails> getAllMortgageeDetailsByStageAndConformedMortgage(String mortgageStage,boolean istocheckConformed,boolean isConformed){
		
		String payLoad = "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgages\"},\"secureContext\": \"admin\"},\"id\": 0}";

				List<CustomerDetails> unsortedAuctionCustomerList = new ArrayList<CustomerDetails>();
				String chainCodeResponse = null;
				try {
				chainCodeResponse = client.invokeChainCode(payLoad);
				} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				}
				
				JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
			
				JSONObject chainCodeReponseJsonResult= chainCodeReponseJson.getJSONObject("result");
				if(chainCodeReponseJsonResult.get("status").equals("OK")){
				chainCodeReponseJsonResult.remove("status");
				String customerData = chainCodeReponseJsonResult.get("message").toString();
				
				JSONArray customerDataArray = new JSONArray(customerData);							
				
		
				for (int iterator = 0; iterator < customerDataArray.length(); iterator++) {
					
					JSONObject eachCustomerDetailsString = customerDataArray.getJSONObject(iterator);
					
					CustomerDetails customerDetailsObj = new Gson().fromJson(eachCustomerDetailsString.toString(), CustomerDetails.class);
					if(istocheckConformed){
					if(customerDetailsObj.getMortgageStage().equals(mortgageStage)&&customerDetailsObj.isConformedMortgage()&&(isConformed))
						unsortedAuctionCustomerList.add(customerDetailsObj);
					}
					else
					{
					if(customerDetailsObj.getMortgageStage().equals(mortgageStage))
						unsortedAuctionCustomerList.add(customerDetailsObj);
						
					}
					
				} 
				}
							 
				List<CustomerDetails> sortedAuctionCustomerList = new ArrayList<CustomerDetails>();
				List<CustomerDetails> auctionCustomerList = new ArrayList<CustomerDetails>();
				
			
				HashMap<Integer,String> partiallysortedA = new HashMap<Integer,String>();
				HashMap<Integer,String> partiallysortedB = new HashMap<Integer,String>();
				HashMap<Integer,String> partiallysortedC = new HashMap<Integer,String>();
				HashMap<Integer,String> partiallysortedD = new HashMap<Integer,String>();
				

				HashMap<Integer,Integer> sortedA = new HashMap<Integer,Integer>();
				HashMap<Integer,Integer> sortedB = new HashMap<Integer,Integer>();
				HashMap<Integer,Integer> sortedC = new HashMap<Integer,Integer>();
				HashMap<Integer,Integer> sortedD = new HashMap<Integer,Integer>();
				
				for (CustomerDetails eachUnsortedCustomer : unsortedAuctionCustomerList) {
							
					if(eachUnsortedCustomer.getRiskClassification().equals("A"))
						partiallysortedA.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRiskClassification());
					if(eachUnsortedCustomer.getRiskClassification().equals("B"))
						partiallysortedB.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRiskClassification());
					if(eachUnsortedCustomer.getRiskClassification().equals("C"))
						partiallysortedC.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRiskClassification());
					if(eachUnsortedCustomer.getRiskClassification().equals("D"))
						partiallysortedD.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRiskClassification());
						

				}
				partiallysortedA = sortByValues(partiallysortedA);	
				partiallysortedB = sortByValues(partiallysortedB);	
				partiallysortedC = sortByValues(partiallysortedC);	
				partiallysortedD = sortByValues(partiallysortedD);
				
				 Set set1 = partiallysortedA.entrySet();
				 Set set2 = partiallysortedB.entrySet();
				 Set set3 = partiallysortedC.entrySet();
				 Set set4 = partiallysortedD.entrySet();
				 
			      Iterator iteratorA = set1.iterator();
			      Iterator iteratorB = set2.iterator();
			      Iterator iteratorC = set3.iterator();
			      Iterator iteratorD = set4.iterator();
			      
			      while(iteratorA.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorA.next();
			           
			           for (CustomerDetails eachUnsortedCustomer : unsortedAuctionCustomerList) {
			        	   
			        	   if((Integer)me2.getKey()==eachUnsortedCustomer.getMortgageNumber()){
			        		   sortedA.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRemainingMortgageAmount());
			        		   sortedA = sortByValues(sortedA);			
			        	   
			        	   }

						}		   
			        
			      }
			      while(iteratorB.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorB.next();
			           
			           for (CustomerDetails eachUnsortedCustomer : unsortedAuctionCustomerList) {
			        	   
			        	   if((Integer)me2.getKey()==eachUnsortedCustomer.getMortgageNumber()){
			        		   sortedB.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRemainingMortgageAmount());
			        		   sortedB = sortByValues(sortedB);			
			        	   
			        	   }

						}		   
			        
			      }
			      while(iteratorC.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorC.next();
			           
			           for (CustomerDetails eachUnsortedCustomer : unsortedAuctionCustomerList) {
			        	   
			        	   if((Integer)me2.getKey()==eachUnsortedCustomer.getMortgageNumber()){
			        		   sortedC.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRemainingMortgageAmount());
			        		   sortedC = sortByValues(sortedC);			
			        
			        	   }

						}		   
			        
			      }
			      
			      while(iteratorD.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorD.next();
			           
			           for (CustomerDetails eachUnsortedCustomer : unsortedAuctionCustomerList) {
			        	   
			        	   if((Integer)me2.getKey()==eachUnsortedCustomer.getMortgageNumber()){
			        		   sortedD.put(eachUnsortedCustomer.getMortgageNumber(), eachUnsortedCustomer.getRemainingMortgageAmount());
			        		   sortedD = sortByValues(sortedD);			
			        
			        	   }

						}		   
			        
			      }
			      
			      Set set5 = sortedA.entrySet();
					 Set set6 = sortedB.entrySet();
					 Set set7 = sortedC.entrySet();
					 Set set8 = sortedD.entrySet();
					 
				      Iterator iteratorE = set5.iterator();
				      Iterator iteratorF = set6.iterator();
				      Iterator iteratorG = set7.iterator();
				      Iterator iteratorH = set8.iterator();
			     
			     
			      while(iteratorE.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorE.next();
			           
			           for (CustomerDetails eachSortedCustomer : unsortedAuctionCustomerList) {
			        	   if((Integer)me2.getKey()==eachSortedCustomer.getMortgageNumber())
			        		   auctionCustomerList.add(eachSortedCustomer);						

						}	
			           
			        
			      }
			      
			      while(iteratorF.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorF.next();
			           
			           for (CustomerDetails eachSortedCustomer : unsortedAuctionCustomerList) {
			        	   if((Integer)me2.getKey()==eachSortedCustomer.getMortgageNumber())
			        		   auctionCustomerList.add(eachSortedCustomer);						

						}	
			           
			        
			      }
			      while(iteratorG.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorG.next();
			           
			           for (CustomerDetails eachSortedCustomer : unsortedAuctionCustomerList) {
			        	   if((Integer)me2.getKey()==eachSortedCustomer.getMortgageNumber())
			        		   auctionCustomerList.add(eachSortedCustomer);						

						}	
			           
			        
			      }
			      
			      while(iteratorH.hasNext()) {
			           Map.Entry me2 = (Map.Entry)iteratorH.next();
			           
			           for (CustomerDetails eachSortedCustomer : unsortedAuctionCustomerList) {
			        	   if((Integer)me2.getKey()==eachSortedCustomer.getMortgageNumber())
			        		   auctionCustomerList.add(eachSortedCustomer);						

						}	
			           
			        
			      }
			      return auctionCustomerList;

	}
		
	public CustomerDetails getCustomerDetails(int mortgageNumber){
			
			String payLoad = "{\"jsonrpc\": \"2.0\",\"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgage\",\"args\":[\"{\\\"MortgageNumber\\\":"
					+ mortgageNumber + "}\"]},\"secureContext\": \"admin\"},\"id\": 0 }";
			RestServiceClientServlet client = new RestServiceClientServlet();
			String chainCodeResponse = null;
			try {
				chainCodeResponse = client.invokeChainCode(payLoad);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
			String customerDataString = chainCodeReponseJson.getJSONObject("result").get("message").toString();
			CustomerDetails customerDetails = new Gson().fromJson(customerDataString, CustomerDetails.class);
			return customerDetails;
			
		}

	/* Remove below method and references in production */

	public CustomerDetails getDummyCustomerObject(){
		
		CustomerDetails customer = new CustomerDetails("Jane", "Bloomington", 313146466, "02/05/1970", 50000, 3.05, 90000, 70000, 240, 1000000, "A", 2, 10000, 60000, 0, 1000, "Texas", "Disbursed:Ready to Purchase", "", "FIXED", "02/05/2017", 3650, false, "securitization", 100002);
		
		return customer;	
	}

	public List<Integer> getMortgagesByStage(String requiredMortgageStage){
		
		List<Integer> mortgageNumbers = new ArrayList<Integer>();
		String payLoad =  "{ \"jsonrpc\": \"2.0\", \"method\": \"query\",\"params\": {\"type\": 1,\"chaincodeID\": {\"name\": \"\"},\"ctorMsg\": {\"function\": \"retrieve_mortgage_portfolio\"},\"secureContext\": \"admin\"},\"id\": 0}";
		
		
		String chainCodeResponse = null;
		try {
			chainCodeResponse = client.invokeChainCode(payLoad);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONObject chainCodeReponseJson = new JSONObject(chainCodeResponse);
		String allCustomersData = chainCodeReponseJson.getJSONObject("result").get("message").toString();
		JSONObject chainCodeReponseJsonResult = new JSONObject(allCustomersData);
		
		JSONArray allCustomersMortgageNumbers = (JSONArray) chainCodeReponseJsonResult.get("MortgageNumbers");
		JSONArray allCustomersCustomerNames = (JSONArray) chainCodeReponseJsonResult.get("CustomerNames");
		JSONArray allMortgageStages = (JSONArray) chainCodeReponseJsonResult.get("MortgageStages");							
		
		for(int iterator=0; iterator<allCustomersMortgageNumbers.length();iterator++){
			String customerName = allCustomersCustomerNames.getString(iterator);
			int mortgageNumber = allCustomersMortgageNumbers.getInt(iterator);
			String mortgageStage =  allMortgageStages.getString(iterator);
					
					if ((customerName != null) && (mortgageStage.equals(requiredMortgageStage))) {
						
						mortgageNumbers.add(mortgageNumber);
					}
		}
		return mortgageNumbers;
		
	}



}
