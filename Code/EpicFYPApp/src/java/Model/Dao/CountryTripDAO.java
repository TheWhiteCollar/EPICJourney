/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

//needs to be renamed into CountryTripDAO
public class CountryTripDAO {
    
    // get all countrytrip rows
    public static ArrayList<String> getAllCountryTrip() {

        ArrayList<String> countryTripNames = new ArrayList<>();
        String sql = "SELECT * FROM countrytrip ORDER BY countryTripName ASC";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                countryTripNames.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CountryTripDAO.class.getName()).log(Level.WARNING, "Unable to retrieve countries", ex);
        }

        return countryTripNames;
    }
    
    //insert new countrytrip
    public static boolean addCountryTrip(String countryTripName) {
        if (countryTripName.length() >= 1) {
            String sql = "INSERT INTO countrytrip (countryTripName) VALUES (?)";

            try (Connection conn = ConnectionManager.getConnection();
                    PreparedStatement stmt = conn.prepareStatement(sql);) {
                stmt.setString(1, countryTripName);
                int result = stmt.executeUpdate();
                if (result == 0) {
                    return false;
                }
            } catch (SQLException ex) {
                Logger.getLogger(CountryTripDAO.class.getName()).log(Level.WARNING, "Country already exist!", ex);
            }
            return true;
        }
        return false;   
    }
    
    // delete a particular countrytrip row
    public static boolean deleteCountryTrip(String countryTripName) {
        String sql = "DELETE FROM countrytrip WHERE countryTripName=?";
        try (
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, countryTripName);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CountryTripDAO.class.getName()).log(Level.WARNING, "Unable to delete country, countryTripName = '" + countryTripName, ex);
            return false;
        }
        return true;
    }
    
    // Update a particular countrytrip row
    public static boolean updateCountry(String newCountryTripName, String currentCountryTripName) {

        String sql = "UPDATE countrytrip SET countryTripName = ? WHERE countryTripName = ?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, newCountryTripName);
            stmt.setString(2, currentCountryTripName);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CountryTripDAO.class.getName()).log(Level.WARNING, "Failed to update: " + currentCountryTripName + ".", ex);
        }
        return true;
    }
    
}
