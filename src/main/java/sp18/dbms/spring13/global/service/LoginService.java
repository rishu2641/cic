package sp18.dbms.spring13.global.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sp18.dbms.group13.global.dao.LoginDao;
import sp18.dbms.group13.global.model.LoginForm;

@Service
public class LoginService {

	@Autowired
	private LoginDao loginDao;
	
	boolean createLogin(LoginForm loginForm) {
		return false;//loginDao.createLogin(loginForm);
	}
	
	
}
