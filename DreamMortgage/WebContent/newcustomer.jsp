<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Apply for Mortgage</title>
<link href="styles.css" rel="stylesheet">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
</script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript">

$(document).ready(function() {
	$( "#customerDOB").datepicker({
	      changeMonth: true,
	      changeYear: true,
	      yearRange: "1930:1999",
	      defaultDate: "01/01/1980"
	    });
	$( "#mrtgageDate").datepicker({
	      changeMonth: true,
	      changeYear: true,
	      yearRange: "2000:2020"
	    });
	

$('#customerName').blur(function(){
var customerNameValidationResult = isCustomerNameValid();
if(!customerNameValidationResult)
	{
		$('#p1').text("Customer name should be alphanumeric(Periods and ` are also allowed)"); 
		$("#customerName_valid").show();
		$("#customerName_valid img").attr('src', "invalid.jpg");
	}
else{
	$("#customerName_valid").show();
	$("#customerName_valid img").attr('src', "valid.jpg");
	$('#p1').text("");
}
});
function isCustomerNameValid(){
var customerName= $('#customerName').val();
var customerName_regex =  /^[a-zA-Z0-9.`]+(\s\w+)*([a-zA-Z0-9.`]+)*(\s\w+)*$/;
if (!customerName_regex.test(customerName) || customerName.length == 0) {
return false;
}
else{
return true;
}
}
	
$('#customerAddress').keyup(function(e){
var addressValue = $(this).val();
    if(addressValue.length > 250){
	this.value = addressValue.substring(0,250);
        return false;
    }
    $("#remainingC").html("Remaining characters : " +(250 - this.value.length));
});
$('#mPAdress').keyup(function(e){
var mPAdressValue = $(this).val();
    if(mPAdressValue.length > 250){
	this.value = mPAdressValue.substring(0,250);
        return false;
    }
    $("#remainingCharMpAddress").html("Remaining characters : " +(250 - this.value.length));
});
	
$('#mPAdress').blur(function(){
$("#remainingCharMpAddress").text("");
if(!isMpAddressValid())
{
$('#p7').text("Mortgage Property Address should be numbers and letters only and special characters(.,-)");
$("#mPAdress_valid").show();
$("#mPAdress_valid img").attr('src', "invalid.jpg");
}
else{
$("#mPAdress_valid").show();
$("#mPAdress_valid img").attr('src', "valid.jpg");
$('#p7').text("");
}
});
function isMpAddressValid(){
var mPAdress = $('#mPAdress').val();
var mPAdress_regex = /^[a-zA-Z0-9.-]+(\,)*(\/)*(\s\w+)*(([a-zA-Z0-9.-]+(\,)*(\/)*)*(\s\w+)*)*$/;
if (!mPAdress_regex.test(mPAdress) || mPAdress.length == 0) {
return false;
}
else{
return true;
}
}
$('#customerAddress').blur(function(){
$("#remainingC").text("");
if(!isCustomerAddressValid())
{
$('#p2').text("Customer Address should be numbers and letters only and the special characters(.,-/)");
$("#customerAddress_valid").show();
$("#customerAddress_valid img").attr('src', "invalid.jpg");
}
else{
$("#customerAddress_valid").show();
$("#customerAddress_valid img").attr('src', "valid.jpg");
$('#p2').text("");
}
});
function isCustomerAddressValid(){
var address = $('#customerAddress').val();
var address_regex = /^[a-zA-Z0-9.-]+(\,)*(\/)*(\s\w+)*(([a-zA-Z0-9.-]+(\,)*(\/)*)*(\s\w+)*)*$/;
if (!address_regex.test(address) || address.length == 0) {
return false;
}
else{
return true;
}
}
function isCustomerDOBValid(){
var customerDOB = $('#customerDOB').val();
var customerDOB_Regex = /^(?=\d)(?:(?:31(?!.(?:0?[2469]|11))|(?:30|29)(?!.0?2)|29(?=.0?2.(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(?:\x20|$))|(?:2[0-8]|1\d|0?[1-9]))([-.\/])(?:1[012]|0?[1-9])\1(?:1[6-9]|[2-9]\d)?\d\d(?:(?=\x20\d)\x20|$))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
if (!customerDOB_Regex .test(customerDOB) || customerDOB.length == 0) {
return false;
}
else{
return true;
}
}
$('#customerDOB').change(function(){
var customerDOBValidationResult = isCustomerDOBValid();
if(!customerDOBValidationResult) 
	{
		$('#p4').text("Date of birth format is invalid (MM/DD/YYYY)"); 
		$("#customerDOB_valid").show();
		$("#customerDOB_valid img").attr('src', "invalid.jpg");
	}
else{
	$("#customerDOB_valid").show();
	$("#customerDOB_valid img").attr('src', "valid.jpg");
	$('#p4').text("");
}
});
function isMrtgageDateValid(){
var mrtgageDate = $('#mrtgageDate').val();
var mrtgageDate_Regex = /^((0?[13578]|10|12)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[01]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1}))|(0?[2469]|11)(-|\/)(([1-9])|(0[1-9])|([12])([0-9]?)|(3[0]?))(-|\/)((19)([2-9])(\d{1})|(20)([01])(\d{1})|([8901])(\d{1})))$/;
if (!mrtgageDate_Regex.test(mrtgageDate) || mrtgageDate.length == 0) {
return false;
}
else{
return true;
}
}
$('#mrtgageDate').change(function(){
var mrtgageDateValidationResult = isMrtgageDateValid();
if(!mrtgageDateValidationResult) 
	{
		$('#p10').text("Mortgage format is invalid (MM/DD/YYYY)"); 
		$("#mrtgageDate_valid").show();
		$("#mrtgageDate_valid img").attr('src', "invalid.jpg");
	}
else{
	$("#mrtgageDate_valid").show();
	$("#mrtgageDate_valid img").attr('src', "valid.jpg");
	$('#p10').text("");
}
});
$("#customerSSN").blur(function(){
var ssnValidationResult = isSSNValid();
if(!ssnValidationResult)
	{
		$("#p3").text("SSN must be a unique 9-Digit Number");
		$("#customerSSN_valid").show();
		$("#customerSSN_valid img").attr('src', "invalid.jpg");
	}
else{
	$("#customerSSN_valid").show();
	$("#customerSSN_valid img").attr('src', "valid.jpg");
	$('#p3').text("");
}	
});
function isSSNValid(){
var ssn = $('#customerSSN').val();
var ssn_regex = /^[0-9]+$/;
if(!ssn.match(ssn_regex) || ssn.length!=9){
	return false;	
}
else
{
return true;
}
}
$("#loanAmount").blur(function(){
var loadAmountValidationResult = isloanAmountValid();
if(!loadAmountValidationResult)
	{
		$("#p5").text("Loan Amount should be between $1,000 to $99,999,99");
		$("#loanAmount_valid").show();
		$("#loanAmount_valid img").attr('src', "invalid.jpg");
	}
else{
	$("#loanAmount_valid").show();
	$("#loanAmount_valid img").attr('src', "valid.jpg");
	$('#p5').text("");
}	
});
function isloanAmountValid(){
var loanAmount = $('#loanAmount').val();

if(parseInt(loanAmount)>=1000 && parseInt(loanAmount)<=9999999) {
	return true;
}
else {
	return false;
}

}
$('#submit').click(function(e) {
	
	$('#successMsg').text("");
	 $('input,textarea,select').each(function(){
	 $(this).trigger('blur');
	  //each input event one by one... will be blured
	});
	
	 $('#customerDOB,#mrtgageDate').trigger('change');
if(isloanAmountValid()&&isSSNValid()&&isMrtgageDateValid()&&isCustomerDOBValid()&&isCustomerNameValid()&&isMpAddressValid()&&isCustomerAddressValid()&&isCustomerDOBValid()&&isMrtgageDateValid()){
   return true;	
}
else
{
	$('#errorMsg').text("Error! Please correct the errors and re-submit the form");
	window.scrollTo(0,0);
	return false;
}


});
$("#mrtgageDuration").blur(function(){
var mrtgageDurationValidationResult = isMrtgageDurationValid();
if(!mrtgageDurationValidationResult)
	{
	
		$("#p11").text("Mortgage duration should be (10-30) years");		
		$("#mrtgageDuration_valid").show();
		$("#mrtgageDuration_valid img").attr('src', "invalid.jpg");
	}
else{
	$("#mrtgageDuration_valid").show();
	$("#mrtgageDuration_valid img").attr('src', "valid.jpg");
	$('#p11').text("");
}	
});
function isMrtgageDurationValid(){
var mrtgageDuration = $('#mrtgageDuration').val();
var mrtgageDuration_regex;
var mrtgageDurationerrMsg;

mrtgageDuration_regex = /^[1-4][0-9]$|^30$/;

if(!mrtgageDuration_regex.test(mrtgageDuration)){
	return false;	
}
else
{
return true;
}
}
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
    <li><a href="newcustomer.jsp" class="active">Customer</a></li>
    <li><a href="bank?action=getAll" >Lending Bank</a></li>
 <li><a href="partnerbank?action=getPurchase"  class="">Partner Bank</a></li>
    <li><a href="securitization?action=get"  class="">Securitization</a></li>
     <li><a href="brokerage?action=get">Full brokerage firm</a></li>
    <li><a href="citycouncil"  >City Council</a></li>
    <li><a href="federalreserve">Federal Reserve</a></li>
     <li><a href="serviceprovider?action=getAll"  class="">Data Service Provider</a></li>
    <li><a href="auditor"  class="">Auditor</a></li>
     <li><a href="auditor?action=blockChainHome">Block Chain Explorer</a></li>
    
  </ul>
