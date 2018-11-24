/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.PaymentDAO;
import Model.Dao.TripStudentDAO;
import Model.Dao.TripsDAO;
import Model.Dao.UserDAO;
import Model.Entity.Trip;
import Model.Entity.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "addNewPaymentCheque", urlPatterns = {"/addNewPaymentCheque"})
public class addNewPaymentCheque extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String chequeNumber = request.getParameter("transactionNumber");
        String amount = request.getParameter("amount");
        double amountI = Double.parseDouble(amount);
        String userEmail = request.getParameter("userEmail");
        String tripIDS = request.getParameter("tripId");
        int tripID = Integer.parseInt(tripIDS);
        String type = request.getParameter("type");
        User user = UserDAO.getUser(userEmail);
        String username = user.getUserFirstName();

        //Email
        // our email details
        final String ourEmail = "smuis480@gmail.com";
        final String ourPassword = "wecandothistgt";

        // configuration for gmails
        Properties props = System.getProperties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.user", ourEmail);
        props.put("mail.smtp.password", ourPassword);
        props.put("mail.smtp.auth", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(ourEmail, ourPassword);
            }
        });

        if (!chequeNumber.equals("")) {
            //get current date
            java.util.Date dt = new java.util.Date();
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentTime = sdf.format(dt);

            Boolean inserted = false;
            int paymentID = 0;
            if (type.equals("deposit")) {
                //insert status="Deposit Made" into tripstudent table
                TripsDAO.insertStudent(userEmail, tripID, "Deposit Made", currentTime);
                int tripStudentID = TripStudentDAO.getTripStudentID(userEmail, tripID, "Deposit Made", currentTime);

                //insert payment into payment table
                inserted = PaymentDAO.addPayment(tripStudentID, "Cheque", chequeNumber, amountI);
                paymentID = PaymentDAO.getPaymentID(tripStudentID, "Cheque", chequeNumber, amountI);

                try {
                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(ourEmail));
                    Address toAddress = new InternetAddress(userEmail);
                    message.setRecipient(Message.RecipientType.TO, toAddress);
                    message.setSubject("EPIC PTE LTD - Deposit successfully received via cheque");
                    String final_Text = "Hi " + username + ",<br><br>";
                    final_Text += "Please note that your deposit payment is successful and your placement in the study trip has been confirmed. Full payment will only be collected after the trip has been activated.<br><br>";
                    final_Text += "Rest assured, we will send you an email/give you a call within 10 working days." + "<br><br>";
                    final_Text += "Stay tuned for updates! <br><br>";
                    final_Text += "Thank you. <br><br>";
                    final_Text += "Regards, <br> EPIC <br>";
                    final_Text += "<p style='font-size:0.67em;'>This is an automatically generated message. Please do not reply to this address. To contact us, please email to <a href='mailto:isabelle@epicjourney.sg' target='top'>isabelle@epicjourney.sg</a> or contact 90059601. </p><br><br>";
                    message.setContent(final_Text, "text/html");
                    Transport.send(message);
                } catch (Exception e) {
                    System.out.println(e);
                }

                //do the acitvation here - get the tripTotalSignup == tripActivation
                Trip trip = TripsDAO.getTrip(tripID);
                int tripTotalSignup = trip.getTripTotalSignup();
                int tripActivation = trip.getTripActivation();

                if (tripTotalSignup == tripActivation) {
                    TripStudentDAO.setActivationStatusByTripID(tripID);
                } else if (tripTotalSignup > tripActivation) {
                    ArrayList<String> signedUpEmails = trip.getSignedUpEmails();
                    TripStudentDAO.setActivationStatusByUserAndTripID(signedUpEmails.get(signedUpEmails.size() - 1), tripID);
                }

                // send email here 
            } else if (type.equals("remainder")) {
                //insert status="Remaining Amount Paid" into tripstudent table
                TripsDAO.insertStudent(userEmail, tripID, "Remaining Amount Paid", currentTime);
                int tripStudentID = TripStudentDAO.getTripStudentID(userEmail, tripID, "Remaining Amount Paid", currentTime);
                //insert payment into payment table
                inserted = PaymentDAO.addPayment(tripStudentID, "Cheque", chequeNumber, amountI);
                paymentID = PaymentDAO.getPaymentID(tripStudentID, "Cheque", chequeNumber, amountI);

                try {
                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(ourEmail));
                    Address toAddress = new InternetAddress(userEmail);
                    message.setRecipient(Message.RecipientType.TO, toAddress);
                    message.setSubject("EPIC PTE LTD - Trip Confirmation");
                    String final_Text = "Hi " + username + ",<br><br>";
                    final_Text += "Please note that your full payment is successful and your placement in the study trip has been confirmed. <br><br>";
                    final_Text += "Please <a href='http://18.191.179.30/EpicFYPApp/login.jsp'>login</a> to your account in the EPIC Portal to view the trip details and itinerary. <br><br>";
                    final_Text += "If you have any queries, please email to <a href='mailto:isabelle@epicjourney.sg' target='top'>isabelle@epicjourney.sg</a> or contact 90059601. <br><br>";
                    final_Text += "Thank you. <br><br>";
                    final_Text += "Regards, <br> EPIC <br>";
                    message.setContent(final_Text, "text/html");
                    Transport.send(message);
                } catch (Exception e) {
                    System.out.println(e);
                }

            }

            if (inserted == true) {
                response.sendRedirect("paymentMade.jsp?paymentId=" + paymentID);
                return;
            } else {
                response.sendRedirect("failureMessage.jsp");
                return;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
