package sp18.dbms.group13.global.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import sp18.dbms.group13.global.model.Ingredients;
import sp18.dbms.group13.global.model.LoginForm;
import sp18.dbms.group13.global.model.Recipe;
import sp18.dbms.group13.global.model.UserDetails;
import sp18.dbms.group13.global.model.UserProfile;

@Repository
public class LoginDao {
	
	@Autowired JdbcTemplate jdbcTemplate;

	public boolean createLogin(LoginForm loginForm) {
		
		int result = jdbcTemplate.update("insert into diet (id,name) values (1,'keto')");
		if(result>0) {
			return true;
			
		}
		else return false;
	}

	public boolean createRegistration(LoginForm loginForm) {
		
		String query1 = " insert into user_details (userid, fname, lname, password, gender, dob) values (?,?,?,?,?,?)";
		int result = jdbcTemplate.update(query1,loginForm.getUserid(),loginForm.getFirstName(),loginForm.getLastName(),loginForm.getStrPassword(),loginForm.getStrGender(),loginForm.getDateOfBirth());
		
        int count = jdbcTemplate.queryForObject("select count(*) from user_profile", Integer.class)+1; 
		
		String query2 = " insert into user_profile (id, userid, dietid, lifestyle, weight, height, isvalid) values (?,?,?,?,?,?,?)";
		int result2 = jdbcTemplate.update(query2, count,loginForm.getUserid(),loginForm.getDietID(),loginForm.getStrLifeStyle(),loginForm.getWeight(),loginForm.getHeight(),1);
		
		
		if(result>0 && result2>0) {
			return true;
		}
		return false;
	}

	public List<UserDetails> checkLogin(LoginForm loginForm) {
		
		String query = " select * from user_details where userid = '"+loginForm.getUserid()+"'";
		List<UserDetails> users  = jdbcTemplate.query(query,
				new BeanPropertyRowMapper(UserDetails.class));
		
		return users;
	}

	public List<UserProfile> getUserDetails(LoginForm loginForm) {
		String query = " select * from user_profile where userid = '"+loginForm.getUserid()+"' and isvalid = 1";
		List<UserProfile> users  = jdbcTemplate.query(query,
				new BeanPropertyRowMapper(UserProfile.class));
		
		return users;
	}

	public List<Recipe> getRecipeDetails(Recipe recipe) {
		
		//String query = "  select * from recipe where id in (select r.id from ingredients i, recipe r, ingredient_recipe_mapping irm where lower(i.name) like '%"+recipe.getSearchString().toLowerCase()+"%' " + 
		//		"and i.id = irm.ingredientid and r.id = irm.recipeid )";
		String[] ingredientList = recipe.getIngr().split(",");
		String[] dietList = recipe.getDiet().split(",");
		
		
		//Query for ingredient list
		String q1 = "";
		if(ingredientList.length>0) {
			String ingredient = " like '%";
			for(String ing:ingredientList) {
				ingredient+=ing+"%' or '%";
			}
			ingredient = ingredient.substring(0,ingredient.length()-6);
			
			q1 = "select distinct(recipeid) from ingredient_recipe_mapping where ingredientid in (select distinct(id) from ingredients where name "+ingredient+" )";
		}
		
		
		//Query for diet list
		String q2 = "";
		if(dietList.length>0) {
			String diet = " like '%";
			for(String die:dietList) {
				diet+=die+"%' or '%";
			}
			diet = diet.substring(0,diet.length()-6);
			
			q2 = "select distinct(recipeid) from recipe_diet_mapping where dietid in ( select distinct(id) from diet where name "+diet+" )";
		}
		
		
		//Query for preptime
		String q3 = "";
		int minPrepTime = 0;
		int maxPrepTime = 50000;
		
		if(!recipe.getPrepTimeMin().equals(""))
			minPrepTime = Integer.parseInt(recipe.getPrepTimeMin());
		
		if(!recipe.getPrepTimeMax().equals(""))
			maxPrepTime = Integer.parseInt(recipe.getPrepTimeMax());
		
		q3 = "select distinct(recipeid) from recipe where preptime between "+minPrepTime+" and "+maxPrepTime;
	
		
		
		//Query for cooktime
		String q4 = "";
		int minCookTime = 0;
		int maxCookTime = 50000;
		
		if(!recipe.getCookTimeMin().equals(""))
			minCookTime = Integer.parseInt(recipe.getCookTimeMin());
		
		if(!recipe.getCookTimeMax().equals(""))
			maxCookTime = Integer.parseInt(recipe.getCookTimeMax());
		
		q4 = "select distinct(recipeid) from recipe where cooktime between "+minCookTime+" and "+maxCookTime;
	
		
		//Query for totaltime
		String q5 = "";
		int minTotalTime = 0;
		int maxTotalTime = 50000;
		
		if(!recipe.getTotalTimeMin().equals(""))
			minTotalTime = Integer.parseInt(recipe.getTotalTimeMin());
		
		if(!recipe.getTotalTimeMax().equals(""))
			maxTotalTime = Integer.parseInt(recipe.getTotalTimeMax());
		
		q5 = "select distinct(recipeid) from recipe where (to_number(cooktime)+to_number(preptime)) between "+minTotalTime+" and "+maxTotalTime;
	
		
		//Query for calories
		String q6 = "";
		int minCalories = 0;
		int maxCalories = 50000;
		
		if(!recipe.getCaloriesMin().equals(""))
			minCalories = Integer.parseInt(recipe.getCaloriesMin());
		
		if(!recipe.getCaloriesMax().equals(""))
			maxCalories = Integer.parseInt(recipe.getCaloriesMax());
		
		q6 = "select distinct(recipeid) from nutritional_information where calories between "+minCalories+" and "+maxCalories;
		
		
		//Query for cholesterol
		String q7 = "";
		int minCholesterol = 0;
		int maxCholesterol = 50000;
		
		if(!recipe.getCholesterolMin().equals(""))
			minCholesterol = Integer.parseInt(recipe.getCholesterolMin());
		
		if(!recipe.getCholesterolMax().equals(""))
			maxCholesterol = Integer.parseInt(recipe.getCholesterolMax());
		
		q7 = "select distinct(recipeid) from nutritional_information where cholestrol between "+minCholesterol+" and "+maxCholesterol;
		
		
		//Query for sodium
		String q8 = "";
		int minSodium = 0;
		int maxSodium = 50000;
		
		if(!recipe.getSodiumMin().equals(""))
			minSodium = Integer.parseInt(recipe.getSodiumMin());
		
		if(!recipe.getSodiumMax().equals(""))
			maxSodium = Integer.parseInt(recipe.getSodiumMax());
		
		q8 = "select distinct(recipeid) from nutritional_information where sodium between "+minSodium+" and "+maxSodium;
		
		
		
		//Query for protein
		String q9 = "";
		int minProtein = 0;
		int maxProtein = 50000;
		
		if(!recipe.getProteinMin().equals(""))
			minProtein = Integer.parseInt(recipe.getProteinMin());
		
		if(!recipe.getProteinMax().equals(""))
			maxProtein = Integer.parseInt(recipe.getProteinMax());
		
		q9 = "select distinct(recipeid) from nutritional_information where protein between "+minProtein+" and "+maxProtein;
		
		

		//Query for carb
		String q10 = "";
		int minCarb = 0;
		int maxCarb = 50000;
		
		if(!recipe.getCarbohydrateMin().equals(""))
			minCarb= Integer.parseInt(recipe.getCarbohydrateMin());
		
		if(!recipe.getCarbohydrateMax().equals(""))
			maxCarb = Integer.parseInt(recipe.getCarbohydrateMax());
		
		q10 = "select distinct(recipeid) from nutritional_information where carb between "+minCarb+" and "+maxCarb;
		
		
		
		//Query for fat
		String q11 = "";
		int minFat = 0;
		int maxFat = 50000;
		
		if(!recipe.getFatMin().equals(""))
			minFat= Integer.parseInt(recipe.getFatMin());
		
		if(!recipe.getFatMax().equals(""))
			maxFat = Integer.parseInt(recipe.getFatMax());
		
		q11 = "select distinct(recipeid) from nutritional_information where fat between "+minFat+" and "+maxFat;
				
				
		
		String queryFinal = "Select * from recipe where id in ("+q1+") or id in ("+q2+") or "
				+ " id in ("+q3+") or "
						+ " id in ("+q4+") or "
						+ " id in ("+q5+") or "
						+ " id in ("+q6+") or "
						+ " id in ("+q7+") or "
						+ " id in ("+q8+") or "
						+ " id in ("+q9+") or "
						+ " id in ("+q10+") or "
						+ " id in ("+q11+")";
		
		
		System.out.println(queryFinal);
				
		List<Recipe> users  = jdbcTemplate.query(queryFinal,
				new BeanPropertyRowMapper(Recipe.class));
		
		return users;
	}

