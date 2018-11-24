<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    /*
    Things undone:
    - Edit button
    - neaten up the javascript files
     */
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin Bulk Uploading</title>
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
        
        <jsp:include page="AdminPortalPermission.jsp" />

        <!-- Main -->
        <section id="main" class="wrapper">

            <div class="container">

                <header class="major">
                    <h2>Bulk uploads</h2>
                    <p>Upload .xlsx or .csv files for bulk updates to database</p> <br>
                    <a href="documents/user_blank.csv" download="User Template File">Download user file format here</a> <br>
                     <a href="documents/trip_blank.csv" download="Trip Template File">Download trip file format here</a> <br>
                     <a href="documents/tripstudent_blank.csv" download="Student applied to Trip Template File">Download tripstudent file format here</a> <br>
                </header> 

                <p style="text-align:center; color: red">
                    <%
                        String Success_Message = (String) request.getAttribute("Success_Msg");
                        if (Success_Message != null) {
                            out.println(Success_Message);
                        }
                    %>
                </p>
                <div class ="align-center">
                    <form action="AdminBootstrapServlet" method="post" enctype="multipart/form-data">
                        
                        <input type="file" name="updateTrips" id="updateTrips" class="inputfile inputfile-1" style="display:none"  accept=".xlsx, .csv"/>
                        <label for="updateTrips"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> 
                            <span>Update Trips</span>
                        </label> 
                        
                        <input type="file" name="updateUsers" id="updateUsers" class="inputfile inputfile-1" style="display:none" accept=".xlsx, .csv"/>
                        <label for="updateUsers"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> 
                            <span>Update Users</span>
                        </label> 

                        <input type="file" name="updateTripsUsersSignedUpFor" id="updateTripsUsersSignedUpFor" class="inputfile inputfile-1" style="display:none" accept=".xlsx, .csv"/>
                        <label for="updateTripsUsersSignedUpFor"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> 
                            <span>Update trips users signed up for</span>
                        </label> 
                        
                        <div class="12u">
                            <br/>
                            <ul class="actions">
                                <li><input type="submit" value="Submit" class="special" /></li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        
    </body>
    <script src="js/custom-file-input.js"></script>
</html>