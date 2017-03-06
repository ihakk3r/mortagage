<!DOCTYPE html>
<html>
<head>
<title>Bank - Customer Details</title>
<link href="styles.css" rel="stylesheet">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
</script>
<script>
$(document).ready(function() {
	
	$( "#customerDOB" ).datepicker({
	      changeMonth: true,
	      changeYear: true,
	      yearRange: "1950:1999",
	      defaultDate: "01/01/1980"
	    });
	$( "#mrtgageDate" ).datepicker({
	      changeMonth: true,
	      changeYear: true,
	      yearRange: "2000:2020"
	    });

$("#applylpAmount").blur(function(){
	var applylpAmountValidationResult = applylpAmountValid();
	if(!applylpAmountValidationResult)
		{
			$("#p20").text("Last Payment Amount range must be $100 - $99,999,99");
			$("#applylpAmount_valid").show();
			$("#applylpAmount_valid img").attr('src', "invalid.jpg");
		}
	else{
		$("#applylpAmount_valid").show();
		$("#applylpAmount_valid img").attr('src', "valid.jpg");
		$('#p20').text("");
	}	
	});
	function applylpAmountValid(){
	var applylpAmount = $('#applylpAmount').val();
	var applylpAmount_regex = /^\d{3,7}(\.\d{0,2})?$/;
	if(!applylpAmount.match(applylpAmount_regex)){
		return false;	
	}
	else
	{
	return true;
	}
	}
	
	$('#update').click(function(e) {
		var applylpAmount = $('#applylpAmount').val();
		 if(parseInt(applylpAmount)>=100 && parseInt(applylpAmount)<=9999999){
			   return true;
			}
			else
			{
				$("#applylpAmount").trigger(blur);
				$('#errorMsg').text("Error! Please correct the errors and re-submit the form");
				window.scrollTo(0,0);
				return false;
			}
		 
	});
	
									
});
</script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
<body>

<div class="container">

<div class="header">
<div class="navBar">
<ul>
    <li><a href="homepage.jsp" >Home</a></li>
    <li><a href="About.jsp">About</a></li>
    
    <li><a href="contactus.jsp">Contact Us</a></li>
</ul>
</div>
  <img src="home-mortgage.png" alt="logo" style="width: 130px; height: 105px;"/>
  <h1>Dream Mortgage</h1>
  <font id="caption"><b>The next generation mortgage application</b></font>
</div>
  
<div class="navBar">
   <ul>
    <li><a href="newcustomer.jsp" >Customer</a></li>
    <li><a href="bank?action=getAll" class="active" >Lending Bank</a></li>
     <li><a href="partnerbank?action=getPurchase"  class="">Partner Bank</a></li>
    <li><a href="securitization?action=get"  class="">Securitization</a></li>
      <li><a href="brokerage?action=get">Full brokerage firm</a></li>
    <li><a href="citycouncil"  class="">City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>


<div class="sidebar">
  <ul>
	<li><a href="bank?action=getAll">Mortgage Application</a></li>
    <li><a href="bank?action=getGse">Approve GSE Transfers</a></li>  
    <li><a href="bank?action=getAuction">Auction Mortgages</a></li>  
    <li><a href="bank?action=reviewAuction">Review Auction Mortgages</a></li>  
     <li><a href="bank?action=getPurchaseRequest" >Approve Auction Transfers</a></li> 
    <li><a href="bank?action=getDisbursed" class="sideActive">Monthly Mortgage Servicing</a></li>  
    <li><a href="customerMetrics.jsp">Customer Time service metrics</a></li>
  </ul>
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<p id="desc" style="font-weight: bold; color: green;">On this page lending bank services all its issued mortgages for servicing fee.</p>
<article>
<div id="form">
<p id="head"></p> 
<h2>Mortgage Monthly Servicing</h2>
<form id="bankForm" action="bank?action=monthlyService" method="POST"> 

<label>Mortgage Number</label>
<input id='mrtgageNumber' readonly="readonly" name="mortgageNumber" type='text'  value = "${customerDetails.getMortgageNumber()}"><span id="customerName_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p1"></p> 
<input name="mortgageNumber" type='hidden' value="${customerDetails.getMortgageNumber()}" />

<label>Apply Mortgage Amount</label>
<input id='applylpAmount' name="applylpAmount" type='text' value = "0"><label><b>$</b></label><span id="applylpAmount_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p20"></p> 

<label>Last Payment Amount</label>
<input id='lastPaymentReadOnly' name="lastPaymentReadOnly" readonly type='text' value = "${customerDetails.getLastPaymentAmount()}"><label><b>$</b></label><span id="lastPaymentReadOnly_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p27"></p> 

<label>Customer Name</label>
<input id='customerName' name="customerName" readonly="readonly" type='text'  value = "${customerDetails.getCustomerName()}"><span id="customerName_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p1"></p> 

<label>SSN</label>
<input id='customerSSN' type='text' readonly="readonly"  value = "${customerDetails.getCustomerSSN()}"><span id="customerSSN_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p3"></p> 

<span id="wrap"> <label for="address">Customer Address</label></span>
<textarea id='customerAddress' readonly="readonly" rows="4" cols="33" >${customerDetails.getCustomerAddress()}</textarea><span id="customerAddress_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id='remainingC'></p>
<p id="p2"></p>

