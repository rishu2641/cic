<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

<script>
var RECIPE_ID;
var RECIPE_NAME = '${recipeString.name}';
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
		/*
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
		*/
	});
	/*$("#user_list_container input").change(function() {
		$.ajax({
			  type: "POST",
			  url: "/CIC/UserList",
			  data: {
				  "id" : RECIPE_ID,
				  "listname": this.value,
				  "othername": $("#other-input").val(),
				  "flag": this.checked
			  },
			  success: function (success) {
				  if(success) {
					  $("#added").show(); //Successfully added recipe to your list.
				  }
			  },
			  error: function (error) {
				  $("#added").show(); //Unable to add recipe to your list.
			  }
		  });
	});*/
}
function addNewList() {
	var listName = $("#new-custom-input").val();
	$('<label id="' + listName + '-label" class="btn btn-primary active"><input type="checkbox" value="' + listName + '" name="list" autocomplete="off">' + listName + '<i class="fa fa-plus"></i></label>').insertBefore("#new-custom");
	$("#new-custom").removeAttr("disabled");
	$("#new-custom-input-container").css("width", "0px");
	
}
$(document).ready(function() {
	window.document.title = RECIPE_NAME;
	addEventListeners();
	$("#body").css({
		"display": "flex",
    	"flex-direction": "column",
    	"justify-content": "center",
    	"align-items": "center"
	});
});
function addCustomList() {
	/*
	$.ajax({
		  type: "POST",
		  url: "/CIC/UserList",
		  data: {
			  "id" : RECIPE_ID,
			  "listname": "other",
			  "othername": listName,
			  "flag": "1"
		  },
		  success: function (listName) {
			  if(success) {
				  $("#added").show(); //Successfully added recipe to your list.
			  }
			  
		  },
		  error: function (error) {
			  $("#added").show(); //Unable to add recipe to your list.
		  }
	  });
*/
}
</script>
<div id="recipe_container">
	<div id="recipe_title">Big boobs coz ppl dont like balls.</div>
	<div class="sub_container">
		<div class="recipe_sub_title">
			My lists
		</div>
		<div id="user_list_container" class="btn-group" data-toggle="buttons">
			<label id="favorite-label" class="btn btn-primary">
				<input type="checkbox" value="favorite" name="list" autocomplete="off">
				Favorite<i class="fa fa-heart"></i>
			</label>
			<label id="cooked-label" class="btn btn-primary">
				<input type="checkbox" value="cooked" name="list" autocomplete="off">
				Cooked<i class="fa fa-check"></i>
			</label>
			<label id="custom1-label" class="btn btn-primary">
				<input type="checkbox" value="custom1" name="list" autocomplete="off">
				Custom List1<i class="fa fa-plus"></i>
			</label>
			<label id="custom2-label" class="btn btn-primary">
				<input type="checkbox" value="custom2" name="list" autocomplete="off">
				Custom List2<i class="fa fa-plus"></i>
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
				<span id="1" class="fa fa-star filled"></span>
				<span id="2" class="fa fa-star filled"></span>
				<span id="3" class="fa fa-star filled"></span>
				<span id="4" class="fa fa-star"></span>
				<span id="5" class="fa fa-star"></span>
			</div>
		</div>
		<div id="recipe_desc">
			'Tis grandma's recipe. For the whole family to enjoy.
		</div>
	</div>
	<div id="recipe_image">
		<img id="recipe_image" src="https://recipeland.com/images/r/685/a2829798dbc8ef087aff_1024.jpg"></img>
	</div>
	<div class="sub_container">
		<div id="recipe_tags_title" class="recipe_sub_title">
			Tags
		</div>
		<div id="recipe_tags">Lovely, large, big, wide, expansive, rack, bull, 404.</div>
	</div>
	<div class="sub_container">
		<div id="recipe_ingr_title" class="recipe_sub_title">
			Ingredients
		</div>
		<div id="recipe_ingr">
			<div class="ingredient">takes</div>
			<div class="ingredient">a</div>
			<div class="ingredient">lot</div>
			<div class="ingredient">1 inch of no fucks to give</div>
			<div class="ingredient">a teaspoon of water to dive into and die</div>
			<div class="ingredient">one group project to fuck you all up</div>
			<div class="ingredient">onions to make you cry</div>
			<div class="ingredient">a lot</div>
			<div class="ingredient">quick brown fox jumps over</div>
			<div class="ingredient">its dead friend</div>
		</div>
	</div>
	<div class="sub_container">
		<div>
			<div id="recipe_method_title" class="recipe_sub_title">
				Method
			</div>
			<div id="recipe_method_icon_container">
				<div id="prepTime"><i class="fa fa-clock"></i><b>Prep</b> 20 mins</div>
				<div id="cookTime"><i class="fa fa-clock"></i><b>Cook</b> 30 mins</div>
				<div id="totalTime"><i class="fa fa-clock"></i><b>Total</b> 50 mins</div>
			</div>
		</div>
		<div id="recipe_method">
			<div class="method">take the no fucks to give</div>
			<div class="method">and shove it up where you want to</div>
			<div class="method">strain it, dry it, grind it, chop it</div>
			<div class="method">knead into large balls</div>
			<div class="method">fry it all up and add some cheese on top</div>
			<div class="method">coz that makes everything better. fry yourself.</div>
		</div>
	</div>
	<div class="sub_container">
		<div class="recipe_sub_title">Nutritional Information</div>
		<div id="recipe_nutritional_information">
			Carbs: 20, Fat:100, Fucks: 0.
		</div>
	</div>
</div>