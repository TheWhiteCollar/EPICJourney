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
        <style>
            .red { 
                color: #ff99bb; 
                font-style: oblique;
                font-weight:500;
            }
        </style>
    </head>
    <body class="landing">

        <!-- Header -->
        <jsp:include page="header.jsp" />

        <!-- Banner -->
        <section id="banner">

            <h2>Life is one <span class="red bold">Epic Journey</span></h2>
            <p>And you are in the driver's seat</p>
            <ul class="actions">
                <li>
                    <%
                        User User = (User) session.getAttribute("User");
                        if (User != null) {
                    %>
                    <a href="studyTrip.jsp" class="button big"><font color="white">Join a study trip</font></a>
                    <a href="internship.jsp" class="button big"><font color="white">Join an internship</font></a>
                        <%
                        } else {
                        %>
                    <a href="login.jsp" class="button big"><font color="white">Take charge of your life now</font></a>
                        <%
                            }
                        %>
                </li>
            </ul>

        </section>

        <!-- One -->
        <section id="one" class="wrapper style2 align-center">
            <div class="container">
                <header>
                    <h2>Why Us</h2>
                    <p>Here are Epic Journey, we provide customised training programmes to develop entrepreneurship and build character to help youths excel in the Emerging Economy around ASEAN</p>
                </header>
                <div class="row 200%">
                    <section class="4u 12u(small)">
                        <i class="icon big rounded fa-cogs"></i>
                        <p>Strong training curriculum combined with carefully selected training tools and products (e.g: inclusion of Design Thinking and Emotional/cultural training)</p>
                    </section>
                    <section class="4u 12u(small)">
                        <i class="icon big rounded fa-lightbulb-o"></i>
                        <p>Provide a platform for youths to validate their business ideas through immersion and collaboration with the local businesses. Faciliating the ideation and prototyping of new business possibilities</p>
                    </section>
                    <section class="4u 12u(small)">
                        <i class="icon big rounded fa-star"></i>
                        <p>Mentorship and guidance in key business areas. Site-visits and cultural business networking to learn about the real life issues faced by locals</p>
                    </section>
                </div>
            </div>
        </section>



        <!-- Two -->
        <section id="two" class="wrapper style2 align-center">
            <div class="container">
                <header>
                    <h2>Overseas Study Trips</h2>
                    <p>We lead young adults on trips to explore the potential of emerging markets</p>
                </header>
                <div class="row">
                    <section class="feature 6u 12u(small)">
                        <img class="image fit" src="images/pic01.jpg" alt="" />
                        <h3 class="title">Myanmar (Yangon/Mandalay)</h3>
                        <p>A social enterpreunear trip customized for 18 – 25 years old (undergraduate/poly students) looking for experience in Myanmar, or young aspiring entrepreneurs looking to validate business ideas in Myanmar</p>
                    </section>
                    <section class="feature 6u 12u(small)">
                        <img class="image fit" src="images/pic02.jpg" alt="" />
                        <h3 class="title">Esse, fugiat, in</h3>
                        <p>Natus perspiciatis fugit illum porro iusto fuga nam voluptas minima voluptates deserunt, veniam reiciendis harum repellat necessitatibus. Animi, adipisci qui. Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                    </section>
                    <section class="feature 6u 12u(small)">
                        <img class="image fit" src="images/pic03.jpg" alt="" />
                        <h3 class="title">Voluptates, repudiandae, dolor</h3>
                        <p>Voluptatibus repellendus tempora, quia! Consequuntur atque, rerum quis, ullam labore officiis ipsa beatae dolore, assumenda eos harum repudiandae, qui ab! Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                    </section>
                    <section class="feature 6u 12u(small)">
                        <img class="image fit" src="images/pic04.jpg" alt="" />
                        <h3 class="title">Eveniet, reiciendis, veniam</h3>
                        <p>Rem nulla molestiae inventore quibusdam repudiandae doloremque eveniet ullam, qui autem possimus saepe laudantium numquam sapiente vel. Repudiandae, nihil tempore. Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                    </section>
                </div>
                <footer>
                    <ul class="actions">
                        <li>
                            <a href="studyTrip.jsp" class="button alt big">Check out our Study Trips</a>
                        </li>
                    </ul>
                </footer>
            </div>
        </section>

        <!-- Three -->
        <section id="three" class="wrapper style2 align-center">
            <div class="container">
                <header>
                    <h2>3 simple steps to start your Epic Journey</h2>
                </header>
                <div class="row 200%">
                    <section class="4u 12u(small)">
<!--try to link the word or icon-->
                        <a href="signuppage.jsp"><i class="icon big rounded fa-heart" style="font-size:60px;color:#55504F"></i></a>
                        <p>Create an account with us, and let us know your interests!</p>
                    </section>
                    <section class="4u 12u(small)">
                        <a href="studyTrip.jsp"><i class="icon big rounded fa-search" style="font-size:60px;color:#55504F"></i></a>
                        <p>Look for overseas study trips</p>
                    </section>
                    <section class="4u 12u(small)">
                        <a href="internship.jsp"><i class="icon big rounded fa-file-o" style="font-size:60px;color:#55504F"></i></a>
                        <p>Look for overseas internships</p>
                    </section>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

    </body>
</html>
