
package sp18.dbms.group13.global.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import sp18.dbms.group13.global.dao.LoginDao;
import sp18.dbms.group13.global.model.LoginForm;

@Controller
public class LoginAction {

    
    @Autowired
    public LoginDao loginService ;

    @ExceptionHandler(Exception.class)
    public String exc(HttpServletRequest request, Exception e) {

        System.out.println("exception occured in LoginAction ......... " + e);
        e.printStackTrace();
        return "ErrorPage";

    }

    @RequestMapping(value = "/HomePage", method = RequestMethod.GET)
    public String HomePage(LoginForm loginForm, HttpServletRequest request) {
    	return "homepage";
    	
    }
    
    @RequestMapping(value = "/LoginPage", method = RequestMethod.GET)
    public String LoginPage(LoginForm loginForm, HttpServletRequest request) {
    	boolean result = loginService.createLogin(loginForm);
    	System.out.println(result);
    	return "homepage";
    	
    }


    
}
