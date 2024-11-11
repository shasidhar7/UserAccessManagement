<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Request Access</title>
</head>
<body>

<h2> Welcome Employee </h2>
    
<%
    // Assuming user_id is stored in the session after login
    session = request.getSession();
    Integer userId = (Integer) session.getAttribute("user_id");  // Get user_id from session
    session.setAttribute("user_id", userId); // Ensure userId is not null
%>

<form action="RequestServlet" method="POST">
    <input type="hidden" name="user_id" value="<%= userId %>"> <!-- Hidden field for user_id -->

    <label for="software">Software:</label><br>
    <select name="software_id" id="software" required>
        <% 
            // Get the list of software from the database
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Database connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

                // Query to get all software
                String sql = "SELECT id, name FROM software";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                // Populate the dropdown with software options
                while (rs.next()) {
                    int softwareId = rs.getInt("id");
                    String softwareName = rs.getString("name");
        %>
            <option value="<%= softwareId %>"><%= softwareName %></option>
        <%  
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Close the resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </select><br><br>

    <label for="access_type">Access Type:</label><br>
    <select name="access_type" id="access_type" required>
        <option value="Read">Read</option>
        <option value="Write">Write</option>
        <option value="Admin">Admin</option>
    </select><br><br>

    <label for="reason">Reason for Request:</label><br>
    <textarea name="reason" id="reason" rows="4" cols="50" required></textarea><br><br>

    <input type="submit" value="Submit Request">
</form>

    <p><a href="login.jsp">L O G O U T</a></p>
</body>
</html>
