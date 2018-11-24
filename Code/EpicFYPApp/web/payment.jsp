<%@page import="Model.Entity.User"%>
<%@page import="Model.Dao.TripStudentDAO"%>
<%@page import="java.text.DecimalFormat"%>
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

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Payment</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/jquery.min.js"></script>
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

        <!-- Details -->
        <section id="main" class="wrapper">
            <div class="container"> 
                <%
                    
                    User User = (User) session.getAttribute("User");
                                    String email = User.getUserEmail();
                    DecimalFormat df2 = new DecimalFormat("#.00");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
                    String tripIDS = request.getParameter("tripId");
                    int tripID = Integer.parseInt(tripIDS);
                    String type = request.getParameter("type");

                    Trip trip = TripsDAO.getTrip(tripID);
                    if (trip != null) {
                        String tripTitle = trip.getTripTitle();
                        String tripCountry = trip.getTripCountry();
                        Date tripStart = trip.getTripStart();
                        Date tripEnd = trip.getTripEnd();
                        double tripPrice = trip.getTripPrice();
                        boolean tripActivated = trip.getActivated();
                        int studentsToActivation = trip.getTripActivation() - trip.getNumberOfStudents();
                %>

                <h2 class="align-center"><b>Trip Details</b></h2>
                <div class="row">
                    <div class="4u 12u(xsmall)"> 
                        <img src="images/Germany.jpg" height=auto width="100%"> 
                    </div>

                    <div class="8u 12u(xsmall)">
                        <table>
                            <col width="120">
                            <tbody>
                                <tr>
                                    <td class="align-right"><b>Trip Title :</b></td>
                                    <td><%out.print(tripTitle);%></td>
                                </tr>
                                <tr>
                                    <td class="align-right"><b>Country :</b></td>
                                    <td><%out.print(tripCountry);%></td>
                                </tr>
                                <tr>
                                    <td class="align-right"><b>Price :</b></td>
                                    <td>$ <%out.print(df2.format(tripPrice));%></td>
                                </tr>



                                <tr>
                                    <td class="align-right"><b>Status :</b></td>
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
                                    <td class="align-right"><b>Start Date :</b></td>
                                    <td><%out.print(dateFormat.format(tripStart));%></td>
                                </tr>
                                <tr>
                                    <td class="align-right"><b>End Date :</b></td>
                                    <td><%out.print(dateFormat.format(tripEnd));%></td>
                                </tr>
                                <tr>
                                    <td class="align-right"><b>Amt due :</b></td>
                                    <%
                                    
                                    int amountIndication = TripStudentDAO.getAmountIndicationUserAndTrip(email, tripID);
                                    if(amountIndication==1){
                                    %>
                                    
                                    <td>$ <%out.print(df2.format(tripPrice*0.5));%></td>
                                    <%
                                    } else if(amountIndication==2){
                                    %>
                                    <td>$ <%out.print(df2.format(tripPrice));%></td>                                    
                                    <%                                   
                                    } 
                                    %>
                                    
                                </tr>
                                <tr>
                                    <td class="align-right"><b>T&C :</b></td>
                                    <td>
                                        <u>Payment for Trip:</u>
                                        
                                        <ul>
                                            <li>50% of study trip price will be collected upon registration to secure booking. </li>
                                            <li>Next 50% will be collected when <b>minimum number of participants required for trip to be activated</b> is met, or when <b>EPIC confirms trip is activated</b>, whichever happens earlier. Payment is required to be completed with 24 hours after trip is confirmed or activated. </li>
                                        </ul>
                                        
                                        <u>For Withdrawals and Cancellations:</u>
                                        <ul>
                                            <li>All withdrawals must be received in writing by EPIC Pte Ltd. </li>
                                            <li>The following rules apply for withdrawals and refunds:
                                                
                                                <ol>
                                                    <li>50% non-refundable deposit upon registration.</li>
                                                    <li>For Withdrawal/Cancellation received less than 30 days prior to Departure, 25% of tour cost will be refunded.</li>
                                                    <li>For Withdrawal/Cancellation received less than 15 days prior to Departure, 10% of tour cost will be refunded.</li>
                                                    <li>For Withdrawal/Cancellation received less than 7 days prior to Departure, 0% of tour cost will be refunded.  <b>No refund will be made. </b></li>
                                                    <li>Refund may take up to 3 months after written confirmation of withdrawal/cancellation is received. </li>
                                                </ol>
                                            </li>
                                        </ul>
                                        
                                        <i>Other Information:</i>
                                        <ul>
                                            <li>Air ticket booking is handled by Epic’s licensed travel agent. </li>
                                            <li>It is the responsibility of the participant to ensure that he/she has a valid passport with 6 months validity from the date of scheduled return to Singapore.</li>
                                            <li>The above package price excludes any applicable visa fees.   </li>
                                            <li>Please note that any incidentals costs or any other items not mentioned above will be at participant’s own expense. </li>
                                        </ul>
                                        
                                        <p>By clicking on the Proceed button, you agree to the Terms & Conditions outlined.</p>
                                   
                                        <form action="paymentOptions.jsp" action="post">
                                            <input style="display: none" type="text" name="tripId" value="<%out.print(tripID);%>"/>
                                            <input style="display: none" type="text" name="type" value="<%out.print(type);%>"/>
                                            <input type="submit" value="Proceed to make payment" class="full_width">
                                        </form>
                                      
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                               
                    </div>
                    <%}%>
                </div>
            </div> 
           
        </section>
                   




        <!-- Footer -->
        <jsp:include page="footer.jsp" />
    </body>
</html>