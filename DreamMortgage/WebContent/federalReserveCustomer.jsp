<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="styles.css" rel="stylesheet">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
</script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>Federal Reserve - Customer Details</title>
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
    <li><a href="partnerbank?action=getPurchase"  class="">Partner Bank</a></li>
    <li><a href="securitization?action=get"  class="">Securitization</a></li>
    <li><a href="brokerage?action=get">Full brokerage firm</a></li>
    <li><a href="citycouncil"  >City Council</a></li>
    <li><a href="federalreserve" class="active">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>


<div class="sidebar" style="height: 1000px">
  
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<p id="desc" style="font-weight: bold; color: green;">Real time reporting to Federal reserve will help provide quick inputs to refine overall monetary policy</p>
<article>
<center><h2>Mortgage statistics</h2></center>
<div id="form">
<table class="cssTableLayout">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="5">Number of mortgage by stages</th>
							<th rowspan="2">Total Mortgages</th>
</tr>
<tr>
							<th>Approved</th>
							<th>Disbursed</th>
							<th>Denied</th>
							<th>Pending bank</th>
							<th>Pending customer</th>
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getApprovedCount()}</td>
								<td>${eachYearKey.getDisbursedCount()}</td>
								<td>${eachYearKey.getDeniedCount()}</td>
								<td>${eachYearKey.getPendingBankCount()}</td>
								<td>${eachYearKey.getPendingCustomerCount()}</td>
								<td>${eachYearKey.getTotalCount()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 300px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="4">Mortgages by ownership</th>
</tr>
<tr>
							<th>NOT_ACQUIRED</th>
							<th>LENDING_BANK</th>
							<th>GSE</th>
							<th>PARTNER_BANK</th>
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getNotAquiredCount()}</td>
								<td>${eachYearKey.getLendingBankCount()}</td>
								<td>${eachYearKey.getGseCount()}</td>
								<td>${eachYearKey.getPartnerBankCount()}</td>
							</tr>

						</c:forEach>
</table>


<br/>

<table class="cssTableLayout" style="width: 300px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="4">Mortgages by Average duration(Disbursed only)</th>
</tr>
<tr>
							<th>10</th>
							<th>15</th>
							<th>20</th>
							<th>30</th>
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getAverage10Count()}</td>
								<td>${eachYearKey.getAverage15Count()}</td>
								<td>${eachYearKey.getAverage20Count()}</td>
								<td>${eachYearKey.getAverage30Count()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 200px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="4">Mortgages by type(Disbursed only)</th>
</tr>
<tr>
							<th>ARM</th>
							<th>FIXED</th>
							
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getArmCount()}</td>
								<td>${eachYearKey.getFixedCount()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 600px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="6">Distribution by mortgage size(Disbursed only)</th>
</tr>
<tr>
							<th><100 K $</th>
							<th>>100K and 250K $</th>
							<th>>250K to 500K $</th>
							<th>> 500K to 750 K $</th>
							<th>>750K to 1 Million $</th>
							<th>>1 Million $</th>
							
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getDistributionBylessThan100KCount()}</td>
								<td>${eachYearKey.getBetweek100kAnd250k()}</td>
								<td>${eachYearKey.getBetween250kAnd500k()}</td>
								<td>${eachYearKey.getBetween500kAnd750k()}</td>
								<td>${eachYearKey.getBetween750kAndoneMillion()}</td>
								<td>${eachYearKey.getGreaterthanOneMillion()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 600px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="5">Distribution by mortgage Rate of Interest (Disbursed only)</th>
</tr>
<tr>
							<th><3.0%</th>
							<th>between 3.1% to 5.0%</th>
							<th>between 5.0% to 7.5%</th>
							<th>between 7.6% to 10%</th>
							<th>>10.1%</th>
							
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getRoilessthan3point()}</td>
								<td>${eachYearKey.getRoibetween3point1And5Point0()}</td>
								<td>${eachYearKey.getRoibetween5point0And7Point5()}</td>
								<td>${eachYearKey.getRoibetween7point6And10()}</td>
								<td>${eachYearKey.getRoigreaterThan10point1()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 330px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="4">Mortgages by Risk Classification(Disbursed only)</th>
</tr>
<tr>
							<th>A</th>
							<th>B</th>
							<th>C</th>
							<th>D</th>
							
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getRisClassificationACount()}</td>
								<td>${eachYearKey.getRisClassificationBCount()}</td>
								<td>${eachYearKey.getRisClassificationCCount()}</td>
								<td>${eachYearKey.getRisClassificationDCount()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 330px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="4">Mortgages by Mortgage start date(Disbursed only))</th>
</tr>
<tr>
							<th>Q1</th>
							<th>Q2</th>
							<th>Q3</th>
							<th>Q4</th>
							
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td>${eachYearKey.getQuarter1Count()}</td>
								<td>${eachYearKey.getQuarter2Count()}</td>
								<td>${eachYearKey.getQuarter3Count()}</td>
								<td>${eachYearKey.getQuarter4Count()}</td>
							</tr>

						</c:forEach>
</table>

<br/>

<table class="cssTableLayout" style="width: 330px;">
<tr>
							<th rowspan="2">Year</th>
							<th colspan="5">Mortgages Averages in Dollars</th>
</tr>
<tr>
							<th>Requested loan Amount</th>
							<th>Granted Loan Amount</th>
							<th>Ownership cost</th>
							<th>Remaining Mortgage amount</th>
							<th>Expected annual cashflow</th>
						
</tr>

<c:forEach items="${federalReserveMapByYears.values()}" var="eachYearKey">


							<tr>
								<td>${eachYearKey.getYear()}</td>
								<td><b>$</b>${eachYearKey.getAverageRequestedLoanAmount()}</td>
								<td><b>$</b>${eachYearKey.getAverageGrantedLoanAmount()}</td>
								<td><b>$</b>${eachYearKey.getAverageOwnershipCost()}</td>
								<td><b>$</b>${eachYearKey.getAverageRemainingLoanAmount()}</td>
								<td><b>$</b>${eachYearKey.getAverageECashFlow()}</td>
							</tr>

						</c:forEach>
</table>

</div>

</article>


<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>
