/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.TripStudentDAO;
import Model.Dao.TripsDAO;
import Model.Entity.Trip;
import java.io.IOException;
import javax.servlet.ServletException;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "applyForTrips", urlPatterns = {"/applyForTrips"})
public class applyForTrips extends HttpServlet {
    
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
        String tripUserEmail = request.getParameter("tripUserEmail");
        int tripID = Integer.parseInt(request.getParameter("tripID"));
        String tripStudentStatus = "Applied interest"; 
        
        //get current date
        java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);
        
        //date time add 2 seconds
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.SECOND, 2);
        java.util.Date date = cal.getTime();
        String currentTime2seconds = sdf.format(date);
        
        //add one to the current trip sign up
        TripsDAO.incrementTripTotalSignup(tripID);
        
        //insert status="Applied interest" into tripstudent table
        if(TripsDAO.insertStudent(tripUserEmail, tripID, tripStudentStatus, currentTime)){
            //insert status="Pending desposit" into tripstudent table
            TripsDAO.insertStudent(tripUserEmail, tripID, "Pending Deposit", currentTime2seconds);
             
            String url = "payment.jsp?tripId=" + tripID+"&type=deposit";
            response.sendRedirect(url);
        }      
         
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
