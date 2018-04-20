You will see all the recipes with filters here.
<script>
$(document).ready(function() {
	$("#allrecipes").addClass("active");
});
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>All Recipes</title>

<style>
* {
    box-sizing: border-box;
}
img {
    width: auto;
    height: auto;
	size: container;
}
.row:after {
    content: "";
    clear: both;
    display: table;
}
[class*="col-"] {
	float:left;
    padding: 15px;
    width: 100%;
}
@media only screen and (min-width: 600px) {
    .col-s-1 {width: 8.33%;}
    .col-s-2 {width: 16.66%;}
    .col-s-3 {width: 25%;}
    .col-s-4 {width: 33.33%;}
    .col-s-5 {width: 41.66%;}
    .col-s-6 {width: 50%;}
    .col-s-7 {width: 58.33%;}
    .col-s-8 {width: 66.66%;}
    .col-s-9 {width: 75%;}
    .col-s-10 {width: 83.33%;}
    .col-s-11 {width: 91.66%;}
    .col-s-12 {width: 100%;}
}
@media only screen and (min-width: 768px) {
    .col-1 {width: 8.33%;}
    .col-2 {width: 16.66%;}
    .col-3 {width: 25%;}
    .col-4 {width: 33.33%;}
    .col-5 {width: 41.66%;}
    .col-6 {width: 50%;}
    .col-7 {width: 58.33%;}
    .col-8 {width: 66.66%;}
    .col-9 {width: 75%;}
    .col-10 {width: 83.33%;}
    .col-11 {width: 91.66%;}
    .col-12 {width: 100%;}
}
html {
    font-family: "Lucida Sans", sans-serif;
}
.menu{
    padding: 8px;
    margin-bottom: 7px;
}
.topnav {
  overflow: hidden;
  background-color: #e9e9e9;
}

.topnav a {
  float: left;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color: #2196F3;
  color: white;
}

.btallrec{
	background-color: #2196F3;
	color: white;
    padding: 6px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 17px;
    margin: 4px 2px;
    cursor: pointer;
}

.btallrec button:hover{
	background-color: #0099cc;
}

.btcollapse{
	background-color: #e9e9e9;
	color = #c6c6c6;
	padding: 6px;
}

.btcollapse button{
	border: none;
	margin-left: 17px;
	margin-top: 5px;
	font-size: 17px;
	text-align: center;
}

@media screen and (max-width: 600px) {
  .topnav a{
    float: none;
    display: block;
    text-align: left;
    width: 100%;
    margin: 0;
    padding: 14px;
  }
}
.searchClass .search-container {
  float: left;
}
.searchClass input[type=text] {
  padding: 6px;
  margin-left: 17px;
  margin-top: 8px;
  font-size: 17px;
  border: none;
}
.searchClass .search-container button {
  float:right;
  padding: 10px 12px;
  margin-top: 8px;
  background: #ddd;
  font-size: 17px;
  border: none;
  cursor: pointer;
}
.searchClass .search-container button:hover {
  background: #ccc;
}
</style>

</head>
<body>

<div class="topnav">
  <a href="#home">Home</a>
  <a class="active" href="#about">All Recipes</a>
  <a href="#contact">About Us</a>
  <a href="#login" style="float:right;">Sign In</a>
  <a href="#Register" style="float:right;">Register</a>
</div>

<div class="row">

<div class="col-4 col-s-4 menu">
<table>
<tr><td>
	<div class="btcollapse">
	<button class="btcollapse" type="button" data-toggle="collapse" data-target="#dietCheckBox">Diet</button>
	<div id="dietCheckBox" class="collapse btcollapse">
		<div class="container btcollapse">
			<form>
			<div class="checkbox">
				<label class="checkbox-inline"><input type="checkbox" value="keto">Keto</label>
				<label class="checkbox-inline"><input type="checkbox" value="paleo">Paleo</label>
				<label class="checkbox-inline"><input type="checkbox" value="ovo">Ovo</label>
				<label class="checkbox-inline"><input type="checkbox" value="lactose intolerant">Lactose Intolerant</label>
			</div>
			<div class="checkbox">
				<label class="checkbox-inline"><input type="checkbox" value="vegan">Vegan</label>
				<label class="checkbox-inline"><input type="checkbox" value="vegetarian">Vegetarian</label>
				<label class="checkbox-inline"><input type="checkbox" value="non vegetarian">Non Vegetarian</label>
			</div>
			<div class="checkbox">
				<label class="checkbox-inline"><input type="checkbox" value="pescetarian">Pescetarian</label>
				<label class="checkbox-inline"><input type="checkbox" value="pollotarian">Pollotarian</label>
				<label class="checkbox-inline"><input type="checkbox" value="jain">Jain</label>
			</div>
			</form>
		</div>
	</div>
	</div>
