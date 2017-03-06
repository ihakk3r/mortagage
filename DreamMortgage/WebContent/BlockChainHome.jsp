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
<body style="height: 100px">

<div class="container"  style="height: 1000px;">
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
    <li><a href="auditor" class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome" class="active">Block Chain Explorer</a></li>
    
  </ul>
</div>
<p id="desc" style="font-weight: bold; color: green;">
This page is service administrator page that helps view behind the scenes encrypted block chain creation as transaction happen in real time.</p>
<label><br></label>
<center><h2>Block Chain Explorer</h2></center>
<div class="content">

	<table style="height: 200px">
	<tr>
	<% int i = 0; %>
	<c:forEach items="${customerDetailsList }" var="customer" >
	
	<td align = "center" onmouseleave="block(<%= i %>);">
		<div class="navBar1">
		
			<ul><li><a href='' id = "<%= i %>" onmouseover="show(this.id);" >${customer.num}</a></li></ul>
			
		</div>
			<div class="navBar2" id = "hide<%= i %>" style="display: none;">
  					<ul><li>
					<b>Block Hash:</b> <br>
					${customer.currentBlockHask}<br><br><br>
					<b>Previous block Hash:</b><br>
					${customer.previousBlockHash}<br><br><br>
					<b>Added to Chain at:</b><br>
					${customer.timeStamp}<br>
					</li></ul>
  				</div>
			<% i++; %>
			</td>
		
		</c:forEach>
	</tr>
</table>
</div>
<label><b>Total Number of blocks : <%=i%></b></label>
<footer style="margin-top: 467px;">Copyright &copy; Team@DreamMortgage</footer>
</div>
<script>
	function show(id) {
		
		var j = <%=i %>;
		
		for(var k = 0; k < j; k++) {
			if(id == k)
				document.getElementById('hide'+k).style.display = 'block';	
		}		
	}
	function block(id) {
		var j = <%=i %>;
		for(var k = 0; k < j; k++) {
			if(id == k)
				document.getElementById('hide'+k).style.display = 'none';
		}
	}
</script>
</body>
</html>