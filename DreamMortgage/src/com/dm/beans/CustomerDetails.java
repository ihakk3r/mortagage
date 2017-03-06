package com.dm.beans;

public class CustomerDetails {
	
	private String CustomerName;
	private String CustomerAddress;
	private int CustomerSSN;
	private String CustomerDOB;
	private int GrantedLoanAmount;
	private double RateofInterest;
	private int PropertyValuation;
	private int ReqLoanAmount;
	private int CreditScore;
	private int FinancialWorth;
	private String RiskClassification;
	private double RiskAdjustedReturn;
	private int ExpectedAnnualCashflow;
	private int RemainingMortgageAmount;
	private int Ownershipcost;
	private int LastPaymentAmount;
	private String MortgagePropertyAddress;
	private String MortgageStage;
	private String MortgagePropertyOwnership;	
	private String MortgageType;
	private String MortgageStartDate;
	private int MortgageDuration;
	private boolean ConformedMortgage;
	private String ModifiedBy;
	private int MortgageNumber;
	
	
	

	public CustomerDetails(String customerName, String customerAddress, int customerSSN, String customerDOB,
			int grantedLoanAmount, double rateofInterest, int propertyValuation, int reqLoanAmount, int creditScore,
			int financialWorth, String riskClassification, double riskAdjustedReturn, int expectedAnnualCashflow,
			int remainingMortgageAmount, int ownershipcost, int lastPaymentAmount, String mortgagePropertyAddress,
			String mortgageStage, String mortgagePropertyOwnership, String mortgageType, String mortgageStartDate,
			int mortgageDuration, boolean conformedMortgage, String modifiedBy, int mortgageNumber) {
		super();
		CustomerName = customerName;
		CustomerAddress = customerAddress;
		CustomerSSN = customerSSN;
		CustomerDOB = customerDOB;
		GrantedLoanAmount = grantedLoanAmount;
		RateofInterest = rateofInterest;
		PropertyValuation = propertyValuation;
		ReqLoanAmount = reqLoanAmount;
		CreditScore = creditScore;
		FinancialWorth = financialWorth;
		RiskClassification = riskClassification;
		RiskAdjustedReturn = riskAdjustedReturn;
		ExpectedAnnualCashflow = expectedAnnualCashflow;
		RemainingMortgageAmount = remainingMortgageAmount;
		Ownershipcost = ownershipcost;
		LastPaymentAmount = lastPaymentAmount;
		MortgagePropertyAddress = mortgagePropertyAddress;
		MortgageStage = mortgageStage;
		MortgagePropertyOwnership = mortgagePropertyOwnership;
		MortgageType = mortgageType;
		MortgageStartDate = mortgageStartDate;
		MortgageDuration = mortgageDuration;
		ConformedMortgage = conformedMortgage;
		ModifiedBy = modifiedBy;
		MortgageNumber = mortgageNumber;
	}
	public String getCustomerName() {
		return CustomerName;
	}
	public void setCustomerName(String customerName) {
		CustomerName = customerName;
	}
	public String getCustomerAddress() {
		return CustomerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		CustomerAddress = customerAddress;
	}
	public int getCustomerSSN() {
		return CustomerSSN;
	}
	public void setCustomerSSN(int customerSSN) {
		CustomerSSN = customerSSN;
	}
	public String getCustomerDOB() {
		return CustomerDOB;
	}
	public void setCustomerDOB(String customerDOB) {
		CustomerDOB = customerDOB;
	}
	public int getGrantedLoanAmount() {
		return GrantedLoanAmount;
	}
	public void setGrantedLoanAmount(int grantedLoanAmount) {
		GrantedLoanAmount = grantedLoanAmount;
	}
	public double getRateofInterest() {
		return RateofInterest;
	}
	public void setRateofInterest(double rateofInterest) {
		RateofInterest = rateofInterest;
	}
	public int getPropertyValuation() {
		return PropertyValuation;
	}
	public void setPropertyValuation(int propertyValuation) {
		PropertyValuation = propertyValuation;
	}
	public int getReqLoanAmount() {
		return ReqLoanAmount;
	}
	public void setReqLoanAmount(int reqLoanAmount) {
		ReqLoanAmount = reqLoanAmount;
	}
	public int getCreditScore() {
		return CreditScore;
	}
	public void setCreditScore(int creditScore) {
		CreditScore = creditScore;
	}
	public int getFinancialWorth() {
		return FinancialWorth;
	}
	public void setFinancialWorth(int financialWorth) {
		FinancialWorth = financialWorth;
	}
	public String getRiskClassification() {
		return RiskClassification;
	}
	public void setRiskClassification(String riskClassification) {
		RiskClassification = riskClassification;
	}
	public double getRiskAdjustedReturn() {
		return RiskAdjustedReturn;
	}
	public void setRiskAdjustedReturn(double riskAdjustedReturn) {
		RiskAdjustedReturn = riskAdjustedReturn;
	}
	public int getExpectedAnnualCashflow() {
		return ExpectedAnnualCashflow;
	}
	public void setExpectedAnnualCashflow(int expectedAnnualCashflow) {
		ExpectedAnnualCashflow = expectedAnnualCashflow;
	}
	public int getRemainingMortgageAmount() {
		return RemainingMortgageAmount;
	}
	public void setRemainingMortgageAmount(int remainingMortgageAmount) {
		RemainingMortgageAmount = remainingMortgageAmount;
	}
	public int getOwnershipcost() {
		return Ownershipcost;
	}
	public void setOwnershipcost(int ownershipcost) {
		Ownershipcost = ownershipcost;
	}
	public int getLastPaymentAmount() {
		return LastPaymentAmount;
	}
	public void setLastPaymentAmount(int lastPaymentAmount) {
		LastPaymentAmount = lastPaymentAmount;
	}
	public String getMortgagePropertyAddress() {
		return MortgagePropertyAddress;
	}
	public void setMortgagePropertyAddress(String mortgagePropertyAddress) {
		MortgagePropertyAddress = mortgagePropertyAddress;
	}
	public String getMortgageStage() {
		return MortgageStage;
	}
	public void setMortgageStage(String mortgageStage) {
		MortgageStage = mortgageStage;
	}
	public String getMortgagePropertyOwnership() {
		return MortgagePropertyOwnership;
	}
	public void setMortgagePropertyOwnership(String mortgagePropertyOwnership) {
		MortgagePropertyOwnership = mortgagePropertyOwnership;
	}
	public String getMortgageType() {
		return MortgageType;
	}
	public void setMortgageType(String mortgageType) {
		MortgageType = mortgageType;
	}
	public String getMortgageStartDate() {
		return MortgageStartDate;
	}
	public void setMortgageStartDate(String mortgageStartDate) {
		MortgageStartDate = mortgageStartDate;
	}
	public int getMortgageDuration() {
		return MortgageDuration/365;
	}
	public void setMortgageDuration(int mortgageDuration) {
		MortgageDuration = mortgageDuration;
	}
	public boolean isConformedMortgage() {
		return ConformedMortgage;
	}
	public void setConformedMortgage(boolean conformedMortgage) {
		ConformedMortgage = conformedMortgage;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public int getMortgageNumber() {
		return MortgageNumber;
	}
	public void setMortgageNumber(int mortgageNumber) {
		MortgageNumber = mortgageNumber;
	}
	@Override
	public String toString() {
		return "CustomerDetails [CustomerName=" + CustomerName + ", CustomerAddress=" + CustomerAddress
				+ ", CustomerSSN=" + CustomerSSN + ", CustomerDOB=" + CustomerDOB + ", GrantedLoanAmount="
				+ GrantedLoanAmount + ", RateofInterest=" + RateofInterest + ", PropertyValuation=" + PropertyValuation
				+ ", ReqLoanAmount=" + ReqLoanAmount + ", CreditScore=" + CreditScore + ", FinancialWorth="
				+ FinancialWorth + ", RiskClassification=" + RiskClassification + ", RiskAdjustedReturn="
				+ RiskAdjustedReturn + ", ExpectedAnnualCashflow=" + ExpectedAnnualCashflow
				+ ", RemainingMortgageAmount=" + RemainingMortgageAmount + ", Ownershipcost=" + Ownershipcost
				+ ", LastPaymentAmount=" + LastPaymentAmount + ", MortgagePropertyAddress=" + MortgagePropertyAddress
				+ ", MortgageStage=" + MortgageStage + ", MortgagePropertyOwnership=" + MortgagePropertyOwnership
				+ ", MortgageType=" + MortgageType + ", MortgageStartDate=" + MortgageStartDate + ", MortgageDuration="
				+ MortgageDuration + ", ConformedMortgage=" + ConformedMortgage + ", ModifiedBy=" + ModifiedBy
				+ ", MortgageNumber=" + MortgageNumber + "]";
	}

	
	
	
}
