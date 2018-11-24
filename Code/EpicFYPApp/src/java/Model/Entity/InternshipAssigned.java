/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

/*
    #1: internshipAssignedID (int 11)
    #2: internshipID (int 11) 
    #3: internshipStudentID (int 11) 

 */
public class InternshipAssigned {
    private int internshipAssignedID;
    private int internshipID;
    private int internshipStudentID;

    public InternshipAssigned(int internshipAssignedID, int internshipID, int internshipStudentID) {
        this.internshipAssignedID = internshipAssignedID;
        this.internshipID = internshipID;
        this.internshipStudentID = internshipStudentID;
    }

    public int getInternshipAssignedID() {
        return internshipAssignedID;
    }

    public void setInternshipAssignedID(int internshipAssignedID) {
        this.internshipAssignedID = internshipAssignedID;
    }

    public int getInternshipID() {
        return internshipID;
    }

    public void setInternshipID(int internshipID) {
        this.internshipID = internshipID;
    }

    public int getInternshipStudentID() {
        return internshipStudentID;
    }

    public void setInternshipStudentID(int internshipStudentID) {
        this.internshipStudentID = internshipStudentID;
    } 
}
