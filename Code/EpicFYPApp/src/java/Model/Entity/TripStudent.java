/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

import java.sql.Date;

/* Database sequence
    
    #1: tripStudentID (int 11)
    #2: tripUserEmail (varchar 50)
    #3: tripID (int 11)
    #4: tripStudentStatus (varchar 100)
    #5: tripStudentTimestamp (Date)
 */

public class TripStudent {

    private int tripStudentID;
    private String tripUserEmail;
    private int tripID;
    private String tripStudentStatus;
    private String tripStudentTimestamp;

    public TripStudent(int tripStudentID, String tripUserEmail, int tripID, String tripStudentStatus, String tripStudentTimestamp) {
        this.tripStudentID = tripStudentID;
        this.tripUserEmail = tripUserEmail;
        this.tripID = tripID;
        this.tripStudentStatus = tripStudentStatus;
        this.tripStudentTimestamp = tripStudentTimestamp;
    }

    public int getTripID() {
        return tripID;
    }

    public void setTripID(int tripID) {
        this.tripID = tripID;
    }

    public String getTripUserEmail() {
        return tripUserEmail;
    }

    public void setTripUserEmail(String tripUserEmail) {
        this.tripUserEmail = tripUserEmail;
    }

    public String getTripStudentStatus() {
        return tripStudentStatus;
    }

    public void setTripStudentStatus(String tripStudentStatus) {
        this.tripStudentStatus = tripStudentStatus;
    }

    public int getTripStudentID() {
        return tripStudentID;
    }

    public void setTripStudentID(int tripStudentID) {
        this.tripStudentID = tripStudentID;
    }

    public String getTripStudentTimestamp() {
        return tripStudentTimestamp;
    }

    public void setTripStudentTimestamp(String tripStudentTimestamp) {
        this.tripStudentTimestamp = tripStudentTimestamp;
    }
    
}