</td></tr>
<tr><td>
  <div class="searchClass">
  <div class="search-container">
    <form action="/action_page.php">
      <input type="text" placeholder="Search Ingredients.." name="search" style="width:400px;">
      <button type="submit"><i class="fa fa-search"></i></button>
    </form>
  </div>  
</div>
</td></tr>
<tr><td>
<div>
<p><!--List of ingredients populated here--></p>
</div>
</td></tr>
<tr><td>
<div class="btcollapse">
	<button class="btcollapse" type="button" data-toggle="collapse" data-target="#timeFilter">Time</button>
	<div id="timeFilter" class="collapse btcollapse">
		<div class="container btcollapse">
			<form>
			<label>Prep Time (less than)</label>
			<div>
				<label class="radio-inline"><input name="optradio" type="radio" value="30">30 minutes</label>
				<label class="radio-inline"><input name="optradio" type="radio" value="45">45 minutes</label>
				<label class="radio-inline"><input name="optradio" type="radio" value="60">60 minutes</label>
			</div>
			<div>
				<label class="radio-inline"><input name="optradio" type="radio" value="90">90 minutes</label>
				<label class="radio-inline"><input name="optradio" type="radio" value="120">120 minutes</label>
				<label class="radio-inline"><input name="optradio" type="radio" value="">none</label>
			</div>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<div>
				<label class="radio-inline"><input class="radio-inline" name="opttimeprep" type="radio" value="minutes">Minutes</label>
				<label class="radio-inline"><input class="radio-inline" name="opttimeprep" type="radio" value="hour">Hour</label>
				</div>
				</label>
			</div>
			<label>Cook Time (less than)</label>
			<div>
				<label class="radio-inline"><input name="optradiocook" type="radio" value="30">30 minutes</label>
				<label class="radio-inline"><input name="optradiocook" type="radio" value="45">45 minutes</label>
				<label class="radio-inline"><input name="optradiocook" type="radio" value="60">60 minutes</label>
			</div>
			<div>
				<label class="radio-inline"><input name="optradiocook" type="radio" value="90">90 minutes</label>
				<label class="radio-inline"><input name="optradiocook" type="radio" value="120">120 minutes</label>
				<label class="radio-inline"><input name="optradiocook" type="radio" value="">none</label>
			</div>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<div>
				<label class="radio-inline"><input class="radio-inline" name="opttimecook" type="radio" value="minutes">Minutes</label>
				<label class="radio-inline"><input class="radio-inline" name="opttimecook" type="radio" value="hour">Hour</label>
				</div>
				</label>
			</div>
			</form>
		</div>
	</div>
</div>
</td></tr>
<tr><td>
<div class="btcollapse">
	<button class="btcollapse" type="button" data-toggle="collapse" data-target="#nutritionFilter">Nutritional Value</button>
	<div id="nutritionFilter" class="collapse btcollapse">
		<div class="container btcollapse">
			<form>
			<label>Cholesterol</label>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<label class="radio-inline">mg</label>
				</label>
			</div>
			<label>Sodium</label>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<label class="radio-inline">mg</label>
				</label>
			</div>
			<label>Protein</label>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<label class="radio-inline">g</label>
				</label>
			</div>
			<label>Carbohydrate</label>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<label class="radio-inline">g</label>
				</label>
			</div>
			<label>Fat</label>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<label class="radio-inline">g</label>
				</label>
			</div>
			<label>Calories</label>
			<div>
				<label class="radio-inline">
				<input type="text"> to <input type="text">
				<label class="radio-inline">cal</label>
				</label>
			</div>
			</form>
		</div>
	</div>
</div>

</td></tr>
<tr><td align='center'>
<div style="height:20px;width:200px">
	<form action="">
	<button type="submit" value="" class="btallrec">Search Recipes</button>
	</form>
</div>
</td></tr>
</table>
</div>

<div class="col-6 col-s-9">
  
</div>

</div>

</body>
</html>