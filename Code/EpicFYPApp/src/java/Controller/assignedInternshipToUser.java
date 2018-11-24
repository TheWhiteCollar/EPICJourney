/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.InternshipAssignedDAO;
import Model.Dao.InternshipDAO;
import Model.Dao.InternshipStudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "assignedInternshipToUser", urlPatterns = {"/assignedInternshipToUser"})
public class assignedInternshipToUser extends HttpServlet {

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
      
        String userEmail = request.getParameter("userEmail");
        String countryContinent = request.getParameter("continent");
        String internshipIDS = request.getParameter("internshipID");
        int internshipID = Integer.parseInt(internshipIDS);
        
        //format date correctly
        java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);
        
        //14 supp 12 from 10
        Boolean inserted1 = InternshipStudentDAO.addInternshipStudent(userEmail, countryContinent, "Internship offered - Pending user internship acceptance", currentTime, 2);
        int internshipStudentID = InternshipStudentDAO.getInternshipStudentIDfromUserContinetStatus(userEmail, countryContinent);
         
        InternshipDAO.updateInternshipVacancyIncrease(internshipID);
        
        Boolean inserted2 = InternshipAssignedDAO.addInternshipAssigned(internshipID, internshipStudentID);
        if(inserted1 && inserted2){
            InternshipDAO.updateInternshipVacancyDecrease(internshipID);
            response.sendRedirect("AdminPortal_userInternshipTrackingPendingAdmin.jsp");
            return;
        }else{
            response.sendRedirect("failureMessage.jsp");
        return;
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
