<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

<title>Login</title>
<script>
$(document).ready(function() {
	window.document.title="Login";
	$("#login").addClass("active");
	if(window.document.referrer.indexOf("Register") != -1) {
		  $("#success-dialog").fadeIn();
	}
});
  function loginme(){
	  callme();
	  var Message=$('#pass').val();
	$('#strPassword').val(Message);
	$('#userid').val($('#user').val());
	document.getElementById("login-form").action="/CIC/Login";
	document.getElementById("login-form").submit();
	$.delay(5000).unblockUI();
  }
  
  </script>

  <style>
 #login-card h1 {
  font-weight: 100;
  text-align: center;
  font-size: 2.3em;
}

#login-card {
  padding: 40px;
  background-color: #F7F7F7;
  margin: 0 auto 10px;
  border-radius: 2px;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  clear: both;
  margin-left: 37%;
  margin-top: 15px;
}

#login-card input[type=submit] {
  width: 100%;
  display: block;
  margin-bottom: 10px;
  position: relative;
}

#login-card input[type=text], input[type=password] {
  height: 44px;
  font-size: 16px;
  width: 100%;
  margin-bottom: 10px;
  -webkit-appearance: none;
  background: #fff;
  border: 1px solid #d9d9d9;
  border-top: 1px solid #c0c0c0;
  /* border-radius: 2px; */
  padding: 0 8px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
}


.login {
  text-align: center;
  font-size: 14px;
  font-family: 'Arial', sans-serif;
  font-weight: 700;
  height: 36px;
  padding: 0 8px;
/* border-radius: 3px; */
/* -webkit-user-select: none;
  user-select: none; */
}


.login-help {
  width: 100%;
  text-align: center;
  font-size: 12px;
}
  </style>
  
<div class="container">
  <div id="success-dialog" class="col-md-6 col-md-offset-3" style="display:none;">
    <div class="alert alert-success dialog" style="display: block;">
	  <strong>Successfully Registered!</strong> Please sign in to continue.
	</div>
  </div>
  <div id="login-card" class="col-md-3 col-md-offset-4">
    <h1>Sign In</h1><br>
  <form:form action="Login" modelAttribute="loginform" id="login-form" method="post">
  	<form:input type="hidden" path="strPassword" id="strPassword" name="strPassword"/>
  		<form:input type="hidden" path="userid" id="userid" name="userid"/>
    <input id="user" type="text" name="user" placeholder="Username">
    <input id="pass" type="password" name="pass" placeholder="Password">
    <input class="btn-lg btn-primary" type="button" name="login" class="login login-submit" value="Sign In" onclick="loginme()">
  </form:form>

  <div class="login-help">
    <a href="#">Forgot Password</a>
  </div>
</div>
</div>

