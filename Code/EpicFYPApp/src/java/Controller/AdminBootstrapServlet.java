/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.TripsDAO;
import Model.Dao.UserDAO;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author User
 */
@MultipartConfig
public class AdminBootstrapServlet extends HttpServlet {

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

        final PrintWriter writer = response.getWriter();

        try {

            // Create path components to save the file -- Users
            final Part filePartUser = request.getPart("updateUsers");
            InputStream fileContentUser = filePartUser.getInputStream();
            if (fileContentUser != null) {
                Scanner sc = new Scanner(fileContentUser);
                String line = sc.nextLine();
                while (sc.hasNextLine()) {
                    line = sc.nextLine();
                    String[] user = line.split(",");
                    String userEmail = user[0];
                    String userFirstName = user[1];
                    String userLastName = user[2];
                    int userPhone = Integer.parseInt(user[3]);
                    String userGender = user[4];
                    String userCitizenship = user[5];
                    int yearOfBirth = Integer.parseInt(user[6]);
                    String userInterest = user[7];
                    String userPassword = user[8];
                    String userOccupation = user[9];
                    String userResume = user[10];
                    String userIsEmailConfirm = user[11]; // by right should be boolean
                    String userHighestEducation = user[12];
                    String userFieldOfStudy = user[13];
                    String userDescription = user[14];
                    String userSchool = user[15];

                    Boolean inserted = UserDAO.addUser(userEmail, userFirstName, userLastName, userPhone, userGender, userCitizenship, yearOfBirth, userInterest, userPassword, userOccupation, null, userIsEmailConfirm, userHighestEducation, userFieldOfStudy, userDescription, userSchool);

                }
            } else {
                writer.println("Not added in successfully");
            }

            // Create path components to save the file -- Trips
            final Part filePartTrip = request.getPart("updateTrips");
            InputStream fileContentTrip = filePartTrip.getInputStream();
            if (fileContentTrip != null) {
                Scanner sc = new Scanner(fileContentTrip);
                String line = sc.nextLine();
                while (sc.hasNextLine()) {
                    line = sc.nextLine();
                    String[] trip = line.split(",");
                    String tripTitle = trip[0];
                    Double tripPrice = Double.parseDouble(trip[1]);
                    String tripItinerary = trip[2];
                    String tripDescription = trip[3];
                    String tripCountry = trip[4];
                    String tripState = trip[5];
                    //Date tripStart = Date.valueOf("1-3-2019");
                    //Date tripEnd = Date.valueOf("3-3-2019");
                    int tripDuration = Integer.parseInt(trip[8]);
                    int tripActivation = Integer.parseInt(trip[9]);
                    String tripInterest = trip[10];
                    int tripTotalSignUp = Integer.parseInt(trip[11]);
                    String tripPicture = trip[12];

                    // boolean inserted = TripsDAO.addTrip(tripTitle, tripPrice, tripItinerary, tripDescription, tripCountry, tripState, tripStart, tripEnd, tripDuration, tripActivation, tripInterest, tripTotalSignUp);
                    boolean inserted = TripsDAO.addTrip(tripTitle, tripPrice, null, tripDescription, tripCountry, tripState, tripDuration, tripActivation, tripInterest, tripTotalSignUp, null);
                }
            } else {
                writer.println("Not added in successfully");
            }

            // Create path components to save the file -- tripstudent
            final Part filePartTripStudent = request.getPart("updateTripsUsersSignedUpFor");
            InputStream fileContentTripStudent = filePartTripStudent.getInputStream();
            if (fileContentTripStudent != null) {
                Scanner sc = new Scanner(fileContentTripStudent);
                String line = sc.nextLine();
                while (sc.hasNextLine()) {
                    line = sc.nextLine();
                    String[] tripStudent = line.split(",");
                    int tripID = Integer.parseInt(tripStudent[0]);
                    String tripUserEmail = tripStudent[1];
                    String tripStudentStatus = tripStudent[2];
                    String tripStudentTimestamp = tripStudent[3];
                
                    
                    if (TripsDAO.addTripStudent(tripUserEmail, tripID, tripStudentStatus, tripStudentTimestamp)) {
                        writer.println("TripStudent Successfully updated");
                    } else {
                        writer.println("Not inserted into database");
                    }
                }
            } else {
                writer.println("Not added in successfully");
            }
            
            request.setAttribute("Success_Msg", "Database successfully updated");
            request.getRequestDispatcher("AdminPortal_bootstrap.jsp").forward(request, response);

        } catch (FileNotFoundException fne) {
            writer.println("Updates fails");
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
