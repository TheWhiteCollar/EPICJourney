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
import java.util.logging.Level;
import java.util.logging.Logger;

public class InternshipAssignedDAO {
    
    //insert internship assigned to student
    public static boolean addInternshipAssigned(int internshipID, int internshipStudentID) {

        String sql = "INSERT INTO internshipassigned (internshipID, internshipStudentID) VALUES (?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, internshipID);
            stmt.setInt(2, internshipStudentID);

            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(InternshipAssignedDAO.class.getName()).log(Level.WARNING, "Failed to add", ex);
        }

        return true;
    }
    
    public static int getInternshipIDbyInternshipStudentID(int internshipStudentID){
        int internshipID = 0;
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT internshipID FROM internshipassigned WHERE internshipStudentID=?");
            stmt.setInt(1, internshipStudentID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                internshipID = rs.getInt(1); 
            }
            rs.close();
            stmt.close();
            conn.close();
            return internshipID;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return internshipID;
    }
    

}
