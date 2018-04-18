package sp18.dbms.group13.global.model;

import java.util.Date;

public class LoginForm {

	int userid;
	
	String firstName;
	
	String lastName;
	
	String strPassword;
	
	String strGender;
	
	Date dateOfBirth;
	
	int dietID;
	
	int strLifeStyle;
	
	int weight;
	
	int height;
	
	int isValid;

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getStrPassword() {
		return strPassword;
	}

	public void setStrPassword(String strPassword) {
		this.strPassword = strPassword;
	}

	public String getStrGender() {
		return strGender;
	}

	public void setStrGender(String strGender) {
		this.strGender = strGender;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public int getDietID() {
		return dietID;
	}

	public void setDietID(int dietID) {
		this.dietID = dietID;
	}

	public int getStrLifeStyle() {
		return strLifeStyle;
	}

	public void setStrLifeStyle(int strLifeStyle) {
		this.strLifeStyle = strLifeStyle;
	}

	public int getWeight() {
		return weight;
		
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getIsValid() {
		return isValid;
	}

	public void setIsValid(int isValid) {
		this.isValid = isValid;
	}
	
	
	
	
}
