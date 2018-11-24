/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;
import java.sql.Blob;

/* Database sequence
  #1: `companyID` int(11) NOT NULL,
  #2:`companyEmail` varchar(50) NOT NULL,
  #3:`companyName` varchar(100) NOT NULL,
  #4:`companyContact` int(15) NOT NULL,
  #5:`companyContinent` varchar(100) NOT NULL,
  #6:`companyCountry` varchar(100) NOT NULL,
  #7:`companyState` varchar(100) NOT NULL,
  #8:`companyDescription` varchar(500) NOT NULL,
  #9:`companyPassword` blob NOT NULL,
  #10:companySalt varchar(6)
    
 */

public class Company {
    private int companyID;
    private String companyEmail;
    private String companyName;
    private int companyContact;
    private String companyContinent;
    private String companyCountry;
    private String companyState;
    private String companyDescription;
    
    public Company(int companyID, String companyEmail, String companyName, int companyContact, String companyContinent, String companyCountry, String companyState, String companyDescription) {
        this.companyID = companyID;
        this.companyEmail = companyEmail;
        this.companyName = companyName;
        this.companyContact = companyContact;
        this.companyContinent = companyContinent;
        this.companyCountry = companyCountry;
        this.companyState = companyState;
        this.companyDescription = companyDescription;
        
    }

    public int getCompanyID() {
        return companyID;
    }

    public void setCompanyID(int companyID) {
        this.companyID = companyID;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public int getCompanyContact() {
        return companyContact;
    }

    public void setCompanyContact(int companyContact) {
        this.companyContact = companyContact;
    }

    public String getCompanyContinent() {
        return companyContinent;
    }

    public void setCompanyContinent(String companyContinent) {
        this.companyContinent = companyContinent;
    }

    public String getCompanyCountry() {
        return companyCountry;
    }

    public void setCompanyCountry(String companyCountry) {
        this.companyCountry = companyCountry;
    }

    public String getCompanyState() {
        return companyState;
    }

    public void setCompanyState(String companyState) {
        this.companyState = companyState;
    }

    public String getCompanyDescription() {
        return companyDescription;
    }

    public void setCompanyDescription(String companyDescription) {
        this.companyDescription = companyDescription;
    }

}
