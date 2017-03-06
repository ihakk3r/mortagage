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
<title>Customer time service metrics</title>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

       <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart2);
      
      function drawChart2() {
          var data = google.visualization.arrayToDataTable([
           ['Quarter', 'Time to disburse a new mortgage application(Average days)', 'Time application was pending with customer(Average days)','Time to process mortgage by Lending bank(Average days)', 'Approval percentage' ] ,
           ['H1/2014',  63 , 20, 40,64 ],
           ['H2/2014',  54 , 19, 32,68 ],
           ['H1/2015',  49 , 18, 28,71 ],
           ['H2/2015',  44 , 19, 22,72 ],
           ['H1/2016',  38 , 17, 18,74 ],
           ['H2/2016',  34 , 15, 16,75 ],
           ['H1/2017',  32 , 13, 15,79 ],
           ['H2/2017',  29 , 11, 14, 83 ]
         ]);

         var options = {
           title: '',
           curveType: 'function',
           vAxis: {title: 'Days/Percentage'},
           hAxis: {title: 'Years'},
           legend: { position: 'right' },
           
         };

         var chart = new google.visualization.LineChart(document.getElementById('curve_chart2'));

         chart.draw(data, options);
       }

      function drawChart() {
         var data = google.visualization.arrayToDataTable([
          ['Year', 'Average days to disburse an new mortgage application', 'Average days application pending with customer','Average days to process mortgage by Lending bank', 'Approval percentage' ] ,
          ['2014',  63 , 20, 40,74 ],
          ['2015',  45 , 21, 30,54 ],
          ['2016',  53 , 23, 20,60 ],
          ['2017',  25 , 24, 10,83 ]
        ]);

        var options = {
          title: '',
          curveType: 'function',
          vAxis: {title: 'Days/Percentage'},
          hAxis: {title: 'Years'},
          legend: { position: 'right' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
    </script>
 

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<title>Brokerage - Statistics</title>
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
    <li><a href="bank?action=getAll"  class="active">Lending Bank</a></li>
        <li><a href="partnerbank?action=getPurchase"  class="">Partner Bank</a></li>
    <li><a href="securitization?action=get"  class="">Securitization</a></li>
    <li><a href="brokerage?action=get" >Full brokerage firm</a></li>
    <li><a href="citycouncil"  class="">City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>

<div class="sidebar" style="height: 1100px">
  <ul>		
	<li><a href="bank?action=getAll" >Mortgage Application</a></li>
    <li><a href="bank?action=getGse">Approve GSE Transfers</a></li>  
    <li><a href="bank?action=getAuction">Auction Mortgages</a></li>  
    <li><a href="bank?action=reviewAuction">Review Auction Mortgages</a></li>  
     <li><a href="bank?action=getPurchaseRequest" >Approve Auction Transfers</a></li> 
    <li><a href="bank?action=getDisbursed"  >Monthly Mortgage Servicing</a></li>
    <li><a href="customerMetrics.jsp" class="sideActive">Customer Time service metrics</a></li>
 	
  </ul>
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<p id="desc" style="font-weight: bold; color: green;">On this page lending bank reviews time quality metrics for customer experience.</p>

<article>
<h2>Customer Time service metrics</h2>

<div id="curve_chart" style="margin-left: 230px; width: 1000px; height: 500px"></div>
<div id="curve_chart2" style="padding-left: 230px; width: 1000px; height: 500px"></div>
</article>
<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>
</body>
</html>
