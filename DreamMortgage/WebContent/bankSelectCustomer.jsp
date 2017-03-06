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
<title>Bank - Select Customer</title>
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
<p id="desc" style="font-weight: bold; color: green;">On this page lending Bank can see all mortgage applications, request for more application information, approve or deny any mortgage application.</p>
<article>
<div id="form">
<c:if test="${not empty customersData}">
<form action="bank?action=get&type=mortgages" method="POST"> 
<label style="font-weight: bold">Customer Details :</label>
<select id="customerSelect" style="height: 32px;" name="customerSelect"> 

<c:forEach items="${customersData}" var="customer">    
 
 <option value="${customer}">${customer}</option>
 
</c:forEach>

</select>
<span id="mrtgageDuration_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p1"></p> 

<input id="submit" type="submit" value="Select">
</form>
</c:if>
</div>
  

</article>

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>
</body>
</html>