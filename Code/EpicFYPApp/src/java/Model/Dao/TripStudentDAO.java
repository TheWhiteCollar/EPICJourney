/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.TripStudent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
    #1: tripStudentID (int 11)
    #2: tripUserEmail (varchar 50)
    #3: tripID (int 11)
    #4: tripStudentStatus (varchar 100)
    #5: tripStudentTimestamp (Datetime)
 */
public class TripStudentDAO {

    // Add existing tripStudent/bulk new tripStudent
    public static boolean addTripStudent(String tripUserEmail, int tripID, String tripStudentStatus, String tripStudentTimestamp) {

        String sql = "INSERT INTO tripstudent (tripUserEmail, tripID, tripStudentStatus, tripStudentTimestamp) VALUES (?,?,?,?)";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, tripUserEmail);
            stmt.setInt(2, tripID);
            stmt.setString(3, tripStudentStatus);
            stmt.setString(4, tripStudentTimestamp);

            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Failed to add new tripStudent information", ex);
        }
        return true;
    }

    // get all existing TripStudent
    public static ArrayList<TripStudent> getAllTripStudents() {
        ArrayList<TripStudent> result = new ArrayList<>();
        try {
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement("select * from tripstudent");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new TripStudent(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5)));
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

    //get particular tripstudent entry
    public static int getTripStudentID(String userEmail, int tripID, String tripStudentStatus, String timestamp) {

        int tripStudentID = 0;
        String sql = "SELECT tripStudentID FROM tripstudent WHERE tripUserEmail=? AND tripID=? AND tripStudentStatus=? AND tripStudentTimestamp=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            stmt.setInt(2, tripID);
            stmt.setString(3, tripStudentStatus);
            stmt.setString(4, timestamp);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                tripStudentID = rs.getInt(1);

            }
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Unable to retrieve tripstudentID", ex);
        }

        return tripStudentID;
    }

    public static ArrayList<TripStudent> getTripsByUser(String userEmail) {
        ArrayList<TripStudent> result = new ArrayList<>();
        String sql = "SELECT * FROM tripstudent WHERE tripUserEmail = ?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new TripStudent(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return null;

    }

    public static ArrayList<TripStudent> getConfirmedTripsByUser(String userEmail) {
        ArrayList<TripStudent> result = new ArrayList<>();
        String sql = "SELECT * FROM tripstudent WHERE tripUserEmail=? AND tripStudentStatus='Remaining Amount Paid' ";// change to trip applied?
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(new TripStudent(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return null;

    }

    //insert the status="Trip Activated" and status="Pending Remaining Amount" for all users who signed up
    public static void setActivationStatusByTripID(int tripID) {
        String sql = "SELECT tripUserEmail FROM tripstudent WHERE tripStudentStatus='Deposit Made' AND tripID=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, tripID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String userEmail = rs.getString(1);

                //get current date
                java.util.Date dt = new java.util.Date();
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String currentTime = sdf.format(dt);

                //date time add 2 seconds
                Calendar cal = Calendar.getInstance();
                cal.setTime(dt);
                cal.add(Calendar.SECOND, 2);
                java.util.Date date = cal.getTime();
                String currentTime2seconds = sdf.format(date);

                //insert status="Applied interest" into tripstudent table
                if (TripsDAO.insertStudent(userEmail, tripID, "Trip Activated", currentTime)) {
                    //insert status="Pending desposit" into tripstudent table
                    TripsDAO.insertStudent(userEmail, tripID, "Pending Remaining Amount", currentTime2seconds);
                }

            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot set trip activation for: " + tripID, ex);
        }
    }

    //insert the status="Trip Activated" and status="Pending Remaining Amount" for the most recent additional user
    public static void setActivationStatusByUserAndTripID(String tripUserEmail, int tripID) {
        String sql = "SELECT tripUserEmail FROM tripstudent WHERE tripStudentStatus='Deposit Made' AND tripID=? AND tripUserEmail=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setInt(1, tripID);
            stmt.setString(2, tripUserEmail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String userEmail = rs.getString(1);

                //get current date
                java.util.Date dt = new java.util.Date();
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                //date time add 3 seconds and 4 seconds respectively
                Calendar cal = Calendar.getInstance();
                cal.setTime(dt);
                cal.add(Calendar.SECOND, 3);
                java.util.Date date = cal.getTime();
                String currentTime3seconds = sdf.format(date);
                cal.add(Calendar.SECOND, 1);
                java.util.Date date2 = cal.getTime();
                String currentTime4seconds = sdf.format(date2);

                //insert status="Applied interest" into tripstudent table
                if (TripsDAO.insertStudent(userEmail, tripID, "Trip Activated", currentTime3seconds)) {
                    //insert status="Pending desposit" into tripstudent table
                    TripsDAO.insertStudent(userEmail, tripID, "Pending Remaining Amount", currentTime4seconds);
                }
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot set trip activation for: " + tripID, ex);
        }
    }

    //return the list of tripIDs signed up for by a particular user
    public static ArrayList<Integer> getTripIDsByUser(String userEmail) {
        ArrayList<Integer> result = new ArrayList<>();
        String sql = "SELECT tripID FROM tripstudent WHERE tripUserEmail=? AND tripStudentStatus='Applied interest'";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(rs.getInt(1));
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return result;

    }

    //return all the status of a particular tripID and userEmail
    public static ArrayList<String> getTripStatusByTripID(String userEmail, int tripID) {
        ArrayList<String> statusArrayList = new ArrayList<>();
        String sql = "SELECT tripStudentStatus,tripStudentTimestamp FROM tripstudent WHERE tripUserEmail=? AND tripID=? ORDER BY tripStudentTimestamp ASC";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            stmt.setInt(2, tripID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                statusArrayList.add(rs.getString(1));
                statusArrayList.add(rs.getString(2));
            }
            rs.close();
            stmt.close();
            conn.close();
            return statusArrayList;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return statusArrayList;
    }

    //status indication of amount to be paid: 1=full amount, 2=1/2 amount
    public static int getAmountIndicationUserAndTrip(String userEmail, int tripID) {
        int status = 0;
        String sql = "SELECT tripStudentStatus FROM tripstudent WHERE tripUserEmail=? AND tripID=? AND (tripStudentStatus='Pending Deposit' OR tripStudentStatus='Pending Remaining Amount')";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, userEmail);
            stmt.setInt(2, tripID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                status += 1;
            }
            rs.close();
            stmt.close();
            conn.close();

            return status;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userEmail: " + userEmail, ex);
        }
        return status;

    }

    //get the latest status of each unique user signup + tripID
    public static ArrayList<TripStudent> getLastStatusOfUserAndTripID() {
        ArrayList<TripStudent> statusArrayList = new ArrayList<>();

        String sql = "SELECT t.tripStudentID, t.tripUserEmail, t.tripID, t.tripStudentStatus, t.tripStudentTimestamp FROM tripstudent t INNER JOIN (SELECT tripUserEmail,tripID, max(tripStudentTimestamp) as MaxDate FROM tripstudent GROUP BY tripUserEmail,tripID) tm ON t.tripUserEmail=tm.tripUserEmail AND t.tripID=tm.tripID AND t.tripStudentTimestamp= tm.MaxDate";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                statusArrayList.add(new TripStudent(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5)));
            }
            rs.close();
            stmt.close();
            conn.close();
            return statusArrayList;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get list", ex);
        }
        return statusArrayList;
    }

    public static ArrayList<String> getTripsByUserInterest(String userInterest) {
        ArrayList<String> result = new ArrayList<>();
        String sql = "SELECT * FROM user";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (rs.getString(8).contains(userInterest)) {
                    result.add(rs.getString(1));
                }
            }
            rs.close();
            stmt.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(TripStudentDAO.class.getName()).log(Level.WARNING, "Cannot get user with userInterest: ", ex);
        }
        return null;

    }

}
