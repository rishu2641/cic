<script>
var LOG_LEVEL = "INFO";
function logDebug(string) {
	if(LOG_LEVEL != "DEBUG") {
		console.log(string);
	}
}
function logInfo(string) {
	if(LOG_LEVEL == "ERROR" || LOG_LEVEL == "INFO") {
		console.log(string);
	}
}
function logError(string) {
	if(LOG_LEVEL == "ERROR") {
		console.log(string);
	}
}
$(document).ready(function() {
	$("#home").addClass("active");
	$("#search").keyup(function(event) {
	    if (event.keyCode === 13) {
	        $("#search-icon").click();
	        $("#search").val("");
	    }
	});
});
var ingrSet = new Set();
function addIngr() {
	  var ingr = $("#search").val().trim();
	  if(!ingrSet.has(ingr) && ingr != "") {
		  $("#ingrContainer").show();
		  ingrSet.add(ingr);
		  $("#ingrContainer").append('<div class="ingredient">' + ingr + '<span class="removeIngrContainer" onclick="removeIngr(this);"><i class="fa fa-times remove-ingr-icon"></i></span></div>' );
	  }
}
function removeIngr(elem) {
	  $(elem).parent().remove();
	  ingrSet.delete(elem.parentElement.textContent);
	  if(ingrSet.size==0) {
		  $("#ingrContainer").hide();
	  }
}
function search() {
	var ingr=[];
	if($("#search").val().trim()!="") ingr.push($("#search").val().trim());
	ingrSet.forEach(function (value1, value2, set) {
		ingr.push(value1);
	});
	ingr = ingr.join(",");
	logDebug("ingr = " + ingr);
	window.location.href="/CIC/FetchRecipeDetails?ingredients=" + ingr;
}
function calculateTuples(){
	 $.ajax({
		  type: "POST",
		  url: "/CIC/CalculateSchemaRows",
		  beforeSend: function() {
			  callme();
		  },
		  success: function (numTuples) {
			  $.unblockUI();
			  $("#numTuples").text(numTuples);
		  },
		  error: function (error) {
			  $.unblockUI();
			  alert("Error trying to get the tuples. There are possibly way too many.");
		  }
	  });
}
</script>
<div class="row">
    <div id="search-container" class="col-md-4 home">
    	
		<div id="tuple_container">
			<button id="tuple_btn" class="btn btn-primary btn-lg btn-block" onclick="calculateTuples();">Click me for the total #tuples :</button>
			<div id="numTuples">
			</div>
		</div>
      <div style="display: flex;flex-direction: row;">
        <input type="text" placeholder="Search Ingredients.." name="search" id="search" class="home">
        <button type="button" id="search-icon" class="home" onclick="addIngr();"><i class="fa fa-plus"></i></button>
      </div>
      <div id="ingrContainer" class="home" style="display:none;"></div>
	  <button type="button" value="" class="btallrec home" id="search-btn" onclick="search();">Search Recipes</button>
    </div> 

<div class="col-md-8">
  <div align='center'>
  <div id="site-welcome">Welcome!</div>
  <div id="site-title" align='center'>Can I Cook?</div>
	<div class="site-desc" align='center'>Of course you can!! Just add the ingredients in your fridge and search for some amazing recipes that are simple to cook and amazing in taste!</div>
	<div align='center' class="site-desc">Want curated suggestions just for you? <a id="home_sign_up" href="/CIC/Register">Sign Up</a> with us today!</div>
			<div class="col-md-11" align='center'> 	
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="/CIC/resources/app_srv/images/Blood_Orange_Chiffon_Cake_with_Mango_Curd_(Unsplash).jpg" alt="default">
						</div>

						<div class="carousel-item">
							<img src="/CIC/resources/app_srv/images/meat-1536352_1920.jpg" alt="MeatDish">
						</div>
    
						<div class="carousel-item">
							<img src="/CIC/resources/app_srv/images/2014_Bruschetta_The_Larder_Chiang_Mai.jpg" alt="Bruschetta">
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
						<span class="carousel-control-prev-icon"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#myCarousel" data-slide="next">
						<span class="carousel-control-next-icon"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
</div>

</div>