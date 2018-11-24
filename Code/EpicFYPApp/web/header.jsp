<%@page import="Model.Entity.Company"%>
<%@page import="Model.Entity.Admin"%>
<%@page import="Model.Entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Header</title>
    </head>
    <body>
        <header id="header">
            <a href="index.jsp"><img src="images/icon.png" srcset="images/icon.png 1000w, images/icon.png 2000w" alt="Epic Journey"></a>

            <nav id="nav">
                <ul>
                    <%
                        User User = (User) session.getAttribute("User");
                        Admin admin = (Admin) session.getAttribute("Admin");
                        Company company = (Company) session.getAttribute("Company");
                        
                        if (User != null) {
                            String Username = User.getUserFirstName();
                            if (Username != null && !Username.isEmpty()) {
                    %>
                    <li><a href="aboutUs.jsp">About Us</a></li>
                    <li><a href="studyTrip.jsp">Overseas Study Trips</a></li>
                    <li><a href="internship.jsp">Overseas Internships</a></li>						                   
                    <li><a href="partnerWithUs.jsp">Partner With Us</a>
                    <li><a href="studentPortal_main.jsp">Hello, <% out.println(Username); %></a>
                        <ul>
                            <li><a href="studentPortal_profile.jsp">Profile</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>

                    </li>
                    
                    <%
                        }
                    } else if (company != null) {
                        String Username = company.getCompanyName();
                        if (Username != null && !Username.isEmpty()) {
                    %>
                    <li><a href="PartnerPortal_internships.jsp">Manage Internship</a>
                        <ul>
                            <li><a href="PartnerPortal_addInternship.jsp">Add New Internship</a></li>
                        </ul>
                    </li>
                    <li><a href="termsandconditions.jsp">Terms & Conditions</a>
                    <li><a href="PartnerPortal_internships.jsp">Hello, <% out.println(Username); %></a>
                        <ul>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                    
                    <%
                        }
                    } else if (admin != null) {
                        String Username = admin.getAdminName();
                        if (Username != null && !Username.isEmpty()) {
                    %>

                
                    <li><a href="AdminPortal_trips.jsp">Manage Trips</a>
                        <ul>
                            <li><a href="AdminPortal_userTripTracking.jsp">User Trip Applications</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Manage Internships</a>
                        <ul>
                            <li><a href="AdminPortal_viewPartnerInternships.jsp">Partner Applications</a></li>
                            <li><a href="AdminPortal_userInternshipTrackingPendingAdmin.jsp">User Applications</a></li>
                            <li><a href="AdminPortal_manageInternshipCountries.jsp">Manage Countries</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Manage Users</a>                       
                        <ul>
                            <li><a href="AdminPortal_viewStudentProfile.jsp">View Students</a></li>
                            <li><a href="AdminPortal_viewPartnerProfile.jsp">View Partners</a></li>
                            <li><a href="AdminPortal_viewAdminProfile.jsp">View Admins</a></li>
                            <li><a href="AdminPortal_detailedStudentInfo.jsp">Detailed Info</a></li>
                        </ul>
                        
                    </li>
                    <li><a href="AdminPortal_bootstrap.jsp">Bulk Uploading</a></li>
                    <li><a href="index_admin.jsp">Hello, <% out.println(Username); %></a>
                        <ul>

                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                    <%
                        }

                    } else {
                    %>
                    <li><a href="aboutUs.jsp">About Us</a></li>
                    <li><a href="studyTrip.jsp">Overseas Study Trips</a></li>
                    <li><a href="internship.jsp">Overseas Internships</a></li>						                   
                    <li><a href="partnerWithUs.jsp">Partner With Us</a>
                    <li><a href="login.jsp">Log In</a></li>    
                        <%
                            }
                        %>

                </ul>
            </nav>
        </header>
    </body>
</html>
