<%@page import="Model.Dao.UserDAO"%>
<%@page import="Model.Entity.Trip"%>
<%@page import="Model.Dao.TripsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Dao.TripStudentDAO"%>
<%@page import="Model.Entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Portal Main Page</title>
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


        <section class="wrapper">
            <div class ="container">              
                <header class="major align-center">
                    <h2>Application Status</h2>
                </header>

                <div class="row 50% uniform">
                    <div class="12u 12u">
                        <%
                           
                            User User = (User) session.getAttribute("User");
                            String email = User.getUserEmail();

                            ArrayList<Integer> tripList = TripStudentDAO.getTripIDsByUser(email);
                            
                            SimpleDateFormat fromDB = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            SimpleDateFormat myFormat = new SimpleDateFormat("dd MMMM yyyy , HH:mm a");
                        %>

                        <table class="alt align-center" style="font-size:14px;">
                            <thead>
                                <tr>
                                    <th class="align-center">Trip ID</th>
                                    <th class="align-center">Trip Title</th>
                                    <th class="align-center">Status</th>
                                    <th class="align-center">Timestamp</th>
                                    <th class="align-center">Action</th>
                                    <th class="align-center">Info</th>
                                </tr>                           
                            </thead>
                            <tbody>
                                <%                                
                                    for (int i = 0; i < tripList.size(); i++) {
                                        int tripID = tripList.get(i);
                                        ArrayList<String> tripStatusList = TripStudentDAO.getTripStatusByTripID(email, tripID);
                                        int statusCount = tripStatusList.size();
                                        String status = tripStatusList.get(statusCount - 2);
                                        String statusDate = tripStatusList.get(statusCount - 1);

                                        //format the statusDate
                                        String reformattedDate = myFormat.format(fromDB.parse(statusDate));
                                %>

                                <tr>
                                    <td class="align-center"><%out.print(tripID);%></td>
                                    <td class="align-center"><%out.print(TripsDAO.getTripTitleFromTripID(tripID));%></td>
                                    <td class="align-center"><%out.print(status);%></td>
                                    <td class="align-center"><%out.print(reformattedDate);%></td>
                                    <%
                                        if (status.equals("Pending Deposit")) {
                                    %>
                                    <td class="align-center"><a href="payment.jsp?tripId=<%out.print(tripID);%>&type=deposit" class="button">Pay</a></td>
                                    <%
                                    } else if (status.equals("Pending Remaining Amount")) {
                                    %> 
                                    <td class="align-center"><a href="payment.jsp?tripId=<%out.print(tripID);%>&type=remainder" class="button">Pay</a></td>
                                    <%
                                    } else {
                                    %>
                                    <td class="align-center">–</td>
                                    <%
                                        }
                                    %>
                                    <td class = "align-center"><button type="button" class="button" data-toggle="modal" data-target="#myModal<%out.print(i);%>">View</button></td>
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

        <%
            for (int i = 0; i < tripList.size(); i++) {
                Trip trip = TripsDAO.getTrip(tripList.get(i));
                SimpleDateFormat myFormat1 = new SimpleDateFormat("dd MMMM yyyy");
                
        %>
        <div class="modal fade" id="myModal<%out.print(i);%>" role="dialog" style="top:15%;">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title align-center"><b>[Trip ID : <%out.print(trip.getTripID());%>]</b> Information on <b><%out.print(trip.getTripTitle());%></b></h4>
                    </div>
                    <div class="modal-body">
                        <div class ="row">
                            <div class="12u 12u(xsmall)">
                                
                            
                                <table style="font-size:14px;">
                                    <tbody>
                                        <tr>
                                            <td class="align-right">Activation Status :</td>
                                            <%
                                            if(trip.getActivated()){
                                            %>
                                            <td class="align-left">Activated</td>
                                            <%    
                                            } else{
                                            %>
                                            <td class="align-left">Not Activated</td>
                                            <%
                                            }
                                            %>
                                            
                                        </tr>
                                        <tr>
                                            <td class="align-right">Country, state :</td>
                                            <td class="align-left"><%out.print(trip.getTripCountry());%>, <%out.print(trip.getTripState());%></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right">Description :</td>
                                            <td class="align-left"><%out.print(trip.getTripDescription());%></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right">Start Date :</td>
                                            <td class="align-left"><%out.print(myFormat1.format(trip.getTripStart()));%></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right">End Date :</td>
                                            <td class="align-left"><%out.print(myFormat1.format(trip.getTripEnd()));%></td>
                                        </tr>  
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class ="row">
                            <div class="12u 12u(xsmall)">
                                <h2 class="align-center">Status History</h2>
                                <table style="font-size:14px;" class="alt">
                                    <thead>
                                        <tr>
                                            <th class="align-center">Status</th>
                                            <th class="align-center">Date and Time</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                        ArrayList<String> tripStatusList = TripStudentDAO.getTripStatusByTripID(email, tripList.get(i));
                                        for(int x=0; x < tripStatusList.size(); x++){
                                            String statusTitle = tripStatusList.get(x);
                                            x++;
                                            String statusDate = tripStatusList.get(x);

                                            //format the statusDate
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
        %>

    </body>
</html>
