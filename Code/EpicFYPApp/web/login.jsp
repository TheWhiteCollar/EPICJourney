
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
                                String Student_ErrorMsg = (String) request.getAttribute("Student_ErrorMsg");

                                if (Student_ErrorMsg != null) {
                                    out.print(Student_ErrorMsg);
                                }

                                // to check if user come to login page straight or come from study trip	
                                String comefrom = (String) request.getParameter("comefrom");
                                String cont = (String) request.getParameter("cont");
                            %>
                        </p>

                        <p style="text-align:center; color: red">

                            <%
                                String Admin_ErrorMsg = (String) request.getAttribute("Admin_ErrorMsg");

                                if (Admin_ErrorMsg != null) {
                                    out.print(Admin_ErrorMsg);
                                }
                            %>
                        </p>

                        <p style="text-align:center; color: red">

                            <%
                                String Company_ErrorMsg = (String) request.getAttribute("Company_ErrorMsg");

                                if (Company_ErrorMsg != null) {
                                    out.print(Company_ErrorMsg);
                                }
                            %>
                        </p>

                        <p style="text-align:center; color: lime">

                            <%
                                String successMessage = (String) request.getAttribute("successMessage");
                                if (successMessage != null) {
                                    out.print(successMessage);
                                }
                            %>
                        </p>

                        <form action="LoginServlet_user" method="post">
                            <input type="text" name="userid" placeholder="- Enter User Email -" class="align-center">
                            <br>
                            <input type="password" name="userpassword" placeholder="- Enter User Password -" class="align-center">
                            <br>
                            <%
                                // if user come from study trip, pass a hidden value of studyTrip to login servlet, so will send back to studyTrip instead of student portal	
                                if (comefrom != null) { %>	
                            <input type="hidden" name="comefrom" value="<%out.print(comefrom);%>">	
                            <%
                                }
                                if (cont != null) {
                            %>	
                            <input type="hidden" name="cont" value="<%out.print(cont);%>">	
                            <%
                                }
                            %>
                            <input type="submit" value="Login" class ="full_width">
                        </form> 
                        <p><a href="forgetpassword.jsp" style="color:#ffe6e6; font-size:18px">Forgot your password?</a></p>
                        <p><a href="signuppage.jsp" style="color:#ffe6e6; font-size:18px">Click to sign up as User!</a></p>
                        <p><a href="signuppagepartner.jsp" style="color:#ffe6e6; font-size:18px">Click to sign up as Partner!</a></p>
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
