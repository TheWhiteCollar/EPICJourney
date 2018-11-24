/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.Entity;

/* Database sequence
    #1: paymentID (int 11)
    #2: paymentTripStudentID (int 11)
    #3: paymentMode (varchar 100)
    #4: paymentTransaction (varchar 100)
    #5: paymentAmount (double)
 */

public class Payment {

   private int paymentID;
   private int paymentTripStudentID;
   private String paymentMode;
   private String paymentTransaction;
   private double paymentAmount;

    public Payment(int paymentID, int paymentTripStudentID, String paymentMode, String paymentTransaction, double paymentAmount) {
        this.paymentID = paymentID;
        this.paymentTripStudentID = paymentTripStudentID;
        this.paymentMode = paymentMode;
        this.paymentTransaction = paymentTransaction;
        this.paymentAmount = paymentAmount;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getPaymentTripStudentID() {
        return paymentTripStudentID;
    }

    public void setPaymentTripStudentID(int paymentTripStudentID) {
        this.paymentTripStudentID = paymentTripStudentID;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getPaymentTransaction() {
        return paymentTransaction;
    }

    public void setPaymentTransaction(String paymentTransaction) {
        this.paymentTransaction = paymentTransaction;
    }

    public double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

}
