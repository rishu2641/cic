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
		
		String query = " select r.* from ingredients i, recipe r, ingredient_recipe_mapping irm where lower(name) like '%"+recipe.getSearchString().toLowerCase()+"%'" + 
				"and i.id = irm.ingredientid and r.id = irm.recipeid;";
		List<Recipe> users  = jdbcTemplate.query(query,
				new BeanPropertyRowMapper(Recipe.class));
		
		return users;
	}
	
	
	
}
