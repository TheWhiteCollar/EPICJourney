
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
                    String tripIDS = request.getParameter("tripId");
                    int tripID = Integer.parseInt(tripIDS);
                    String type = request.getParameter("type");
                %>
                <h3><b>Choose your payment options :</b></h3>

                <a href="paymentCheque.jsp?tripId=<%out.print(tripID);%>&type=<%out.print(type);%>" class="button">Cheque</a>
                <a href="paymentBankTransfer.jsp?tripId=<%out.print(tripID);%>&type=<%out.print(type);%>" class="button">Bank Transfer</a>
                <a href="paymentPayNow.jsp?tripId=<%out.print(tripID);%>&type=<%out.print(type);%>" class="button">PayNow</a>
            </div>
        </section>
    </body>
</html>
