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
                <h2 class="align-center">Manage Internship Countries</h2>

                <table>
                    <tbody>
                        <tr>
                            <td class="align-right">Add:</td>
                            <td>
                                <button type="button" class="button" data-toggle="modal" data-target="#myModalAdd">Add a new internship country</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">View / Delete</td>
                            <td>
                                <a href="AdminPortal_manageInternshipAmerica.jsp" class="button">America</a> 
                                <a href="AdminPortal_manageInternshipAsia.jsp" class="button">Asia</a> 
                                <a href="AdminPortal_manageInternshipAustralia.jsp" class="button">Australia</a> 
                                <a href="AdminPortal_manageInternshipEurope.jsp" class="button">Europe</a> 
                            </td>
                        </tr>
                    </tbody>
                </table>
                
        </section>
    
        <div class="modal fade" id="myModalAdd" role="dialog" style="top:20%;">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title align-center"><b>New internship country details</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="12u 12u">
                                <form action="addCountryInternship" method="post">
                                    <table>
                                        <tr>
                                            <td class="align-right">Country:</td>
                                            <td><input type="text" name="country" placeholder="Enter country name"></td>
                                        </tr>
                                        <tr>
                                            <td class="align-right">Continent:</td>
                                            <td>
                                                <select name="continent">
                                                    <option value="America">America</option>
                                                    <option value="Asia">Asia</option>
                                                    <option value="Australia">Australia</option>
                                                    <option value="Europe">Europe</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="align-right"><input type="submit" value="Add new country"></td>
                                        </tr>
                                    </table>
                                    
                                </form>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="button" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>