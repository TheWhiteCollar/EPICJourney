

<%@page import="Model.Dao.FieldOfStudyDAO"%>
<%@page import="Model.Dao.InterestDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!DOCTYPE html>

<html lang="en" class="no-js">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Partner Sign Up</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>
        <script>(function (e, t, n) {
                var r = e.querySelectorAll("html")[0];
                r.className = r.className.replace(/(^|\s)no-js(\s|$)/, "$1js$2")
            })(document, window, 0);</script>

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
        <section id="login">
            <div class = "container">
                <div class = "container">

                    <%
                        String ErrorMsg = (String) request.getAttribute("ErrorMsg");
                        if (ErrorMsg != null) {
                            out.println(ErrorMsg);
                        }
                    %>

                    <form id="regForm" action="signuppartnerServlet" method="post">
                        <header class="major">
                            <h2>Sign up with your email</h2>
                        </header> 
                        <!-- One "tab" for each step in the form: -->

                        <div class="signup-tab">

                            By signing up, you agree to the <a href="termsandconditions.jsp" style="color:red; font-size:18px">terms and conditions</a>

                                <h2 class = "align-center">Account Information</h2>
                                <div class="row uniform 50%">
                                    <div class="6u 12u(xsmall)">
                                        <input type ="text" name ="companyName" placeholder ="Company name *"/>
                                    </div>
                                    <div class="6u 12u(xsmall)">
                                        <input type ="number" name ="companyContact" placeholder = "Company contact *"/>
                                    </div>
                                    <div class="12u">
                                        <input type ="text" name ="companyEmail" placeholder ="Company Email*"/>
                                    </div>
                                    <div class="12u">
                                        <input type ="password" name ="companyPassword" placeholder ="Company Password *"/>
                                    </div>
                                </div>
                        </div>

                        <div class="signup-tab">
                            <h2 class = "align-center">Service Partner Information</h2> 
                            <div class="row uniform 50%">              
                                <div class="6u 12u(xsmall)">
                                    <input type ="text" name ="companyContinent" placeholder ="Company Continent*"/>
                                </div>
                                <div class="6u 12u(xsmall)">
                                    <input type ="text" name ="companyCountry" placeholder ="Company Country*"/>                          
                                </div>
                                <div class="12u 12u(xsmall)">
                                    <input type ="text" name ="companyState" placeholder ="Company State*"/>                          
                                </div>
                                </br>
                            </div>
                        </div>    

                        <div class="signup-tab">
                            <h2 class = "align-center">Getting to know your company</h2>
                            <div class ="row">
                                <div class ="12u 12u(xsmall)">
                                    <textarea name="companyDescription" placeholder="Describe your company" rows="6"></textarea>
                                </div>
                            </div>
                        </div>
                        </br>

                        <div style="overflow:auto;">
                            <div style="float:left;">
                                <button type="button" id="prevBtn" class = "button" onclick="nextPrev(-1)">Previous</button>
                            </div>

                            <div style="float:right;">
                                <button type="button" id="nextBtn" class = "button" onclick="nextPrev(1)">Next</button>
                            </div>
                        </div>
                        <!-- Circles which indicates the steps of the form: -->
                        <div style="text-align:center;">
                            <span class="step"></span>
                            <span class="step"></span>
                            <span class="step"></span>
                        </div>
                    </form> 
                </div>

        </section>


        <!-- Footer -->
        <jsp:include page="footer.jsp" />


        <script>
            var currentTab = 0; // Current tab is set to be the first tab (0)
            showTab(currentTab); // Display the crurrent tab

            function showTab(n) {
                // This function will display the specified tab of the form...
                var x = document.getElementsByClassName("signup-tab");
                x[n].style.display = "block";
                //... and fix the Previous/Next buttons:
                if (n == 0) {
                    document.getElementById("prevBtn").style.display = "none";
                } else {
                    document.getElementById("prevBtn").style.display = "inline";
                }
                if (n == (x.length - 1)) {
                    document.getElementById("nextBtn").innerHTML = "Submit";
                } else {
                    document.getElementById("nextBtn").innerHTML = "Next";
                }
                //... and run a function that will display the correct step indicator:
                fixStepIndicator(n)
            }

            function nextPrev(n) {
                // This function will figure out which tab to display
                var x = document.getElementsByClassName("signup-tab");
                // Exit the function if any field in the current tab is invalid:
                if (n == 1 && !validateForm())
                    return false;
                // Hide the current tab:
                x[currentTab].style.display = "none";
                // Increase or decrease the current tab by 1:
                currentTab = currentTab + n;
                // if you have reached the end of the form...
                if (currentTab >= x.length) {
                    // ... the form gets submitted:
                    document.getElementById("regForm").submit();
                    return false;
                }
                // Otherwise, display the correct tab:
                showTab(currentTab);
            }

            function validateForm() {
                // This function deals with validation of the form fields
                var x, y, i, w, valid = true;
                x = document.getElementsByClassName("signup-tab");
                y = x[currentTab].getElementsByTagName("input");
                // A loop that checks every input field in the current tab:
                for (i = 0; i < y.length; i++) {
                    // If a field is empty...
                    if (y[i].value == "") {
                        // add an "invalid" class to the field:
                        y[i].className += " invalid";
                        // and set the current valid status to false
                        valid = false;
                    }
                }
                //this works, but need to think how to pass even if the citizenship is not selected
//                w = x[currentTab].getElementsByTagName("select");
//                // A loop that checks every select field in the current tab:
//                for (i = 0; i < w.length; i++) {
//                    // If a field is empty...
//                    if (w[i].value == "") {
//                        // add an "invalid" class to the field:
//                        w[i].className += " invalid";
//                        // and set the current valid status to false
//                        valid = false;
//                    }
//                }
                // If the valid status is true, mark the step as finished and valid:
                if (valid) {
                    document.getElementsByClassName("step")[currentTab].className += " finish";
                }
                return valid; // return the valid status
            }

            function fixStepIndicator(n) {
                // This function removes the "active" class of all steps...
                var i, x = document.getElementsByClassName("step");
                for (i = 0; i < x.length; i++) {
                    x[i].className = x[i].className.replace(" active", "");
                }
                //... and adds the "active" class on the current step:
                x[n].className += " active";
            }
        </script>
    </body>
</html> 