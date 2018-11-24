
<%@page import="Model.Entity.User"%>

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
    </head>

    <body>
        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Main -->
        <section id="login" class="wrapper">
            <div class="container">
                <header class="major">
                    <h2>Reset your password</h2>
                </header> 

                <% // To retrieve error message
                    String ErrorMsg = (String) request.getAttribute("ErrorMsg");
                    if (ErrorMsg != null) {
                        out.println(ErrorMsg);
                    }
                %>

                <form action="forgetPasswordServlet" method="post">
                    Enter your email address:<br>
                    <input type="text" name="email" placeholder="xxx@gmail.com">
                    <br>
                    <input type="submit" value="Click here to reset your password">
                </form>


                <% // to retrieve reset password message 
                    String PasswordSent = (String) request.getAttribute("PasswordSent");
                    if (PasswordSent != null) {
                        out.println("<h1>" + PasswordSent + "</h1>");
                    }
                %>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />
    </body>
</html> 
