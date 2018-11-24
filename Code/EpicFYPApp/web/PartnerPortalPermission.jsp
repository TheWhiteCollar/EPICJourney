<%-- 
    Document   : PartnerPortalPermission
    Created on : 22 Nov, 2018, 4:21:01 PM
    Author     : User
--%>

<%@page import="Model.Entity.Company"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Company company = (Company) session.getAttribute("Company");

            if (company == null || company != company) {
                request.setAttribute("Company_ErrorMsg", "Please login as partner to view the page");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        %>
    </body>
</html>
