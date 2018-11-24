<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Entity.Internship"%>
<%@page import="Model.Dao.InternshipDAO"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Model.Dao.CompanyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Entity.Company"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Manage internship applications</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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


        <section id="main" class="wrapper">
            <div class="container">
                <h2 class="align-center">Your Applications</h2>
                
                <div class="row">
                    <div class="12u 12u(xsmall)">
                        <%
                            DecimalFormat df2 = new DecimalFormat("#.00");
                            Company companySession = (Company) session.getAttribute("Company");
                            int currentPartnerID = companySession.getCompanyID();
                            ArrayList<Internship> internshipList = InternshipDAO.getCompanyInternships(currentPartnerID);
                            int counta = 0;
                            if (internshipList.isEmpty()) {
                        %>
                        <p class="align-center">No internship postings</p>
                        <%
                        } else {
                        %>
                        <table class="alt align-center" style="font-size:13px;">
                            <thead>
                                <tr>
                                    <th class="align-center">#</th>
                                    <th class="align-center">Internship Position</th>
                                    <th class="align-center">Salary</th>
                                    <th class="align-center">Field of Study</th>
                                    <th class="align-center">Time Period</th>
                                    <th class="align-center">Vacancy</th>
                                    <th class="align-center">Supervisor</th>
                                    <th class="align-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    
                                    for (int i = 0; i < internshipList.size(); i++) {
                                        Internship internship = internshipList.get(i);
                                        Company company = CompanyDAO.getCompanyByID(internship.getInternshipPartnerID());
                                        counta += 1;
                                %>
                                <tr>
                                    <td class = "align-center"><%out.print(counta);%></td>
                                    <td><%out.print(internship.getInternshipName());%></td>
                                    <td>$ <%out.print(df2.format(internship.getInternshipPay()));%></td>
                                    <td><%out.print(internship.getInternshipFieldOfStudy());%></td>
                                    <td><%out.print(internship.getInternshipStart() + " to " + internship.getInternshipEnd());%></td>
                                    <td><%out.print(internship.getInternshipVacancy());%></td>
                                    <td><%out.print(internship.getInternshipSupervisor());%></td>
                                    
                                    <td>
                                        <form action="deletePartnerInternshipFromPartner" method="post">
                                            <input type="hidden" name="internshipID" value="<%out.print(internship.getInternshipID());%>">
                                            <input type="submit" value ="Delete" style="font-size:13px;">
                                        </form>

                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>