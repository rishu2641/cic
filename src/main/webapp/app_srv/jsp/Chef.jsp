<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

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
	var chefname = '${searchString}';
	window.document.title = chefname;
	$.ajax({
		  type: "POST",
		  url: "/CIC/FetchChefDetails",
		  data: {
			  "chefname": chefname,
		  },
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
			  alert("Error while querying with given chefname. Please try again.");
		  }
	  });
});
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