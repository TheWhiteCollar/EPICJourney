<%@page import="Model.Dao.InterestDAO"%>
<%@page import="Model.Dao.CountryTripDAO"%>
<%@page import="Model.Entity.User"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Instant"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Dao.TripsDAO"%>
<%@page import="Model.Entity.Trip"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    /*
    Things undone:
    - trip description
    - actual filter
    - trip itineary
    -set a limit of trip shown
    
     */
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Overseas study missions/internships for all</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />

        <script src="js/jquery.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>

        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript> 
        <script>
            $(function () {
                $.get('/EpicFYPApp/getAllTripsFilteredServlet', function (tripJson) {
                    var trips = JSON.parse(tripJson);
                    var tripHTML = '';
                    var count = 1;
                    console.log(trips);
                    $.each(trips, function (index, trip) {
                        var number = trip.tripActivation - trip.signedUpEmails.length;
                        switch (count % 3) {
                            case (1):
                                tripHTML += '<div class ="row"><div class = "4u 12u(xsmall)"><table  style="border:1px solid; border-radius: 10px;">';
                                break;
                            case (2):
                                tripHTML += '<div class = "4u 12u(xsmall)"><table  style="border:1px solid; border-radius: 10px;">';
                                break;
                            case (0):
                                tripHTML += '<div class = "4u 12u(xsmall)"><table  style="border:1px solid; border-radius: 10px;">';
                                break;
                        }
                        tripHTML += '<tr><td class = "align-center"><img src="' + 'images/Belgium.jpg' + '" width =100% height =auto></td></tr>';
                        tripHTML += '<tr><td>' + trip.tripTitle + ' | ' + trip.tripCountry + ' | ' + trip.tripStart + ' - ' + trip.tripEnd + ' | $' + trip.tripPrice + ' | ';
                        if (trip.activated) {
                            tripHTML += 'Activated</td></tr>';
                        } else {
                            tripHTML += 'Not Activated (' + number + " more)</td></tr>";
                        }
                        tripHTML += '<tr><td>Travel to Myanmar and experience their beautiful scenery</td></tr>';
                        tripHTML += '<tr><td>';

            <%
                User User = (User) session.getAttribute("User");
                if (User != null) {
            %>
                        tripHTML += '<form action="applyForTrips" method="post">';
                        tripHTML += '<input style="display: none" type="text" name="tripID" value="' + trip.tripID + '"/>';
                        tripHTML += '<input style="display: none" type="text" name="tripUserEmail" value="' + '${User.getUserEmail()}' + '"/>';

                        var user = '${User.getUserEmail()}';
                        if (trip.signedUpEmails.includes(user)) {
                            tripHTML += '<p><input disabled type="submit" value="Applied" class="full_width"/></form></p>';
                        } else {
                            tripHTML += '<p><input type="submit" value="Apply" class="full_width"/></form></p>';
                        }

            <%
            } else {
            %>

                        tripHTML += '<p><a href = "login.jsp?comefrom=studyTrip" class = "button full_width">Log in to apply</a></p>';


            <%}%>

                        tripHTML += '<form action="tripDetails.jsp" method="post"><input type="text" name="tripID" style="display: none" value="' + trip.tripID + '"><input type = "submit" class="full_width" value = "More Details"></form>';
                        tripHTML += '</td></tr>';
                        switch (count % 3) {
                            case (1):
                                tripHTML += '</table></div>';
                                break;
                            case (2):
                                tripHTML += '</table></div>';
                                break;
                            case (0):
                                tripHTML += '</table></div></div>';
                                break;
                        }
                        count += 1;
                    });
                    $("#trips").append(tripHTML);
                });
            });
        </script>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Filter -->
        <section id="main" class="wrapper">
            <div class="container">
                <header class="major">
                    <h2>Overseas Study Trips</h2>
                    <p>Let's Explore! Apply for your study trip here!</p>
                </header>

                <div class="tab">
                    <button class="tablinks" onclick="openUser(event, 'filter')">More filtering options:</button>      
                </div>


                <div id="filter" class="tabcontentFade">
                    <span onclick="this.parentElement.style.display = 'none'" class="toprightClose">&times</span>

                    <form action="storedAllFilteredVariables" method="post" onsubmit="showLoader()">
                        <p>
                        <div class = "row">
                            <div class="3u 12u(small)">
                                <% LocalDate todayDate = java.time.LocalDate.now(); %>
                                Date (min):                                                                       
                                <input name = "startDate" type="date" min = "<% out.print(todayDate); %>" >
                            </div>
                            <div class="3u 12u(small)">
                                Date (max):                              
                                <input name = "endDate" type="date" min = "<% out.print(todayDate);%>" >
                            </div> 
                        </div>

                        </p>

                        <p>
                        <div class = "row">
                            <div class="2u 12u(small)">
                                Price (min):
                                <input type="number" name ="price_min" placeholder = "0" min = "0">
                            </div>
                            <div class="2u 12u(small)">
                                Price (max):
                                <input type="number" name ="price_max" placeholder = "0" min = "0"> 
                            </div>

                            <!--                            
                            <div class="3u 12u(small)">
                                Ratings:
                                <select name="rating">
                                    <option disabled selected value style="display:none"> - select a rating - </option>
                                    <option value="bad">Bad</option>
                                    <option value="average">Average</option>
                                    <option value="excellent">Excellent</option>
                                </select>
                            </div>
                            -->
                            <div class="4u 12u(small)">
                                Programmes:
                                <select name="programmes" >
                                    <option disabled selected value style="display:none"> - select a programme - </option>
                                    <%
                                        ArrayList<String> allInterests = InterestDAO.getInterests();

                                        if (!allInterests.isEmpty()) {
                                            for (int i = 0; i < allInterests.size(); i++) {
                                                String interests = allInterests.get(i);

                                    %>
                                    <option value="<%out.print(interests);%>"><%out.print(interests);%></option>
                                    <%    }
                                        }

                                    %>
                                </select>
                            </div>
                            <div  class="4u 12u(small)">
                                Country:
                                <select name="country">
                                    <option disabled selected value style="display:none"> - Select a Country - </option>
                                    <%                                    ArrayList<String> allCountryTrip = CountryTripDAO.getAllCountryTrip();

                                        if (!allCountryTrip.isEmpty()) {
                                            for (int i = 0; i < allCountryTrip.size(); i++) {
                                                String country = allCountryTrip.get(i);

                                    %>
                                    <option value="<%out.print(country);%>"><%out.print(country);%></option>
                                    <%    }
                                        }

                                    %>
                                </select> 
                            </div>
                        </div>
                        </p>


                        <input type="submit" value="Apply" class="full_width"> 
                    </form> 
                </div>

                <!-- Overseas trip populates -->
                </br>
                <div id="trips"></div>
            </div>
        </section>

        <<!-- Footer -->
        <jsp:include page="footer.jsp" />
        <script src="js/tabs.js"></script>
    </body>
</html>