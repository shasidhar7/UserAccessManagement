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

    <div class="page-container">
        <div class="welcome-section">
            <h2>Welcome Employee</h2>
        </div>

        <div class="container">
            <h4>Request Access</h4>
            
            <%
                // Assuming user_id is stored in the session after login
                session = request.getSession();
                Integer userId = (Integer) session.getAttribute("user_id");  // Get user_id from session
                session.setAttribute("user_id", userId); // Ensure userId is not null
            %>

            <form action="RequestServlet" method="POST">
                <input type="hidden" name="user_id" value="<%= userId %>"> <!-- Hidden field for user_id -->

                <label for="software">Software</label>
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
                </select><br>

                <label for="access_type">Access Type</label>
                <select name="access_type" id="access_type" required>
                    <option value="Read">Read</option>
                    <option value="Write">Write</option>
                    <option value="Admin">Admin</option>
                </select><br>

                <label for="reason">Reason for Request</label>
                <textarea name="reason" id="reason" rows="4" cols="50" required></textarea><br>

                <div class="button-container">
                    <input type="submit" value="Submit Request">
                    <a href="login.jsp" class="logout-link">L O G O U T</a>
                </div>
            </form>
        </div>
    </div>

</body>

<style>
   
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Arial', sans-serif;
    }

    body {
        background-color: #f2f4f8;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 20px;
        color: #333;
    }

    .page-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        max-width: 500px;
    }

    .welcome-section {
        width: 100%;
        max-width: 450px;
        background-color: #20c997;
        color: white;
        text-align: center;
        padding: 10px 0;
        font-size: 20px;
        font-weight: bold;
        border-radius: 8px 8px 0 0;
        margin-bottom: 15px;
    }

    .container {
        background-color: #ffffff;
        width: 100%;
        max-width: 450px;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border: 1px solid #e0e0e0;
    }

    h4 {
        color: green;
        margin-bottom: 15px;
        font-size: 22px;
        text-align: center;
    }

    .heading {
        color: green;
        margin-bottom: 20px;
        font-size: 24px;
        text-align: center;
        letter-spacing: 1px;
    }

    form {
        width: 100%;
    }

    label {
        font-size: 14px;
        font-weight: 600;
        color: #555;
        margin-bottom: 5px;
        display: block;
        text-align: left;
    }

    select,
    textarea,
    input[type="text"] {
        width: 100%;
        padding: 6px;
        margin-top: 5px;
        margin-bottom: 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        transition: border-color 0.3s;
    }

    select:focus,
    textarea:focus,
    input[type="text"]:focus {
        border-color: #007bff;
        outline: none;
    }

    textarea {
        resize: vertical; 
    }

    .button-container {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    input[type="submit"] {
        padding: 8px 16px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
        font-size: 14px;
    }

    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    .logout-link {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
        padding: 10px;
    }

    .logout-link:hover {
        text-decoration: underline;
    }
    
</style>

</html>
