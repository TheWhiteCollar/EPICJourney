/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.InternshipDAO;
import Model.Dao.InternshipStudentDAO;
import Model.Entity.Company;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "addPartnerInternship", urlPatterns = {"/addPartnerInternship"})
public class addPartnerInternship extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
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
        String internshipName = request.getParameter("internshipName");
        String internshipFieldOfStudy = request.getParameter("internshipFieldOfStudy");
        String internshipDescription = request.getParameter("internshipDescription");
        Date internshipStart = Date.valueOf(request.getParameter("internshipStart"));
        Date internshipEnd = Date.valueOf(request.getParameter("internshipEnd"));
        Double internshipPay = Double.parseDouble(request.getParameter("internshipPay"));
        String internshipSupervisor = request.getParameter("internshipSupervisor");
        String internshipSupervisorEmail = request.getParameter("internshipSupervisorEmail");
        int internshipVacancy = Integer.parseInt(request.getParameter("internshipVacancy"));

        Company company = null;
        HttpSession sessionCom = request.getSession(true);
        company = (Company) sessionCom.getAttribute("Company");

        int internshipPartnerID = company.getCompanyID();

        java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String internshipDatetime = sdf.format(dt);
        String text = "fail";

        if (internshipEnd.after(internshipStart) && InternshipDAO.addInternship(internshipName, internshipFieldOfStudy, internshipDescription, internshipStart, internshipEnd, internshipPay, internshipSupervisor, internshipSupervisorEmail, internshipVacancy, internshipPartnerID, internshipDatetime)) {
            text = "success";

            // Retrieve all student email with interest related to this trip interest
            ArrayList<String> result = new ArrayList<>();
            result = InternshipStudentDAO.getInternshipsByUserFieldOfStudy(internshipFieldOfStudy);

            // Send email
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

            for (int i = 0; i < result.size(); i++) {
                try {
                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(ourEmail));
                    Address toAddress = new InternetAddress(result.get(i));
                    message.setRecipient(Message.RecipientType.TO, toAddress);
                    message.setSubject("EPIC PTE LTD - It's a match!!");
                    String final_Text = "Hello, <br><br>";
                    final_Text += "A new overseas internship has been added and it seems that it is a good fit for you! <br><br>";
                    final_Text += "Login to http://18.191.179.30/EpicFYPApp/index.jsp to take a look at the overseas study trips! <br><br>";
                    final_Text += "Wait no more, sign up for an overseas internship today!  <br><br>";
                    final_Text += "Hope to see you soon. <br><br>";
                    final_Text += "Regards, <br> EPIC <br>";
                    final_Text += "<p style='font-size:0.67em;'>This is an automatically generated message. Please do not reply to this address. To contact us, please email to <a href='mailto:isabelle@epicjourney.sg' target='top'>isabelle@epicjourney.sg</a> or contact 90059601. </p><br><br>";
                    message.setContent(final_Text, "text/html");
                    Transport.send(message);
                } catch (Exception e) {
                    System.out.println(e);
                }
            }

        }

        response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
        response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
        response.getWriter().write(text);       // Write response body.
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
