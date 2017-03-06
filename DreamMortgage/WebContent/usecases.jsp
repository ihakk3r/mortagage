<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Dream Mortgage Flow</title>
<link href="styles.css" rel="stylesheet">
</head>
<body>

<div class="container">

<div class="header">
<div class="navBar">
<ul>
    <li><a href="homepage.jsp" class="active">Home</a></li>
    <li><a href="">About</a></li>
    
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
    <li><a href="citycouncil"  class="">City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
  
  </div>
<div class="sidebar">
<ul>
 <li><a href="">Use cases</a></li>
    <li><a href="">Blockchain Technology</a></li>  
    </ul>
</div>


<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<div id="form">
<p><strong><u>USE CASE 1: Transparent Customer Application</u></strong>&nbsp;&nbsp;<a download="UseCaseDiagram-1.png" href="https://github.com/ihakk3r/mortagage/raw/master/Design-Doc/UseCaseDiagram-1.png">view</a></p>
<ol>
<li>Customer applies for mortgage on Blockchain .</li>
<li>Bank system pulls all information and underwrites the application and approves/denies or pends the loan.</li>
<li>Customer access the block chain to get the most recent status of his application.</li>
<li>After loan approved, the money transferred to the customer and the property is purchased.</li>
</ol>
<p><strong><u>USE CASE 2: Reselling Mortgage to GSE(securitizing agencies)</u></strong>&nbsp;&nbsp;<a download="UseCaseDiagram-2.png" href="https://github.com/ihakk3r/mortagage/raw/master/Design-Doc/UseCaseDiagram-2.png">view</a></p>
<ol>
<li>Confirmed accounts will be visible to GSE</li>
<li>GSE requests purchase of the selected confirmed mortgages.</li>
<li>Bank can Approve GSE request</li>
<li>GSE can Cancel or Own the Mortgage.</li>
<li>If owned GSE will group the security according to the rating.</li>
</ol>
<p>&nbsp;<strong><u>USE CASE 3: Reselling Mortgage to Partner Bank</u></strong>&nbsp;&nbsp;<a download="UseCaseDiagram-3.png" href="https://github.com/ihakk3r/mortagage/raw/master/Design-Doc/UseCaseDiagram-3.png">view</a></p>
<ol>
<li>&ldquo;Dispersed-Ready to Sell&rdquo; accounts will be visible to Partner Banks</li>
<li>Partner Banks requests purchase of the selected confirmed mortgages.</li>
<li>Smart Contract changes the ownership to Partner Bank if Money is settled.</li>
</ol>
<p><strong><u>USE CASE 4: Increasing Business Value of existing Mortgage </u></strong>&nbsp;&nbsp;<a download="UseCaseDiagram-4.png" href="https://github.com/ihakk3r/mortagage/raw/master/Design-Doc/UseCaseDiagram-4.png">view</a></p>
<ol>
<li>Monitor Block Chain for Financial Need.</li>
<li>If financial worth falls customer might want to tap into Home Equity Line. In that case show customer that Home Equity Loan is available.</li>
<li>If financial worth increases customer might need investment avenues or reduce debt. Show customer investment plans</li>
<li>If reference interest rate falls refinancing options can be shown to customer</li>
<li>If reference interest rate increases then period increase for little higher interest rate can be promoted.</li>
<li>Similarly if credit score/rating increases then promote refinancing with lower rate.</li>
</ol>
</div>


<footer>Copyright &copy; Team@DreamMortgage</footer>



</body>
</html>