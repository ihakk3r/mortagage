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
<title>Auditor</title>
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
    <li><a href="citycouncil"  class="">City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
    <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="active">Auditor</a></li>
    <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
  </ul>
</div>
<p id="desc" style="font-weight: bold; color: green;">
This page is available to any auditor of any participants to audit blockchain ledger for process compliance or for required legal purposes.
</p>
<article>
<div id="form">
	
<div>
<% int i = 0; %>
<input id = "lst" list="num" placeholder="Search for Mortgage Numbers....." value = "">
	<datalist id = "num">
	<option value="--Show All--">
	<c:forEach items="${allUniqueMortgageNumbers}" var="mortgageNum">
	<option value="${mortgageNum}">
</c:forEach>
</datalist>
<input type="button" id="submit" onclick="show()" value = "Apply Filter"> 
</div><br>
<table class="cssTableLayout" style = "width:100%" id = "myTable">
	<tr>
		<th width="10%" align="center"><b>Mortgage Number</b></th>
		<th width="15%" align="center"><b>Participant</b></th>
		<th width="20%" align="center"><b>Action</b></th>
		<th width="45%" align="center"><b>Modified Fields</b></th>
		<th width="10%" align="center"><b>Time Stamp</b></th>
	</tr>
	<c:forEach var="j" begin="0" end="${size}" step="1">
	<tr id ="${customerDtls.get(size-j).mortgageNumber}<%= i %>">
			<td width="10%" align="left">${customerDtls.get(size-j).mortgageNumber}</td>
			<td width="15%" align="left">${customerDtls.get(size-j).participant}</td>
			<td width="20%" align="left">${customerDtls.get(size-j).action}</td>
			<td width="45%" align="left">${customerDtls.get(size-j).data}</td>
			<td width="10%" align="left">${customerDtls.get(size-j).timeStamp}</td>
		</tr>
	<% i++;%>
	</c:forEach>
</table>
</div>
</article>
<% i=0; %>
<footer>Copyright &copy; Team@DreamMortgage</footer>
</div>
<script type="text/javascript">
	function show() {
		var a = document.getElementById('lst').value;
		if(a == ""||a=="--Show All--"){
		
			<c:forEach var="j" begin="0" end="${size}" step="1">
			document.getElementById('${customerDtls.get(size-j).mortgageNumber}'+<%= i %>).style.display = "";
			<% i++;%>
			</c:forEach>
			<% i=0; %>
		}
		
		else {
			
			<c:forEach var="j" begin="0" end="${size}" step="1">
				if('${customerDtls.get(size-j).mortgageNumber}' == a)
					document.getElementById(a+<%= i %>).style.display = "";
				
				else
					document.getElementById('${customerDtls.get(size-j).mortgageNumber}'+<%= i %>).style.display = "none";
				<% i++;%>
			</c:forEach>
		}	
	}
	
</script>
</body>
</html>