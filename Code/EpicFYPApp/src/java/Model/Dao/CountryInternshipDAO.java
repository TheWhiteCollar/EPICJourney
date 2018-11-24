/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.CountryInternship;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CountryInternshipDAO {
    // Update a particular countryinternship row
    public static boolean updateCountryInternship(String countryName, String countryContinent) {

        String sql = "UPDATE countryinternship SET countryContinent=? WHERE countryName=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, countryContinent);
            stmt.setString(2, countryName);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CountryInternshipDAO.class.getName()).log(Level.WARNING, "Failed to update: " + countryName + ".", ex);
        }
        return true;
    }

    // Add a new countryinternship row
    public static boolean addCountryInternship(String countryName, String countryContinent) {

        String sql = "INSERT INTO countryinternship (countryName, countryContinent) VALUES (?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, countryName);
            stmt.setString(2, countryContinent);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CountryInternshipDAO.class.getName()).log(Level.WARNING, "Country Name is already taken!", ex);
        }
        return true;
    }

    public static boolean deleteCountryInternship(String countryName) {

        String sql1 = "DELETE FROM countryinternship WHERE countryName=?";

        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setString(1, countryName);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CountryInternshipDAO.class.getName()).log(Level.WARNING, "Unable to delete country, countryName = '" + countryName, ex);
            return false;
        }
        return true;
    }

    //get all countryinternship names
    public static ArrayList<CountryInternship> getAllCountryInternship() {
        ArrayList<CountryInternship> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM countryinternship ORDER BY countryName ASC");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new CountryInternship(rs.getString(1), rs.getString(2)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static ArrayList<String> getAllCountryInternshipString() {

        ArrayList<String> countryInternshipNames = new ArrayList<>();
        String sql = "SELECT * FROM countryinternship ORDER BY countryName ASC";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                countryInternshipNames.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CountryInternshipDAO.class.getName()).log(Level.WARNING, "Unable to retrieve countries", ex);
        }

        return countryInternshipNames;
    }
    
    //get all countryinternship names with contient America
    public static ArrayList<CountryInternship> getAllCountryInternship(String countryName) {
        ArrayList<CountryInternship> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * from countryinternship WHERE countryContinent=?");
            stmt.setString(1, countryName);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new CountryInternship(rs.getString(1), rs.getString(2)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}
