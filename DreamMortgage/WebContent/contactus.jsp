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
    <li><a href="homepage.jsp">Home</a></li>
    <li><a href="About.jsp">About</a></li>
    
    <li><a href="contactus.jsp" class="active">Contact Us</a></li>
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
<div class="sidebar" style="height: 800px">

</div>


<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<div style="height: 800px; width: 1000px; margin: 0 auto">
<center><strong>Meet the team Dream Mortgage</strong></center>
<div style="position: relative; top: 70px; left: 10px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Rohan Dalvi</strong><br>
		ADM<br>
		<font style="font-size:9px;">+1 309-660-7054</font><br>
		<font style="font-size:9px;"><b>rohan.dalvi@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 20px; left: 20px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Aditi Dalvi</strong><br>
		GS_INS<br>
		<font style="font-size:9px;">+1 309-533-2521</font><br>
		<font style="font-size:9px;"><b>aditi.dalvi@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 40px; left: 300px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Abhishek Rawal</strong><br>
		ADM<br>
		<font style="font-size:9px;">+1 309-831-9746</font><br>
		<font style="font-size:9px;"><b>abhishek.rawal@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 0px; left: 270px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Lokesh Reddy</strong><br>
		ADM<br>
		<font style="font-size:9px;">+91 90965-63321</font><br>
		<font style="font-size:9px; margin-left: -38px;"><b>lokeshwar.pinnamreddy@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 30px; left: 130px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Mohan Palaka</strong><br>
		ADM<br>
		<font style="font-size:9px;">+91 99667-92038</font><br>
		<font style="font-size:9px;"><b>venkata.palaka@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 20px; left: 190px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:30px; left:130px;">
		<strong>Durga Prasad<br>Perumalla</strong><br>
		ADM<br>
		<font style="font-size:9px;">+91 80871-93917</font><br>
		<font style="font-size:9px; margin-left: -38px"><b>durga-prasad.perumalla@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 15px; left: 375px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Abhinav Agrawal</strong><br>
		ADM<br>
		<font style="font-size:9px;">+91 97649-03260</font><br>
		<font style="font-size:9px; margin-right: 10px"><b>abhinav.agrawal@capgemini.com</b></font>
	</div>
</div>
<div style="position: relative; top: 60px; left: -280px; background-image: url(droplet.jpg); background-size: 100% 100%; height: 150px; width: 350px;float: left;">
	<div style="position: relative; top:35px; left:130px;">
		<strong>Abhishek Malani</strong><br>
		ADM<br>
		<font style="font-size:9px;">+91 77095-37659</font><br>
		<font style="font-size:9px; margin-right: 10px"><b>abhishek.malani@capgemini.com</b></font>
	</div>
</div>
</div>


<footer>Copyright &copy; Team@DreamMortgage</footer>
</div>


</body>
</html>