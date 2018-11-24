<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
        Interphase by TEMPLATED
        templated.co @templatedco
        Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
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
        <section id="main" class="wrapper align-center">
            <div class="container">
                <header class="major">
                    <h2>Overseas Internship</h2>
                    <p>Register, and get matched!</p>
                </header>



                <h3>Pick the continent of your choice</h3>
                <div class="row">

                    <section class="feature 6u 12u(small)">
                        <a href="internshipDetails.jsp?cont=America"><img class="image fit" src="images/pic01.jpg" alt="" /></a>
                        <h3 class="title"><a href="internshipDetails.jsp?cont=America">America</a></h3>
                    </section>
                    <section class="feature 6u 12u(small)">
                        <a href="internshipDetails.jsp?cont=Asia"><img class="image fit" src="images/pic02.jpg" alt="" /></a>
                        <h3 class="title"><a href="internshipDetails.jsp?cont=Asia">Asia</a></h3>
                    </section>
                    <section class="feature 6u 12u(small)">
                        <a href="internshipDetails.jsp?cont=Australia"><img class="image fit" src="images/pic03.jpg" alt="" /></a>
                        <h3 class="title"><a href="internshipDetails.jsp?cont=Australia">Australia</a></h3>
                    </section>
                    <section class="feature 6u 12u(small)">
                        <a href="internshipDetails.jsp?cont=Europe"><img class="image fit" src="images/pic04.jpg" alt="" /></a>
                        <h3 class="title"><a href="internshipDetails.jsp?cont=Europe">Europe</a></h3>
                    </section>


                </div>

            </div>
        </section>
        
        <!-- InternshipAbout -->
        <section id="internshipabout" class="wrapper align-center">
            <div class="container">

                <header class="major">
                    <h2>Our Internship Process</h2>
                    <p>Ever wanted to intern overseas, but the entire process is daunting?</p> 
                    </header>
                    
                <p>Then we have just the thing you need! </p>
                <p>We have partners in these 4 continents looking for interns! 
                    All you need to do is register under your continent of interest, and we will match you accordingly!
                Our internships are highly competitive, and only matched applications will be contacted. </p>
                
                
                
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

    </body>
</html>