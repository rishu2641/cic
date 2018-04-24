<script>
	  $(document).ready(function () {
		  window.document.title = "Register";
		  $("#register").addClass("active");
		  $(".help-block").hide();
		  $("input").keyup(function() {
			  var id = $(this).attr("id");
			  $(".help-block-" + id).hide();
			  validateField(id);
			  $("#error-dialog").hide();
			  $("#success-dialog").hide();
		  });
		  $("input").change(function() {
			  var id = $(this).attr("id");
			  $(".help-block-" + id).hide();
			  validateField(id);
			  $("#error-dialog").hide();
			  $("#success-dialog").hide();
			  checkDuplicateUser();
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
		  checkDuplicateUser(true);
	  }
	  function checkDuplicateUser(submit) {
		  $.ajax({
			  type: "POST",
			  url: "/CIC/DuplicateUser",
			  data: {
				  "userid" : $.trim($("#userid").val())
			  },
			  success: function (failure) {
				  if(failure) {
					  $("#help-block-duplicate-userid").show();
				  }
				  if(submit){
					  sendData();
				  }
			  },
			  error: function (error) {
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
	<div class="container" style="max-width: 800px;">
		<div id="success-dialog" class="alert alert-success dialog"
			style="display: none;">
			<strong>Success!</strong> Redirecting you to login page.
		</div>
		<div id="error-dialog" class="alert alert-danger dialog"
			style="display: none;">
			<strong>Error!</strong> Please try again.
		</div>
		<div class="panel panel-primary">
			<div class="panel-heading">Primary Details</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-7 label-input">
						<span class="label-container"><label for="userid"
							class="col-md-5 col-form-label">User Name</label></span>
						<div class="col-md-7">
							<input type="text" class="form-control" id="userid"
								placeholder="Username" required> <span
								id="help-block-duplicate-userid"
								class="help-block help-block-userid">Username already
								exists. Get creative!</span> <span id="help-block-len-userid"
								class="help-block help-block-userid">Username is
								mandatory and can only have a maximum of 16 characters.</span>
						</div>
					</div>
					<div class="col-md-2"></div>
				</div>
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-7 label-input">
						<span class="label-container"><label for="strPassword"
							class="col-md-5 col-form-label">Password</label></span>
						<div class="col-md-7">
							<input type="password" class="form-control" id="strPassword"
								placeholder="Password" required> <span
								id="help-block-len-password"
								class="help-block help-block-strPassword">Password can
								have a minimum of 8 and a maximum of 16 characters.</span>
								<!-- Sorry, your password must contain a capital letter, two numbers, a symbol, an inspiring message, a spell, a gang sign, a hieroglyph and the blood of a virgin -->
								<!-- Sorry, your password is not good enough. Just like you. -->
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-7 label-input">
						<span class="label-container"><label for="confirmpassword"
							class="col-md-5 col-form-label">Confirm Password</label></span>
						<div class="col-md-7">
							<input type="password" class="form-control" id="confirmpassword"
								placeholder="Confirm Password" required> <span
								id="help-block-password-mismatch"
								class="help-block help-block-confirmpassword">Password
								mismatch</span>
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
						<span class="label-container"><label for="firstName"
							class="col-md-4 col-form-label">First Name</label></span>
						<div class="col-md-8">
							<input type="text" class="form-control" id="firstName"
								placeholder="First Name" required> <span
								id="help-block-len-firstname"
								class="help-block help-block-firstName">First name is
								mandatory and can only have a maximum of 20 characters.</span>
						</div>
					</div>
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="lastName"
							class="col-md-4 col-form-label">Last Name</label></span>
						<div class="col-md-8">
							<input type="text" class="form-control" id="lastName"
								placeholder="Last Name"> <span
								id="help-block-len-lastname"
								class="help-block help-block-lastName">Last name can only
								have a maximum of 20 characters.</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 label-input">
						<span class="label-container"><label
							class="col-md-4 col-form-label">Gender</label></span>
						<div class="col-md-8">
							<label class="col-md-6" for="male"> Male <input class=""
								type="radio" name="strGender" id="male" value="male">
							</label> <label class="col-md-6" for="female"> Female <input
								class="" type="radio" name="strGender" id="female"
								value="female">
							</label>
						</div>
					</div>
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="dateOfBirth"
							class="col-md-4 col-form-label">Date of Birth</label></span>
						<div class="col-md-8">
							<input type="date" class="form-control" id="dateOfBirth">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="height"
							class="col-md-4 col-form-label">Height</label></span>
						<div class="col-md-8">
							<input type="number" class="form-control" id="height"
								placeholder="Height in cm" min="0" max="999"> <span
								id="help-block-max-height" class="help-block help-block-height">Height
								can only be a number between 0 and 999 cm.</span>
						</div>
					</div>
					<div class="col-md-6 label-input">
						<span class="label-container"><label for="weight"
							class="col-md-4 col-form-label">Weight</label></span>
						<div class="col-md-8">
							<input type="number" class="form-control" id="weight"
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
			<button id="submit-btn" type="button" class="btn btn-primary btn-lg"
				onclick="submit();">Register</button>
		</div>
	</div>