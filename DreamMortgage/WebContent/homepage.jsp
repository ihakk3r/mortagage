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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
</script>
<script>
function embedPdf(url,id){
	
	if(document.getElementById("homeDesc")!=null)
		document.getElementById("homeDesc").style.display = "none";
	var form = document.getElementById("form");
	form.innerHTML = "";
	form.innerHTML = "<iframe src="+url+" style='width:1000px; height:500px;' frameborder='0'></iframe>";
	
	$('#'+id).prop("class","sideActive");
	
	$('.hsidebar a').not("#"+id).each(function(){
		
		$(this).prop("class","");
	});

}
</script>
<body>

<div class="container">

<div class="header">
<div class="navBar">
<ul>
    <li><a href="homepage.jsp" class="active">Home</a></li>
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
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
  
  </div>
<div class="hsidebar">

<ul>

<li><a id="link1" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/US%20Mortgage%20Industry%20Overview.pdf&embedded=true','link1')" >US Mortgage Industry Overview</a></li>

<li><a id="link2" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Mortgage%20Industry%20Participants.pdf&embedded=true','link2')" >Mortgage Industry Participants</a></li>

<li><a id="link3" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Mortgage%20financing%20in%20Nutshell.pdf&embedded=true','link3')" >Mortgage financing in Nutshell</a></li>

<li><a id="link4" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Mortgage%20industry%20challenges.pdf&embedded=true','link4')" >Mortgage Industry Challenges</a></li>

<li><a id="link5" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Dream%20Mortgage%20Solution.pdf&embedded=true','link5')" >Dream Mortgage solution</a></li>

<li><a id="link6" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Dream%20Mortgage%20Solution%20Highlights.pdf&embedded=true','link6')" >Dream Mortgage solution highlights</a></li>

<li><a id="link7" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Mortgage%20Deed%20tracking%20using%20smart%20contracts.pdf&embedded=true','link7')" >Mortgage Deed tracking using smart contract</a></li>

<li><a id="link8" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Dream%20Mortgage%20-%20Business%20Flow.pdf&embedded=true',link8)">Dream Mortgage Business Flow</a></li>

<li><a id="link9" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Dream%20Mortgage%20Design%20%26%20Teck%20stack.pdf&embedded=true','link9')" >High Level , Low Level Design & Tech stack</a></li>


<li><a id="link10" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Use%20cases%2C%20source%20code%20and%20sample%20walk%20through.pdf&embedded=true',link10)">Usecase, Sample link and source code</a></li>

<li><a id="link11" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Further%20planned%20demo%20enhancements..pdf&embedded=true',link11)">Future Demo enhancement plans</a></li>

<li><a id="link12" href="javascript: void(0)" onclick="embedPdf('http://docs.google.com/gview?url=https://github.com/DreamMortgage/Documentation/raw/master/Citation.pdf&embedded=true',link12)">Citation</a></li>

    </ul>

</div>


<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<div id="form">

<div id="homeDesc" style="background-image: url(data-dive-promising-partnerships.jpg); background-size: 100% 100%; margin-top: 20px; margin-left: 20px; height: 500px; width: 84%;float: left;">

    <div style="position: relative; top: -17px; left: 10px; width: 570px;">

       <strong>Welcome to Dream Mortgage!</strong> the next gen mortgage processing.<br><br>

       Here everything is transparent as water and up to date to take away your anxiety and help you move into your new home if you are buying one or get a loan for your need.<br><br>

       Please click on the above links and start the journey of trouble free loan processing.  Please feel free to contact us and we are always there for you.

       </div>   

</div>	
</div>

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>