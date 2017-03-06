<!DOCTYPE html>
<html>
<head>
<link href="styles.css" rel="stylesheet">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
</script>
<script>
$(document).ready(function() {
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
		$("#pValuation").blur(function(){
			var ispValuationResult = ispValuationValid();
			if(!ispValuationResult)
				{
					$("#p14").text("Property Valuation should be between $1,000 to $99,999,99");
				/* 	$("#gloanAmount").focus(); */
					$("#pValuationvalid").show();
					$("#pValuation_valid img").attr('src', "invalid.jpg");
				}
			else{
				$("#pValuation_valid").show();
				$("#pValuation_valid img").attr('src', "valid.jpg");
				$('#p14').text("");
			}	
			});
			function ispValuationValid(){
			var pValuation = $('#pValuation').val();
			
			if(parseInt(pValuation)>=1000 && parseInt(pValuation)<=9999999) {
				return true;
			}
			else {
				return false;
			}
		}
		
			//Credit Score Validation
			$("#cScore").blur(function(){
				var iscScoreValidResult = iscScoreValid();
				if(!iscScoreValidResult)
					{
						$("#p15").text("Credit Score range should be between 50 to 800.");
					/* 	$("#gloanAmount").focus(); */
						$("#cScore_valid").show();
						$("#cScore_valid img").attr('src', "invalid.jpg");
					}
				else{
					$("#cScore_valid").show();
					$("#cScore_valid img").attr('src', "valid.jpg");
					$('#p15').text("");
				}	
				});
				function iscScoreValid(){
				var cScore = $('#cScore').val();

				if(parseInt(cScore)>=50 && parseInt(cScore)<=800) {
					return true;
				}
				else {
					return false;
				}
			}

						//Remaining Loan Amount Validation
						$("#fNetworth").blur(function(){
							var fNetworth = isFNetworthValid();
							if(!fNetworth)
								{
									$("#p16").text("Financial Networth Amount should be between $1,000 to $9,999,999.");
								/* 	$("#gloanAmount").focus(); */
									$("#fNetworth").show();
									$("#fNetworth_valid img").attr('src', "invalid.jpg");
								}
							else{
								$("#fNetworth_valid").show();
								$("#fNetworth_valid img").attr('src', "valid.jpg");
								$('#p16').text("");
							}	
							});
							function isFNetworthValid(){
							var fNetworth = $('#fNetworth').val();
						
							if(parseInt(fNetworth)>=1000 && parseInt(fNetworth)<=9999999) {
								return true;
							}
							else {
								return false;
							}
							
							}
					
							$('#submit').click(function(e) {
								
								$('#successMsg').text("");
								 $('input,textarea').each(function(){
								  $(this).trigger('blur');
								  //each input event one by one... will be blured
								});
								 
								 if(isFNetworthValid()&&iscScoreValid()&&ispValuationValid()&&isROIValid()&&isgloanAmountValid()&&isMpAddressValid()&&lpAmountValid){
									   return true;	
									}
									else
									{
										$('#errorMsg').text("Error! Please correct the errors and re-submit the form");
										window.scrollTo(0,0);
										return false;
									}
								 
							});
							
});
</script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>Data Service Provider - Customer Details</title>
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
    <li><a href="bank?action=getAll" >Lending Bank</a></li>
       <li><a href="partnerbank?action=getPurchase" >Partner Bank</a></li>
    <li><a href="securitization?action=get">Securitization</a></li>
     <li><a href="brokerage?action=get">Full brokerage firm</a></li>
    <li><a href="citycouncil"  >City Council</a></li>
    <li><a href="federalreserve" >Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="active">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>


<div  class="sidebar">
  
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<article>
<div id="form">
<p id="head"></p> 
<h2>Mortgage Details</h2>
<form action="serviceprovider?action=put" method="POST"> 

<label>Mortgage Number</label>
<input id='mrtgageNumber' name="mortgageNumber" type='text' readonly value = "${customerDetails.getMortgageNumber()}"><span id="customerName_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p1"></p> 
<input name="mrtgageNumber" type='hidden' value="${customerDetails.getMortgageNumber()}" />

<label>Customer Name</label>
<input id='customerName' name="customerName" type='text' readonly value = "${customerDetails.getCustomerName()}"><span id="customerName_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p1"></p> 

<label>SSN</label>
<input id='customerSSN' type='text' readonly value = "${customerDetails.getCustomerSSN()}" readonly><span id="customerSSN_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p3"></p> 

<label>Property Valuation </label>
<input type="text" name="pValuation" id="pValuation" value="${customerDetails.getPropertyValuation()}" ><label><b>$</b></label><span id="pValuation_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p14"></p>

<label>Credit Score</label>
<input type="text" name="creditScore" id="cScore" value="${customerDetails.getCreditScore()}" ><span id="cScore_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p15"></p>

<label>Financial Networth</label>
<input type="text" name="fNetworth" id="fNetworth" value="${customerDetails.getFinancialWorth()}" ><label><b>$</b></label><span id="fNetworth_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p16"></p>

<input id="submit" type="submit" value="Submit">

</form>
</div>

</article>

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>
