/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.InternshipStudent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InternshipStudentDAO {
    
    // Add a new internship student
    public static boolean addInternshipStudent(String internshipUserEmail, String internshipStudentContinent, String internshipStudentStatus, String internshipStudentDatetime, int internshipStudentStatusAction) {

        String sql = "INSERT INTO internshipstudent (internshipUserEmail, internshipStudentContinent, internshipStudentStatus, internshipStudentDatetime, internshipStudentStatusAction) VALUES (?,?,?,?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, internshipUserEmail);           
            stmt.setString(2, internshipStudentContinent);
            stmt.setString(3, internshipStudentStatus);
            stmt.setString(4, internshipStudentDatetime);
            stmt.setInt(5, internshipStudentStatusAction);

            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(InternshipStudentDAO.class.getName()).log(Level.WARNING, "Failed to add new internshipStudent information", ex);
        }

        return true;
    }
    
    //get List of rejected internshipstudent, action=0
    public static ArrayList<InternshipStudent> getAllRejectedInternshipStudents() {
        ArrayList<InternshipStudent> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT i.internshipStudentID, i.internshipUserEmail, i.internshipStudentContinent, i.internshipStudentStatus, i.internshipStudentDatetime , i.internshipStudentStatusAction \n" +
"FROM internshipstudent i \n" +
"INNER JOIN (\n" +
"	SELECT internshipStudentID, internshipUserEmail,internshipStudentContinent, max(internshipStudentDatetime) as MaxDate \n" +
"	FROM internshipstudent \n" +
"	GROUP BY internshipUserEmail,internshipStudentContinent) tm \n" +
"	ON i.internshipUserEmail=tm.internshipUserEmail AND i.internshipStudentContinent=tm.internshipStudentContinent AND i.internshipStudentDatetime = tm.MaxDate  \n" +
"	WHERE i.internshipStudentStatusAction=0";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new InternshipStudent(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    //get List of confirmed internshipstudent action=3
    public static ArrayList<InternshipStudent> getAllConfirmedInternshipStudents() {
        ArrayList<InternshipStudent> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT i.internshipStudentID, i.internshipUserEmail, i.internshipStudentContinent, i.internshipStudentStatus, i.internshipStudentDatetime , i.internshipStudentStatusAction \n" +
"FROM internshipstudent i \n" +
"INNER JOIN (\n" +
"	SELECT internshipStudentID, internshipUserEmail,internshipStudentContinent, max(internshipStudentDatetime) as MaxDate \n" +
"	FROM internshipstudent \n" +
"	GROUP BY internshipUserEmail,internshipStudentContinent) tm \n" +
"	ON i.internshipUserEmail=tm.internshipUserEmail AND i.internshipStudentContinent=tm.internshipStudentContinent AND i.internshipStudentDatetime = tm.MaxDate  \n" +
"	WHERE i.internshipStudentStatusAction=3";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new InternshipStudent(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    //get List of pending admin action internshipstudent action=1
    public static ArrayList<InternshipStudent> getAllPendingAdminInternshipStudents() {
        ArrayList<InternshipStudent> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT i.internshipStudentID, i.internshipUserEmail, i.internshipStudentContinent, i.internshipStudentStatus, i.internshipStudentDatetime , i.internshipStudentStatusAction \n" +
"FROM internshipstudent i \n" +
"INNER JOIN (\n" +
"	SELECT internshipStudentID, internshipUserEmail,internshipStudentContinent, max(internshipStudentDatetime) as MaxDate \n" +
"	FROM internshipstudent \n" +
"	GROUP BY internshipUserEmail,internshipStudentContinent) tm \n" +
"	ON i.internshipUserEmail=tm.internshipUserEmail AND i.internshipStudentContinent=tm.internshipStudentContinent AND i.internshipStudentDatetime = tm.MaxDate  \n" +
"	WHERE i.internshipStudentStatusAction=1";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new InternshipStudent(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    //get List of pending user action internshipstudent action=2
    public static ArrayList<InternshipStudent> getAllPendingUserInternshipStudents() {
        ArrayList<InternshipStudent> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
                        String sql = "SELECT i.internshipStudentID, i.internshipUserEmail, i.internshipStudentContinent, i.internshipStudentStatus, i.internshipStudentDatetime , i.internshipStudentStatusAction \n" +
"FROM internshipstudent i \n" +
"INNER JOIN (\n" +
"	SELECT internshipStudentID, internshipUserEmail,internshipStudentContinent, max(internshipStudentDatetime) as MaxDate \n" +
"	FROM internshipstudent \n" +
"	GROUP BY internshipUserEmail,internshipStudentContinent) tm \n" +
"	ON i.internshipUserEmail=tm.internshipUserEmail AND i.internshipStudentContinent=tm.internshipStudentContinent AND i.internshipStudentDatetime = tm.MaxDate  \n" +
"	WHERE i.internshipStudentStatusAction=2";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new InternshipStudent(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    //get List of cancelled internshipstudent action=4
    public static ArrayList<InternshipStudent> getAllCancelledInternshipStudents() {
        ArrayList<InternshipStudent> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            String sql = "SELECT i.internshipStudentID, i.internshipUserEmail, i.internshipStudentContinent, i.internshipStudentStatus, i.internshipStudentDatetime , i.internshipStudentStatusAction \n" +
"FROM internshipstudent i \n" +
"INNER JOIN (\n" +
"	SELECT internshipStudentID, internshipUserEmail,internshipStudentContinent, max(internshipStudentDatetime) as MaxDate \n" +
"	FROM internshipstudent \n" +
"	GROUP BY internshipUserEmail,internshipStudentContinent) tm \n" +
"	ON i.internshipUserEmail=tm.internshipUserEmail AND i.internshipStudentContinent=tm.internshipStudentContinent AND i.internshipStudentDatetime = tm.MaxDate  \n" +
"	WHERE i.internshipStudentStatusAction=4";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new InternshipStudent(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    //count number of continent of a particular user (used to check if user alr signed up to a continent)
    public static int countInternshipStudentByCont(String internshipUserEmail, String continent, int currentYear) {

        int count = 0;
        String sql = "SELECT COUNT(internshipUserEmail) FROM internshipstudent WHERE internshipUserEmail=? AND internshipStudentContinent=? AND internshipStudentStatus='User submitted application - Admin to review application' AND YEAR(internshipStudentDatetime)=?";
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, internshipUserEmail);
            stmt.setString(2, continent);
            stmt.setInt(3, currentYear);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            stmt.close();
            conn.close();
            return count;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    //get the list of continents signed up by a user
    public static ArrayList<String> getContinentsByUser(String userEmail){
        ArrayList<String> result = new ArrayList<>();
        String sql = "SELECT internshipStudentContinent FROM internshipstudent WHERE internshipUserEmail=? AND internshipStudentStatus='User submitted application - Admin to review application'";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(rs.getString(1));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(InternshipStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return result;
    }
    
    //get all status of a particular continent and user
    public static ArrayList<String> getInternshipStatusByContinent(String userEmail, String continent){
        ArrayList<String> statusArrayList = new ArrayList<>();
        String sql = "SELECT internshipStudentStatus, internshipStudentDatetime, internshipStudentStatusAction FROM internshipstudent WHERE internshipUserEmail=? AND internshipStudentContinent=? ORDER BY internshipStudentDatetime ASC";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            stmt.setString(2, continent);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                statusArrayList.add(rs.getString(1));
                statusArrayList.add(rs.getString(2));
                statusArrayList.add(Integer.toString(rs.getInt(3)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return statusArrayList;
        } catch (SQLException ex) {
            Logger.getLogger(InternshipStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return statusArrayList;
    } 
    
    public static int getInternshipStudentIDforAcceptedTrips(String userEmail, String continent){
        int internshipStudentID = 0;
        
        String sql = "SELECT i.internshipStudentID, i.internshipUserEmail, i.internshipStudentContinent, i.internshipStudentDatetime , i.internshipStudentStatusAction \n" +
                    "FROM internshipstudent i \n" +
                    "INNER JOIN (\n" +
"	SELECT internshipUserEmail,internshipStudentContinent, max(internshipStudentDatetime) AS MaxDate \n" +
"	FROM internshipstudent \n" +
"	GROUP BY internshipUserEmail,internshipStudentContinent) \n" +
"	tm ON i.internshipUserEmail=tm.internshipUserEmail AND i.internshipStudentContinent=tm.internshipStudentContinent 	AND i.internshipStudentDatetime = tm.MaxDate\n" +
"	WHERE i.internshipUserEmail=? AND i.internshipStudentContinent=? AND i.internshipStudentStatusAction=3";
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            stmt.setString(2, continent);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if(rs.getInt(5)==3){
                    internshipStudentID = rs.getInt(1);
                }
            }
            rs.close();
            stmt.close();
            conn.close();
            return internshipStudentID;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internshipStudentID;
    }
    
    public static ArrayList<String> getInternshipsByUserFieldOfStudy(String userFieldOfStudy) {
        ArrayList<String> result = new ArrayList<>();
        String sql = "SELECT * FROM user";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (rs.getString(15).contains(userFieldOfStudy)) {
                    result.add(rs.getString(1));
                }
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(InternshipStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userFieldOfStudy ", ex);
        }
        return null;

    }
    
    public static int getInternshipStudentIDfromUserContinetStatus(String userEmail, String continent){
        
        int internshipStudentID = 0;
        
        String sql = "SELECT * FROM internshipstudent WHERE internshipUserEmail=? AND internshipStudentContinent=? AND internshipStudentStatus='Internship offered - Pending user internship acceptance'";
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userEmail);
            stmt.setString(2, continent);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                internshipStudentID = rs.getInt(1);
               
            }
            rs.close();
            stmt.close();
            conn.close();
            return internshipStudentID;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internshipStudentID;
    }
    
    
    
}
