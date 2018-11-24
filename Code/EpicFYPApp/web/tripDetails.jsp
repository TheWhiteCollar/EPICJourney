<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Dao.TripStudentDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="Model.Entity.Admin"%>
<%@page import="Model.Entity.User"%>
<%@page import="Model.Entity.User"%>
<%@page import="Model.Dao.TripsDAO"%>
<%@page import="Model.Entity.Trip"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Overseas study missions/internships for all</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>


        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
        <!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->

    </head>
    <body>

        <!-- Header -->        
        <jsp:include page="header.jsp" />

        <!-- Main -->
        <section id="main" class="wrapper ">
            <div class="container">

                <%
                    // pass the trip ID over - by a session??
                    String tripIDS = request.getParameter("tripID");
                    int tripID = Integer.parseInt(tripIDS);	
                    
                    Trip trip = TripsDAO.getTrip(tripID);
                    if (trip != null) {
                        String tripTitle = trip.getTripTitle();
                        String tripCountry = trip.getTripCountry();
                        String tripDescription = trip.getTripDescription();
                        Date tripStart = trip.getTripStart();
                        Date tripEnd = trip.getTripEnd();
                        int tripDuration = trip.getTripDuration();
                        double tripPrice = trip.getTripPrice();
                        boolean tripActivated = trip.getActivated();
                        int studentsToActivation = trip.getTripActivation() - trip.getNumberOfStudents();
                        
                %> 

                <header class="major align-center">
                    <h2>#<%out.print(tripID);%> : <%out.print(tripTitle);%></h2>
                    <p><%out.print(tripDescription);%></p>
                </header>
                
                <div class="box alt">
                    <div class="row 50% uniform">	

                        <div class="4u"></br><span class="image fit"><img src="images/<%out.print(tripCountry);%>.jpg" alt="" width="100%px" height=auto /></span></div>

                        <div class="8u">

                            <table>
                                <thead>
                                    <tr>
                                        <th colspan = "3" class="align-center">Summarised Trip Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Country : <%out.print(tripCountry);%></td>
                                        <td>Price : $<%out.print(tripPrice);%></td>

                                        <%
                                            if (tripActivated) {
                                        %>
                                        <td>Activated</td>
                                        <%
                                        } else {
                                        %>
                                        <td>Not Activated (<%out.print(studentsToActivation);%> more)</td>

                                        <%}%>

                                    </tr>
                                    <tr>
                                        <td>Start : <%out.print(tripStart);%></td>
                                        <td>End : <%out.print(tripEnd);%></td>
                                        <td>Duration : <%out.print(tripDuration);%> days</td>
                                    </tr>
                                    <tr>
                                        <!--<td><a href ="downloadItinerary" class ="button">Trip Itinerary</a></td>-->
                                        <%
                                            User User = (User) session.getAttribute("User");
                                            if (User != null) {
                                                ArrayList<Integer> tripsArraylist = TripStudentDAO.getTripIDsByUser(User.getUserEmail());
                                                int occurrences = Collections.frequency(tripsArraylist, tripID);
                                                
                                                if(occurrences == 0){
                                                
                                        %>
                                        <td colspan="3">
                                            <form action="applyForTrips" method="post">
                                                <input style="display: none" type="text" name="tripID" value="<%out.print(tripID);%>"/>
                                                <input style="display: none" type="text" name="tripUserEmail" value="<%out.print(User.getUserEmail());%>"/>                                        
                                                <input type="submit" value="Apply for trip" class="full_width">
                                            </form>
                                        </td>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <td colspan="3"><a href ="login.jsp" class ="button full_width">Log in to apply</a></td>
                                        <%}%>
                                    </tr>

                                </tbody>

                            </table>

                        </div>					
                    </div>
                </div>	

                <%
                    }
                %>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />



    </body>
</html>