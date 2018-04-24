
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
});
</script>
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

</style>
<script>
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
	  
  }
</script>
<div class="row" id="the-big-one">

<div id="search-bar">
  <div id="search-container" class="col-md-3  filter-container2">
      <div>
      <input type="text" placeholder="Search Ingredients.." name="search" id="search">
      <button type="button" id="search-icon" onclick="addIngr();"><i class="fa fa-plus"></i></button>
      </div>
      <div id="ingrContainer" style="display:none;">
      </div>
      <div>
	    <button type="button" value="" class="btallrec" id="search-btn" onclick="search();">Search Recipes</button>
      </div>
  </div> 
  <div class="btcollapse col-md-3 filter-container1">
	<button type="button" data-toggle="collapse" data-target="#dietCheckBox">
	  Filter by Diet
	  <i class="fa fa-angle-down"></i>
	</button>
	<div id="dietCheckBox" class="collapse">
		<div>
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
		</div>
	</div>
  </div>
  
  <div class="btcollapse col-md-3 filter-container1">
	<button type="button" data-toggle="collapse" data-target="#prepTimeFilter">
	  Filter by Prep Time
	  <i class="fa fa-angle-down"></i>
	</button>
	<div id="prepTimeFilter" class="collapse">
		<div style="width: 134px;margin-left: 58px;">
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
				<label class="radio-inline"><input type="radio" value="prepTimeCustom" id="prepTimeCustom" name="prepTime">custom</label>
				<input type="text" class="form-control filter-text" id="from-prepTime" disabled> to
				<input type="text" class="form-control filter-text" id="to-prepTime" disabled> mins
			</div>
		</div>
	</div>
  </div>
  
  <div class="btcollapse col-md-3 filter-container1">
	<button type="button" data-toggle="collapse" data-target="#cookTimeFilter">
	  Filter by Cooking Time
	  <i class="fa fa-angle-down"></i>
	</button>
	<div id="cookTimeFilter" class="collapse">
		<div style="width: 134px;margin-left: 58px;">
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
				<label class="radio-inline"><input type="radio" id="cookTimeCustom" value="cookTimeCustom" name="cookTime">custom</label>
				<input type="text" class="form-control filter-text" id="from-cookTime" disabled> to
				<input type="text" class="form-control filter-text" id="to-cookTime" disabled> mins
			</div>
		</div>
	</div>
  </div>
  
  <div class="btcollapse col-md-3 filter-container1">
	<div>
	  <button type="button" data-toggle="collapse" data-target="#nutritionFilter">
	    Nutritional Value
	    <i class="fa fa-angle-down"></i>
	  </button>
	</div>
	<div id="nutritionFilter" class="collapse col-md-12">
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
			<label class="filter-text-label">Carbohydrate</label>
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

</div>
