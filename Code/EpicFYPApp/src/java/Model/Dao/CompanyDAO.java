/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.Company;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CompanyDAO {
    
    //update a particular company row
    public static boolean updateCompany(int companyID, String companyEmail, String companyName, int companyContact, String companyContinent, String companyCountry, String companyState, String companyDescription){

        String sql = "UPDATE company SET companyEmail=?, companyName=?, companyContact=?, companyContinent=?, companyCountry=?, companyState=?, companyDescription=? WHERE companyID=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            
            stmt.setString(1, companyEmail);
            stmt.setString(2, companyName);
            stmt.setInt(3, companyContact);
            stmt.setString(4, companyContinent);
            stmt.setString(5, companyCountry);
            stmt.setString(6, companyState);
            stmt.setString(7, companyDescription);
            stmt.setInt (8, companyID);
           

            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.WARNING, "Failed to update new Company information", ex);
        }
        return true;
    }

    // Add existing Company/bulk new Companies
    public static boolean addCompany(String companyEmail, String companyName, int companyContact, String companyContinent, String companyCountry, String companyState, String companyDescription, String companyPassword) {

        String sql = "INSERT INTO company (companyEmail, companyName, companyContact, companyContinent, companyCountry, companyState, companyDescription, companyPassword, companySalt) VALUES (?,?,?,?,?,?,?,AES_ENCRYPT(?,?),?)";
        
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, companyEmail);
            stmt.setString(2, companyName);
            stmt.setInt(3, companyContact);
            stmt.setString(4, companyContinent);
            stmt.setString(5, companyCountry);
            stmt.setString(6, companyState);
            stmt.setString(7, companyDescription);
            stmt.setString(8, companyPassword);
            //generate the salt
            SecureRandom test = new SecureRandom();
            int testresult = test.nextInt(1000000);
            String resultStr = testresult + "";
            if (resultStr.length() != 6) 
                for (int x = resultStr.length(); x < 6; x++) resultStr = "0" + resultStr;
            
            stmt.setString(9, resultStr);
            stmt.setString(10, resultStr);//generate the salt

            
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.WARNING, "Failed to add new Company information", ex);
        }
        return true;
    }
    
    // get all existing Companies
    public static ArrayList<Company> getAllCompanies() {
        ArrayList<Company> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT companyID, companyEmail, companyName, companyContact, companyContinent, companyCountry, companyState, companyDescription FROM company WHERE companyID<>0 ORDER BY companyName ASC");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new Company(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
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
    
    // get Company by ID
    public static Company getCompanyByID(int companyID) {
        Company company = null;
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select companyID, companyEmail, companyName, companyContact, companyContinent, companyCountry, companyState, companyDescription from company WHERE companyID=?");
            stmt.setInt(1, companyID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                company = new Company(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
            }
            rs.close();
            stmt.close();
            conn.close();
            return company;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //delete a particular Company row
    public static boolean deleteCompany(int companyID) {

        String sql1 = "DELETE FROM company WHERE companyID=?";

        try (
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setInt(1, companyID);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.WARNING, "Unable to delete company, companyID = '" + companyID, ex);
            return false;
        }
        return true;
    }
    
    public static Company getCompanyByLogin(String companyEmail, String companyPassword) {

        Company company = null;
        String sql = "SELECT companyID, companyEmail, companyName, companyContact, companyContinent, companyCountry, companyState, companyDescription FROM company WHERE companyEmail=? AND companyPassword=AES_ENCRYPT(?,companySalt)";

        try (Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, companyEmail);
            stmt.setString(2, companyPassword);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (company == null) {
                    company = new Company(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompanyDAO.class.getName()).log(Level.WARNING, "Unable to retrieve" + companyEmail + ".", ex);
        }

        return company;
    }
}