	public List<Recipe> getChefDetails(Recipe recipe) {
		String query = "  select * from recipe where id in (select r.id from recipe r where lower(r.name) like '%"+recipe.getSearchString().toLowerCase()+"%' )" ;
		List<Recipe> users  = jdbcTemplate.query(query,
				new BeanPropertyRowMapper(Recipe.class));
		
		return users;
	}

	public boolean updateProfileAndRegistration(LoginForm loginForm) {

		String query = " select * from user_profile where userid = '"+loginForm.getUserid()+"' and isvalid = 1";
		List<UserProfile> users  = jdbcTemplate.query(query,
				new BeanPropertyRowMapper(UserProfile.class));
		
		int result = 0;
		if(users.size()>0) {
			String query1 = " update user_profile set isvalid = 0 where userid = '"+loginForm.getUserid()+"'";
			result = jdbcTemplate.update(query1);
		}
		
		
		boolean update = false;
		String query2 = " update user_details set ";
		if(!loginForm.getFirstName().trim().equals("")) {
			query2 += " fname = '"+loginForm.getFirstName()+"'";
			update = true;
		}
		if(!loginForm.getFirstName().trim().equals("")) {
			query2 += " fname = '"+loginForm.getFirstName()+"'";
			update = true;
		}
		int result2 = 0;
		if(update) {
			result2 = jdbcTemplate.update(query2);
		}

        int count = jdbcTemplate.queryForObject("select count(*) from user_profile", Integer.class)+1; 

		String query3 = " insert into user_profile (id, userid, dietid, lifestyle, weight, height, isvalid) values (?,?,?,?,?,?,?)";
		int result3 = jdbcTemplate.update(query3, count,loginForm.getUserid(),(loginForm.getDietID()!=null && !loginForm.getDietID().trim().equals(""))?loginForm.getDietID():users.get(0).getDietid(),
				(loginForm.getStrLifeStyle()!=null && !loginForm.getStrLifeStyle().trim().equals(""))?loginForm.getStrLifeStyle():users.get(0).getLifestyle(),
						!(loginForm.getWeight()==0)?loginForm.getWeight():users.get(0).getWeight(),
								!(loginForm.getHeight()==0)?loginForm.getHeight():users.get(0).getHeight(),1);


		if(result>0 && result2>0 && result3>0) {
			return true;
		}
		
		return false;
	}
	
	
	
}
