/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/* Database sequence
    #1: paymentID (int 11)
    #2: paymentTripStudentID (int 11)
    #3: paymentMode (varchar 100)
    #4: paymentTransaction (varchar 100)
    #5: paymentAmount (double)
 */

public class PaymentDAO {
  
    // Add a new payment row
    public static boolean addPayment(int tripStudentID, String paymentMode, String paymentTransaction, double paymentAmount) {

        String sql = "INSERT INTO payment (tripStudentID, paymentMode, paymentTransaction, paymentAmount) VALUES (?,?,?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, tripStudentID);
            stmt.setString(2, paymentMode);
            stmt.setString(3, paymentTransaction);
            stmt.setDouble(4, paymentAmount);
            
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.WARNING, "Payment ID already exists", ex);
        }
        return true;
    }

    //delete a particular payment row
    public static boolean deletePayment(int paymentID) {

        String sql1 = "DELETE FROM payment WHERE paymentID=?";

        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setInt(1, paymentID);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.WARNING, "Unable to delete" + paymentID, ex);
            return false;
        }
        return true;
    }

    //get all payment names
    public static ArrayList<Payment> getAllPayments() {
        ArrayList<Payment> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select * from payment");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new Payment(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getDouble(5)));
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
    
    //get particular payment entry
    public static int getPaymentID(int tripStudentID, String paymentMode, String paymentTransaction, double paymentAmount) {

        int paymentID=0;
        String sql = "SELECT paymentID FROM payment WHERE tripStudentID=? AND paymentMode=? AND paymentTransaction=? AND paymentAmount=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, tripStudentID);
            stmt.setString(2, paymentMode);
            stmt.setString(3, paymentTransaction);
            stmt.setDouble(4, paymentAmount);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                
                paymentID = rs.getInt(1);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Unable to retrieve tripstudentID", ex);
        }

        return paymentID;
    }

}
