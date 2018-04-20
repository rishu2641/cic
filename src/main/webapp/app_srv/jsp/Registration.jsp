<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!--<link rel="stylesheet"
      href="/PRIT/resources/app_srv/css/bootstrap.min.css" />
    <link rel="stylesheet"
      href="/PRIT/resources/app_srv/css/bootstrap-theme.min.css" /> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    
    <link rel="stylesheet"
	href="/cic/resources/app_srv/css/custom.css" />
	<style>
	  span.label-container {
        text-align: left;
        line-height: 29px;
	  }
	  .label-input {
	    padding-top: 10px;
	  }
	  .help-block {
	    font-size: 11px;
        color: #CC3300;
      }
      .dialog {
        margin-top: 10px;
        margin-bottom:10px;
      }
      .checkbox-container span {
        text-align: left;
      }
	</style>
	<script>
	  $(document).ready(function () {
		  $(".help-block").hide();
		  $("input").keyup(function() {
			  var id = $(this).attr("id");
			  $(".help-block-" + id).hide();
			  validateField(id);
		  });
		  $("input").change(function() {
			  var id = $(this).attr("id");
			  $(".help-block-" + id).hide();
			  validateField(id);
		  });
	  });
	  function validateField(id) {
		  var valid = true;
		  if(id == "confirmpassword") {
			  var elemId = "confirmpassword";
			  if($("#confirmpassword").val() != $("#strPassword").val()) {
				  $("#help-block-password-mismatch").show();
				  valid = false;
			  } else {
				  $("#help-block-password-mismatch").hide();
			  }
		  } else if (id == "strPassword") {
			  var len = $("#strPassword").val().length;
			  if(len<8 || len>16) {
				  $("#help-block-len-password").show();
				  valid = false;
			  } else {
				  $("#help-block-len-password").hide();
			  }
		  } else if(id == "userid") {
			  var len = $("#userid").val().length;
			  if(len<=0 || len >20) {
				  $("#help-block-len-userid").show();
				  valid = false;
			  } else {
				  $("#help-block-len-userid").hide();
			  }
		  } else if(id == "firstName") {
			  var len = $("#firstName").val().length;
			  if(len<=0 || len >20) {
				  $("#help-block-len-firstname").show();
				  valid = false;
			  } else {
				  $("#help-block-len-firstname").hide();
			  }
		  } else if(id == "lastName") {
			  var len = $("#lastName").val().length;
			  if(len >16) {
				  $("#help-block-len-lastname").show();
				  valid = false;
			  } else {
				  $("#help-block-len-lastname").hide();
			  }
		  } else if(id == "height") {
			  var val = $("#height").val();
			  if(val<0 || val >999) {
				  $("#help-block-max-height").show();
				  valid = false;
			  } else {
				  $("#help-block-max-height").hide();
			  }
		  } else if(id == "weight") {
			  var val = $("#weight").val().length;
			  if(val<0 || val >999) {
				  $("#help-block-max-weight").show();
				  valid = false;
			  } else {
				  $("#help-block-max-weight").hide();
			  }
		  }
		  return valid;
	  }
	  function submit() {
		  var valid = true;
		  $.each($("input"), function(index, value) {
			  valid = validateField($(value).attr("id")) && valid;
		  });
		  if(!valid) {
			  return;
		  }
		  checkDuplicateUser();
		  sendData();
	  }
	  function checkDuplicateUser() {
		  $.ajax({
			  type: "POST",
			  url: "/CIC/DuplicateUser",
			  data: {
				  "userid" : $.trim($("#userid").val())
			  },
			  success: function (success) {
				  alert("success : " + success);
				  if(!success) {
					  $("#help-block-duplicate-userid").show();
				  }
			  },
			  error: function (error) {
				  alert("error : " + error);
				  $("#help-block-duplicate-userid").show();
			  }
		  });
	  }
	  function sendData() {
		  $.ajax({
			  type: "POST",
			  url: "/CIC/RegisterUser",
			  data: {
				  "userid" : $.trim($("#userid").val()),
				  "strPassword" : $.trim($("#strPassword").val()),
				  "firstName" : $.trim($("#firstName").val()),
				  "lastName" : $.trim($("#lastName").val()),
				  "strGender": $("input[name=strGender]:checked").val(),
				  "dateOfBirth": $("#dateOfBirth").val(),
				  "height" : $("#height").val() || 0,
				  "weight" : $("#weight").val() || 0,
				  "strLifeStyle": $("#strLifeStyle").val(),
				  "dietID": $("#dietID").val()
			  },
			  success: function (response) {
				  if(response) {
					  $("#success-dialog").show();
				  } else {
					  $("#error-dialog").show();
				  }
			  },
			  error: function (error) {
				  $("#error-dialog").show();
			  }
		  });
	  }
	</script>
  </head>
  <body class="text-center">
    <div class="container" style="max-width:800px;">
      <h2 class="display-2">Registration</h2>
	    <div id="success-dialog" class="dialog" style="display:none;" class="alert alert-success">
  			<strong>Success!</strong>
  		    Redirecting you to login page.
		</div>
	    <div id="error-dialog" class="dialog" style="display:none;" class="alert alert-danger">
  			<strong>Error!</strong>
  			Please try again.
		</div>
        <div class="panel panel-primary">
          <div class="panel-heading">Primary Details</div>
          <div class="panel-body">
            <div class="row">
              <div class="col-md-2"></div>
              <div class="col-md-7 label-input">
	            <span class="label-container"><label for="userid" class="col-md-5 col-form-label">User Name</label></span>
                <div class="col-md-7">
	              <input type="text" class="form-control" id="userid" placeholder="Username" required>
	              <span id="help-block-duplicate-userid" class="help-block help-block-userid">Username already exists. Get creative!</span>
	              <span id="help-block-len-userid" class="help-block help-block-userid">Username is mandatory and can only have a maximum of 16 characters.</span>
	            </div>
	          </div>
              <div class="col-md-2"></div>
	        </div>
            <div class="row">
              <div class="col-md-2"></div>
              <div class="col-md-7 label-input">
	            <span class="label-container"><label for="strPassword" class="col-md-5 col-form-label">Password</label></span>
                <div class="col-md-7">
                  <input type="password" class="form-control" id="strPassword" placeholder="Password" required>
                  <span id="help-block-len-password" class="help-block help-block-strPassword">Password can have a minimum of 8 and a maximum of 16 characters.</span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-2"></div>
              <div class="col-md-7 label-input">
	            <span class="label-container"><label for="confirmpassword" class="col-md-5 col-form-label">Confirm Password</label></span>
                <div class="col-md-7">
                  <input type="password" class="form-control" id="confirmpassword" placeholder="Confirm Password" required>
                  <span id="help-block-password-mismatch" class="help-block help-block-confirmpassword">Password mismatch</span>
                </div>
              </div>
            </div>
            <div class="col-md-2"></div>
          </div>
        </div>
         <div class="panel panel-primary">
          <div class="panel-heading">Secondary Details</div>
          <div class="panel-body">
            <div class="row">
              <div class="col-md-6 label-input">
	            <span class="label-container"><label for="firstName" class="col-md-4 col-form-label">First Name</label></span>
	            <div class="col-md-8">
	              <input type="text" class="form-control" id="firstName" placeholder="First Name" required>
	              <span id="help-block-len-firstname" class="help-block help-block-firstName">First name is mandatory and can only have a maximum of 20 characters.</span>
	            </div>
	          </div>
              <div class="col-md-6 label-input">
	            <span class="label-container"><label for="lastName" class="col-md-4 col-form-label">Last Name</label></span>
	            <div class="col-md-8">
	              <input type="text" class="form-control" id="lastName" placeholder="Last Name">
	              <span id="help-block-len-lastname" class="help-block help-block-lastName">Last name can only have a maximum of 20 characters.</span>
	            </div>
	          </div>
	        </div>
            <div class="row">
              <div class="col-md-6 label-input">
                <span class="label-container"><label class="col-md-4 col-form-label">Gender</label></span>
                <div class="col-md-8">
	              <label class="col-md-6" for="male">
                    Male
                    <input class="" type="radio" name="strGender" id="male" value="male">
                  </label>
	              <label class="col-md-6" for="female">
                     Female
                    <input class="" type="radio" name="strGender" id="female" value="female">
                  </label>
                </div>
              </div>
              <div class="col-md-6 label-input">
                <span class="label-container"><label for="dateOfBirth" class="col-md-4 col-form-label">Date of Birth</label></span>
                <div class="col-md-8">
	            	<input type="date" class="form-control" id="dateOfBirth">
	            </div>
	          </div>
	        </div>
            <div class="row">
              <div class="col-md-6 label-input">
                <span class="label-container"><label for="height" class="col-md-4 col-form-label">Height</label></span>
                <div class="col-md-8">
	            	<input type="number" class="form-control" id="height" placeholder="Height in cm" min="0" max="999">
	            	<span id="help-block-max-height" class="help-block help-block-height">Height can only be a number between 0 and 999 cm.</span>
                </div>
              </div>
              <div class="col-md-6 label-input">
                <span class="label-container"><label for="weight" class="col-md-4 col-form-label">Weight</label></span>
                <div class="col-md-8">
	            	<input type="number" class="form-control" id="weight" placeholder="Weight in lbs" min="0" max="999">
	            	<span id="help-block-max-weight" class="help-block help-block-weight">Weight can only be a number between 0 and 999 lbs.</span>
                </div>
	          </div>
	        </div>
	        <div class="row">
              <div class="col-md-2 label-input">
                <span class="label-container"><label for="height" class="col-md-4 col-form-label">Diet</label></span>
              </div>
              <div class="col-md-10 checkbox-container btn-group btn"  data-toggle="buttons">
              <div class="btn">
                <span class="col-md-4 btn">
                    <label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="keto" name="dietID" class="form-check-input">Keto
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="paleo" name="dietID">Paleo
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="ovo" name="dietID">Ovo
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="lactose-intolerance" name="dietID">Lactose Intolerance
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="vegan" name="dietID">Vegan
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="vegetarian" name="dietID">Vegetarian
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="non-vegetarian" name="dietID">Non Vegetarian
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="pescatarian" name="dietID">Pescatarian
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="pollotarian" name="dietID">Pollotarian
                	</label>
                </span>
                <span class="col-md-4 btn">
                	<label class="btn btn-primary form-check-label">
                	<input type="checkbox" value="jain" name="dietID">Jain
                	</label>
                </span>
              </div>
	        </div>
          </div>
        </div>
	    <div class="col-4">
	    	<button type="button" class="btn btn-primary btn-lg" onclick="submit();">Register</button>
	    </div>
      </div>
  </body>
    
 
</html>