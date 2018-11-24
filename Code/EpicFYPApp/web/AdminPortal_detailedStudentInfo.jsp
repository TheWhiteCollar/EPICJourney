<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.Entity.Trip"%>
<%@page import="Model.Dao.TripsDAO"%>
<%@page import="Model.Dao.TripStudentDAO"%>
<%@page import="Model.Entity.TripStudent"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Model.Dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin View Full Profile</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap-notify.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>
        
        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
    </head>
    <body>

        <!-- Header -->
        <jsp:include page="header.jsp" />
        <jsp:include page="AdminPortalPermission.jsp" />
        
        
        
        <section class="wrapper">
            <div class="container">
                <h2 class="align-center">Detailed Information</h2>
                <div class="align-center">
                    <a href="javascript:window.print()" download="fullScreen.PDF" class="button">Save as PDF</a>
                    <br>
                    <br>
                </div>
                
                <%
                ArrayList<User> allUsers = UserDAO.getAllUsers();
                        
                        if (!allUsers.isEmpty()) {
                %>
                <table class = "alt" style="font-size:12px;">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Citizenship</th>
                            <th>D.O.B</th>
                            <th>Interests</th>
                            <th>Occupation</th>
                            <th>Highest Qualification</th>
                            <th>Field of Study</th>
                            <th>Org/Sch</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                                for (int i = 0; i < allUsers.size(); i++) {
                                    User u = allUsers.get(i);
                        %>
                        <tr>
                            <td><% out.print(u.getUserFirstName() + " " + u.getUserLastName()); %></td>                      
                            <td><% out.print(u.getUserEmail()); %></td>
                            <td class = "align-center"><% out.print(u.getUserPhone()); %></td>
                            <td><% out.print(u.getUserCitizenship()); %></td>
                            <td><% out.print(u.getUserDOB()); %></td>
                            <td><% out.print(u.getUserInterest()); %></td>
                            <td><% out.print(u.getUserOccupation()); %></td>
                            <td><% out.print(u.getUserHighestEducation()); %></td>
                            <td><% out.print(u.getUserFieldOfStudy()); %></td>
                            <td><% out.print(u.getUserSchool()); %></td>
                            
                        </tr>
                        <%
                                }
                        %>
                    </tbody>    
                </table>
                    <%
                        }else {
                    %>
                    <p class="align-center">There is no users signed up yet...</p>
                    <%
                        }
                    %>
                    
        </section>
    </body>
</html>             