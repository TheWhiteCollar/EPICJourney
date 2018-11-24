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
        <title>Epic Journey - Terms and Conditions</title>
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
            <div class = "container">
                <div class = "container">

                    <%
                        String ErrorMsg = (String) request.getAttribute("ErrorMsg");
                        if (ErrorMsg != null) {
                            out.println(ErrorMsg);
                        }
                    %>
        <h2 class="align-center">Terms and Conditions</h2>   
       
        <h3 class = "align-center">(Internship Application Fees)</h3>
     
        <table style="font-size:14px;">
            <tbody>
                <tr>
                    <td><b>Administration Fee</b></td>
                    <td><b>S$1500</b></td>
                </tr>
                <tr>
                    <td><b>Individual career counselling inclusive of resume writing</b></td>
                    <td><b>S$500</b></td>
                </tr>
                <tr>
                    <td><i>Compulsory for First time registrant  and Optional for subsequent application within the calendar year</i></td>
                </tr>
                <tr>
                    <td><b>Total Programme Fee *</b></td> 
                    <td><b>S$2000</b></td>
                </tr>
            </tbody>
        </table>        
        <br>
        <h1><b>Administration fee indicated above includes the following services:</b></h1>
        <table style="font-size:14px;">
            <tbody>
                <tr>
                    <td><b>1. 24/7 emergency support at destination</b></td>
                </tr>
                <tr>
                    <td><b>2. Welcome package including written guide and internship countries information</b></td>
                </tr>
                <tr>
                    <td><b>3. Visa assistance (where required</b></td>
                </tr>
                <tr>
                    <td><b>4. Academic credit assistance (where applicable or required</b></td> 
                </tr>
                <tr>
                    <td><b>5. Subsidy application assistance (where applicable or required)</b></td> 
                </tr>
                <tr>
                    <td><i>The final programme will be customized based on the core business activities of the hosting companies, the skills/knowledge and career interest of the students and other parameters unique to the internship programme.</i></td>
                </tr>
                <tr>
                    <td><i>*The fees do not include airfare, insurance, food and lodge, which can be arranged by EPIC as additional services and at cost charged by 3rd parties. The fees may defer for different countries/ length of internship/ paid or unpaid internship placements. EPIC has the final discretion to make adjustment to the fees or promotional discount applicable.</i></td>
                </tr>
                <tr>
                    <td><i>Please<a href="termsandconditions.jsp#footer"> contact us</a> for more details on internship fees applicable.</i></td> 
                </tr>
            </tbody>
        </table>                 
        <br>
        <h1><b>Internship Periods (min 6 weeks to maximum period allowed subject to visa approval:</b></h1>
        <table style="font-size:14px;">
            <thead>
                <tr>
                    <th><b>Semester</b></th>
                    <th><b>Registration Deadline</b></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><b>Spring (Jan – Jun)</b></td>
                    <td><b>Opens 1 August of calendar year before internship<br>Closes 31 October of calendar year before internship</b></td>
                </tr>
                <tr>
                    <td><b>Summer (May – Aug)</b></td>
                    <td><b>Opens 1 December of calendar year before internship<br>Closes 28 Feb of the year of internship</b></td>
                </tr>
                <tr>
                    <td><b>Winter (Jun – Dec)</b></td>
                    <td><b>Opens 1 January of the year of internship<br>Closes 31 March of the year of internship</b></td>
                </tr>
            </tbody>
        </table>
        <br>
        <p><i><b>*Service Partners are required to agree with terms and conditions before signing up</b></i></p>
        <p class="align-center"><a href="signuppagepartner.jsp" class="button big">Partner with us now</a></p>
        
        </section>
      
        <!-- Footer -->
        <jsp:include page="footer.jsp" />
    </body>    
</html>
