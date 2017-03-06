package com.dm.beans;

public class GraphObjectBean {
	
	
	private String riskCategory;
	private int grantedLoanAmount;
	private int remainingLoanAmount;
	private String year;
	private int expectedAnnualCashFlow;
	public String getRiskCategory() {
		return riskCategory;
	}
	public int getGrantedLoanAmount() {
		return grantedLoanAmount;
	}
	public void setGrantedLoanAmount(int grantedLoanAmount) {
		this.grantedLoanAmount = grantedLoanAmount;
	}
	public int getRemainingLoanAmount() {
		return remainingLoanAmount;
	}
	public void setRemainingLoanAmount(int remainingLoanAmount) {
		this.remainingLoanAmount = remainingLoanAmount;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public int getExpectedAnnualCashFlow() {
		return expectedAnnualCashFlow;
	}
	public void setExpectedAnnualCashFlow(int expectedAnnualCashFlow) {
		this.expectedAnnualCashFlow = expectedAnnualCashFlow;
	}
	public void setRiskCategory(String riskCategory) {
		this.riskCategory = riskCategory;
	}
	@Override
	public String toString() {
		return "GraphObjectBean [riskCategory=" + riskCategory
				+ ", grantedLoanAmount=" + grantedLoanAmount
				+ ", remainingLoanAmount=" + remainingLoanAmount + ", year="
				+ year + ", expectedAnnualCashFlow=" + expectedAnnualCashFlow
				+ "]";
	}
	public GraphObjectBean(String riskCategory, int grantedLoanAmount,
			int remainingLoanAmount, String year, int expectedAnnualCashFlow) {
		super();
		this.riskCategory = riskCategory;
		this.grantedLoanAmount = grantedLoanAmount;
		this.remainingLoanAmount = remainingLoanAmount;
		this.year = year;
		this.expectedAnnualCashFlow = expectedAnnualCashFlow;
	}
	
	
	

}
