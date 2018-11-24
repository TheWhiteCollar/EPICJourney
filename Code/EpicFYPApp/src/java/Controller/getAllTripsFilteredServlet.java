/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.TripsDAO;
import Model.Entity.Trip;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "getAllTripsFilteredServlet", urlPatterns = {"/getAllTripsFilteredServlet"})
public class getAllTripsFilteredServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getAllTripsFilteredServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getAllTripsFilteredServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String minDate = "";
        String maxDate = "";
        double minPrice = 0;
        double maxPrice = 100000.00;
        String tripTitle = "";
        String tripCountry = "";

        // Create session
        HttpSession session = request.getSession(true);
        String price_max = (String) session.getAttribute("tripPrice");
        if (price_max != "") {
            maxPrice = Double.parseDouble(price_max);
        }
        String programmes = (String) session.getAttribute("tripProgramme");;
        if (programmes != "") {
            tripTitle = programmes;
        }
        String country = (String) session.getAttribute("tripCountry");;
        if (country != "") {
            tripCountry = country;
        }

        /*
        String price_max = request.getParameter("price_max");
        if (price_max != "") {
            maxPrice = Double.parseDouble(price_max);
        }
        String programmes = request.getParameter("programmes");
        if (programmes != "") {
            tripTitle = programmes;
        }
        String country = request.getParameter("country");
        if (country != "") {
            tripCountry = country;
        }
         */
        ArrayList<Trip> allTrips = TripsDAO.getFilteredTrips(minDate, maxDate, minPrice, maxPrice, tripTitle, tripCountry);
        Gson gson = new Gson();
        PrintWriter pw = response.getWriter();
        pw.print(gson.toJson(allTrips));
        pw.close();
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