</div>

<div class="sidebar" style="height: 800px;">
  <ul>  
    <c:if test="${customerStatus eq 'existing'}">
    <li><a href="newcustomer.jsp">Apply For Mortgage</a></li>
    <li><a href="customer?action=getAll" class="sideActive" >Check Mortgage Details</a></li>   
    </c:if>
    <c:if test="${customerStatus ne 'existing'}">
    <li><a href="newcustomer.jsp" class="sideActive">Apply For Mortgage</a></li>
     <li><a href="customer?action=getAll">Check Mortgage Details</a></li>   
   </c:if>
  </ul>
</div>

<p id="successMsg">${successMsg}</p> 
<p id="errorMsg">${failureMsg}</p>
<c:choose>
    <c:when test="${customerStatus eq 'existing'}">
        <p id="desc" style="font-weight: bold; color: green;">Customer checks status of Mortgage application or updates an required information.</p>
    </c:when>    
    <c:otherwise>
        <p id="desc" style="font-weight: bold; color: green;">Customer fills mortgage application on this page</p>

    </c:otherwise>
</c:choose>
<div id="form">
 
<h2>Customer Details</h2>
<form action="customer?action=put" method="POST" style="margin-top: -35px"> 
<c:choose>
    <c:when test="${customerStatus eq 'existing'}">
        <input type="hidden" name="customerStatus" value="${customerStatus}"/> 
        <br />
    </c:when>    
    <c:otherwise>
        <input type="hidden" name="customerStatus" value="new"/> 
        <br />
    </c:otherwise>
