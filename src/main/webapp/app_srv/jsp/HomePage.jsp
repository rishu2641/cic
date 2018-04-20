<style>
{
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
	float: left;
	padding: 15px;
	width: 100%;
}

@media only screen and (min-width: 600px) {
	.col-s-1 {
		width: 8.33%;
	}
	.col-s-2 {
		width: 16.66%;
	}
	.col-s-3 {
		width: 25%;
	}
	.col-s-4 {
		width: 33.33%;
	}
	.col-s-5 {
		width: 41.66%;
	}
	.col-s-6 {
		width: 50%;
	}
	.col-s-7 {
		width: 58.33%;
	}
	.col-s-8 {
		width: 66.66%;
	}
	.col-s-9 {
		width: 75%;
	}
	.col-s-10 {
		width: 83.33%;
	}
	.col-s-11 {
		width: 91.66%;
	}
	.col-s-12 {
		width: 100%;
	}
}

@media only screen and (min-width: 768px) {
	.col-1 {
		width: 8.33%;
	}
	.col-2 {
		width: 16.66%;
	}
	.col-3 {
		width: 25%;
	}
	.col-4 {
		width: 33.33%;
	}
	.col-5 {
		width: 41.66%;
	}
	.col-6 {
		width: 50%;
	}
	.col-7 {
		width: 58.33%;
	}
	.col-8 {
		width: 66.66%;
	}
	.col-9 {
		width: 75%;
	}
	.col-10 {
		width: 83.33%;
	}
	.col-11 {
		width: 91.66%;
	}
	.col-12 {
		width: 100%;
	}
}

html {
	font-family: "Lucida Sans", sans-serif;
}

.menu {
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

.btallrec {
	background-color: #2196F3;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}

.btallrec button:hover {
	background-color: #0099cc;
}

@media screen and (max-width: 600px) {
	.topnav a {
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
	float: right;
	padding: 6px 10px;
	margin-top: 8px;
	margin-right: 16px;
	background: #ddd;
	font-size: 17px;
	border: none;
	cursor: pointer;
}

.searchClass .search-container button:hover {
	background: #ccc;
}
</style>
<script>
$(document).ready(function() {
	$("#home").addClass("active");
});
</script>
<div class="row">

<div class="col-4 col-s-4 menu">
<table>
<tr><td>
  <div class="searchClass">
  <div class="search-container">
    <input type="text" placeholder="Search.." name="search" style="width:400px;">
    <button type="button"><i class="fa fa-search"></i></button>
  </div>  
</div>
</td></tr>
<tr><td>
<div>
<p></p>
</div>
</td></tr>
<tr><td>
<div>
<p></p>
</div>
</td></tr>
<tr><td align='center'>
<div style="height:20px;width:200px">
	<form action="">
	<button type="button" value="" class="btallrec btn btn-primary btn-lg">Search Recipes</button>
	</form>
</div>
</td></tr>
</table>
</div>

<div class="col-6 col-s-9">
  <h1 align='center' class="display-4">Welcome!!</h1>
  <div align='center' class="intro">Can I Cook?</div>
	<div align='center' class="intro">Of course you can!! Just add the ingredients in your fridge and search for some amazing recipes that are simple to cook and amazing in taste!</div>
	<div align='center' class="intro">Want curated suggestions just for you? Sign Up with us today!</div>
			<div class="container col-10 col-s-12" align='center'> 	
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="item active">
							<img src="/CIC/resources/app_srv/images/Blood_Orange_Chiffon_Cake_with_Mango_Curd_(Unsplash).jpg" alt="Cake">
						</div>

						<div class="item">
							<img src="/CIC/resources/app_srv/images/meat-1536352_1920.jpg" alt="MeatDish">
						</div>
    
						<div class="item">
							<img src="/CIC/resources/app_srv/images/2014_Bruschetta_The_Larder_Chiang_Mai.jpg" alt="Bruschetta">
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
</div>

</div>