<label>Date of Birth</label>
<input type="text" id="customerDOB" readonly="readonly" value = "${customerDetails.getCustomerDOB()}"><span id="customerDOB_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p4"></p>

<label>Mortgage Stage</label>
<select id='mStage' name="mStage" disabled>
  <option value="Pending-Customer:" ${customerDetails.getMortgageStage() == 'Pending-Customer:' ? 'selected' : ''}>Pending-Customer:</option>
  <option value="Pending-Bank:" ${customerDetails.getMortgageStage() == 'Pending-Bank:' ? 'selected' : ''}>Pending-Bank</option>
  <option value="Approved:" ${customerDetails.getMortgageStage() == 'Approved:' ? 'selected' : ''}>Approved:</option>
  <option value="Denied:" ${customerDetails.getMortgageStage() == 'Denied:' ? 'selected' : ''}>Denied:</option>
  <option value="Disbursed:" ${customerDetails.getMortgageStage() == 'Disbursed:' ? 'selected' : ''}>Disbursed:</option>
  <option value="Disbursed:Ready to Sell" ${customerDetails.getMortgageStage() == 'Disbursed:Ready to Sell' ? 'selected' : ''}>Disbursed:Ready to Sell</option>
  <option value="Disbursed:Ready to purchase" ${customerDetails.getMortgageStage() == 'Disbursed:Ready to purchase' ? 'selected' : ''}>Disbursed:Ready to purchase</option>
  <option value="Disbursed:Approved" ${customerDetails.getMortgageStage() == 'Disbursed:Approved' ? 'selected' : ''}>Disbursed:Approved</option>
  <option value="Disbursed:Sold" ${customerDetails.getMortgageStage() == 'Disbursed:Sold' ? 'selected' : ''}>Disbursed:Sold</option>
</select>
<p id="p12"></p> 

<label>Mortgage Property Address</label>
<textarea id='mPAdress' name="mPAdress" readonly="readonly" rows="4" cols="33">${customerDetails.getMortgagePropertyAddress()}</textarea><span id="mPAdress_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id='remainingCharMpAddress'></p>
<p id="p7"></p>

<label>Granted Loan Amount</label>
<input type="text" name="gloanAmount" readonly="readonly" id="gloanAmount" ${notDisbursed} value="${customerDetails.getGrantedLoanAmount()}" ><label><b>$</b></label><span id="gloanAmount_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<label>$</label>
<p id="p5"></p> 

<label>Rate of Interest</label>
<input type="text" name="rateOfInterest" id="roi" readonly="readonly" value="${customerDetails.getRateofInterest()}" ><label>%</label><span id="roi_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p13"></p> 

<label>Mortgage Start Date</label>
<input type="text" name="mrtgageStartDate" id="mrtgageDate" readonly="readonly" value="${customerDetails.getMortgageStartDate()}" ><span id="mrtgageDate_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p10"></p>

<label>Mortgage Duration</label>
<input type="text" name="mrtgageDuration" id="mrtgageDuration" readonly="readonly" value="${customerDetails.getMortgageDuration()}" >
<select id="durationType" disabled> <option value="1">Years</option><option value="0">Days</option></select>
<span id="mrtgageDuration_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p11"></p> 

<label>Property Valuation </label>
<input type="text" name="pValuation" id="pValuation" value="${customerDetails.getPropertyValuation()}" readonly="readonly" ><label><b>$</b></label><span id="pValuation_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p14"></p>

<label>Credit Score</label>
<input type="text" name="creditScore" id="cScore" value="${customerDetails.getCreditScore()}" readonly="readonly" ><span id="cScore_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p15"></p>

<label>Financial Networth</label>
<input type="text" name="fNetworth" id="fNetworth" value="${customerDetails.getFinancialWorth()}" readonly="readonly" ><label><b>$</b></label><span id="fNetworth_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p16"></p>

<label>Risk Classification </label>
<input type="text" id="rClassification" readonly="readonly" value="${customerDetails.getRiskClassification()}"><span id="rClassification_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p17"></p>

<label>% Risk Adjusted Return</label>
<input type="text" id="rAdjusted" readonly="readonly" value="${customerDetails.getRiskAdjustedReturn()}"><span id="rAdjusted_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p18"></p>

<label>Expected Annual Cashflow </label>
<input type="text" id="eAFlow" readonly="readonly" value="${customerDetails.getExpectedAnnualCashflow()}"><label><b>$</b></label><span id="eAFlow_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p19"></p>

<label>Remaining Mortgage Amount</label>
<input type="text" id="rLAmount" readonly="readonly" value="${customerDetails.getRemainingMortgageAmount()}"><label><b>$</b></label><span id="rLAmount_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p20"></p>

<label>Mortgage Deed Ownership </label>
<input type="text" id="mortgageOwnership" name="mortgageOwnership" readonly="readonly" value="${customerDetails.getMortgagePropertyOwnership()}"><span id="oCost_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p22"></p>

<label>Ownership Cost </label>
<input type="text" id="oCost" name="ownershipCost" readonly="readonly" value="${customerDetails.getOwnershipcost()}"><label><b>$</b></label><span id="oCost_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p21"></p> 




<input id="update" type="submit" value="Update Information" style="width: auto;">

</form>
</div>

</article>

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>
