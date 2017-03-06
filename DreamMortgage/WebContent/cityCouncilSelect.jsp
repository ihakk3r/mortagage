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
<title>City Council - Customer Details</title>
<script>
$(document).ready(function() {
	
	$('#submit').click(function(){
		
		if($('#mortagaePropertyAddress').val().length!=0){
			return true;
		}
		else{
			$('#p1').text("Mortgage Property Address should not be left blank");
			return false;
		}
			
	});
	
});
</script>
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
    <li><a href="citycouncil"  class="active">City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>
<div class="sidebar">
  
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<p id="desc" style="font-weight: bold; color: green;">This page provides search function to city or municipalities who provides essential services and are taxing authority reviews the upcoming transfers to  better anticipate the changes and to reach out the customer once customer owns home in their jurisdiction
</p>
<article>
<div id="form">

<form action="citycouncil" method="POST"> 

<label style="font-weight: bold">Mortgage Property Address :</label>
<input id="mortagaePropertyAddress" name="mortagaePropertyAddress"  style="height: 22px;" type="text" >
<input type="submit" id="submit"  style="height: 25px;" value="Search"/>
<p id="p1" style="margin-left: 200px"></p>
    <c:if test="${not empty customersDetails}">  
   <div style="height: 20px">
   </div>
<table class="cssTableLayout">
<tr>
							<th>Mortgage Number</th>
							<th>Customer Name</th>
							<th>Customer's Address</th>
							<th>Mortgage Property Address</th>
							<th>Mortgage Start Date</th>
</tr>
<c:forEach items="${customersDetails}" var="eachCustomer">
							<tr>
								<td>${eachCustomer.getMortgageNumber()}</td>
								<td>${eachCustomer.getCustomerName()}</td>
								<td>${eachCustomer.getCustomerAddress()}</td>
								<td>${eachCustomer.getMortgagePropertyAddress()}</td>
								<td>${eachCustomer.getMortgageStartDate()}</td>
							</tr>
						</c:forEach>
</table>

 </c:if> 
 </form>
</div>
</article>
<footer>Copyright &copy; Team@DreamMortgage</footer>
</div>
</body>
</html>