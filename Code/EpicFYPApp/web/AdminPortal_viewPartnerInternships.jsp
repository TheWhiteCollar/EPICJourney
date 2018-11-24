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
        <title>Epic Journey - Admin View Partner internship applications</title>
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

        <jsp:include page="AdminPortalPermission.jsp" />

        <section id="main" class="wrapper">
            <div class="container">
                <h2 class="align-center">Partner Internship Applications</h2>


                <div class="row">
                    <div class="12u 12u(xsmall)">
                        <%
                            ArrayList<Internship> internshipList = InternshipDAO.getAllInternships();
                            int counta = 0;
                            if (internshipList.isEmpty()) {
                        %>
                        <p class="align-center">No partner has posted any internships :(</p>
                        <%
                        } else {
                        %>
                        <table class="alt align-center" style="font-size:14px;">
                            <thead>
                                <tr>
                                    <th class="align-center">#</th>
                                    <th class="align-center">Partner Company</th>
                                    <th class="align-center">Job Title</th>
                                    <th class="align-center">Field of Study</th>
                                    <th class="align-center">Country</th>
                                    <th class="align-center">Vacancy</th>
                                    <th class="align-center">Info</th>
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
                                    <td><%out.print(company.getCompanyName());%></td>
                                    <td><%out.print(internship.getInternshipName());%></td>
                                    <td><%out.print(internship.getInternshipFieldOfStudy());%></td>
                                    <td><%out.print(company.getCompanyCountry());%></td>
                                    <td><%out.print(internship.getInternshipVacancy());%></td>
                                    <td><button type="button" class="button" data-toggle="modal" data-target="#myModal<%out.print(i);%>">View</button></td>
                                    <td>
                                        <form action="deletePartnerInternship" method="post">
                                            <input type="hidden" name="internshipID" value="<%out.print(internship.getInternshipID());%>">
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
                            }
                        %>
                    </div>

                </div>
            </div>


            <%
                SimpleDateFormat fromDB = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat myFormat = new SimpleDateFormat("dd MMMM yyyy , HH:mm a");
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
                DecimalFormat df2 = new DecimalFormat("#.00");
                if (!internshipList.isEmpty()) {
                    for (int x = 0; x < internshipList.size(); x++) {
                        Internship internship = internshipList.get(x);
                        Company company = CompanyDAO.getCompanyByID(internship.getInternshipPartnerID());
                        
                        String dateTime = internship.getInternshipDatetime(); 
                        String reformattedStr1 = myFormat.format(fromDB.parse(dateTime));
            %>
            <div class="modal fade" id="myModal<%out.print(x);%>" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title align-center"><b><%out.print(company.getCompanyName()); %></b> internship application for <b><%out.print(internship.getInternshipName());%></b></h4>
                        </div>
                        <div class="modal-body">           
                            
                                <table style="font-size:14px;">
                                    <tbody>
                                        <tr>
                                            <td class="align-right"><b>Company:</b></td>
                                            <td><%out.print(company.getCompanyName()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Country (State):</b></td>
                                            <td><%out.print(company.getCompanyCountry()); %> (<%out.print(company.getCompanyState()); %>)</td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Position:</b></td>
                                            <td><%out.print(internship.getInternshipName()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Time Period:</b></td>
                                            <td><%out.print(dateFormat.format(internship.getInternshipStart())); %> <b>to</b> <%out.print(dateFormat.format(internship.getInternshipEnd())); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Salary:</b></td>
                                            <td>$ <%out.print(df2.format(internship.getInternshipPay())); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Vacancy:</b></td>
                                            <td><%out.print(internship.getInternshipVacancy()); %> position(s) left</td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Supervisor:</b></td>
                                            <td><%out.print(internship.getInternshipSupervisor()); %> (<%out.print(internship.getInternshipSupervisorEmail()); %>)</td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Field of Study:</b></td>
                                            <td><%out.print(internship.getInternshipFieldOfStudy()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Description:</b></td>
                                            <td><%out.print(internship.getInternshipDescription()); %></td>
                                        </tr>
                                    </tbody>
                                </table>
                           
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="button" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <%
            }}
            %>            

        </section>
    </body>
</html>