<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.Dao.InternshipDAO"%>
<%@page import="Model.Dao.InternshipAssignedDAO"%>
<%@page import="Model.Entity.Internship"%>
<%@page import="Model.Dao.InternshipStudentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
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

                            //get how many different internship they signed up for
                            //then populate the internship status by order
                            //if the status action is 2 then populate the appropriate action? - accept decline (might need to count the status :<)
                            //otherwise it is -
                            User User = (User) session.getAttribute("User");
                            String email = User.getUserEmail();

                            ArrayList<String> continentList = InternshipStudentDAO.getContinentsByUser(email);
                            
                            SimpleDateFormat fromDB = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            SimpleDateFormat myFormat = new SimpleDateFormat("dd MMMM yyyy , HH:mm a");

                        %>

                        <table class="alt align-center" style="font-size:14px;">
                            <thead>
                                <tr>
                                    <th class="align-center">Continent</th>
                                    <th class="align-center">Status</th>
                                    <th class="align-center">Follow Up</th>
                                    <th class="align-center">Date and Time</th>
                                    <th class="align-center">Action</th>
                                    <th class="align-center">Info</th>
                                </tr>                           
                            </thead>
                            <tbody>
                                <%                               
                                    for (int i = 0; i < continentList.size(); i++) {
                                        
                                        String continent = continentList.get(i);
                                        
                                        ArrayList<String> internshipStatusList = InternshipStudentDAO.getInternshipStatusByContinent(email, continent);
                                        int statusCount = internshipStatusList.size();
                                        String status = internshipStatusList.get(statusCount - 3);
                                        String[] statusCurrentPending = status.split("\\s*-\\s*");
                                        String currentStatus = statusCurrentPending[0];
                                        String pendingStatus = statusCurrentPending[1];
                                        String statusDate = internshipStatusList.get(statusCount - 2);
                                        String statusAction = internshipStatusList.get(statusCount - 1);

                                        //format the statusDate
                                        String reformattedDate = myFormat.format(fromDB.parse(statusDate));
                                %>

                                <tr>
                                    <td class="align-center"><%out.print(continent);%></td>
                                    <td class="align-center"><%out.print(currentStatus);%></td>
                                    <td class="align-center"><%out.print(pendingStatus);%></td>
                                    <td class="align-center"><%out.print(reformattedDate);%></td>
                                    <%
                                        if (statusAction.equals("2")) {
                                    %>
                                    <td class="align-center"><a href="#" class="button">Accept</a></td>
                                    <%
                                    } else{
                                    %> 
                                    <td class="align-center">-</td>
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
            for (int y = 0; y < continentList.size(); y++) {
                String continent = continentList.get(y); 
        %>
        <div class="modal fade" id="myModal<%out.print(y);%>" role="dialog" style="top:15%;">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title align-center">Information on internship to <b><%out.print(continent);%></b></h4>
                    </div>
                    <div class="modal-body">
                        <%
                            int internshipStudentID = InternshipStudentDAO.getInternshipStudentIDforAcceptedTrips(email, continent);
                          
                            if(internshipStudentID != 0){
                                int internshipID = InternshipAssignedDAO.getInternshipIDbyInternshipStudentID(internshipStudentID);
                                if(internshipID != 0){
                                    Internship internship = InternshipDAO.getInternshipByID(internshipID);
                                    SimpleDateFormat myFormat1 = new SimpleDateFormat("dd MMMM yyyy");
                                    DecimalFormat df2 = new DecimalFormat("#.00");

                                    if(internship != null){
                        %>
                        <div class ="row">
                            <div class="12u 12u(xsmall)">
                                <h2 class="align-center">Internship Details</h2>
                                <table style="font-size:14px;">
                                    <tbody>
                                        <tr>
                                            <td>Job Title:</td>
                                            <td><%out.print(internship.getInternshipName());%></td>
                                        </tr>
                                        <tr>
                                            <td>Field of Study:</td>
                                            <td><%out.print(internship.getInternshipFieldOfStudy());%></td>
                                        </tr>
                                        <tr>
                                            <td>Description:</td>
                                            <td><%out.print(internship.getInternshipDescription());%></td>
                                        </tr>
                                        <tr>
                                            <td>Start Date:</td>
                                            <td><%out.print(myFormat1.format(internship.getInternshipStart()));%></td>
                                        </tr>
                                        <tr>
                                            <td>End Date:</td>
                                            <td><%out.print(myFormat1.format(internship.getInternshipEnd()));%></td>
                                        </tr>
                                        <tr>
                                            <td>Monthly Salary:</td>
                                            <td>$ <%out.print(df2.format(internship.getInternshipPay()));%></td>
                                        </tr>
                                        <tr>
                                            <td> Supervisor:</td>
                                            <td><%out.print(internship.getInternshipSupervisor());%> (<%out.print(internship.getInternshipSupervisorEmail());%>)</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>                
                        <%
                        }}}
                        %>
                        
                        <div class ="row">
                            <div class="12u 12u(xsmall)">
                                <h2 class="align-center">Status History</h2>
                                <table style="font-size:14px;" class="alt">
                                    <thead>
                                        <tr>
                                            <th class="align-center">Status</th>
                                            <th class="align-center">Follow up</th>
                                            <th class="align-center">Date and Time</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                        ArrayList<String> internshipStatusList = InternshipStudentDAO.getInternshipStatusByContinent(email, continent);
                                        for(int x=0; x < internshipStatusList.size(); x++){
                                            
                                            String status = internshipStatusList.get(x);
                                            String[] statusCurrentPending = status.split("\\s*-\\s*");
                                            String currentStatus = statusCurrentPending[0];
                                            String pendingStatus = statusCurrentPending[1];
                                            x++;
                                            String statusDate = internshipStatusList.get(x);
                                            x++;

                                            //format the statusDate
                                            String reformattedDate = myFormat.format(fromDB.parse(statusDate));
                                        %>
                                      
                                        <tr>
                                            <td class="align-center"><%out.print(currentStatus);%></td>
                                            <td class="align-center"><%out.print(pendingStatus);%></td>
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
