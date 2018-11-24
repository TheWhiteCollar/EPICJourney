/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Dao;

import Controller.ConnectionManager;
import Model.Entity.Trip;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Part;

/* Database sequence: TripStudent
    #1: tripStudentID (int 11)
    #2: tripUserEmail (varchar 50)
    #3: triID (int 11)
    #4: tripStudentStatus (varchar 100)
    #5: tripStudentTimestamp (Date)
 */
public class TripsDAO {

    public static boolean insertStudent(String tripUserEmail, int tripID, String tripStudentStatus, String tripStudentTimestamp) {

        String sql = "INSERT INTO `tripstudent` (tripUserEmail, tripID, tripStudentStatus, tripStudentTimestamp) VALUES (?, ?, ?, ?)";

        try (
            Connection conn = ConnectionManager.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);) {
            stmt.setString(1, tripUserEmail);
            stmt.setInt(2, tripID);
            stmt.setString(3, tripStudentStatus);
            stmt.setString(4, tripStudentTimestamp);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Unable to insert trip, tripID = '" + tripID + "' studentEmail = '" + tripUserEmail + "'.", ex);
            return false;
        }

        return true;
    }
    

    public static ArrayList<Trip> getTrips() {
        ArrayList<Trip> allTrips = new ArrayList<>();
        String sql1 = "SELECT * FROM tripstudent";
        HashMap<Integer, String> tripstudent = new HashMap<>();
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String tripUserEmail = rs.getString(2);
                int tripID = rs.getInt(3);
                if (!tripstudent.containsKey(tripID)) {
                    tripstudent.put(tripID, tripUserEmail);
                } else {
                    String result = tripstudent.get(tripID);
                    result += "," + tripUserEmail;
                    tripstudent.put(tripID, result);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get tripstudent from db", ex);
        }

        String sql2 = "SELECT * FROM trip";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql2);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int tripID = rs.getInt(1);
                String tripUserEmail = "";
                if (tripstudent.containsKey(tripID)) {
                    tripUserEmail = tripstudent.get(tripID);
                }

                ArrayList<String> emails = convertEmailString(tripUserEmail);
                Trip trip = new Trip(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getBlob(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getDate(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getString(13),emails);
                allTrips.add(trip);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get all trips from database", ex);
        }
        return allTrips;
    }

    public static ArrayList<Trip> getFilteredTrips(String minDate, String maxDate, double minPrice, double maxPrice, String tripTitle, String tripCountry) {
        ArrayList<Trip> allTrips = new ArrayList<>();
        String sql1 = "SELECT * FROM tripstudent";
        HashMap<Integer, String> tripstudent = new HashMap<>();
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String tripUserEmail = rs.getString(2);
                int tripID = rs.getInt(3);
                if (!tripstudent.containsKey(tripID)) {
                    tripstudent.put(tripID, tripUserEmail);
                } else {
                    String result = tripstudent.get(tripID);
                    result += "," + tripUserEmail;
                    tripstudent.put(tripID, result);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get tripstudent from db", ex);
        }

        String sql2 = "SELECT * FROM trip WHERE tripPrice <= 2000";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql2);) {;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int tripID = rs.getInt(1);
                String tripUserEmail = "";
                if (tripstudent.containsKey(tripID)) {
                    tripUserEmail = tripstudent.get(tripID);
                }

                ArrayList<String> emails = convertEmailString(tripUserEmail);
                Trip trip = new Trip(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getBlob(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getDate(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getString(14),emails);
                allTrips.add(trip);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get all trips from database", ex);
        }

        return allTrips;
    }

    public static Trip getTrip(int tripID) {
        Trip trip = null;
        String sql1 = "SELECT tripUserEmail FROM tripstudent WHERE tripID=? AND tripStudentStatus='Applied interest'";
        ArrayList<String> emailList = new ArrayList<>();
        
        //String emailString = "";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setInt(1, tripID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                emailList.add(rs.getString(1));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get trip with tripID: " + tripID, ex);
        }

        String sql2 = "SELECT * FROM trip WHERE tripID=?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql2);) {
            stmt.setInt(1, tripID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                trip = new Trip(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getBlob(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getDate(8), rs.getDate(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getString(13), emailList);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get trip with tripID: " + tripID, ex);
        }
        return trip;
    }

    public static boolean deleteTrip(int tripID) {
        //delete the students
        String sql1 = "DELETE FROM tripstudent WHERE tripID=?";

        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setInt(1, tripID);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Unable to delete trip, tripID = '" + tripID, ex);
            return false;
        }

        //delete the trip
        String sql2 = "DELETE FROM trip WHERE tripID=?";

        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql2);) {
            stmt.setInt(1, tripID);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Unable to delete trip, tripID = '" + tripID, ex);
            return false;
        }
        return true;
    }

    public static boolean insertTrip(String tripTitle, double tripPrice, Part tripItinerary, String tripDescription, String tripCountry, String tripState, Date tripStart, Date tripEnd, int tripDuration, int tripActivation, String tripInterest, String tripPicture) {
        //get max tripID
        String sql1 = "SELECT CONVERT(MAX(CONVERT(tripID,UNSIGNED INTEGER)),CHAR(200)) FROM trip ";

        int maxTripID = 0;
        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            ResultSet rs = stmt.executeQuery();
            rs.next();
            maxTripID = rs.getInt(1);
            System.out.println("maxTrip " + maxTripID);

        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Unable to insert trip", ex);
            return false;
        }
        //insert the trip
        String sql2 = "INSERT INTO `trip` (`tripID`, `tripTitle`, `tripPrice`, `tripItinerary`, `tripDescription`,`tripCountry`, `tripState`, `tripStart`, `tripEnd`, `tripDuration`,`tripActivation`, `tripInterest`,`tripPicture`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        maxTripID++;
        try (
                Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql2);) {
            stmt.setInt(1, maxTripID);
            stmt.setString(2, tripTitle);
            stmt.setDouble(3, tripPrice);
            stmt.setString(5, tripDescription);
            stmt.setString(6, tripCountry);
            stmt.setString(7, tripState);
            stmt.setDate(8, tripStart);
            stmt.setDate(9, tripEnd);
            stmt.setInt(10, tripDuration);
            stmt.setInt(11, tripActivation);
            stmt.setString(12, tripInterest);
            stmt.setString(13, tripPicture);
            
            //trip itinerary
            InputStream tripInputStream = null;
            if (tripItinerary != null){
                System.out.println(tripItinerary.getName());
                System.out.println(tripItinerary.getSize());
                System.out.println(tripItinerary.getContentType());

                try{
                    tripInputStream = tripItinerary.getInputStream();
                }catch(IOException e){
                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to upload resume into database", e);
                }
            }
            
            if(tripInputStream!= null){
                stmt.setBinaryStream(4, tripInputStream, (int) tripItinerary.getSize());
            }else{
                stmt.setNull(4, java.sql.Types.BLOB);
            }
            
//            //trip picture
//            InputStream tripPic = null;
//            if (tripPicture != null){
//                System.out.println(tripPicture.getName());
//                System.out.println(tripPicture.getSize());
//                System.out.println(tripPicture.getContentType());
//
//                try{
//                    tripPic = tripPicture.getInputStream();
//                }catch(IOException e){
//                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to upload picture into database", e);
//                }
//            }
//            
//            if(tripPic!= null){
//                stmt.setBinaryStream(14, tripPic, (int) tripPicture.getSize());
//            }else{
//                stmt.setNull(14, java.sql.Types.BLOB);
//            }
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Unable to insert trip", ex);
            return false;
        }
        return true;
    }

    public static ArrayList<String> convertEmailString(String emails) {
        if (emails.length() == 0) {
            return new ArrayList<>();
        }
        ArrayList<String> emailsAL = new ArrayList<>(Arrays.asList(emails.split(",")));
        System.out.println(emailsAL.size());
        System.out.println(emailsAL.get(0));
        return emailsAL;
    }

    
    // Add existing trips/bulk new trips
    //public static boolean addTrip(String tripTitle, double tripPrice, String tripItinerary, String tripDescription, String tripCountry, String tripState, Date tripStart, Date tripEnd, int tripDuration, int tripActivation, String tripInterest, int tripTotalSignUp) {
    public static boolean addTrip(String tripTitle, double tripPrice, Part tripItinerary, String tripDescription, String tripCountry, String tripState, int tripDuration, int tripActivation, String tripInterest, int tripTotalSignUp, Part tripPicture) {

        String sql = "INSERT INTO trip (tripTitle, tripPrice, tripItinerary, tripDescription, tripCountry, tripState, tripStart, tripEnd, tripDuration, tripActivation, tripInterest, tripTotalSignUp,tripItinerary) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try (Connection conn = ConnectionManager.getConnection()) {
            ;
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, tripTitle);
            stmt.setDouble(2, tripPrice);
            stmt.setString(4, tripDescription);
            stmt.setString(5, tripCountry);
            stmt.setString(6, tripState);
            stmt.setDate(7, Date.valueOf("2018-08-26"));
            stmt.setDate(8, Date.valueOf("2018-08-26")); //set this to value being passed in
            stmt.setInt(9, tripDuration);
            stmt.setInt(10, tripActivation);
            stmt.setString(11, tripInterest);
            stmt.setInt(12, tripTotalSignUp);
            
            //trip itinerary
            InputStream tripInputStream = null;
            if (tripItinerary != null){
                System.out.println(tripItinerary.getName());
                System.out.println(tripItinerary.getSize());
                System.out.println(tripItinerary.getContentType());

                try{
                    tripInputStream = tripItinerary.getInputStream();
                }catch(IOException e){
                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to upload resume into database", e);
                }
            }
            
            if(tripInputStream!= null){
                stmt.setBinaryStream(3, tripInputStream, (int) tripItinerary.getSize());
            }else{
                stmt.setNull(3, java.sql.Types.BLOB);
            }
            
