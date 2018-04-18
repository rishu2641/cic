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
	
	
	
}
