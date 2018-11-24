<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Dao.TripsDAO"%>
<%@page import="Model.Entity.Trip"%>
<%@page import="Model.Dao.UserDAO"%>
<%@page import="Model.Entity.User"%>
<%@page import="Model.Dao.TripStudentDAO"%>
<%@page import="Model.Entity.TripStudent"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin View Partner Profile</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
        
        <jsp:include page="AdminPortalPermission.jsp" />

      
        <section class="wrapper">
            
            <div class="container">
                <header class="major">
                    <h3>Tracking Users' Applications</h3>
                </header>
                <table class = "alt" style="font-size:14px;">
                    <thead>
                        <tr>
                            <th class="align-center">#</th>
                            <th class="align-center">Trip Title</th>
                            <th class="align-center">User name</th>
                            <th class="align-center">Current Status</th>
                            <th class="align-center">More information</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<TripStudent> allTripStudent = TripStudentDAO.getLastStatusOfUserAndTripID();
                            int count = 0;
                            if (!allTripStudent.isEmpty()) {
                                for (int i = 0; i < allTripStudent.size(); i++) {
                                    TripStudent ts = allTripStudent.get(i);
                                    count += 1;
                                    String userEmail = ts.getTripUserEmail();
                                    User user = UserDAO.getUser(userEmail);
                                    String name = "" + user.getUserFirstName() + " " + user.getUserLastName();
                                    int tripID = ts.getTripID();
                                    Trip trip = TripsDAO.getTrip(tripID);
                                    String tripName = trip.getTripTitle();
                        %>
                        <tr>
                            <td class="align-center"><%out.print(count);%></td>
                            <td class="align-center"><% out.print(tripName); %></td>                      
                            <td class="align-center"><% out.print(name); %></td>
                            <td class="align-center"><% out.print(ts.getTripStudentStatus()); %></td>
                            <td class="align-center"><button type="button" class="button" data-toggle="modal" data-target="#myModal<%out.print(i);%>">View</button></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>    
                </table>

                <%
                    if (!allTripStudent.isEmpty()) {
                        for (int i = 0; i < allTripStudent.size(); i++) {
                            TripStudent ts = allTripStudent.get(i);
                            Trip t = TripsDAO.getTrip(ts.getTripID());
                            User u = UserDAO.getUser(ts.getTripUserEmail());

                %>
                <div class="modal fade" id="myModal<%out.print(i);%>" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title align-center"><b><%out.print(u.getUserFirstName() + " " + u.getUserLastName());%>'s</b> application to <b><%out.print(t.getTripTitle());%></b></h4>
                            </div>
                            <div class="modal-body">
                                <div class ="row">
                                    <div class="4u 12u(xsmall)">
                                        <div align="center"><img src="images/Belgium.jpg" alt ="avatar-image" height="80%" width="80%"></div>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class="align-right"><b>Trip ID:</b></td>
                                                    <td><%out.print(t.getTripID());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Title:</b></td>
                                                    <td><%out.print(t.getTripTitle());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Country:</b></td>
                                                    <td><%out.print(t.getTripCountry());%>, <%out.print(t.getTripState());%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="8u 12u(xsmall)">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class="align-right"><b>Name :</b></td>
                                                    <td><%out.print(u.getUserFirstName() + " " + u.getUserLastName());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Email :</b></td>
                                                    <td><%out.print(u.getUserEmail());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Phone :</b></td>
                                                    <td><%out.print(u.getUserPhone());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Gender :</b></td>
                                                    <td><%out.print(u.getUserGender());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Citizenship :</b></td>
                                                    <td><%out.print(u.getUserCitizenship());%></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Interests :</b></td>
                                                    <td><%out.print(u.getUserInterest());%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                                              
                                </div>
                                <div class ="row">
                                    <div class ="12u 12u">
                                        <h2 class="align-center">Status History</h2>
                                        <table class="alt">
                                            <thead>
                                                <tr>
                                                    <td class="align-center">Status</td>
                                                    <td class="align-center">Date & Time</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                ArrayList<String> tripstudentStatusList = TripStudentDAO.getTripStatusByTripID(u.getUserEmail(), t.getTripID());
                                                for(int x=0; x < tripstudentStatusList.size(); x++){
                                                String statusTitle = tripstudentStatusList.get(x);
                                                x++;
                                                String statusDate = tripstudentStatusList.get(x);

                                                //format the statusDate
                                                SimpleDateFormat fromDB = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                SimpleDateFormat myFormat = new SimpleDateFormat("dd MMMM yyyy , HH:mm a");
                                                String reformattedDate = myFormat.format(fromDB.parse(statusDate));
                                                %>
                                                <tr>
                                                    <td class="align-center"><%out.print(statusTitle);%></td>
                                                    <td class="align-center"><%out.print(reformattedDate);%></td>
                                                </tr>
                                                <%
                                                }
                                                %>
                                            </tbody>
                                        </table>                                         
                                    </div>                            
                                </div>
                  

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="button" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>

            </div>
        </section>
    </body>
</html>