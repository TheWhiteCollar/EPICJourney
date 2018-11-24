
<%@page import="Model.Entity.User"%>
<%@page import="Model.Dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Resume</title>
    </head>
    <body>
        
        <%
            String email = request.getParameter("userEmail");
            User u = UserDAO.getUser(email);
            Blob file = u.getUserResume();
            byte[ ] fileData = file.getBytes(1,(int)file.length());

            response.setContentType("application/pdf"); 
            response.setHeader("Content-Disposition", "inline");
            response.setContentLength(fileData.length);
            OutputStream output = response.getOutputStream();
            output.write(fileData);
            output.flush();
        %>
    </body>
</html>
