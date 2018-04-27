<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>


<script>
	localStorage.setItem("userid", '${userDetails.userid}');
	  $(document).ready(function () {
		  window.document.title = "UserDashboard";
		  $("#sign-in").addClass("active");
		  $(".help-block").hide();
		  $("#firstName").val('${userDetails.fname}');
		  $("#lastName").val('${userDetails.lname}');
		  $("#userid").val('${userDetails.userid}');
		  $("#userid").attr('disabled', "disabled");
		  $("#password").val('${userDetails.password}');
		  $("#dateOfBirth").val('${userDetails.dob}');
		  $("#height").val('${userProfile.height}');
		  $("#weight").val('${userProfile.weight}');
		  $("#diet").val('${userProfile.dietid}');
		  $("#lifestyle").val('${userProfile.lifestyle}');
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
		  } else if(id == "dateOfBirth") {
			  var val = $("#dateOfBirth").val();
			  var year = parseInt(val.split("-")[0]);
			  var currYear = new Date().getFullYear();
			  var age = currYear-year;
			  $("#help-block-dateOfBirth").text("This makes you " + age);
			  $("#help-block-dateOfBirth").show();
		  }
		  if(!valid) {
			  $("#submit-btn").attr("disabled", "disabled");
		  } else {
			  $("#submit-btn").removeAttr("disabled");
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
	  }
	  function sendData() {
		  $.ajax({
			  type: "POST",
			  url: "/CIC/UpdateProfile",
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
					  $("#success-dialog").fadeIn().delay(2000).fadeOut();
					  window.location.replace("/CIC/Login");
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
<div class="text-center">
	<div class="about-title">Welcome, ${userDetails.fname} ${userDetails.lname}</div>
	<div>
		<div id="registration-container">
			<div id="primary-container">
				<div class="registration-heading">
					Primary Details
				</div>
				<div class="input-container">
					<label for="userid" class="col-md-5 col-form-label">User Name</label>
					<div class="input-label-container"><input type="text" class="form-control" id="userid"
								placeholder="Username" required> <span
								id="help-block-duplicate-userid"
								class="help-block help-block-userid">Username already
								exists. Get creative!</span> <span id="help-block-len-userid"
								class="help-block help-block-userid">Username is
								mandatory and can only have a maximum of 16 characters.</span></div>
				</div>
				<div class="input-container">
					<label for="strPassword" class="col-md-5 col-form-label">Password</label>
					<div class="input-label-container"><input type="password" class="form-control" id="strPassword"
								placeholder="Password" required> <span
								id="help-block-len-password"
								class="help-block help-block-strPassword">Password can
								have a minimum of 8 and a maximum of 16 characters.</span>
								<!-- Sorry, your password must contain a capital letter, two numbers, a symbol, an inspiring message, a spell, a gang sign, a hieroglyph and the blood of a virgin -->
								<!-- Sorry, your password is not good enough. Just like you. --></div>
				</div>
				<div class="input-container">
					<label for="confirmpassword"
							class="col-md-5 col-form-label">Confirm Password</label>
					<div class="input-label-container"><input type="password" class="form-control" id="confirmpassword"
								placeholder="Confirm Password" required> <span
								id="help-block-password-mismatch"
								class="help-block help-block-confirmpassword">Password
								mismatch</span></div>
				</div>
			</div>
			<div id="secondary-container">
				<div class="registration-heading">
					Secondary Details
				</div>
				<div id="sub-secondary-container3">
				<div id="sub-secondary-container1">
					<div class="input-container">
						<label for="firstName" class="col-md-5 col-form-label">First Name</label>
						<div class="input-label-container"><input type="text" class="form-control" id="firstName"
								placeholder="First Name" required> <span
								id="help-block-len-firstname"
								class="help-block help-block-firstName">First name is
								mandatory and can only have a maximum of 20 characters.</span></div>
					</div>
					<div class="input-container" id="gender-container">
						<label class="col-md-5 col-form-label">Gender</label>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
						<label class="btn btn-secondary">
							<input type="radio" name="strGender" id="male" value="male" autocomplete="off" > Male
						</label>
						<label class="btn btn-secondary active">
							<input type="radio" name="strGender" id="female" value="female" autocomplete="off" checked> Female
						</label>
						</div>
					</div>
					<div class="input-container">
						<label for="height"
							class="col-md-4 col-form-label">Height</label>
						<div class="input-label-container"><input type="number" class="form-control" id="height"
								placeholder="Height in cm" min="0" max="999"> <span
								id="help-block-max-height" class="help-block help-block-height">Height
								can only be a number between 0 and 999 cm.</span></div>
					</div>
					
					<div class="input-container">
						<label for="lifestyle"
								class="col-md-4 col-form-label">Lifestyle</label>
						<select class="form-control" name=lifestyle " id="lifestyle">
									<option value="keto">Keto</option>
									<option value="paleo">Paleo</option>
									<option value="ovo">Ovo</option>
									<option value="lactose-intolerant">Lactose Intolerant</option>
									<option value="pescatarian">Pescatarian</option>
									<option value="Pollotarian">Pollotarian</option>
									<option value="Jain">Jain</option>
									<option value="None" selected="selected">None</option>
								</select>
					</div>
				</div>
				<div id="sub-secondary-container2">
					<div class="input-container">
						<label for="lastName" class="col-md-5 col-form-label">Last Name</label>
						<div class="input-label-container"><input type="text" class="form-control" id="lastName"
								placeholder="Last Name"> <span
								id="help-block-len-lastname"
								class="help-block help-block-lastName">Last name can only
								have a maximum of 20 characters.</span></div>
					</div>
					<div class="input-container">
						<label for="dateOfBirth" class="col-md-5 col-form-label">Date of Birth</label>
						<div class="input-label-container"><input type="date" class="form-control" id="dateOfBirth"><span
								id="help-block-dateOfBirth" class="help-block help-block-dateOfBirth"></span></div>
					</div>
					<div class="input-container">
						<label for="weight"
							class="col-md-4 col-form-label">Weight</label>
						<div class="input-label-container"><input type="number" class="form-control" id="weight"
								placeholder="Weight in lbs" min="0" max="999"> <span
								id="help-block-max-weight" class="help-block help-block-weight">Weight
								can only be a number between 0 and 999 lbs.</span></div>
					</div>
					<div class="input-container">
						<label for="diet"
							class="col-md-4 col-form-label">Diet</label>
						<select class="form-control" name="diet" id="diet">
								<option value="vegan">Vegan</option>
								<option value="vegetarian">Vegetarian</option>
								<option value="non-vegetarian">Non Vegetarian</option>
								<option value="None" selected="selected">None</option>
							</select>
					</div>
				</div>
				</div>
			</div>
			
		<div>
			<button id="submit-btn" type="button" class="btn btn-primary btn-lg"
				onclick="submit();">Update my profile</button>
		</div>
		</div>
	</div>