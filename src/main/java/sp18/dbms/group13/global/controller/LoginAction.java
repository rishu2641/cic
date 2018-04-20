
package sp18.dbms.group13.global.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sp18.dbms.group13.global.dao.LoginDao;
import sp18.dbms.group13.global.model.LoginForm;
import sp18.dbms.group13.global.model.Recipe;
import sp18.dbms.group13.global.model.UserDetails;
import sp18.dbms.group13.global.model.UserInfo;
import sp18.dbms.group13.global.model.UserProfile;

@Controller
public class LoginAction {

	@Autowired
	public LoginDao loginService;

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

	@RequestMapping(value = "/Register", method = RequestMethod.GET)
	public String registerUser(LoginForm loginForm, HttpServletRequest request) {
		return "registration";

	}

	@RequestMapping(value = "/Login", method = RequestMethod.GET)
	public String Login(LoginForm loginForm, HttpServletRequest request) {
		return "login";

	}

	@RequestMapping(value = "/RegisterUser", method = RequestMethod.POST)
	public @ResponseBody Boolean LoginPage(LoginForm loginForm, HttpServletRequest request) {
		boolean result = loginService.createRegistration(loginForm);
		return result;

	}
	
	
	@RequestMapping(value = "/DuplicateUser", method = RequestMethod.POST)
	public @ResponseBody Boolean DuplicateUser(LoginForm loginForm, HttpServletRequest request) {
		List<UserDetails> luT = loginService.checkLogin(loginForm);
		if(luT.size()>0) {
			return true;
		}
		return false;
	}

	@RequestMapping(value = "/Login", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView Login(LoginForm loginForm, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelandview = new ModelAndView("homepage");
		UserInfo usrInfo = (UserInfo) request.getSession().getAttribute("UserInfo");
			if (usrInfo == null) {
				String passwordHash = loginForm.getStrPassword();
				try {
					List<UserDetails> luT = loginService.checkLogin(loginForm);

					if (luT.size() > 0) {
						if (luT.get(0).getPassword().equals(passwordHash)) {
							UserInfo userInfo = new UserInfo();
							userInfo.setUserid(loginForm.getUserid());
							request.getSession().setAttribute("UserInfo", userInfo);
							UserProfile lf = loginService.getUserDetails(loginForm);
							modelandview.addObject("userDetails", lf);
							modelandview.setViewName("dashboard");

						}
						else {
							request.setAttribute("Message", "Invalid Credentials");
						}
					}else {
						request.setAttribute("Message", "Invalid Credentials");
					}	
						
				} catch (Exception e) {
					request.setAttribute("Message", "Please try again!");
					request.getSession().invalidate();
					e.printStackTrace();
				}

			} else {
				loginForm.setUserid(usrInfo.getUserid());
				UserProfile lf = loginService.getUserDetails(loginForm);
				modelandview.addObject("userDetails", lf);
				modelandview.setViewName("dashboard");
			}
		return modelandview;

	}

	
	@RequestMapping(value = "/FetchRecipeDetails", method = RequestMethod.POST)
	public @ResponseBody List<Recipe> fetchRecipeDetails(Recipe recipe, HttpServletRequest request) {
		List<Recipe> result = loginService.getRecipeDetails(recipe);
		return result;

	}

    
}
