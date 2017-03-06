<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Bank - Auction Mortgages</title>
<link href="styles.css" rel="stylesheet">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
</script>
<script>
$(document).ready(function() {
	var isAtleastOneChecked = false;
	$('#selectAll').on('change',function(){
		var isChecked = $(this).is(':checked');
		$('input[type=checkbox]').each(function(){
			$(this).prop("checked",isChecked);
		});
	});
	
	$('#submit').click(function(){
		
		$('input[type=checkbox]').each(function(){
			isAtleastOneChecked = $(this).is(':checked');
			if(isAtleastOneChecked)
				return false;
		});
		
		if(isAtleastOneChecked){
			$('#bankForm').attr("action","bank?action=auction");
			return true;
		}
		else{
			$('#errorMsg').text("You must select atleast one mortgage.");
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
	<li><a href="bank?action=getAll" >Mortgage Application</a></li>
    <li><a href="bank?action=getGse">Approve GSE Transfers</a></li>  
    <li><a href="bank?action=getAuction" class="sideActive">Auction Mortgages</a></li>  
    <li><a href="bank?action=reviewAuction">Review Auction Mortgages</a></li>  
    <li><a href="bank?action=getPurchaseRequest">Approve Auction Transfers</a></li> 
    <li><a href="bank?action=getDisbursed">Monthly Mortgage Servicing</a></li>
    <li><a href="customerMetrics.jsp">Customer Time service metrics</a></li>
    
  </ul>
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<p id="desc" style="font-weight: bold; color: green;">On this page lending bank sells mortgage deeds to partner bank in return for capital.</p>
<article>
<div id="form">
<p id="head"></p> 
<c:if test="${not empty auctionCustomerList}">
<h2>Auction Mortgages</h2>

<form id="bankForm" method="POST"> 
<table class="cssTableLayout">
<tr>
							<th><input type="checkbox" id="selectAll"></th>
							<th>Customer Name</th>
							<th>Mortgage Number</th>
							<th>Mortgage Property Address</th>
							<th>Granted Loan Amount</th>
							<th>Mortgage Start Date</th>
							<th>Mortgage Duration</th>
							<th>Remaining Mortgage Amount</th>
							<th>Mortgage Deed Ownership</th>
							<th>Ownership Cost</th>
							<th>Risk Classification</th>
							<th>Risk Adjusted Return</th>
							<th>Expected Annual Cashflow</th>
							<th>Conformed Mortgage</th>

</tr>
<c:forEach items="${auctionCustomerList}" var="eachCustomer">

							<tr>
							<td><input type="checkbox" name="customer" value="${eachCustomer.getMortgageNumber()}"></td>
								<td>${eachCustomer.getCustomerName()}</td>
								<td>${eachCustomer.getMortgageNumber()}</td>
								<td>${eachCustomer.getMortgagePropertyAddress()}</td>
								<td><b>$</b>${eachCustomer.getGrantedLoanAmount()}</td>
								<td>${eachCustomer.getMortgageStartDate()}</td>
								<td>${eachCustomer.getMortgageDuration()}</td>
								<td><b>$</b>${eachCustomer.getRemainingMortgageAmount()}</td>
								<td>${eachCustomer.getMortgagePropertyOwnership()}</td>
								<td><b>$</b>${eachCustomer.getOwnershipcost()}</td>								
								<td>${eachCustomer.getRiskClassification()}</td>
								<td>${eachCustomer.getRiskAdjustedReturn()}</td>
								<td><b>$</b>${eachCustomer.getExpectedAnnualCashflow()}</td>
								<c:if test="${eachCustomer.isConformedMortgage() eq true}">
								<td>Yes</td>
								</c:if>
								<c:if test="${eachCustomer.isConformedMortgage() ne true}">
								<td>No</td>
								</c:if>
							</tr>

						</c:forEach>
</table>
<br/>
<input type="submit" id="submit" value="Open for Auction" style="width: 120px; height:27px;">
<p id="pError" style="margin-left: 0px"></p>

</form>
</c:if>
</div>

</article>

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>
