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

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    Array.prototype.reduce = undefined;
    $(document).ready(function(){
    
    	google.charts.load('current', {
    	  packages: ['corechart', 'bar']
    	});

    	google.charts.setOnLoadCallback(drawStacked);
    	google.charts.setOnLoadCallback(drawEACashFlow);   	
    	google.charts.setOnLoadCallback(drawMgAmount);
    	var headSubArray = new Array();
    	
    	<c:if test="${not empty yearsList}">
    	headSubArray.push('Year & Amount Type');
		</c:if>
		
    	<c:forEach var="riskClassification" items="${riskClassifications}">

    	<c:if test="${riskClassification eq 'A'}">
	    	headSubArray.push('Risk classification A');
			</c:if> 
			<c:if test="${riskClassification eq 'B'}">
	    	headSubArray.push('Risk classification B');
			</c:if> 
			<c:if test="${riskClassification eq 'C'}">
	    	headSubArray.push('Risk classification C');
			</c:if> 
			<c:if test="${riskClassification eq 'D'}">
	    	headSubArray.push('Risk classification D');
			</c:if> 
			
		</c:forEach>
	
    	var dataArray = new Array();
    	dataArray.push(headSubArray);
    	<c:if test="${not empty graphObjs}">
    	
    	<c:forEach var="year" items="${yearsList}">
    	var subDataArrayGrantedLoan = new Array();
    	subDataArrayGrantedLoan.push('${year}'+'  Granted Loan');
    		<c:forEach var="graphObj" items="${graphObjs}">
    		<c:if test="${graphObj.getYear() eq year}">
    			<c:if test="${graphObj.getRiskCategory() eq 'A'}">
    			subDataArrayGrantedLoan.push(${graphObj.getGrantedLoanAmount()});
    			</c:if> 
    			<c:if test="${graphObj.getRiskCategory() eq 'B'}">
    			subDataArrayGrantedLoan.push(${graphObj.getGrantedLoanAmount()});
    			</c:if> 
    			<c:if test="${graphObj.getRiskCategory() eq 'C'}">
    			subDataArrayGrantedLoan.push(${graphObj.getGrantedLoanAmount()});
    			</c:if> 
    			<c:if test="${graphObj.getRiskCategory() eq 'D'}">
    			subDataArrayGrantedLoan.push(${graphObj.getGrantedLoanAmount()});
    			</c:if> 
	    	</c:if>
    		 </c:forEach>
    		 dataArray.push(subDataArrayGrantedLoan);
    		 
    		 var subDataArrayRemainingLoan = new Array(); 
    		 subDataArrayRemainingLoan.push('${year}'+' Remaining Loan');
     		<c:forEach var="graphObj" items="${graphObjs}">
     		<c:if test="${graphObj.getYear() eq year}">
     			<c:if test="${graphObj.getRiskCategory() eq 'A'}">
     			subDataArrayRemainingLoan.push(${graphObj.getRemainingLoanAmount()});
     			</c:if> 
     			<c:if test="${graphObj.getRiskCategory() eq 'B'}">
     			subDataArrayRemainingLoan.push(${graphObj.getRemainingLoanAmount()});
     			</c:if> 
     			<c:if test="${graphObj.getRiskCategory() eq 'C'}">
     			subDataArrayRemainingLoan.push(${graphObj.getRemainingLoanAmount()});
     			</c:if> 
     			<c:if test="${graphObj.getRiskCategory() eq 'D'}">
     			subDataArrayRemainingLoan.push(${graphObj.getRemainingLoanAmount()});
     			</c:if> 
 	    	</c:if>
     		 </c:forEach>
     		 dataArray.push(subDataArrayRemainingLoan);
    	</c:forEach>
    	 </c:if>         
    	 
    	 
    		var dataArrayForEACashFlow = new Array();
        	dataArrayForEACashFlow.push(headSubArray);
        	<c:if test="${not empty graphObjs}">
        	
        	<c:forEach var="year" items="${yearsList}">
        	var subDataArrayEACashFlow = new Array();
        	subDataArrayEACashFlow.push('${year}');
        		<c:forEach var="graphObj" items="${graphObjs}">
        		<c:if test="${graphObj.getYear() eq year}">
        			<c:if test="${graphObj.getRiskCategory() eq 'A'}">
        			subDataArrayEACashFlow.push(${graphObj.getExpectedAnnualCashFlow()});
        			</c:if> 
        			<c:if test="${graphObj.getRiskCategory() eq 'B'}">
        			subDataArrayEACashFlow.push(${graphObj.getExpectedAnnualCashFlow()});
        			</c:if> 
        			<c:if test="${graphObj.getRiskCategory() eq 'C'}">
        			subDataArrayEACashFlow.push(${graphObj.getExpectedAnnualCashFlow()});
        			</c:if> 
        			<c:if test="${graphObj.getRiskCategory() eq 'D'}">
        			subDataArrayEACashFlow.push(${graphObj.getExpectedAnnualCashFlow()});
        			</c:if> 
    	    	</c:if>
        		 </c:forEach>
        		 dataArrayForEACashFlow.push(subDataArrayEACashFlow);
        		 
        	</c:forEach>
        	 </c:if> 
     
        	
        	 
        	var dataArrayForMGAmount = new Array();
         	dataArrayForMGAmount.push(headSubArray);
         	<c:if test="${not empty graphObjs}">
         	
         	<c:forEach var="year" items="${yearsList}">
         	var subDataArrayForMGAmount = new Array();
         	subDataArrayForMGAmount.push('${year}');
         		<c:forEach var="graphObj" items="${graphObjs}">
         		<c:if test="${graphObj.getYear() eq year}">
         			<c:if test="${graphObj.getRiskCategory() eq 'A'}">
         			subDataArrayForMGAmount.push(${graphObj.getRemainingLoanAmount()});
         			</c:if> 
         			<c:if test="${graphObj.getRiskCategory() eq 'B'}">
         			subDataArrayForMGAmount.push(${graphObj.getRemainingLoanAmount()});
         			</c:if> 
         			<c:if test="${graphObj.getRiskCategory() eq 'C'}">
         			subDataArrayForMGAmount.push(${graphObj.getRemainingLoanAmount()});
         			</c:if> 
         			<c:if test="${graphObj.getRiskCategory() eq 'D'}">
         			subDataArrayForMGAmount.push(${graphObj.getRemainingLoanAmount()});
         			</c:if> 
     	    	</c:if>
         		 </c:forEach>
         		dataArrayForMGAmount.push(subDataArrayForMGAmount);
         		 
         	</c:forEach>
         	 </c:if> 
    	function drawStacked() {
    	  var mbsData = google.visualization.arrayToDataTable(dataArray);
    	 

    	  
    	  var mbsOptions = {
    			  title: 'Mortgage Real time Statistics.',
    			  chartArea: {
    			      width: '50%'
    			    },bar: { groupWidth: '25%' },
    		        isStacked: true,
    		        vAxis: {
    		    	      title: 'Total Amount',
    		    	      minValue: 0,
    		    	    }
    		    	    
    		    	    
    		      };
   	  

        var chart = new google.visualization.ColumnChart(document.getElementById('mbsDiv'));

        chart.draw(mbsData, mbsOptions);
        
        
        
      }
    	
    	
    	function drawEACashFlow() {
      	  var eaCashFlowData = google.visualization.arrayToDataTable(dataArrayForEACashFlow);
      	 

      	  
      	  var eaCashFlowDataOptions = {
      			  title: 'Expected Annual Cashflow Statistics.',
      			  chartArea: {
      			      width: '30%'
      			    },bar: { groupWidth: '15%' },
      		        isStacked: true,
      		        vAxis: {
      		    	      title: 'Total Amount',
      		    	      minValue: 0,
      		    	    },
      		    	    hAxis: {
      		    	      title: 'Year'
      		    	    }
      		    	    
      		      };
     	  

          var chart = new google.visualization.ColumnChart(document.getElementById('eaCashFlowDiv'));

          chart.draw(eaCashFlowData, eaCashFlowDataOptions);
          
          
          
        }
    	
    	
    	function drawMgAmount() {
        	  var MgAmountData = google.visualization.arrayToDataTable(dataArrayForMGAmount);
        	 

        	  
        	  var MgAmountDataOptions = {
        			  title: 'Remaining Mortgage Amount Statistics.',
        			  chartArea: {
        			      width: '30%'
        			    },bar: { groupWidth: '15%' },
        		        isStacked: true,
        		        vAxis: {
        		    	      title: 'Total Amount',
        		    	      minValue: 0,
        		    	    },
        		    	    hAxis: {
        		    	      title: 'Year'
        		    	    }
        		    	    
        		      };
       	  

            var chart = new google.visualization.ColumnChart(document.getElementById('mgAmountDiv'));

            chart.draw(MgAmountData, MgAmountDataOptions);
            
            
            
          }
    });
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
    <li><a href="bank?action=getAll" >Lending Bank</a></li>
        <li><a href="partnerbank?action=getPurchase"  class="">Partner Bank</a></li>
    <li><a href="securitization?action=get"  class="">Securitization</a></li>
    <li><a href="brokerage?action=get"  class="active">Full brokerage firm</a></li>
    <li><a href="citycouncil"  class="">City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>

<div class="sidebar" style="height: 1200px">
  <ul>
  <li><a href="#mbsDiv">Remaning Vs Granted Loan Amount</a></li>
  <li><a href="#eaCashFlowDiv">Expected Annual CashFlow</a></li>
  <li><a href="#mgAmountDiv">Remaining Loan Amount</a></li>
  </ul>
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${errorMsg}</p>
<p id="desc" style="font-weight: bold; color: green;">Full Service broker screen allows securities broker to view their portfolio real time. GSE Purchased Mortgages are grouped by year and sold to Full service brokers who then sell to investors.
</p>
<article>

<div id="mbsDiv"  style="width: 900px; height: 500px; margin-left: 230px;">

</div>
<div id="eaCashFlowDiv"  style="width: 900px; height: 500px; margin-left: 230px;">

</div>
<div id="mgAmountDiv" style="width: 900px; height: 500px; margin-left: 230px;"></div>
</article>
</div>
<footer>Copyright &copy; Team@DreamMortgage</footer>

</body>
</html>
