<%@page import="Model.Dao.InternshipStudentDAO"%>
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

        <%
            User User = (User) session.getAttribute("User");
            String email = User.getUserEmail();
            
            ArrayList<Integer> tripList = TripStudentDAO.getTripIDsByUser(email);
            int tripCount = tripList.size();
            ArrayList<String> continentList = InternshipStudentDAO.getContinentsByUser(email);
            int continentCount = continentList.size();
        %>
        <section class="wrapper">
            <div class ="container align-center">              
                <header class="major align-center">
                    <h2>Application Status</h2>
                </header>
        
        
        <%
            if(tripCount == 0){
        %>
                <p>It seems you have not signed up for any trips :/</p>
                <a href="studyTrip.jsp" class="button">Sign up for a study trip today!</a>    
        <%
            } if(continentCount == 0){
        %>
        <br>  
        <br> 
        <p>It seems you have not signed up for any internships :/</p>
                <a href="internship.jsp" class="button">Join an internship today!</a>
        <%
            } if(tripCount != 0){
        %>
                <a href="studentPortal_studyTripStatus.jsp" class="button">Study Trip Status</a>   
        <%
            }if(continentCount != 0){
        %>
            
                <a href="studentPortal_internshipStatus.jsp" class="button">Internship Status</a> 
        <%
            }
        %>
            </div>
        </section>

    </body>
</html>
