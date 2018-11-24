<%@page import="Model.Entity.CountryInternship"%>
<%@page import="Model.Dao.CountryInternshipDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin View Partner internship applications</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap-notify.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-layers.min.js"></script>
        <script src="js/init.js"></script>

        <noscript>
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>

    </head>
    <body>

        <!-- Header -->
        <jsp:include page="header.jsp" />

        <jsp:include page="AdminPortalPermission.jsp" />

        <section id="main" class="wrapper">
            <div class="container">
                <h2 class="align-center">Manage Asia internship countries</h2>
                <div class="align-center">
                    <a href="AdminPortal_manageInternshipAmerica.jsp" class="button">America</a> 
                    <a href="#" class="button" style="background-color: #FA9189;">Asia</a> 
                    <a href="AdminPortal_manageInternshipAustralia.jsp" class="button">Australia</a> 
                    <a href="AdminPortal_manageInternshipEurope.jsp" class="button">Europe</a> 
                </div>

                <div>
                    <div class="row">
                        <div class="12u 12u(xsmall)">
                            <%
                                ArrayList<CountryInternship> allAsiaCountries = CountryInternshipDAO.getAllCountryInternship("Asia");
                                        int countAsia = 0;
                                        if (!allAsiaCountries.isEmpty()) {
                            %>
                            <table class="alt align-center">
                                <thead>
                                    <tr>
                                        <td><b>#</b></td>
                                        <td><b>Country</b></td>
                                        <td><b>Continent</b></td>
                                        <td><b>Action</b></td>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (int i = 0; i < allAsiaCountries.size(); i++) {
                                                CountryInternship ci = allAsiaCountries.get(i);
                                                countAsia += 1;
                                %>
                                    
                                    <tr>
                                        <td class = "align-center"><%out.print(countAsia);%></td>
                                        <td><%out.print(ci.getCountryName());%></td>
                                        <td><%out.print(ci.getCountryContinent());%></td>
                                        <td>
                                            <form action="deleteCountryInternship" method="post">
                                                <input type="hidden" name="countryName" value="<%out.print(ci.getCountryName());%>">
                                                <input type="hidden" name="countryContinent" value="<%out.print(ci.getCountryContinent());%>">
                                                <input type="submit" value ="Delete" style="font-size:14px;">
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                        }

                                    %>

                                </tbody>
                            </table>
                            <%                                    
                            } else {
                            %>
                            <p class="align-center">There is no countries for Asia</p>
                            <% 
                            }
                            %>

                        </div>

                    </div>
                </div>
            </div>
    </body>
</html>