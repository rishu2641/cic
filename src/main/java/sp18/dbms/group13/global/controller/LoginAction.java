
package sp18.dbms.group13.global.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
    
    @RequestMapping(value = "/RegisterUser", method = RequestMethod.POST)
    public @ResponseBody Boolean LoginPage(LoginForm loginForm, HttpServletRequest request) {
    	boolean result = loginService.createRegistration(loginForm);
    	return result;
    	
    }


    
}
