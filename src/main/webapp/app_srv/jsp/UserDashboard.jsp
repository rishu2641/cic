<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false"%>

<h3>Welcome! <a href="/CIC/UserProfile">${userDetails.fname} ${userDetails.lname}</a> </h3>

<script>
function saveHistory(){
	$.ajax({
		  type: "POST",
		  url: "/CIC/InsertIntoHistory",
		  data: {
			  "recipeId": 1380
		  },
		  beforeSend: function() {
			  callme();
		  },
		  success: function (success) {
			  $.unblockUI();
			  alert("Data saved in history!");
		  },
		  error: function (error) {
			  $.unblockUI();
			  alert("Error while querying with given filters. Please check your filters/ingredients and try again.");
		  }
	  });
}

</script>


<input type="button" value="i am a button, you should click me" onclick="saveHistory()"/>