<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

<script>

var chefname = '${recipeString.chefname}';
var preptime = '${recipeString.preptime}';
var cooktime = '${recipeString.cooktime}';
var totaltime = parseInt(cooktime) + parseInt(preptime);
var instructions = '${recipeString.instructions}';
var searchString = '${recipeString.searchString}';
var RECIPE_ID = '${recipeString.id}';
var name = '${recipeString.name}';
var description = '${recipeString.description}';
var cuisine = '${recipeString.cuisine}';
var rating = parseInt('${recipeString.rating}')%5;
var num_of_reviews = '${recipeString.num_of_reviews}';
var servings = '${recipeString.servings}';
var recipe_link = '${recipeString.recipe_link}';
var keywords = '${recipeString.keywords}';
var image_link = '${recipeString.image_link}';
var ingr = '${recipeString.ingr}';
var diet = '${recipeString.diet}';
var cholestrol = '${recipeString.cholestrol}';
var sodium = '${recipeString.sodium}';
var protein = '${recipeString.protein}';
var carb = '${recipeString.carb}';
var fat = '${recipeString.fat}';
var calories = '${recipeString.calories}';
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
function addEventListeners() {
	$("#new-custom").click(function() {
		$("#new-custom-input-container").animate({
			width: '250px'
	    });
		$(this).attr("disabled", "disabled");
	});
	$("#recipe_rating span").hover(function() {
		var id = this.id;
		$("#" + id).addClass("hover");
	});
	$("#recipe_rating").focusout(function() {
		for(var i=1;i<=5;i++) {
			$("#" + i).removeClass("hover");
		}
	});
	$("#recipe_rating").mouseout(function() {
		for(var i=1;i<=5;i++) {
			$("#" + i).removeClass("hover");
		}
	});
	$("#recipe_rating span").click(function() {
		var id = this.id;
		for(var i=1;i<=id;i++) {
			$("#" + i).addClass("filled");
		}
		for(var i=parseInt(id)+1;i<=5;i++) {
			$("#" + i).removeClass("filled");
		}
		$.ajax({
			  type: "POST",
			  url: "/CIC/UserRating",
			  data: {
				  "id" : RECIPE_ID,
				  "rating": id
			  },
			  success: function (success) {
			  },
			  error: function (error) {
			  }
		  });
	});
	$("#user_list_container label").click(function() {
		var input = $(this).find("input").get(0);
		$.ajax({
			  type: "POST",
			  url: "/CIC/FavCookOrOther",
			  data: {
				  "id" : RECIPE_ID,
				  "listname": input.value == "fav" || input.value == "cook" ? input.value : "other",
				  "othername": input.value != "fav" && input.value != "cook" ? input.value : "",
				  "flag": $(this).hasClass("active") ? 0 : 1
			  },
			  success: function (success) {
				  if(success) {
					  alert("Successfully added recipe to your list.");
				  }
			  },
			  error: function (error) {
				  alert("Unable to add recipe to your list.");
			  }
		  });
	});
	var ingredients = ingr.split(",");
	for(var i=0;i<ingredients.length;i++) {
		if(ingredients[i].trim() != "") {
			$("#recipe_ingr").append('<div class="ingredient">' + ingredients[i] + '</div>');
		}
	}
	var instr = instructions.split(",");
	for(var i=0;i<instr.length;i++) {
		$("#recipe_method").append('<div class="method">' + instr[i] + '</div>');
	}
	var nutritionObj = {
			"cholestrol ": cholestrol,
			"sodium": sodium,
			"protein": protein,
			"carb": carb,
			"fat": fat,
			"calories": calories
	};
	for(var key in nutritionObj) {
		$("#recipe_nutritional_information").append('<div>' + key + ' : ' + nutritionObj[key] + '</div>');
	}
	$("#totalTime").append('<b> Total time : </b>' + totaltime + ' mins');
}
function addNewList() {
	var listName = $("#new-custom-input").val();
	$('<label id="' + listName + '-label" class="btn btn-primary active"><input type="checkbox" value="' + listName + '" name="list" autocomplete="off">' + listName + '<i class="fa fa-plus"></i></label>').insertBefore("#new-custom");
	$("#new-custom").removeAttr("disabled");
	$("#new-custom-input-container").css("width", "0px");
	$.ajax({
		  type: "POST",
		  url: "/CIC/FavCookOrOther",
		  data: {
			  "id" : RECIPE_ID,
			  "listname": "other",
			  "othername": listName,
			  "flag": "1"
		  },
		  success: function (listName) {
			  alert("Successfully added recipe to your list.");
			  
		  },
		  error: function (error) {
			  alert("Unable to add recipe to your list.");
		  }
	  });
	
}
$(document).ready(function() {
	window.document.title = name;
	for(var i=1;i<=rating;i++) {
		$("#" + i).addClass("filled");
	}
	addEventListeners();
	$("#body").css({
		"display": "flex",
    	"flex-direction": "column",
    	"justify-content": "center",
    	"align-items": "center"
	});
	
	var listNames = [];
	var activeListNames = [];
	for(var i=0;i<listNames.length;i++) {
		var str = '<label class="btn btn-primary';
		if(listNames[i] in activeListNames) {
			str +=  'active';
		}
		str += '"><input type="checkbox" value="' + listNames[i] + '" name="list" autocomplete="off">' + listNames[i] + '<i class="fa fa-plus"></i></label>';
		$("#new-custom-input-container").insertBefore(str);
	}
});
</script>
<div id="recipe_container">
	<div id="recipe_title">${recipeString.name}</div>
	<span>by <a href="/CIC/FetchChefDetails?chefname=" + '${recipeString.chefname}>'${recipeString.chefname}</a></span>
	<div class="sub_container">
		<div class="recipe_sub_title">
			My lists
		</div>
		<div id="user_list_container" class="btn-group" data-toggle="buttons">
			<label id="favorite-label" class="btn btn-primary">
				<input type="checkbox" value="fav" name="list" autocomplete="off">
				Favorite<i class="fa fa-heart"></i>
			</label>
			<label id="cooked-label" class="btn btn-primary">
				<input type="checkbox" value="cook" name="list" autocomplete="off">
				Cooked<i class="fa fa-check"></i>
			</label>			
			<div id="new-custom-input-container">
				<input type="text" id="new-custom-input" placeholder="My list name.."></input>
				<button type="button" id="new-custom-submit" onclick="addNewList()" class="btn btn-primary">Submit</button>
			</div>
			<button type="button" id="new-custom" class="btn btn-primary">
				Create and add to a new list<i class="fa fa-plus"></i></button>
		</div>
	</div>
	<div class="sub_container">
		<div class="recipe_sub_title">
			<div id="recipe_desc_title">Description</div>
			<div id="recipe_rating">
				<span id="1" class="fa fa-star"></span>
				<span id="2" class="fa fa-star"></span>
				<span id="3" class="fa fa-star"></span>
				<span id="4" class="fa fa-star"></span>
				<span id="5" class="fa fa-star"></span>
			</div>
		</div>
		<div id="recipe_desc">
			${recipeString.description}
		</div>
	</div>
	<div id="recipe_image">
		<img id="recipe_image" src="${recipeString.image_link }"></img>
	</div>
	<div class="sub_container">
		<div id="recipe_tags_title" class="recipe_sub_title">
			Tags
		</div>
		<div id="recipe_tags">${recipeString.keywords}</div>
	</div>
	<div class="sub_container">
		<div id="recipe_ingr_title" class="recipe_sub_title">
			Ingredients
		</div>
		<div id="recipe_ingr">
		</div>
	</div>
	<div class="sub_container">
		<div>
			<div id="recipe_method_title" class="recipe_sub_title">
				Method
			</div>
			<div id="recipe_method_icon_container">
				<div id="prepTime"><i class="fa fa-clock"></i><b>Prep</b>${recipeString.preptime} mins</div>
				<div id="cookTime"><i class="fa fa-clock"></i><b>Cook</b> ${recipeString.cooktime} mins</div>
				<div id="totalTime"><i class="fa fa-clock"></i></div>
			</div>
		</div>
		<div id="recipe_method">
		</div>
	</div>
	<div class="sub_container">
		<div class="recipe_sub_title">Nutritional Information</div>
		<div id="recipe_nutritional_information">
		</div>
	</div>
</div>