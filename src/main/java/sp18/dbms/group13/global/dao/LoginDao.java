package sp18.dbms.group13.global.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import sp18.dbms.group13.global.model.LoginForm;

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
	
	
	
}
