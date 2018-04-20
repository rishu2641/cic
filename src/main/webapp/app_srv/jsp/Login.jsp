<title>Login</title>
<script>
$(document).ready(function() {
	$("#login").addClass("active");
});
</script>

  <script>
  function login(){
	  var Message=$('#pass').val();
	$('#strPassword').val(Message);
	$('#userid').val($('#user').val());
	//alert(hash);
	document.getElementById("login-form").action="/PRIT/Login";
	//alert("before submit");
	document.getElementById("login-form").submit();
  }
  
  </script>

  <style>
  
	body {
  background: url(https://dl.dropboxusercontent.com/u/23299152/Wallpapers/wallpaper-22705.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
  font-family: 'Roboto', sans-serif;
}

.login-card h1 {
  font-weight: 100;
  text-align: center;
  font-size: 2.3em;
}

.login-card {
  padding: 40px;
  width: 274px;
  background-color: #F7F7F7;
  margin: 0 auto 10px;
  border-radius: 2px;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  overflow: hidden;
}

.login-card input[type=submit] {
  width: 100%;
  display: block;
  margin-bottom: 10px;
  position: relative;
}

.login-card input[type=text], input[type=password] {
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
  

  <div class="login-card">
    <h1>Log-in</h1><br>
  <form action="Login" id="login-form" method="post">
  	
    <input id="user" type="text" name="user" placeholder="Username">
    <input id="pass" type="password" name="pass" placeholder="Password">
    <input type="button" name="login" class="login login-submit" value="login" onclick="login()">
  </form>

  <div class="login-help">
    <a href="#">Register</a>  <a href="#">Forgot Password</a>
  </div>
</div>

