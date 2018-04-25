<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>
    
<!DOCTYPE html>

<html lang="en" class="no-js">
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
    <meta charset="utf-8">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <title>
        Can I Cook
    </title>
    <script src="/CIC/resources/app_srv/js/jquery.min.js"></script>
        <script src="/CIC/resources/app_srv/js/jquery.blockUI.js"></script>
    
    <link rel="stylesheet" href="/CIC/resources/app_srv/css/bootstrap.min.css" />
    <script src="/CIC/resources/app_srv/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/CIC/resources/app_srv/css/custom.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="/CIC/resources/app_srv/js/bodymovin.min.js" type="text/javascript"></script>
	<script src="https://www.google.com/recaptcha/api.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.4/TweenMax.min.js"></script>
	
  </head>
  <body class="text-center">
    <div id="navbar" class="topnav">
      <a id="uf" href="http://www.ufl.edu/" class="logo"><img src="https://accessibility.ufl.edu/media/templates/uf2015/img/logo-uf.svg" alt="logo-uf" style="width:-1px;height:-1px;" class=""></a>
      <div style="display: flex;flex-direction: row;flex: 1;">
	      <a id="home" href="/CIC/HomePage"><i class="fa fa-home"></i>Home</a>
	      <a id="allrecipes" href="/CIC/AllRecipes">All Recipes</a>
	      <a id="about" href="/CIC/About">About</a>
	      <a id="sign-out" href="/CIC/Logout">Sign Out</a>
	      <a id="login" href="/CIC/Login">Sign In</a>
	      <a id="register" href="/CIC/Register">Register</a>
	      <a id="contact" href="#">Contact</a>
      </div>
      <div style="display: flex;flex-direction: row;">
	      <a id="facebook" class="topnav-icon" href="https://facebook.com/canicook/"><i class="fa fa-facebook-f"></i></a>
	      <a id="twitter" class="topnav-icon"  href="https://twitter.com/canicook/"><i class="fa fa-twitter"></i></a>
	      <a id="instagram" class="topnav-icon"  href="https://instagram.com/canicook/"><i class="fa fa-instagram"></i></a>
      </div>
    </div>
    
    <script>
    function callme(){
    	$.blockUI.defaults.css = { 
                padding: 0,
                margin: 0,
                width: '30%',
                top: '40%',
                left: '35%',
                textAlign: 'center',
                cursor: 'wait'
            };
    	$.blockUI({ message: '<img src="/CIC/resources/app_srv/images/loader.gif" />' });
    }
    </script>
    
  	<div id="body">
  	<script>
  	$.blockUI.defaults.css = { 
            padding: 0,
            margin: 0,
            width: '30%',
            top: '40%',
            left: '35%',
            textAlign: 'center',
            cursor: 'wait'
        };
    $(document).ajaxStart($.blockUI({ message: '<img src="/CIC/resources/app_srv/images/loader.gif" />' })).ajaxStop($.unblockUI());
    </script>
  	  <tiles:insertAttribute name="body" />
  	</div>
  	</script>
  </body>
    
 
</html>