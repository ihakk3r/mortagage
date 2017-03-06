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
	      defaultDate : "01/01/1980"
	    });
	$( "#mrtgageDate" ).datepicker({
	      changeMonth: true,
	      changeYear: true,
	      yearRange: "2000:2020"
	    });
	function isMrtgageDateValid(){
		var mrtgageDate = $('#mrtgageDate').val();
		var mrtgageDate_Regex = /^((0?[13578]|10|12)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$/;
		if (!mrtgageDate_Regex.test(mrtgageDate) || mrtgageDate.length == 0) {
		return false;
		}
		else{
		return true;
		}
		}
		$('#mrtgageDate').change(function(){
		var mrtgageDateValidationResult = isMrtgageDateValid();
		if(!mrtgageDateValidationResult) 
			{
				$('#p10').text("Mortgage format is invalid (MM/DD/YYYY)"); 
				$("#mrtgageDate_valid").show();
				$("#mrtgageDate_valid img").attr('src', "invalid.jpg");
			}
		else{
			$("#mrtgageDate_valid").show();
			$("#mrtgageDate_valid img").attr('src', "valid.jpg");
			$('#p10').text("");
		}
		});
		
		$("#mrtgageDuration").blur(function(){
			var mrtgageDurationValidationResult = isMrtgageDurationValid();
			if(!mrtgageDurationValidationResult)
				{
				
					$("#p11").text("Mortgate duration should be atmost (5-50) years");		
					$("#mrtgageDuration_valid").show();
					$("#mrtgageDuration_valid img").attr('src', "invalid.jpg");
				}
			else{
				$("#mrtgageDuration_valid").show();
				$("#mrtgageDuration_valid img").attr('src', "valid.jpg");
				$('#p11').text("");
			}	
			});
			function isMrtgageDurationValid(){
			var mrtgageDuration = $('#mrtgageDuration').val();
			var mrtgageDuration_regex;
			var mrtgageDurationerrMsg;

			mrtgageDuration_regex = /^[5-9]$|^[1-4][0-9]$|^50$/;

			if(!mrtgageDuration_regex.test(mrtgageDuration)){
				return false;	
			}
			else
			{
			return true;
			}
			}	
	
	$('#mPAdress').keyup(function(e){
		var mPAdressValue = $(this).val();
		    if(mPAdressValue.length > 250){
			this.value = mPAdressValue.substring(0,250);
		        return false;
		    }
		    $("#remainingCharMpAddress").html("Remaining characters : " +(250 - this.value.length));
		});
			
		$('#mPAdress').blur(function(){
		$("#remainingCharMpAddress").text("");
		if(!isMpAddressValid())
		{
		$('#p7').text("Mortgage Property Address should be numbers and letters only and the special characters(.,-/)");
		$("#mPAdress_valid").show();
		$("#mPAdress_valid img").attr('src', "invalid.jpg");
		}
		else{
		$("#mPAdress_valid").show();
		$("#mPAdress_valid img").attr('src', "valid.jpg");
		$('#p7').text("");
		}
		});
		function isMpAddressValid(){
		var mPAdress = $('#mPAdress').val();
		var mPAdress_regex = /^[a-zA-Z0-9.-]+(\,)*(\/)*(\s*\w+)*(([a-zA-Z0-9.-]+(\,)*(\/)*)*(\s*\w+)*)*$/;
		if (!mPAdress_regex.test(mPAdress) || mPAdress.length == 0) {
		return false;
		}
		else{
		return true;
		}
		}
		
		
		
		$("#oCost").blur(function(){
			var oCostValidationResult = oCostAmountValid();
			if(!oCostValidationResult)
				{
					$("#p21").text("Mortgage Ownership cost should be between $100 to $99,999,99");
					$("#oCost_valid").show();
					$("#oCost_valid img").attr('src', "invalid.jpg");
				}
			else{
				$("#oCost_valid").show();
				$("#oCost_valid img").attr('src', "valid.jpg");
				$('#p21').text("");
			}	
			});
			function oCostAmountValid(){
			var oCost = $('#oCost').val();

			if(parseInt(oCost)>=100 && parseInt(oCost)<=9999999){
				return true;	
			}
			else
			{
			return false;
			}
			}
		
		$("#gloanAmount").blur(function(){
			var loadAmountValidationResult = isgloanAmountValid();
			if(!loadAmountValidationResult)
				{
					$("#p5").text("Granted Amount should be less than $99,999,99");
				/* 	$("#gloanAmount").focus(); */
					$("#gloanAmountvalid").show();
					$("#gloanAmount_valid img").attr('src', "invalid.jpg");
				}
			else{
				$("#gloanAmount_valid").show();
				$("#gloanAmount_valid img").attr('src', "valid.jpg");
				$('#p5').text("");
			}	
			});
			function isgloanAmountValid(){
			var gloanAmount = $('#gloanAmount').val();

			if(parseInt(gloanAmount)>=0 && parseInt(gloanAmount)<=9999999) {
				return true;
			}
			else {
				return false;
			}

			}

			$("#roi").blur(function(){
				var roiValid = isROIValid();
				if(!roiValid)
					{
						$("#p13").text("Please Enter Valid Rate of Interest (x%)");
						$("#roi").focus();
						$("#roivalid").show();
						$("#roi_valid img").attr('src', "invalid.jpg");
					}
				else{
					$("#roi_valid").show();
					$("#roi_valid img").attr('src', "valid.jpg");
					$('#p13').text("");
				}	
				});

				function isROIValid(){
				var roiAmount = $('#roi').val();
				var roi_regex = /^\d{1,2}(\.\d{1,2})?$/;

				if(!roiAmount.match(roi_regex)){
					return false;	
				}
				else
				{
				return true;
				}
				}
				
				//Propert Valuation Validation
				function validatePvaluation(){
					var ispValuationResult = ispValuationValid();
					if(!ispValuationResult)
						{
						$("#p14").text("Property Valuation must be a 4-7 digit value.");
						
							$("#pValuationvalid").show();
							$("#pValuation_valid img").attr('src', "invalid.jpg");
						}
					else{
						$("#pValuation_valid").show();
						$("#pValuation_valid img").attr('src', "valid.jpg");
						$('#p14').text("");
					}	
				}
					
				
					//Credit Score Validation
					function validateCreditScore(){
						var iscScoreValidResult = iscScoreValid();
						if(!iscScoreValidResult)
							{
								$("#p15").text("Credit Score range must be 50-800.");
						
								$("#cScorevalid").show();
								$("#cScore_valid img").attr('src', "invalid.jpg");
							}
						else{
							$("#cScore_valid").show();
							$("#cScore_valid img").attr('src', "valid.jpg");
							$('#p15').text("");
						}	
					}
						
				
								function validateFNetworth(){
									var fNetworth = isFNetworthValid();
									if(!fNetworth)
										{
											$("#p16").text("Financial Networth Amount must be 4-7 Digit Number.");
									
											$("#fNetworth").show();
											$("#fNetworth_valid img").attr('src', "invalid.jpg");
										}
									else{
										$("#fNetworth_valid").show();
										$("#fNetworth_valid img").attr('src', "valid.jpg");
										$('#p16').text("");
									}	
									}
									  
									
									function iscScoreValid(){
										var cScore = $('#cScore').val();
										

										if(parseInt(cScore)>=50 && parseInt(cScore)<=800) {
											return true;
										}
										else {
											return false;
										}
									  }
										
									function isFNetworthValid(){
											var fNetworth = $('#fNetworth').val();
											var fNetworth_regex = /^\d{4,7}(\.\d{0,2})?$/;

											if(!fNetworth.match(fNetworth_regex)){
												return false;	
											}
											else
											{
											return true;
											}
											}
									function ispValuationValid(){
										var pValuation = $('#pValuation').val();
										var pValuation_regex = /^\d{4,7}(\.\d{0,2})?$/;

										if(!pValuation.match(pValuation_regex)) return false;
										else return true;
									}
									
									
							
									$('#update').click(function(e) {
										
										$('#successMsg').text("");
										$('#errorMsg').text("");
										var result = true;
											
										 if(isROIValid()&&isgloanAmountValid()&&isMpAddressValid()){											   
											   $('#bankForm').attr("action","bank?action=put&type=update");
											   return true;
											}
											else{
											
												$('#errorMsg').text("Error! Please correct the errors and re-submit the form");
												window.scrollTo(0,0);
												return false;
											}
										 
									});
									$('#additional').click(function(e) {
										$('#successMsg').text("");	
										$('#errorMsg').text("");
										$('#bankForm').attr("action","bank?action=put&type=additional");
				
										return true;
										
									});
										$('#approve').click(function(e) {
											$('#successMsg').text("");	
											$('#errorMsg').text("")
											var oCostValid = true;
											if($('#oCost').val()!=0)
												oCostValid = oCostAmountValid();
											 if(oCostValid&&isFNetworthValid()&&iscScoreValid()&&ispValuationValid()&&isROIValid()&&isgloanAmountValid()&&isMpAddressValid()){
												   
												   $('#bankForm').attr("action","bank?action=put&type=approve");
			
												   return true;
												}
												else
												{
													$('#roi').trigger('blur');
													$('#gloanAmount').trigger('blur');
													$('#mPAdress').trigger('blur');
													$('#oCost').trigger('blur');
													
													 if(!ispValuationValid()||!isFNetworthValid()||!iscScoreValid()){
														$('#errorMsg').text("Error!You cannot approve this application. Property Valuation, Financial Networth, Credit score should be acquired from Data Service provider.");
														window.scrollTo(0,0);
													 }else{
														$('#errorMsg').text("Error! Please correct the errors and re-submit the form");
														window.scrollTo(0,0);
													 }return false;
												}
											 
										});
												$('#deny').click(function(e) {
													$('#successMsg').text("");	
													$('#errorMsg').text("");
													
												 	   $('#bankForm').attr("action","bank?action=put&type=deny");
														  return true;							 
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
	<li><a href="bank?action=getAll"  class="sideActive">Mortgage Application</a></li>
    <li><a href="bank?action=getGse">Approve GSE Transfers</a></li>  
    <li><a href="bank?action=getAuction">Auction Mortgages</a></li>  
    <li><a href="bank?action=reviewAuction">Review Auction Mortgages</a></li>  
     <li><a href="bank?action=getPurchaseRequest" >Approve Auction Transfers</a></li> 
    <li><a href="bank?action=getDisbursed">Monthly Mortgage Servicing</a></li>
    <li><a href="customerMetrics.jsp">Customer Time service metrics</a></li>
  </ul>
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<article>
<div id="form">
<p id="head"></p> 
<h2>Mortgage Application</h2>
<form id="bankForm" action="" method="POST"> 

<label>Mortgage Number</label>
<input id='mrtgageNumber' readonly="readonly" name="mrtgageNumber" type='text'  value = "${customerDetails.getMortgageNumber()}"><span id="customerName_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p1"></p> 
<input name="mortgageNumber" type='hidden' value="${customerDetails.getMortgageNumber()}" />

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
<textarea id='mPAdress' name="mPAdress" rows="4" cols="33" >${customerDetails.getMortgagePropertyAddress()}</textarea><span id="mPAdress_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id='remainingCharMpAddress'></p>
<p id="p7"></p>

<label>Requested Loan Amount </label>
<input type="text" name="loanAmount" id="loanAmount" readonly value="${customerDetails.getReqLoanAmount()}"><label><b>$</b></label><span id="loanAmount_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p24"></p> 

<label>Granted Loan Amount</label>
<input type="text" name="gloanAmount" id="gloanAmount" ${makeDisbursedFieldsReadonly} value="${customerDetails.getGrantedLoanAmount()}" ><label><b>$</b></label><span id="gloanAmount_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p5"></p> 

<label>Rate of Interest</label>
<input type="text" name="rateOfInterest" id="roi" ${makeDisbursedFieldsReadonly} value="${customerDetails.getRateofInterest()}" ><label>%</label><span id="roi_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p13"></p> 

<label>Mortgage Start Date</label>
<input type="text" name="mrtgageStartDate" id="mrtgageDate" ${makeDisbursedFieldsReadonly} value="${customerDetails.getMortgageStartDate()}" ><span id="mrtgageDate_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p10"></p>

<label>Mortgage Duration</label>
<select id="mrtgageDuration" name="mrtgageDuration"  ${makeDisbursedSelectDisabled}> 
	<option value="0" >Select</option>
	<option value="10" ${customerDetails.getMortgageDuration() == '10' ? 'selected' : ''}>10</option>
	<option value="15" ${customerDetails.getMortgageDuration() == '15' ? 'selected' : ''}>15</option>
	<option value="20" ${customerDetails.getMortgageDuration() == '20' ? 'selected' : ''}>20</option>
	<option value="30" ${customerDetails.getMortgageDuration() == '30' ? 'selected' : ''}>30</option>
</select>
<label>Years</label>
<span id="mrtgageDuration_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p11"></p> 

<label>Property Valuation </label>
<input type="text" name="pValuation" id="pValuation" value="${customerDetails.getPropertyValuation()}" readonly ><label><b>$</b></label><span id="pValuation_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p14"></p>

<label>Credit Score</label>
<input type="text" name="creditScore" id="cScore" value="${customerDetails.getCreditScore()}"readonly ><span id="cScore_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p15"></p>

<label>Financial Networth</label>
<input type="text" name="fNetworth" id="fNetworth" value="${customerDetails.getFinancialWorth()}" readonly ><label><b>$</b></label><span id="fNetworth_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
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

<label>Mortgage Deed Ownership </label>
<input type="text" id="mrtgageOwnership" name="mortgageOwnership" readonly="readonly" value="${customerDetails.getMortgagePropertyOwnership()}"><span id="mrtgageOwnership_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p22"></p>

<label>Ownership Cost </label>
<input type="text" id="oCost" name="ownershipCost" ${makeDisbursedFieldsReadonly} value="${customerDetails.getOwnershipcost()}"><label><b>$</b></label><span id="oCost_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p21"></p> 

<input id="update" type="submit" value="Update Information" style="width: auto">
<input type="hidden" id="updateCustomer" value="updateCustomer" name="updateCustomer" >

<input type="submit" id="additional" value="Request additional documents">
<input type="submit" id="approve" value="Approve">
<input type="submit" id="deny" value="Deny">
</form>
</div>

</article>

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>
