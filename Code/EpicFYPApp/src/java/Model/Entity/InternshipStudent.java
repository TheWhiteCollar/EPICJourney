/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

/* Database sequence
    #1: internshipStudentID (int 11)
    #2: internshipUserEmail (varchar 50)
    #3: internshipStudentContinent (varchar 15)
    #4: internshipStudentStatus (varchar 90)
    #5: internshipStudentDatetime (Date)
    #6: internshipStudentStatusAction (int 1) 0=rejected, 1=admin action, 2=user action, 3=internship confirmed, 4=cancelled
 */

public class InternshipStudent {

    private int internshipStudentID;
    private String internshipUserEmail;
    private String internshipStudentContinent;
    private String internshipStudentStatus;
    private String internshipStudentDatetime;
    private int internshipStudentStatusAction;

    public InternshipStudent(int internshipStudentID, String internshipUserEmail, String internshipStudentContinent, String internshipStudentStatus, String internshipStudentDatetime, int internshipStudentStatusAction) {
        this.internshipStudentID = internshipStudentID;
        this.internshipUserEmail = internshipUserEmail;
        this.internshipStudentContinent = internshipStudentContinent;
        this.internshipStudentStatus = internshipStudentStatus;
        this.internshipStudentDatetime = internshipStudentDatetime;
        this.internshipStudentStatusAction = internshipStudentStatusAction;
    }

    public int getInternshipStudentID() {
        return internshipStudentID;
    }

    public void setInternshipStudentID(int internshipStudentID) {
        this.internshipStudentID = internshipStudentID;
    }

    public String getInternshipUserEmail() {
        return internshipUserEmail;
    }

    public void setInternshipUserEmail(String internshipUserEmail) {
        this.internshipUserEmail = internshipUserEmail;
    }

    public String getInternshipStudentStatus() {
        return internshipStudentStatus;
    }

    public void setInternshipStudentStatus(String internshipStudentStatus) {
        this.internshipStudentStatus = internshipStudentStatus;
    }

    public String getInternshipStudentContinent() {
        return internshipStudentContinent;
    }

    public void setInternshipStudentContinent(String internshipStudentContinent) {
        this.internshipStudentContinent = internshipStudentContinent;
    }

    public String getInternshipStudentDatetime() {
        return internshipStudentDatetime;
    }

    public void setInternshipStudentDatetime(String internshipStudentDatetime) {
        this.internshipStudentDatetime = internshipStudentDatetime;
    }

    public int getInternshipStudentStatusAction() {
        return internshipStudentStatusAction;
    }

    public void setInternshipStudentStatusAction(int internshipStudentStatusAction) {
        this.internshipStudentStatusAction = internshipStudentStatusAction;
    }   
}
