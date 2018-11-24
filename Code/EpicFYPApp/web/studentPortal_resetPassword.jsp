
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

        <!-- For user to choose if they want to login as student or admin -->


    </head>
    <body class="landing">

        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Main -->
        <section id="banner" class="wrapper">
            <div class="container">
                <div align="center">
                    <div style="width:300px">


                        <p style="text-align:center; color: red">

                            <%
                                String userEmail = (String) request.getParameter("userEmail");
                            %>
                        </p>

                        <form action="resetPassword" method="post">
                            Please enter your new password: <br><br>
                            <input type="password" name="userpassword" placeholder="- Enter Password -" class="align-center">
                            <br>
                            <%
                        // if user come from study trip, pass a hidden value of studyTrip to login servlet, so will send back to studyTrip instead of student portal	
                        if (userEmail != null) { %>	
                            <input type="hidden" name="userEmail" value="<%out.print(userEmail);%>">	
                            <%
                        }
                            %>
                            <input type="submit" value="Reset" class ="full_width">
                        </form> 
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

        <!-- For user to choose if they want to login as student or admin -->
        <script src="js/tabs.js"></script>
    </body>
</html>