</c:choose>
     
     <c:choose>
    <c:when test="${empty mrtgageNumber}">
        <input type="hidden" name="mortgageNumber" value=""/> 

    </c:when>       
    <c:otherwise>
    <label>Mortgage Number</label>
<label id='mrtgageNumber'><b>${mrtgageNumber}</b></label>
<br>
<br>
<input type="hidden" name="mortgageNumber" value="${mrtgageNumber}"/> 
     
    </c:otherwise>
</c:choose>

	
    <c:if test="${mrtgageStatus eq 'existing'}">
   <label>Mortgage Stage</label>
	<label id='mStage' style="margin-left: 115px;"><b>${mrtgageStage}</b></label>
	<br>
	<br>  
	</c:if>  
	<c:if test="${mrtgageStatus eq 'created'}">
	<label>Mortgage Stage</label>
	<label id='mStage' style="margin-left: 115px;"><b>Pending-Bank:</b></label>
	<br>
	<br>
	</c:if>
	
	 <c:if test="${not empty grantedloanAmount and mrtgageStage ne 'Denied:'}">
  <label>Granted Loan Amount </label>
        <label id="cgloanAmount"><b>${grantedloanAmount}$</b></label>
        <br />
 
        </c:if>

<p id="p12"></p>
<label>Customer Name</label>
<input id='customerName' name="customerName" value="${customerName}" type='text'><span id="customerName_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id="p1"></p> 
<span id="wrap"> <label for="address">Customer Address</label></span>
<textarea id='customerAddress' name="customerAddress" rows="4" cols="33">${customerAddress}</textarea><span id="customerAddress_valid" style="display: none"><img src="valid.jpg" class="validImg"/></span>
<p id='remainingC'></p>
<p id="p2"></p>
<label>SSN</label>
<input id='customerSSN' name="customerSSN" value="${customerSSN}" ${readonly} type='text'><span id="customerSSN_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p3"></p> 
<label>Date of Birth</label>
<input type="text" name="customerDOB" ${readonly} value="${customerDOB}" id="customerDOB"><span id="customerDOB_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p4"></p> 
<label>Request Loan Amount </label>
<input type="text" name="loanAmount" id="loanAmount" ${readonly} value="${loanAmount}" style="margin-left: 73px;"><label><b>$</b></label><span id="loanAmount_valid" style="display: none"><img src="valid.jpg"  class="validImg"/></span>
<p id="p5"></p> 
        
