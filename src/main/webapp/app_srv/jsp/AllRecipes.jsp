
<title>All Recipes</title>
<script>
$(document).ready(function() {
	$("#allrecipes").addClass("active");
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
/*[class*="col-"] {
	float:left;
    padding: 15px;
    width: 100%;
}*/
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
	padding: 0px;
	border: 1px solid blue;
	
}

.btcollapse button{
	border: none;
    /* margin-left: 17px; */
    /* margin-top: 5px; */
    font-size: 17px;
    /* text-align: center; */
    width: 100%;
    padding: 10px;
}

#search-container {
  float: left;
  padding-right: 0px;
}
#search-container::after {
  content: "";
  clear: both;
  display: table;
}
#search {
  padding: 10px;
  font-size: 17px;
  border: 1px solid grey;
  float: left;
  width: 80%;
  background: #f1f1f1;
  margin-left: 12px;
}
#search-icon {
  float: left;
    height: 46px;
    width: 46px;
    background: #2196F3;
    color: white;
    font-size: 17px;
    border: 1px solid grey;
    border-left: none;
    cursor: pointer;
}
#search-icon:hover {
  /*background: #ccc;*/
  background: #0b7dda;
}
#search-bar {
    padding-top: 10px;
}
.filter-text {
    width: 57px;
    display: inline-block;
    padding-left: 3px;
}
.filter-text-label {
	width: 100%;
    float: left;
    text-align: left;
    padding-top: 6px;
}
#the-big-one {
    width: 100%;
}
.text-container {
    padding-top: 10px;
}
.label-container-1 {
    float: left;
    padding-top: 3px;
    padding-bottom: 5px;
}
.filter-container1 {
    width: 250px !important;
}
.filter-container2 {
	width: 365px !important
}
.label-container-custom {
	width: 237px;
	margin-left: -53px;"
}
.filter-text2 {
    width: 72px;
    display: inline-block;
    padding-left: 3px;
}
</style>

<div class="row" id="the-big-one">

<div id="search-bar">
  <div id="search-container" class="col-md-3  filter-container2">
      <input type="text" placeholder="Search Ingredients.." name="search" id="search">
      <button type="button" id="search-icon" onclick="addIngr();"><i class="fa fa-plus"></i></button>
      <div>
	    <button type="button" value="" class="btallrec">Search Recipes</button>
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
				<label class="radio-inline"><input name="optradio" type="radio" value="30" id="prepTime30">less than 30 mins</label>
			</div>
			<div class = "label-container-1">
				<label class="radio-inline"><input name="optradio" type="radio" value="60" id="prepTime60">less than 60 mins</label>
			</div>
			<div class = "label-container-1">
				<label class="radio-inline"><input name="optradio" type="radio" value="120" id="prepTime120">less than 120 mins</label>
			</div>
			<div class = "label-container-1 label-container-custom">
				<label class="radio-inline"><input name="optradio" type="radio" value="120" id="prepTime120">custom</label>
				<input type="text" class="form-control filter-text" id="from-prepTime"> to
				<input type="text" class="form-control filter-text" id="to-prepTime"> mins
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
				<label class="radio-inline"><input name="optradio" type="radio" value="30" id="cookTime30">less than 30 mins</label>
			</div>
			<div class = "label-container-1">
				<label class="radio-inline"><input name="optradio" type="radio" value="60" id="cookTime60">less than 60 mins</label>
			</div>
			<div class = "label-container-1">
				<label class="radio-inline"><input name="optradio" type="radio" value="120" id="cookTime120">less than 120 mins</label>
			</div>
			<div class = "label-container-1 label-container-custom">
				<label class="radio-inline"><input name="optradio" type="radio" id="prepTimeCustom">custom</label>
				<input type="text" class="form-control filter-text" id="from-cookTime"> to
				<input type="text" class="form-control filter-text" id="to-cookTime"> mins
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
