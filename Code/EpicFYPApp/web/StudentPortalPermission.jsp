<%-- 
    Document   : StudentPortalPermission
    Created on : 20 Nov, 2018, 8:39:32 AM
    Author     : User
--%>

<%@page import="Model.Entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
            User user = (User) session.getAttribute("User");

            if (user == null || user != user) {
                request.setAttribute("Student_ErrorMsg", "Please login as student to view the page");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        %>
    </body>
</html>