<label>Mortgage Property Address </label>
<textarea id="mPAdress" name="mPAdress" rows="4"  cols="33" ${readonly}>${mPAdress}</textarea><span id="mPAdress_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="remainingCharMpAddress"></p>
<p id="p7"></p>
<label>Type of Mortgage </label>
<select id="mrtgageType" name="mrtgageType" ${disabled}> 
	<option value="ARM" ${mrtgageType == 'ARM' ? 'selected' : ''}>ARM</option>
	<option value="FIXED" ${mrtgageType == 'FIXED' ? 'selected' : ''}>FIXED</option>
</select>
<p id="p9"></p>

<label>Mortgage Start Date</label>
<input type="text" value="${mrtgageDate}" name="mrtgageDate" id="mrtgageDate" ${readonly}><span id="mrtgageDate_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>
<p id="p10"></p> 
<label>Mortgage Duration</label>

<select id="mrtgageDuration" name="mrtgageDuration" ${disabled}> 
	<option value="0" >Select</option>
	<option value="10" ${mrtgageDuration == '10' ? 'selected' : ''}>10</option>
	<option value="15" ${mrtgageDuration == '15' ? 'selected' : ''}>15</option>
	<option value="20" ${mrtgageDuration == '20' ? 'selected' : ''}>20</option>
	<option value="30" ${mrtgageDuration == '30' ? 'selected' : ''}>30</option>
</select>
<label>Years</label>
<span id="mrtgageDuration_valid" style="display: none"><img src="valid.jpg"  class="validImg" /></span>

<p id="p11"></p> 
     
     <c:choose>
    <c:when test="${empty mrtgageOwnership}">
        
    </c:when>    
    <c:otherwise>
    <label>Mortgage Deed Ownership</label>
        <input type="text" id="mrtgageOwnership" value="${mrtgageOwnership}" ${readonly}/> 
          <br />
    </c:otherwise>
</c:choose>


<input id="submit" type="submit" value="Submit">
</form>
</div>
 

<footer>Copyright &copy; Team@DreamMortgage</footer>

</div>

</body>
</html>