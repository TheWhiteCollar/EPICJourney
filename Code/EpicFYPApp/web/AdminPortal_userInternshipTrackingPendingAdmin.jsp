
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Dao.InternshipDAO"%>
<%@page import="Model.Entity.Internship"%>
<%@page import="Model.Dao.UserDAO"%>
<%@page import="Model.Entity.User"%>
<%@page import="Model.Entity.InternshipStudent"%>
<%@page import="Model.Dao.InternshipStudentDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Model.Dao.CompanyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Entity.Company"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin View Tracking User internships</title>
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

        <section id="main" class="wrapper">
            <div class="container">
                <h3 class="align-center">Pending Admin Action</h3>
                <div class="align-center">
                    <a href="AdminPortal_userInternshipTrackingConfirmed.jsp" class="button">Confirmed</a>
                    <a href="AdminPortal_userInternshipTrackingPendingUser.jsp" class="button">Pending User Action</a>
                    <a href="#" class="button" style="background-color: #FA9189;">Pending Admin Action</a>
                    <a href="AdminPortal_userInternshipTrackingRejected.jsp" class="button">Rejected</a>
                    <a href="AdminPortal_userInternshipTrackingCancelled.jsp" class="button">Cancelled</a>   
                    <br>
                    <br>
                </div>

                <div class="row">
                    <div class="12u 12u(xsmall)">
                        <%
                            SimpleDateFormat fromDB = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            SimpleDateFormat myFormat = new SimpleDateFormat("dd MMMM yyyy , HH:mm a");

                            ArrayList<InternshipStudent> pendingInternship = InternshipStudentDAO.getAllPendingAdminInternshipStudents();
                            int countpending = 0;
                            if (pendingInternship.isEmpty()) {
                        %>
                        <p class="align-center">There are no pending admin tasks :D</p>
                        <%
                        } else {
                        %>

                        <table class="alt align-center" style="font-size:13px;">
                            <thead>
                                <tr>
                                    <th class="align-center">#</th>
                                    <th class="align-center">Name</th>
                                    <th class="align-center">Status</th>
                                    <th class="align-center">Follow up</th>
                                    <th class="align-center">Date and Time</th>
                                    <th class="align-center">Info</th>
                                    <th class="align-center" colspan="2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = 0; i < pendingInternship.size(); i++) {
                                        InternshipStudent ci = pendingInternship.get(i);
                                        User user = UserDAO.getUser(ci.getInternshipUserEmail());

                                        countpending += 1;

                                        String reformattedStr = myFormat.format(fromDB.parse(ci.getInternshipStudentDatetime()));

                                        String status = ci.getInternshipStudentStatus();
                                        String[] statusCurrentPending = status.split("\\s*-\\s*");
                                        String currentStatus = statusCurrentPending[0];
                                        String pendingStatus = statusCurrentPending[1];
                                %>
                                <tr>
                                    <td><%out.print(countpending);%></td>
                                    <td><%out.print(user.getUserFirstName());%> <%out.print(user.getUserLastName());%></td>
                                    <td><%out.print(currentStatus);%></td>
                                    <td><%out.print(pendingStatus);%></td>
                                    <td><%out.print(reformattedStr);%></td>
                                    <td><button type="button" class="button" data-toggle="modal" data-target="#myModalRejected<%out.print(i);%>">View</button></td>
                                   <%
                                   if(!status.equals("Interview completed - Review interview")){
                                   %>
                                    
                                    <td>
                                        <form action="internshipPendingAdminStatusAccept" method="post">
                                            <input type="hidden" name="userEmail" value="<%out.print(ci.getInternshipUserEmail());%>">
                                            <input type="hidden" name="continent" value="<%out.print(ci.getInternshipStudentContinent());%>">
                                            <input type="hidden" name="status" value="<%out.print(status);%>">
                                            <input type="submit" value ="Accept" style="font-size:13px;">
                                        </form>
                                    </td>
                                    <% 
                                     }else{   
                                    %>
                                    <td>
                                        <button type="button" class="button" data-toggle="modal" data-target="#myModal<%out.print(i);%>" style="font-size:13px;">Accept</button>  
                                    </td>
                                    <%
                                      }  if(!(status.equals("Admin approves application - Send email with internship details for interest confirmation") || status.equals("User accepts - Send email to schedule interview"))){
                                    %>
                                    <td>
                                        <form action="internshipPendingAdminStatusReject" method="post">
                                            <input type="hidden" name="userEmail" value="<%out.print(ci.getInternshipUserEmail());%>">
                                            <input type="hidden" name="continent" value="<%out.print(ci.getInternshipStudentContinent());%>">
                                            <input type="hidden" name="status" value="<%out.print(status);%>">
                                            <input type="submit" value ="Reject" style="font-size:13px;">
                                        </form>
                                    </td>
                                    <%
                                    }
                                    %>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <%
                            }
                        %>
                    </div>
                </div>


                <%
                    if (!pendingInternship.isEmpty()) {
                        for (int i = 0; i < pendingInternship.size(); i++) {
                            InternshipStudent ci = pendingInternship.get(i);
                            User user = UserDAO.getUser(ci.getInternshipUserEmail());

                            String userName = user.getUserFirstName() + " " + user.getUserLastName();

                %>
                <div class="modal fade" id="myModalRejected<%out.print(i);%>" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title align-center">Information of <b><%out.print(userName);%></b></h4>
                            </div>
                            <div class="modal-body">
                                
                                    <div class="12u 12u">
                                        <table style="font-size:14px;">
                                            <tbody>
                                                <tr>
                                                    <td class="align-right"><b>Name </b></td>
                                                    <td class="align-left"><% out.print(userName); %></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Email </b></td>
                                                    <td><% out.print(user.getUserEmail()); %></td>
                                                </tr>
                                                <tr>
                                                    <td class="align-right"><b>Phone </b></td>
                                                    <td><% out.print(user.getUserPhone()); %></td>
                                                </tr>
                                                <%
                                                if(user.getUserResume() != null){
                                                %>
                                                <tr>
                                                    <td class="align-right">Resume</td>
                                                    <td><a href="viewResume.jsp?userEmail=<%out.println(user.getUserEmail());%>" class="button">View Resume</a></td>
                                                </tr>
                                                <%
                                                }
                                                %>
                                            </tbody>
                                        </table> 
                                    </div>                             
                              

                                    <h3 class="align-center"><b>Status History</b></h3>
                                    <table class="alt align-center" style="font-size:14px;">
                                        <thead>
                                            <tr>
                                                <th class="align-center">Status</th>
                                                <th class="align-center">Follow up</th>
                                                <th class="align-center">Date and Time</th>
                                            </tr>
                                        </thead> 
                                        <tbody>
                                                            <%
                                        ArrayList<String> internshipStatusList = InternshipStudentDAO.getInternshipStatusByContinent(ci.getInternshipUserEmail(), ci.getInternshipStudentContinent());
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
                <%
                    if (!pendingInternship.isEmpty()) {
                        for (int i = 0; i < pendingInternship.size(); i++) {
                            InternshipStudent ci = pendingInternship.get(i);
                            User user = UserDAO.getUser(ci.getInternshipUserEmail());

                            String userName = user.getUserFirstName() + " " + user.getUserLastName();
                %>
                <div class="modal fade" id="myModal<%out.print(i);%>" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title align-center"><b>Internship Assignment</b></h4>
                            </div>
                            <div class="modal-body">
                               
                                <form action="assignedInternshipToUser" method="post">
                                    <table class="align-center">
                                        <tr>
                                            <td> Select the internship for <%out.print(userName);%>:</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <select name="internshipID">
                                                    <%
                                                        ArrayList<Internship> internshipList = InternshipDAO.getAllVacantInternships();
                                                        for(int x=0; x < internshipList.size(); x++){
                                                            Internship internship = internshipList.get(x);
                                                    %>
                                                    <option value="<%out.print(internship.getInternshipID());%>"><%out.print(internship.getInternshipName());%> - <%out.print(internship.getInternshipFieldOfStudy());%></option>
                                                    <%
                                                      }  
                                                    %>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="hidden" name="userEmail" value="<%out.print(ci.getInternshipUserEmail());%>">
                                                <input type="hidden" name="continent" value="<%out.print(ci.getInternshipStudentContinent());%>">
                                                <input type="submit" value ="Assign internship" style="font-size:13px;">
                                                
                                            </td>
                                        </tr>
                                    </table>
                                    
                                </form>
                                
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