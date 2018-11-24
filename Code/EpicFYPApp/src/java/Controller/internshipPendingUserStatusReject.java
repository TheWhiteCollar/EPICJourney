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

@WebServlet(name = "internshipPendingUserStatusReject", urlPatterns = {"/internshipPendingUserStatusReject"})
public class internshipPendingUserStatusReject extends HttpServlet {

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
        String status = request.getParameter("status");
        
        //format date correctly
        java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);
        
        Boolean inserted;
        
        if(status.equals("Sent interest email - Waiting for user reply")){
            inserted = InternshipStudentDAO.addInternshipStudent(userEmail, countryContinent, "Application withdrawn - No interview scheduled", currentTime, 0);
            if(inserted){
                response.sendRedirect("AdminPortal_userInternshipTrackingPendingUser.jsp");
                return;
            }else{
                response.sendRedirect("failureMessage.jsp");
            return;
            }
            
        } else if(status.equals("Sent interview schedule email - Waiting for user reply")){
            inserted = InternshipStudentDAO.addInternshipStudent(userEmail, countryContinent, "User withdraws from scheduled interview - No further action", currentTime, 0);
            if(inserted){
                response.sendRedirect("AdminPortal_userInternshipTrackingPendingUser.jsp");
                return;
            }else{
                response.sendRedirect("failureMessage.jsp");
            return;
            }
        }else if(status.equals("Internship offered - Pending user internship acceptance")){
            inserted = InternshipStudentDAO.addInternshipStudent(userEmail, countryContinent, "User rejects internship offer- No further action", currentTime, 0);
            //find internshipstudent id
            int internshipStudentID = InternshipStudentDAO.getInternshipStudentIDfromUserContinetStatus(userEmail, countryContinent);
            //look for the id
            int internshipID = InternshipAssignedDAO.getInternshipIDbyInternshipStudentID(internshipStudentID);
            InternshipDAO.updateInternshipVacancyIncrease(internshipID);
            if(inserted){
                response.sendRedirect("AdminPortal_userInternshipTrackingPendingUser.jsp");
                return;
            }else{
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
