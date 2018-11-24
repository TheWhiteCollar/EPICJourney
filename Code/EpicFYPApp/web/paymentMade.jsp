
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Payment</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/jquery.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>

        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript> 

    </head>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Details -->
        <section id="main" class="wrapper">
            <div class="container align-center">
                    <%
                    String paymentId = request.getParameter("paymentId");                   
                    %>
                    <div class="row">
                        <div class="3u 12u(xsmall)">
                            <img src="images/success.png" height=auto width="100%"> 
                        </div>
                        <div class="9u 12u(xsmall) align-center">
                            <p></p>
                            <h4><b>[ Payment ID : <%out.print(paymentId);%> ]</b> Your application will be reviewed soon</h4>
                            <p class="align-left">
                                Thank you for choosing EPIC. An email will be sent to you once your payment is successfully received.
                                If you have any queries, please contact: <a href="mailto:isabelle@epicjourney.sg?Subject=Problems%20with%20deposit%20payment">isabelle@epicjourney.sg</a>
                            </p>
                        </div>
                        
                    </div>
                
                <a href="index.jsp" class="button">Back to Home</a>
            </div>
        </section>
    </body>
</html>
