<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

<title>All Recipes</title>
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
function attachEventHandlers() {
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
	$("#search").keyup(function(event) {
	    if (event.keyCode === 13) {
	        $("#search-icon").click();
	        $("#search").val("");
	    }
	});
}
function attachEggAnimation() {
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
	var animObj = {};
	$.each($("#dietCheckBox label"), function (index, value) {
		var diet = value.id.split("-label")[0];
		var animData = {
			wrapper: value,
			animType: 'svg',
			loop: false,
			prerender: false,
			autoplay: false,
			path: "/CIC/resources/app_srv/js/egg_flip.json"
		};
		animObj["anim-"+diet] = bodymovin.loadAnimation(animData);
		window["animInterval-"+diet] = window.setInterval(function() {
			var elem = $(value).find("svg");
			if(elem.length) {
				clearInterval(window["animInterval-"+diet]);
				$(value).find("svg").css({
					"width": "25%",
					"height": "auto",
					"cursor": "pointer",
					"float": "right"
				});
			}
		}, 200);
		$(value).find("svg").ready(function() {
			$(value).find("svg").css({
				"width": "25%",
				"height": "auto",
				"cursor": "pointer",
				"float": "right"
			});
		});
		animObj["anim-"+diet].setSpeed(15);
	});
	
	$("#dietCheckBox label").click(function() {
		var diet = this.id.split("-label")[0];
		var anim=animObj["anim-"+diet];
		var tweenElem = $(this).find(".eggGroup").get(0);
		if(anim.currentFrame > 0) {
			anim.playSegments([anim.currentFrame, 0], true);
			TweenMax.to(tweenElem, 1, {
				x:0,
			    ease:Elastic.easeOut.config(0.9,0.38)
			})   
		} else {
			TweenMax.to(tweenElem, 1.4, {
				x:73,
			    ease:Elastic.easeOut.config(0.9,0.38)
			 })
			 anim.playSegments([anim.currentFrame, 300], true)
		}
	});
}
function renderIngredients() {
	var ingr = "${searchString}".split(",");
	for(var i=0;i<ingr.length;i++) {
		addIngr(ingr[i]);
	}
	search();
}
function renderGetRequest() {
	renderIngredients();
}
$(document).ready(function() {
	window.document.title = "AllRecipes";
	$("#allrecipes").addClass("active");
	attachEventHandlers();
	attachEggAnimation();
	if("${searchString}") {
		renderGetRequest();
	}
});
  var ingrSet = new Set();
  function addIngr(ingredient) {
	  var ingr = ingredient || $("#search").val().trim();
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
  var dataTable;
  function search() {
	  
	  var dietArr = $("#dietCheckBox label.active").map(function() {
		    return $(this).find("input").get(0).value;
		}).get();
      var diet = dietArr.join(",");
	  logDebug("diet = " + diet);
	  
	  var ingr=[];
	  if($("#search").val().trim()!="") ingr.push($("#search").val().trim());
	  ingrSet.forEach(function (value1, value2, set) {
		  ingr.push(value1);
	  });
	  ingr = ingr.join(",");
	  logDebug("ingr = " + ingr);
	  
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
	  logDebug("prepTimeMin = " + prepTimeMin);
	  logDebug("prepTimeMax = " + prepTimeMax);
	  
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
	  logDebug("cookTimeMin = " + cookTimeMin);
	  logDebug("cookTimeMax = " + cookTimeMax);
	  
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
	  logDebug("totalTimeMin = " + totalTimeMin);
	  logDebug("totalTimeMax = " + totalTimeMax);
	  
	  var caloriesMin = $("#from-calories").val();
	  var caloriesMax = $("#to-calories").val();
	  if((isNaN(parseInt(caloriesMin)) || isNaN(parseInt(caloriesMax))) && (caloriesMin != "" || caloriesMax != "")) {
		  alert("Please enter numeric values for the minimum and maximum calories.");
		  return;
	  }
	  logDebug("caloriesMin = " + caloriesMin);
	  logDebug("caloriesMax = " + caloriesMax);
	  
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
	  logDebug("cholesterolMin = " + cholesterolMin);
	  logDebug("cholesterolMax = " + cholesterolMax);
	  
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
	  logDebug("sodiumMin = " + sodiumMin);
	  logDebug("sodiumMax = " + sodiumMax);
	  
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
	  logDebug("proteinMin = " + proteinMin);
	  logDebug("proteinMax = " + proteinMax);
	  
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
	  logDebug("carbohydrateMin = " + carbohydrateMin);
	  logDebug("carbohydrateMax = " + carbohydrateMax);
	  
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
	  logDebug("fatMin = " + fatMin);
	  logDebug("fatMax = " + fatMax);
	  
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
	  logInfo(data);
	  $.ajax({
		  type: "POST",
		  url: "/CIC/FetchRecipeDetails",
		  data: data,
		  beforeSend: function() {
			  callme();
		  },
		  success: function (success) {
			  $.unblockUI();
			  parseResponse(success);
			  logDebug(success);
		  },
		  error: function (error) {
			  $.unblockUI();
			  alert("Error while querying with given filters. Please check your filters/ingredients and try again.");
		  }
	  });
  }
  function onRecipeClick(recipeId) {
	  $.ajax({
		  type: "POST",
		  url: "/CIC/InsertIntoHistory",
		  data: {
			  "recipeId" : recipeId
		  },
		  success: function () {
			  alert("Data saved in history!");
		  },
		  error: function () {
			  alert("Data saved in history!");
		  }
	  });
	  window.location.href = "/CIC/recipe?id=" + recipeId;
	  
  }
  function parseResponse(arr) {
	  for(var i=0;i<arr.length;i++) {
			var obj = arr[i];
			var recipe_item_thumbnail = '<div class="recipe_item_thumbnail" onclick="onRecipeClick(' + obj.id + ')"><img src="' + obj.image_link + '" alt="' + obj.name + '" title="' + obj.name + '"></div>';
			var recipe_item_title = '<div class="recipe_item_title" onclick="onRecipeClick(' + obj.id + ')">' + obj.name + '</div>';
			var recipe_item_author = '<div class="recipe_item_author"> by <a href="/CIC/FetchChefDetails?chefname=' + obj.chefname + '" title="View ' + obj.chefname + '\'s recipes">' + obj.chefname + '</a></div>';
			var recipe_item_desc = '<div class="recipe_item_desc">' + obj.description + '<a class="view_recipe_link" onclick="onRecipeClick(' + obj.id + ')">View Recipe</a></div>';
			var recipe_item_content='<div class="recipe_item_content">' + recipe_item_title + recipe_item_author + recipe_item_desc +'</div>';
			var recipe_item_container = '<div class="recipe_item_container page-item" onclick="onRecipeClick(' + obj.id + ')">' + recipe_item_thumbnail + recipe_item_content +'</div>';
			$("#allrecipes-body").append('<tr><td>' + recipe_item_container + '</tr></td');
	  }
	  if(!dataTable) {
		  dataTable = $("#dataTable").DataTable();
	  }

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
		<div id="dietCheckBox" style="display:none;" class="btn-group" data-toggle="buttons">
			<label id="keto-label" class="btn btn-primary"><input type="checkbox" value="keto" name="diet" autocomplete="off">Keto</label>
			<label id="paleo-label" class="btn btn-primary"><input type="checkbox" value="paleo" name="diet" autocomplete="off">Paleo</label>
			<label id="lactose-intolerant-label" class="btn btn-primary"><input type="checkbox" value="lactose intolerant" name="diet" autocomplete="off">Lactose Intolerant</label>
			<label id="vegan-label" class="btn btn-primary"><input type="checkbox" value="vegan" name="diet" autocomplete="off">Vegan</label>
			<label id="vegetarian-label" class="btn btn-primary"><input type="checkbox" value="vegetarian" name="diet" autocomplete="off">Vegetarian</label>
			<label id="non-vegetarian-label" class="btn btn-primary"><input type="checkbox" value="non vegetarian" name="diet" autocomplete="off">Non Vegetarian</label>
			<label id="pescetarian-label" class="btn btn-primary"><input type="checkbox" value="pescetarian" name="diet" autocomplete="off">Pescetarian</label>
			<label id="pollotarian-label" class="btn btn-primary"><input type="checkbox" value="pollotarian" name="diet" autocomplete="off">Pollotarian</label>
			<label id="jain-label" class="btn btn-primary"><input type="checkbox" value="jain" name="diet" autocomplete="off">Jain</label>
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
	<table id="dataTable">
	<thead style="display:none">
		<tr>
			<th>
			</th>
		</tr>
	</thead>
	<tbody id="allrecipes-body">
	</tbody>
	</table>
  </div>
</div>
