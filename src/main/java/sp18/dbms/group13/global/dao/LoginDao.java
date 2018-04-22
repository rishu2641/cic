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
		
		String query = "  select * from recipe where id in (select r.id from ingredients i, recipe r, ingredient_recipe_mapping irm where lower(i.name) like '%"+recipe.getSearchString().toLowerCase()+"%' " + 
				"and i.id = irm.ingredientid and r.id = irm.recipeid )";
		List<Recipe> users  = jdbcTemplate.query(query,
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
