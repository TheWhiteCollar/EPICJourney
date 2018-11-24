<%@page import="java.time.LocalDate"%>
<%@page import="Model.Dao.CompanyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Entity.Company"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Epic Journey - Admin View Partner Profile</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="Imparting life skills through overseas exposure via internships and study missions. Countries of focus: Cambodia, Laos, Myanmar, Vietnam, India, Indonesia, Thailand, Japan and China." />
        <meta name="keywords" content="overseas, study missions, internships, training, life skills, career exposure" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
        
        <jsp:include page="AdminPortalPermission.jsp" />

        <section class="wrapper">
            <div class="container" >
                
                <h2 class="align-center">Partners' Profiles</h2>
                <table class="alt">
                    <thead>
                        <tr>
                            <th class="align-center">#</th>
                            <th>Partner Name</th>
                            <th>Country</th>
                            <th class="align-center">State</th>
                            <th class="align-center">More information</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Company> allPartners = CompanyDAO.getAllCompanies();
                            int count = 0;
                            if (!allPartners.isEmpty()) {
                                for (int i = 0; i < allPartners.size(); i++) {
                                    Company p = allPartners.get(i);
                                    count += 1;
                        %>
                        <tr>
                            <td class="align-center"><%out.print(count);%></td>
                            <td><% out.print(p.getCompanyName()); %></td>                      
                            <td><% out.print(p.getCompanyCountry()); %></td>
                            <td class="align-center"><% out.print(p.getCompanyState()); %></td>
                            <td class="align-center"><button type="button" class="button" data-toggle="modal" data-target="#myModal<%out.print(i);%>">View</button></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>    
                </table>

                <%
                    if (!allPartners.isEmpty()) {
                        for (int i = 0; i < allPartners.size(); i++) {
                            Company p = allPartners.get(i);

                %>
                <div class="modal fade" id="myModal<%out.print(i);%>" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title align-center"><b><%out.print(p.getCompanyName()); %></b></h4>
                            </div>
                            <div class="modal-body">                         
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="align-right"><b>Country: </b></td>
                                            <td><%out.print(p.getCompanyCountry()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>State: </b></td>
                                            <td><%out.print(p.getCompanyState()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Description: </b></td>
                                            <td><% out.print(p.getCompanyDescription()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Email: </b></td>
                                            <td><% out.print(p.getCompanyEmail()); %></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right"><b>Contact No: </b></td>
                                            <td><% out.print(p.getCompanyContact()); %></td>
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
                        }
                    }
                %>

            </div>
        </section>
    </body>
</html>