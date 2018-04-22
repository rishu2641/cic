<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>
<script>
	  function submit() {
		  $.ajax({
			  type: "POST",
			  url: "/CIC/UpdateProfile",
			  data: {
				  "firstName" : $.trim($("#firstName").val()),
				  "lastName" : $.trim($("#lastName").val()),
				  "height" : $("#height").val() || 0,
				  "weight" : $("#weight").val() || 0,
				  "strLifeStyle": $("#strLifeStyle").val(),
				  "dietID": $("#dietID").val()
			  },
			  success: function (response) {
					  $("#success-dialog").show();
				  },
			  error: function (error) {
				  alert(1);
				  $("#error-dialog").show();
			  }
		  });
	  }
	</script>
	
	<script>
	$( document ).ready(function() {
		$("#lifestyle option:selected").prop("selected",false);
		$("#lifestyle option[value=" + '${userProfile.lifestyle}' + "]")
		        .prop("selected",true);
		
		$("#diet option:selected").prop("selected",false);
		$("#diet option[value=" + '${userProfile.dietid}' + "]")
		        .prop("selected",true);
	});
	
	</script>
	
</head>
<body class="text-center">
	<div class="container" style="max-width: 800px;">
		<h2 class="display-2">User Profile</h2>
		<div id="success-dialog" class="alert alert-success dialog"
			style="display: none;">
			<strong>Success!</strong> Details updated successfully.
		</div>
		<div id="error-dialog" class="alert alert-danger dialog"
			style="display: none;">
			<strong>Error!</strong> Please try again.
		</div>
		
		<div class="panel panel-primary">
			<div class="panel-heading">Edit Details</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="firstName"
							class="col-md-4 col-form-label">First Name</label></span>
						<div class="col-md-8">
							<label class="col-form-label">${userDetails.fname}</label>
						</div>
					</div>
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="lastName"
							class="col-md-4 col-form-label">Last Name</label></span>
						<div class="col-md-8">
							<label class="col-form-label">${userDetails.lname}</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="height"
							class="col-md-4 col-form-label">Height</label></span>
						<div class="col-md-8">
							<input type="number" class="form-control" id="height" value="${userProfile.height}"
								placeholder="Height in cm" min="0" max="999"> <span
								id="help-block-max-height" class="help-block help-block-height">Height
								can only be a number between 0 and 999 cm.</span>
						</div>
					</div>
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="weight"
							class="col-md-4 col-form-label">Weight</label></span>
						<div class="col-md-8">
							<input type="number" class="form-control" id="weight" value="${userProfile.weight}"
								placeholder="Weight in lbs" min="0" max="999"> <span
								id="help-block-max-weight" class="help-block help-block-weight">Weight
								can only be a number between 0 and 999 lbs.</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="lifestyle"
							class="col-md-4 col-form-label">Lifestyle</label></span>
						<div class="col-md-8">
							<select class="form-control" name=lifestyle id="lifestyle">
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
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="diet"
							class="col-md-4 col-form-label">Diet</label></span>
						<div class="col-md-8">
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
		</div>
		<div class="col-4">
			<button type="button" class="btn btn-primary btn-lg"
				onclick="submit();">Update</button>
		</div>
	</div>