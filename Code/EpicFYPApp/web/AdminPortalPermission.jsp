<%-- 
    Document   : AdminPortalPermission
    Created on : 20 Nov, 2018, 8:39:06 AM
    Author     : User
--%>

<%@page import="Model.Entity.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Admin admin = (Admin) session.getAttribute("Admin");

            if (admin == null || admin != admin) {
                request.setAttribute("Admin_ErrorMsg", "Please login as admin to view the page");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        %>


    </body>
</html>
