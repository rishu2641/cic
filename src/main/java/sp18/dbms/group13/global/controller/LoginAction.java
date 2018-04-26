
package sp18.dbms.group13.global.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;

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
	
	@RequestMapping(value = "/AllRecipes", method = RequestMethod.GET)
  public String AllRecipes() {
    return "allrecipes";
  }
	
	@RequestMapping(value = "/About", method = RequestMethod.GET)
  public String About() {
    return "about";
  }
	
	@RequestMapping(value = "/Logout", method = RequestMethod.GET)
	  public String Logout(HttpServletRequest request) {
		request.getSession().setAttribute("UserInfo", null);
	    return "homepage";
	  }

	@RequestMapping(value = "/Login", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView Login(@ModelAttribute("loginform")LoginForm loginForm, HttpServletRequest request, HttpServletResponse response) {

		ModelAndView modelandview = new ModelAndView("loginpage");
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
							List<UserProfile> lf = loginService.getUserDetails(loginForm);
							modelandview.addObject("userProfile", lf.get(0));
							modelandview.addObject("userDetails", luT.get(0));
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
				List<UserProfile> lf = loginService.getUserDetails(loginForm);
				List<UserDetails> luT = loginService.checkLogin(loginForm);
				
				modelandview.addObject("userProfile", lf.get(0));
				modelandview.addObject("userDetails", luT.get(0));
				modelandview.setViewName("dashboard");
			}
		return modelandview;

	}

	
	@RequestMapping(value = "/FetchRecipeDetails", method = RequestMethod.POST)
	public @ResponseBody List<Recipe> fetchRecipeDetails(Recipe recipe, HttpServletRequest request) {
		List<Recipe> result = loginService.getRecipeDetails(recipe);
		return result;

	}
	
	@RequestMapping(value = "/FetchIngredientDetails", method = RequestMethod.POST)
	public @ResponseBody List<Recipe> fetchIngredientDetails(Recipe recipe, HttpServletRequest request) {
		List<Recipe> result = loginService.getRecipeDetails(recipe);
		return result;

	}

	@RequestMapping(value = "/FetchRecipeDetails", method = RequestMethod.GET)
	public String fetchRecipeDetails(@RequestParam(value="ingredients", required=true) String searchString, Recipe recipe, HttpServletRequest request) {
		recipe.setSearchString(searchString);
		recipe.setIngr(searchString);
    request.setAttribute("searchString", searchString);
		return "allrecipes";

	}
	
	@RequestMapping(value = "/FetchChefDetails", method = RequestMethod.GET)
	public String fetchChefDetails(@RequestParam(value="chefname", required=true) String searchString, Recipe recipe, HttpServletRequest request) {
		recipe.setSearchString(searchString);
		List<Recipe> result = loginService.getChefDetails(recipe);
		request.setAttribute("recipeList", result);
		request.setAttribute("searchString", searchString);
		return "allrecipes";

	}
	
	@RequestMapping(value = "/UserProfile", method = RequestMethod.GET)
	public String userProfile(HttpServletRequest request) {
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("UserInfo");
		String userId = "";
		if(userInfo!=null) {
			userId = userInfo.getUserid();
			LoginForm loginForm = new LoginForm();
			loginForm.setUserid(userId);
			List<UserProfile> lf = loginService.getUserDetails(loginForm);
			List<UserDetails> luT = loginService.checkLogin(loginForm);
			
			request.setAttribute("userProfile", lf.get(0));
			request.setAttribute("userDetails", luT.get(0));
		}
		return "userProfile";

	}
	
	@RequestMapping(value = "/UpdateProfile", method = RequestMethod.POST)
	public @ResponseBody boolean updateProfile(LoginForm loginForm, HttpServletRequest request) {
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("UserInfo");
		String userId = "";
		if(userInfo!=null) {
			userId = userInfo.getUserid();
		}
		loginForm.setUserid(userId);
		boolean result = loginService.updateProfileAndRegistration(loginForm);
		return result;

	}
	
	
	@RequestMapping(value = "/CalculateSchemaRows", method = RequestMethod.POST)
	public @ResponseBody int calculateSchemaRows(LoginForm loginForm, HttpServletRequest request) {
		UserInfo userInfo = (UserInfo) request.getSession().getAttribute("UserInfo");
		String userId = "";
		if(userInfo!=null) {
			userId = userInfo.getUserid();
		}
		loginForm.setUserid(userId);
		int result = loginService.calculateSchemaRows(loginForm);
		return result;

	}
	
	
	
	
    
}
