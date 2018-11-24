package Controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Model.Dao.CountryInternshipDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "addCountryInternship", urlPatterns = {"/addCountryInternship"})
public class addCountryInternship extends HttpServlet {

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
            
        String countryName = request.getParameter("country");
        String countryContinent = request.getParameter("continent");

        Boolean inserted = CountryInternshipDAO.addCountryInternship(countryName,countryContinent);
        if(inserted && countryContinent.equals("America")){
            response.sendRedirect("AdminPortal_manageInternshipAmerica.jsp");
            return;
        } else if(inserted && countryContinent.equals("Asia")){
            response.sendRedirect("AdminPortal_manageInternshipAsia.jsp");
            return;
        } else if(inserted && countryContinent.equals("Australia")){
            response.sendRedirect("AdminPortal_manageInternshipAustralia.jsp");
            return;
        } else if(inserted && countryContinent.equals("Europe")){
            response.sendRedirect("AdminPortal_manageInternshipEurope.jsp");
            return;
        } else{
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
