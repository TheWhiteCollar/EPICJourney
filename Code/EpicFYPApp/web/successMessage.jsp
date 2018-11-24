<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Under Construction Page</title>
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
    <body class = "landing">

        <!-- Header -->        
        <jsp:include page="header.jsp" />

        <!-- Main -->
        <section id="banner">

            <%
                String message = request.getParameter("message");
            if(message.equals("signup")){
            %>
            <h2>You have successfully created an account!</h2>
            <p>Please confirm your account via email</p>
            
            <%
            } else if(message.equals("updateprofile")){
            %>
            <h2>You have successfully updated your account information!</h2>
            <%
            }
            %>
            <ul class="actions">
                <li>      
                    <a href="studyTrip.jsp" class="button big"><font color="white">Join a study trip</font></a>
                    <a href="internship.jsp" class="button big"><font color="white">Join an internship</font></a>
                </li>
            </ul>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

    </body>
</html>