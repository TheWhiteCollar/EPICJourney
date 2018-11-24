/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

/* Database sequence
    #1: countryTripName (varchar 100)
 */

public class CountryTrip {
    private String countryTripName;

    public CountryTrip(String countryTripName) {
        this.countryTripName = countryTripName;
    }

    public String getCountryTripName() {
        return countryTripName;
    }

    public void setCountryTripName(String countryTripName) {
        this.countryTripName = countryTripName;
    }
    
    
}
