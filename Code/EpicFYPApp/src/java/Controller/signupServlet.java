/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "signupServlet", urlPatterns = {"/signupServlet"})
public class signupServlet extends HttpServlet {

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

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        // retrieve user input
        String userEmail = request.getParameter("email");
        String userFirstName = request.getParameter("firstName");
        String userLastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        int userPhone = Integer.parseInt(phone);
        String userGender = request.getParameter("gender");
        String userCitizenship = request.getParameter("citizenship");
        if (userCitizenship.equals("Others")) {
            userCitizenship = request.getParameter("others_citizenship");
        }
        String yob = request.getParameter("yob");
        int yearOfBirth = Integer.parseInt(yob);

        String[] userInterestString = request.getParameterValues("interest");
        String userInterest = "";
        for (int i = 0; i < userInterestString.length; i++) {
            userInterest += "" + userInterestString[i];
            if (i != userInterestString.length - 1) {
                userInterest += ", ";
            }
        }
        String userPassword = request.getParameter("password");
        String userOccupation = request.getParameter("occupation");

        String userIsEmailConfirm = "pending"; // by right should be boolean
        String userHighestEducation = request.getParameter("highest_qualification");

        String[] fos = request.getParameterValues("fos");
        String userFieldOfStudy = "";
        for (int i = 0; i < fos.length; i++) {
            userFieldOfStudy += "" + fos[i];
            if (i != fos.length - 1) {
                userFieldOfStudy += ", ";
            }
        }

        String userDescription = request.getParameter("message");
        String userSchool = request.getParameter("school");

        // validate fields are not empty and insert into database - should do it in frontend?
        if (!userFirstName.equals("") && !userLastName.equals("") && !userEmail.equals("") && !userPassword.equals("") && !userOccupation.equals("")) {

            // Insert into database
            Boolean inserted = UserDAO.addUser(userEmail, userFirstName, userLastName, userPhone, userGender, userCitizenship, yearOfBirth, userInterest, userPassword, userOccupation, null, userIsEmailConfirm, userHighestEducation, userFieldOfStudy, userDescription, userSchool);

            if (inserted == true) {

                // send email
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

                try {
                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(ourEmail));
                    Address toAddress = new InternetAddress(userEmail);
                    message.setRecipient(Message.RecipientType.TO, toAddress);
                    MimeBodyPart textPart = new MimeBodyPart();
                    Multipart multipart = new MimeMultipart();
                    String final_Text = "Hello, please verify your account: http://18.191.179.30/EpicFYPApp/accountConfirmationServlet?userEmail=" + userEmail;
                    textPart.setText(final_Text);
                    multipart.addBodyPart(textPart);
                    message.setContent(multipart);
                    message.setSubject("Verify your account");
                    Transport.send(message);
                    // After reset email is successfully change
                    request.setAttribute("successMessage", "You have signed up successfully. An email have been sent to you for verification.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                } catch (Exception e) {
                    out.println(e);
                }
            } else {
                response.sendRedirect("signuppage.jsp");
                return;
            }
        }

        request.setAttribute("ErrorMsg", "Missing fields");
        request.getRequestDispatcher("signuppage.jsp").forward(request, response);

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
