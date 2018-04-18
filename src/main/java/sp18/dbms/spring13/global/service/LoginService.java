package sp18.dbms.spring13.global.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sp18.dbms.group13.global.dao.LoginDao;

@Service
public class LoginService {

	@Autowired
	private LoginDao loginDao;
	
	
}
