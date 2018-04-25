
<title>All Recipes</title>
<script>
$(document).ready(function() {
	window.document.title = "AllRecipes";
	$("#allrecipes").addClass("active");
	$('input[type=radio][name=prepTime]').change(function() {
        if (this.value == 'prepTimeCustom') {
        	$("#from-prepTime").removeAttr("disabled");
        	$("#to-prepTime").removeAttr("disabled");
        } else {
        	$("#from-prepTime").attr("disabled", "disabled");
        	$("#to-prepTime").attr("disabled", "disabled");
        }
    });
	$('input[type=radio][name=cookTime]').change(function() {
        if (this.value == 'cookTimeCustom') {
        	$("#from-cookTime").removeAttr("disabled");
        	$("#to-cookTime").removeAttr("disabled");
        } else {
        	$("#from-cookTime").attr("disabled", "disabled");
        	$("#to-cookTime").attr("disabled", "disabled");
        }
    });
	$('input[type=radio][name=totalTime]').change(function() {
        if (this.value == 'totalTimeCustom') {
        	$("#from-totalTime").removeAttr("disabled");
        	$("#to-totalTime").removeAttr("disabled");
        } else {
        	$("#from-totalTime").attr("disabled", "disabled");
        	$("#to-totalTime").attr("disabled", "disabled");
        }
    });
	$.each($(".filter-container1 button"), function(index, value) {
		$(value).click(function() {
			var divId = this.id.split("-btn")[0];
			$("#" + divId).slideToggle("slow");
		});
		var divId = value.id.split("-btn")[0];
		$("#divId").focusout(function() {
			var divId = this.id.split("-btn")[0];
			$("#" + divId).slideUp("slow");
		});
	});
});
  $(document).ready(function () {
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
	  var dietArr = $("input[name='diet']:checked").map(function() {
		    return this.value;
		}).get();
      var diet = dietArr.join(",");
	  console.log("diet = " + diet);
	  
	  var ingr="";
	  ingrSet.forEach(function (value1, value2, set) {
		  ingr+=value1+",";
	  });
	  ingr = ingr.substring(0, ingr.length - 1);
	  console.log("ingr = " + ingr);
	  
	  var prepTime = $("input[name='prepTime']:checked").val();
	  var prepTimeMin = 0;
	  var prepTimeMax = prepTime;
	  if(prepTime == "prepTimeCustom") {
		  prepTimeMin = parseInt($("#from-prepTime").val().trim());
		  prepTimeMax = parseInt($("#to-prepTime").val().trim());
		  if(isNaN(prepTimeMin) || isNaN(prepTimeMax)) {
			  alert("Please enter numeric values for the minimum and maximum preparation time.");
			  return;
		  }
		  if(prepTimeMin > prepTimeMax) {
			  alert("Minimum prep time cannot be more than maximum prep time.");
			  return;
		  }
	  } else if (prepTime) {
		  prepTimeMin = "0";
	  } else {
		  prepTimeMin = "";
		  prepTimeMax = "";
	  }
	  console.log("prepTimeMin = " + prepTimeMin);
	  console.log("prepTimeMax = " + prepTimeMax);
	  
	  var cookTime = $("input[name='cookTime']:checked").val();
	  var cookTimeMin = 0;
	  var cookTimeMax = cookTime || "";
	  if(cookTime == "cookTimeCustom") {
		  cookTimeMin = parseInt($("#from-cookTime").val().trim());
		  cookTimeMax = parseInt($("#to-cookTime").val().trim());
		  if(isNaN(cookTimeMin) || isNaN(cookTimeMax)) {
			  alert("Please enter numeric values for the minimum and maximum cooking time.");
			  return;
		  }
		  if(cookTimeMin > cookTimeMax) {
			  alert("Minimum cooking time cannot be more than maximum cooking time.");
			  return;
		  }
	  } else if (cookTime) {
		  cookTimeMin = "0";
	  } else {
		  cookTimeMin = "";
		  cookTimeMax = "";
	  }
	  console.log("cookTimeMin = " + cookTimeMin);
	  console.log("cookTimeMax = " + cookTimeMax);
	  
	  var totalTime = $("input[name='totalTime']:checked").val();
	  var totalTimeMin = 0;
	  var totalTimeMax = totalTime || "";
	  if(totalTime == "totalTimeCustom") {
		  totalTimeMin = parseInt($("#from-totalTime").val().trim());
		  totalTimeMax = parseInt($("#to-totalTime").val().trim());
		  if(isNaN(totalTimeMin) || isNaN(totalTimeMax)) {
			  alert("Please enter numeric values for the minimum and maximum total time.");
			  return;
		  }
		  if(totalTimeMin > totalTimeMax) {
			  alert("Minimum total time cannot be more than maximum total time.");
			  return;
		  }
	  } else if (totalTime) {
		  totalTimeMin = "0";
	  } else {
		  totalTimeMin = "";
		  totalTimeMax = "";
	  }
	  console.log("totalTimeMin = " + totalTimeMin);
	  console.log("totalTimeMax = " + totalTimeMax);
	  
	  var caloriesMin = $("#from-calories").val();
	  var caloriesMax = $("#to-calories").val();
	  if((isNaN(parseInt(caloriesMin)) || isNaN(parseInt(caloriesMax))) && (caloriesMin != "" || caloriesMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum calories.");
		  return;
	  }
	  console.log("caloriesMin = " + caloriesMin);
	  console.log("caloriesMax = " + caloriesMax);
	  
	  var cholesterolMin = $("#from-cholesterol").val();
	  var cholesterolMax = $("#to-cholesterol").val();
	  if((isNaN(parseInt(cholesterolMin)) || isNaN(parseInt(cholesterolMax))) && (cholesterolMin != "" || cholesterolMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum cholesterol.");
		  return;
	  }
	  if(parseInt(cholesterolMin) > parseInt(cholesterolMax)) {
		  alert("Minimum cholesterol cannot be more than maximum cholesterol.");
		  return;
	  }
	  console.log("cholesterolMin = " + cholesterolMin);
	  console.log("cholesterolMax = " + cholesterolMax);
	  
	  var sodiumMin = $("#from-sodium").val();
	  var sodiumMax = $("#to-sodium").val();
	  if((isNaN(parseInt(sodiumMin)) || isNaN(parseInt(sodiumMax))) && (sodiumMin != "" || sodiumMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum sodium.");
		  return;
	  }
	  if(parseInt(sodiumMin) > parseInt(sodiumMax)) {
		  alert("Minimum sodium cannot be more than maximum sodium.");
		  return;
	  }
	  console.log("sodiumMin = " + sodiumMin);
	  console.log("sodiumMax = " + sodiumMax);
	  
	  var proteinMin = $("#from-protein").val();
	  var proteinMax = $("#to-protein").val();
	  if((isNaN(parseInt(proteinMin)) || isNaN(parseInt(proteinMax))) && (proteinMin != "" || proteinMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum protein.");
		  return;
	  }
	  if(parseInt(proteinMin) > parseInt(proteinMax)) {
		  alert("Minimum protein cannot be more than maximum protein.");
		  return;
	  }
	  console.log("proteinMin = " + proteinMin);
	  console.log("proteinMax = " + proteinMax);
	  
	  var carbohydrateMin = $("#from-carbohydrate").val();
	  var carbohydrateMax = $("#to-carbohydrate").val();
	  if((isNaN(parseInt(carbohydrateMin)) || isNaN(parseInt(carbohydrateMax))) && (carbohydrateMin != "" || carbohydrateMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum carbohydrate.");
		  return;
	  }
	  if(parseInt(carbohydrateMin) > parseInt(carbohydrateMax)) {
		  alert("Minimum carbohydrate cannot be more than maximum carbohydrate.");
		  return;
	  }
	  console.log("carbohydrateMin = " + carbohydrateMin);
	  console.log("carbohydrateMax = " + carbohydrateMax);
	  
	  var fatMin = $("#from-fat").val();
	  var fatMax = $("#to-fat").val();
	  if((isNaN(parseInt(fatMin)) || isNaN(parseInt(fatMax))) && (fatMin != "" || fatMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum fat.");
		  return;
	  }
	  if(parseInt(fatMin) > parseInt(fatMax)) {
		  alert("Minimum fat cannot be more than maximum fat.");
		  return;
	  }
	  console.log("fatMin = " + fatMin);
	  console.log("fatMax = " + fatMax);
	  
	  var data = {
		  "ingr" : ingr || "",
		  "diet": diet || "",
		  "prepTimeMin": ""+prepTimeMin || "",
		  "prepTimeMax": ""+prepTimeMax || "",
		  "cookTimeMin": ""+cookTimeMin || "",
		  "cookTimeMax": ""+cookTimeMax || "",
		  "totalTimeMin": ""+totalTimeMin || "",
		  "totalTimeMax": ""+totalTimeMax || "",
		  "caloriesMin": ""+caloriesMin || "",
		  "caloriesMax": ""+caloriesMax || "",
		  "cholesterolMin": ""+cholesterolMin || "",
		  "cholesterolMax": ""+cholesterolMax || "",
		  "sodiumMin": ""+sodiumMin || "",
		  "sodiumMax": ""+sodiumMax || "",
		  "proteinMin": ""+proteinMin || "",
		  "proteinMax": ""+proteinMax || "",
		  "carbohydrateMin": ""+carbohydrateMin || "",
		  "carbohydrateMax": ""+carbohydrateMax || "",
		  "fatMin": ""+fatMin || "",
		  "fatMax": ""+fatMax || ""
	  };
	  console.log(data);
	  $.ajax({
		  type: "POST",
		  url: "/CIC/FetchRecipeDetails",
		  data: data,
		  success: function (success) {
			  console.log(success);
		  },
		  error: function (error) {
			  alert("Error while querying with given filters. Please check your filters/ingredients and try again.");
		  }
	  });
  }
  function parseResponse(arr) {
	  arr = [{
		  "searchString":null,
		  "id":"18982",
		  "description":null,
		  "chefname":"Tarla Dalal",
		  "preptime":"20 mins",
		  "cooktime":"0 mins ",
		  "instructions":null,
		  "cuisine":null,
		  "rating":"5",
		  "num_of_reviews":"1",
		  "servings":"4 servings",
		  "recipe_link":"https://www.tarladalal.com/Hawaiian-Fruit-and-Coconut-Salad-2194r",
		  "keywords":null,
		  "image_link":"https://www.tarladalal.com/members/9306/big/big_hawaiian_coconut-11990.jpg?size=696X905"}
	  ];
  }
</script>
<div class="row" id="the-big-one">
  <div id="search-container" class="col-md-3  filter-container2">
    <div  style="display: flex;flex-direction: row;margin-bottom: 17px; margin-left: 5px;">
      <input type="text" placeholder="Search Ingredients.." name="search" id="search">
      <button type="button" id="search-icon" onclick="addIngr();"><i class="fa fa-plus"></i></button>
    </div>
    <div id="ingrContainer" style="display:none;">
    </div>
	<button type="button" value="" class="btallrec" id="search-btn" onclick="search();">Search Recipes</button>
  </div> 
  <div id="allrecipes-container" class="col-md-9">
  	<div id="allrecipes-filter-container">
	  <div class="filter-container1">
		<button type="button" id="dietCheckBox-btn">
		   Diet
		  <i class="fa fa-angle-down"></i>
		</button>
		<div id="dietCheckBox" style="display:none;">
			<div>
				<div class="checkbox">
					<label class="checkbox-inline"><input type="checkbox" value="keto" name="diet">Keto</label>
					<label class="checkbox-inline"><input type="checkbox" value="paleo" name="diet">Paleo</label>
					<label class="checkbox-inline"><input type="checkbox" value="lactose intolerant" name="diet">Lactose Intolerant</label>
				</div>
				<div class="checkbox">
					<label class="checkbox-inline"><input type="checkbox" value="vegan" name="diet">Vegan</label>
					<label class="checkbox-inline"><input type="checkbox" value="vegetarian" name="diet">Vegetarian</label>
					<label class="checkbox-inline"><input type="checkbox" value="non vegetarian" name="diet">Non Vegetarian</label>
				</div>
				<div class="checkbox">
					<label class="checkbox-inline"><input type="checkbox" value="pescetarian" name="diet">Pescetarian</label>
					<label class="checkbox-inline"><input type="checkbox" value="pollotarian" name="diet">Pollotarian</label>
					<label class="checkbox-inline"><input type="checkbox" value="jain" name="diet">Jain</label>
				</div>
			</div>
		</div>
	  </div>
	  
	  <div class="filter-container1">
		<button type="button" id="prepTimeFilter-btn">
		   Prep Time
		  <i class="fa fa-angle-down"></i>
		</button>
		<div id="prepTimeFilter" style="display:none;">
			<div class="label-container-2">
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="30" id="prepTime30" name="prepTime">less than 30 mins</label>
				</div>
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="60" id="prepTime60" name="prepTime">less than 60 mins</label>
				</div>
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="120" id="prepTime120" name="prepTime">less than 120 mins</label>
				</div>
				<div class = "label-container-1 label-container-custom">
					<label class="radio-inline"><input type="radio" value="prepTimeCustom" id="prepTimeCustom" name="prepTime"></label>
					<input type="text" class="form-control filter-text" id="from-prepTime" disabled> to
					<input type="text" class="form-control filter-text" id="to-prepTime" disabled> mins
				</div>
			</div>
		</div>
	  </div>
	  
	  <div class="filter-container1">
		<button type="button" id="cookTimeFilter-btn">
		   Cooking Time
		  <i class="fa fa-angle-down"></i>
		</button>
		<div id="cookTimeFilter" style="display:none;">
			<div class="label-container-2">
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="30" id="cookTime30" name="cookTime">less than 30 mins</label>
				</div>
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="60" id="cookTime60" name="cookTime">less than 60 mins</label>
				</div>
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="120" id="cookTime120" name="cookTime">less than 120 mins</label>
				</div>
				<div class = "label-container-1 label-container-custom">
					<label class="radio-inline"><input type="radio" id="cookTimeCustom" value="cookTimeCustom" name="cookTime"></label>
					<input type="text" class="form-control filter-text" id="from-cookTime" disabled> to
					<input type="text" class="form-control filter-text" id="to-cookTime" disabled> mins
				</div>
			</div>
		</div>
	  </div>
	  
	  <div class="filter-container1">
		<button type="button" id="totalTimeFilter-btn">
		   Total Time
		  <i class="fa fa-angle-down"></i>
		</button>
		<div id="totalTimeFilter" style="display:none;">
			<div class="label-container-2">
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="30" id="totalTime30" name="totalTime">less than 30 mins</label>
				</div>
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="60" id="totalTime60" name="totalTime">less than 60 mins</label>
				</div>
				<div class = "label-container-1">
					<label class="radio-inline"><input type="radio" value="120" id="totalTime120" name="totalTime">less than 120 mins</label>
				</div>
				<div class = "label-container-1 label-container-custom">
					<label class="radio-inline"><input type="radio" id="totalTimeCustom" value="totalTimeCustom" name="totalTime"></label>
					<input type="text" class="form-control filter-text" id="from-totalTime" disabled> to
					<input type="text" class="form-control filter-text" id="to-totalTime" disabled> mins
				</div>
			</div>
		</div>
	  </div>
	  
	  <div class="filter-container1">
	<div>
	  <button type="button" id="nutritionFilter-btn">
	     Nutritional Value
	    <i class="fa fa-angle-down"></i>
	  </button>
	</div>
	<div id="nutritionFilter" class="col-md-12" style="display:none;">
		<div>
			<div class="text-container">
			<label class="filter-text-label">Calories</label>
				<input type="text" class="form-control filter-text2" id="from-calories"> to
				<input type="text" class="form-control filter-text2" id="to-calories"> cal
			</div>
			<div class="text-container">
			<label class="filter-text-label">Cholesterol</label>
				<input type="text" class="form-control filter-text2" id="from-cholesterol"> to
				<input type="text" class="form-control filter-text2" id="to-cholesterol"> mg
			</div>
			<div class="text-container">
			<label class="filter-text-label">Sodium</label>
				<input type="text" class="form-control filter-text2" id="from-sodium"> to
				<input type="text" class="form-control filter-text2" id="to-sodium"> mg
			</div>
			<div class="text-container">
			<label class="filter-text-label">Protein</label>
				<input type="text" class="form-control filter-text2" id="from-protein"> to
				<input type="text" class="form-control filter-text2" id="to-protein"> mg
			</div>
			<div class="text-container">
			<label class="filter-text-label">Carbs.</label>
				<input type="text" class="form-control filter-text2" id="from-carbohydrate"> to
				<input type="text" class="form-control filter-text2" id="to-carbohydrate"> g
			</div>
			<div class="text-container" style="padding-bottom:10px;">
			<label class="filter-text-label">Fat</label>
				<input type="text" class="form-control filter-text2" id="from-fat"> to
				<input type="text" class="form-control filter-text2" id="to-fat"> g
			</div>
		</div>
	</div>
  </div>
	</div>
	<div id="allrecipes-body">
	  <div class="recipe-item-container">
	  	<div class="recipe-item-thumbnail">
	  	  <img src="https://www.tarladalal.com/members/9306/big/big_hawaiian_coconut-11990.jpg" alt="Card image cap">
	  	</div>
	  	<div class="recipe-item-content">
	  	  <div class="recipe-item-title">
	  	    Balls. Big ones.
	  	  </div>
	  	  <div class="recipe-item-author">
	  	    by <a href="#authorpage">author</a>
	  	  </div>
	  	  <div class="recipe-item-desc">
	  	    Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls.
	  	    Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. Balls. 
	  	    <a class="view-recipe-link" href="#recipelink">View recipe</a>
	  	  </div>
	  	</div>
	  </div>
	  
	  <div class="recipe-item-container">
	  	<div class="recipe-item-thumbnail">
	  	  <img src="https://www.tarladalal.com/members/9306/big/big_hawaiian_coconut-11990.jpg" alt="Card image cap">
	  	</div>
	  	<div class="recipe-item-content">
	  	  <div class="recipe-item-title"> Balls. Small ones.
	  	  </div>
	  	  <div class="recipe-item-author">
	  	    by <a href="#authorpage">author</a>
	  	  </div>
	  	  <div class="recipe-item-desc">
	  	    Balls. Balls. Balls.
	  	    <a class="view-recipe-link" href="#">View recipe</a>
	  	  </div>
	  	</div>
	  </div>
	</div>
  </div>
</div>
