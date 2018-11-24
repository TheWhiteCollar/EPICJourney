/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

/* Database sequence
    #1: fieldOfStudyName (varchar 200)
 */

public class FieldOfStudy {

    private String fieldOfStudyName;

    public FieldOfStudy(String fieldOfStudyName) {
        this.fieldOfStudyName = fieldOfStudyName;
    }

    public String getFieldOfStudyName() {
        return fieldOfStudyName;
    }

    public void setFieldOfStudyName(String fieldOfStudyName) {
        this.fieldOfStudyName = fieldOfStudyName;
    }

}
