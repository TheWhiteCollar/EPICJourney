/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.AdminDAO;
import Model.Dao.CompanyDAO;
import Model.Dao.UserDAO;
import Model.Entity.Admin;
import Model.Entity.Company;
import Model.Entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "LoginServlet_user", urlPatterns = {"/LoginServlet_user"})
public class LoginServlet_user extends HttpServlet {

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

        // retrieve userid and password
        String userid = request.getParameter("userid");
        String userpassword = request.getParameter("userpassword");

         String comefrom = request.getParameter("comefrom");
         String cont = request.getParameter("cont");
        // Create session
        HttpSession session = request.getSession(true);

        // send user back to login.jsp if they try to access servlet directly
        if (!userid.equals("") || !userpassword.equals("")) {

            //create an empty user
            User user = null;
            user = UserDAO.getUserByLogin(userid, userpassword);
            
            if (user != null) {
                session.setAttribute("User", user);
                if (comefrom != null && comefrom.equals("studyTrip")) {
                    response.sendRedirect("studyTrip.jsp");	
                } else if(comefrom != null && comefrom.equals("internshipDetails")){
                    
                    String url = "internshipDetails.jsp?cont="+ cont;
                    response.sendRedirect(url);
                }else {
                    response.sendRedirect("studentPortal_main.jsp");
                }
        
                return;
            }
            
            Admin admin = null;
                admin = AdminDAO.getAdminByLogin(userid, userpassword);
            
                if (admin != null){
                    session.setAttribute("Admin", admin);
                    response.sendRedirect("AdminPortal_trips.jsp");
                    return;
                    }
                }
        
            Company company = null;
                company = CompanyDAO.getCompanyByLogin(userid, userpassword);

                if (company != null){
                    session.setAttribute("Company", company);
                    response.sendRedirect("PartnerPortal_internships.jsp");
                    return;
                    }
                
            request.setAttribute("Student_ErrorMsg", "Invalid userid/password");
            request.getRequestDispatcher("login.jsp").forward(request, response);

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
