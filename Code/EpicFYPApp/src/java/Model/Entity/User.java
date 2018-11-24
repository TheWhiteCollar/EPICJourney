/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

import java.sql.Blob;

/* Database sequence

    #1: userEmail (varchar 50)
    #2: userFirstName (varchar 50)
    #3: userLastName (varchar 50)
    #4: userPhone (int 15)
    #5: userGender (varchar 1)
    #6: userCitizenship (varchar 100)
    #7: userDOB (year 4)
    #8: userInterest (varchar 1000)
    #9: userPassword (blob) - not in entity
    #10: userSalt (varchar 6) - not in entity
    #11: userOccupation (varchar 100)
    #12: userResume (mediumblob)
    #13: userIsEmailConfirm (varchar 10)
    #14: userHighestEducation (varchar 100)
    #15: userFieldOfStudy (varchar 100)
    #16: userDescription (varchar 500)
    #17: userSchool (varchar 50)

 */

public class User {
    
    private String userEmail;
    private String userFirstName;
    private String userLastName;
    private int userPhone;
    private String userGender;
    private String userCitizenship;
    private int userDOB;
    private String userInterest;
    private String userOccupation;
    private Blob userResume;
    private String userIsEmailConfirm;
    private String userHighestEducation;
    private String userFieldOfStudy;
    private String userDescription;
    private String userSchool;

    public User(String userEmail, String userFirstName, String userLastName, int userPhone, String userGender, String userCitizenship, int userDOB, String userInterest, String userOccupation, Blob userResume, String userIsEmailConfirm, String userHighestEducation, String userFieldOfStudy, String userDescription, String userSchool) {
        this.userEmail = userEmail;
        this.userFirstName = userFirstName;
        this.userLastName = userLastName;
        this.userPhone = userPhone;
        this.userGender = userGender;
        this.userCitizenship = userCitizenship;
        this.userDOB = userDOB;
        this.userInterest = userInterest;
        this.userOccupation = userOccupation;
        this.userResume = userResume;
        this.userIsEmailConfirm = userIsEmailConfirm;
        this.userHighestEducation = userHighestEducation;
        this.userFieldOfStudy = userFieldOfStudy;
        this.userDescription = userDescription;
        this.userSchool = userSchool;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserFirstName() {
        return userFirstName;
    }

    public void setUserFirstName(String userFirstName) {
        this.userFirstName = userFirstName;
    }

    public String getUserLastName() {
        return userLastName;
    }

    public void setUserLastName(String userLastName) {
        this.userLastName = userLastName;
    }

    public int getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(int userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getUserCitizenship() {
        return userCitizenship;
    }

    public void setUserCitizenship(String userCitizenship) {
        this.userCitizenship = userCitizenship;
    }

    public int getUserDOB() {
        return userDOB;
    }

    public void setUserDOB(int userDOB) {
        this.userDOB = userDOB;
    }

    public String getUserInterest() {
        return userInterest;
    }

    public void setUserInterest(String userInterest) {
        this.userInterest = userInterest;
    }

    public String getUserOccupation() {
        return userOccupation;
    }

    public void setUserOccupation(String userOccupation) {
        this.userOccupation = userOccupation;
    }

    public Blob getUserResume() {
        return userResume;
    }

    public void setUserResume(Blob userResume) {
        this.userResume = userResume;
    }

    public String getUserIsEmailConfirm() {
        return userIsEmailConfirm;
    }

    public void setUserIsEmailConfirm(String userIsEmailConfirm) {
        this.userIsEmailConfirm = userIsEmailConfirm;
    }

    public String getUserHighestEducation() {
        return userHighestEducation;
    }

    public void setUserHighestEducation(String userHighestEducation) {
        this.userHighestEducation = userHighestEducation;
    }

    public String getUserFieldOfStudy() {
        return userFieldOfStudy;
    }

    public void setUserFieldOfStudy(String userFieldOfStudy) {
        this.userFieldOfStudy = userFieldOfStudy;
    }

    public String getUserDescription() {
        return userDescription;
    }

    public void setUserDescription(String userDescription) {
        this.userDescription = userDescription;
    }

    public String getUserSchool() {
        return userSchool;
    }

    public void setUserSchool(String userSchool) {
        this.userSchool = userSchool;
    }

}
