/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.CompanyDAO;
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
@WebServlet(name = "signuppartnerServlet", urlPatterns = {"/signuppartnerServlet"})
public class signuppartnerServlet extends HttpServlet {

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
        String companyEmail = request.getParameter("companyEmail");
        String companyName = request.getParameter("companyName");
        String contact = request.getParameter("companyContact");
        int companyContact = Integer.parseInt(contact);
        String companyContinent = request.getParameter("companyContinent");
        String companyCountry = request.getParameter("companyCountry");
        String companyState = request.getParameter("companyState");
        String companyDescription = request.getParameter("companyDescription");
        String companyPassword = request.getParameter("companyPassword");

        // validate fields are not empty and insert into database - should do it in frontend?
        //should add in companyTermsAndConditions?
        if (!companyEmail.equals("") && !companyName.equals("") && !companyPassword.equals("")) {

            // Insert into database
            //set companyLogo as null (cause unsolved),set companyID as 1 as incremeted automatically, set companyTermsAndConditions as 1 cause unsure about the checkbox
            Boolean inserted = CompanyDAO.addCompany(companyEmail, companyName, companyContact, companyContinent, companyCountry, companyState, companyDescription, companyPassword);

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
                    Address toAddress = new InternetAddress(companyEmail);
                    message.setRecipient(Message.RecipientType.TO, toAddress);
                    MimeBodyPart textPart = new MimeBodyPart();
                    Multipart multipart = new MimeMultipart();
                    String final_Text = "Hello partner, please verify your account: http://18.191.179.30/EpicFYPApp/accountConfirmationServlet?companyEmail=" + companyEmail;
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
                response.sendRedirect("signuppagepartner.jsp");
                return;
            }
        }

        request.setAttribute("ErrorMsg", "Missing fields");
        request.getRequestDispatcher("signuppagepartner.jsp").forward(request, response);

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
