<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Software List</title>
</head>

<body>

<h2>Software List</h2>

<table border="1">
    <thead>
        <tr>
            <th>Software Name</th>
            <th>Description</th>
            <th>Access Levels</th>
        </tr>
    </thead>
    <tbody>
        <% 
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");
                String sql = "SELECT * FROM software";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String accessLevels = rs.getString("access_levels");
        %>
        <tr>
            <td><%= name %></td>
            <td><%= description %></td>
            <td><%= accessLevels %></td>
        </tr>
        <% 
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </tbody>
</table>

<br>
<a href="createSoftware.jsp" class="back-link">Back</a>

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
        color: #333;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        min-height: 100vh;
        padding: 20px;
    }

    h2 {
        font-size: 28px;
        color: green;
        margin-bottom: 18px;
    }

    table {
        width: 70%; 
        max-width: 1000px; /* Max width */
        border-collapse: collapse;
        margin-top: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 12px 20px; 
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #007bff;
        color: white;
        font-weight: bold;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .back-link {
        font-size: 20px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
        margin-bottom: 20px;
        display: inline-block;
        letter-spacing: 3px;
    }

    .back-link:hover {
        text-decoration: underline;
    }

    .container {
        width: 80%; 
        max-width: 1000px;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

</style>

</html>