//            //trip picture
//            InputStream tripPic = null;
//            if (tripPicture != null){
//                System.out.println(tripPicture.getName());
//                System.out.println(tripPicture.getSize());
//                System.out.println(tripPicture.getContentType());
//
//                try{
//                    tripPic = tripPicture.getInputStream();
//                }catch(IOException e){
//                    Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Failed to upload picture into database", e);
//                }
//            }
//            
//            if(tripPic!= null){
//                stmt.setBinaryStream(13, tripPic, (int) tripPicture.getSize());
//            }else{
//                stmt.setNull(13, java.sql.Types.BLOB);
//            }
            
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Trip is already registered!", ex);
        }
        return true;
    }

    // Add existing trips that students went/bulk new trips that students is going
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
            Logger.getLogger(UserDAO.class.getName()).log(Level.WARNING, "Student who is going for this trip is already registered!", ex);
        }
        return true;
    }

    public static int getTripbyUser(String useremail) {
        int count = 0;
        String sql1 = "SELECT * FROM tripstudent WHERE tripUserEmail=?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setString(1, useremail);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get trip with useremail: " + useremail, ex);
        }

        return count;
    }
    
    //add 1 to the trip total sign up count
    public static boolean incrementTripTotalSignup(int tripID) {

        String sql = "UPDATE trip SET tripTotalSignUp=tripTotalSignUp+1 WHERE tripID=?";

        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setInt(1, tripID);
            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Failed to update trip: " + tripID + ".", ex);
        }
        return true;
    }
    
    //get corresponding trip name based off trip ID
    public static String getTripTitleFromTripID(int tripID){
        String title = "";
        String sql1 = "SELECT tripTitle FROM trip WHERE tripID=?";
        try (Connection conn = ConnectionManager.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql1);) {
            stmt.setInt(1, tripID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                title += rs.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TripsDAO.class.getName()).log(Level.WARNING, "Cannot get trip: " + tripID, ex);
        }

        return title;
    }

}
