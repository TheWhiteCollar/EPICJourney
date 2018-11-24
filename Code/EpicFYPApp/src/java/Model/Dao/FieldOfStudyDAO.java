/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;
import Controller.ConnectionManager;
import Model.Entity.Internship;
import Model.Entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FieldOfStudyDAO {
    //get all field of studies available
    public static ArrayList<String> getFieldOfStudies() {

        ArrayList<String> fieldOfStudies = new ArrayList<>();
        String sql = "SELECT * FROM fieldofstudy";

        try (Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                fieldOfStudies.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FieldOfStudyDAO.class.getName()).log(Level.WARNING, "Unable to retrieve Field of Study", ex);
        }

        return fieldOfStudies;
    }
    
    //add a new Field Of Study
    public static boolean addFieldOfStudy(String fieldOfStudyName) {

        String sql = "INSERT INTO fieldofstudy (fieldOfStudyName) VALUES (?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, fieldOfStudyName);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FieldOfStudyDAO.class.getName()).log(Level.WARNING, "Field of Study already exist!", ex);
        }
        return true;
    }

    //deletes field of study from fieldofstudy table, updates user and internship table to remove ",a" or ", a" or "a," or "a ,"
    public static boolean deleteFieldOfStudy(String fieldOfStudyName) {
        String sql = "DELETE FROM fieldofstudy WHERE fieldOfStudyName=?";

        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, fieldOfStudyName);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FieldOfStudyDAO.class.getName()).log(Level.WARNING, "Unable to delete Field of Study, fieldOfStudyName = '" + fieldOfStudyName, ex);
            return false;
        }
        
        
        return true;
    }

    //update existing field of study
    public static boolean updateFieldOfStudy(String newFieldOfStudyName, String currentFieldOfStudyName) {

        //update field of study table
        String sql = "UPDATE fieldofstudy SET fieldOfStudyName=? WHERE fieldOfStudyName=?";

        try (Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setString(1, newFieldOfStudyName);
            stmt.setString(2, currentFieldOfStudyName);

            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FieldOfStudyDAO.class.getName()).log(Level.WARNING, "Failed to update new Field of Study information", ex);
        }

        //update field of study in user table   
        ArrayList<User> allUsers = UserDAO.getAllUsers();
        for (int i = 0; i < allUsers.size(); i++) {
            User u = allUsers.get(i);
            String userEmail = u.getUserEmail();
            String userFieldOfStudy = u.getUserFieldOfStudy();
            if (userFieldOfStudy.toLowerCase().contains(currentFieldOfStudyName.toLowerCase())) {
                //replace
                userFieldOfStudy = userFieldOfStudy.replace(currentFieldOfStudyName, newFieldOfStudyName);

                String sql1 = "UPDATE user SET userFieldOfStudy=? WHERE userEmail=?";

                try (Connection conn = ConnectionManager.getConnection();
                    PreparedStatement stmt = conn.prepareStatement(sql1);) {
                    stmt.setString(1, userFieldOfStudy);
                    stmt.setString(2, userEmail);

                    int result = stmt.executeUpdate();
                    if (result == 0) {
                        return false;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FieldOfStudyDAO.class.getName()).log(Level.WARNING, "Failed to update new Field of Study information in user : " + userEmail, ex);
                } 
            }
        }
            
        //update field of study in internship table
        ArrayList<Internship> allInternships = InternshipDAO.getAllInternships();
        for (int i = 0; i < allInternships.size(); i++) {
            Internship in = allInternships.get(i);
            int internshipID = in.getInternshipID();
            String internshipFieldOfStudies = in.getInternshipFieldOfStudy();
            if (internshipFieldOfStudies.toLowerCase().contains(currentFieldOfStudyName.toLowerCase())) {
                //replace
                internshipFieldOfStudies = internshipFieldOfStudies.replace(currentFieldOfStudyName, newFieldOfStudyName);

                String sql1 = "UPDATE internship SET internshipFieldOfStudy=? WHERE internshipID=?";

                try (Connection conn = ConnectionManager.getConnection();
                        PreparedStatement stmt = conn.prepareStatement(sql1);) {
                    stmt.setString(1, internshipFieldOfStudies);
                    stmt.setInt(2, internshipID);

                    int result = stmt.executeUpdate();
                    if (result == 0) {
                        return false;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(FieldOfStudyDAO.class.getName()).log(Level.WARNING, "Failed to update new Field of Study information", ex);
                } 
            }
        }
        
      return true;
    }
}
