/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

/* Database sequence
    #1: countryName (varchar 100)
    #2: countryContinent (varchar 100)
 */

public class CountryInternship {
    private String countryName;
    private String countryContinent;

    public CountryInternship(String countryName, String countryContinent) {
        this.countryName = countryName;
        this.countryContinent = countryContinent;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getCountryContinent() {
        return countryContinent;
    }

    public void setCountryContinent(String countryContinent) {
        this.countryContinent = countryContinent;
    }
    
    
}
