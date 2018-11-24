/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Dao.InternshipStudentDAO;
import Model.Dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "addNewInternshipStudent", urlPatterns = {"/addNewInternshipStudent"})
public class addNewInternshipStudent extends HttpServlet {

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
        // retrieve user input
        String userEmail = request.getParameter("userEmail");
        String continent = request.getParameter("cont");
        String userFirstName = request.getParameter("firstName");
        String userLastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        int userPhone = Integer.parseInt(phone);      
        String userCitizenship = request.getParameter("citizenship");
        String userHighestEducation = request.getParameter("highest_qualification");
        String userSchool = request.getParameter("school");
        String userFieldOfStudy = request.getParameter("fos");
        
        //format date correctly
        java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);

        //get the resume parameter
        Part filePart = request.getPart("uploadedfile"); 
     
        //update user
        //updateUser(String userEmail, String userFirstName, String userLastName, int userPhone, String userGender, String userCitizenship, int userDOB, String userProfilePic, String userInterest, String userPassword, String userOccupation, String userResume, String userIsEmailConfirm, String userHighestEducation, String userFieldOfStudy, String userDescription, String userSchool, Part userResume)
        //add into internshipStudent
        if (!userFirstName.equals("") && !userLastName.equals("") && !userCitizenship.equals("") && !userHighestEducation.equals("") && !userSchool.equals("") && !userFieldOfStudy.equals("") && filePart!=null) {

            // Insert into database
            boolean insertedUser = UserDAO.updateUser(userEmail, userFirstName, userLastName, userPhone, userCitizenship, userHighestEducation, userFieldOfStudy, userSchool,filePart);
            boolean insertedInternshipStudent = InternshipStudentDAO.addInternshipStudent(userEmail, continent, "User submitted application - Admin to review application", currentTime, 1);
            if (insertedUser==true && insertedInternshipStudent==true) {
                response.sendRedirect("applyInternshipSucceed.jsp");
                return;
            } else {
                String url = "internshipDetails.jsp?cont=" + continent;
                response.sendRedirect(url);
                return;
            }
        }

        request.setAttribute("ErrorMsg", "Sign up failed. Do reach out to us via email");
        request.getRequestDispatcher("internshipDetails.jsp").forward(request, response);
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
