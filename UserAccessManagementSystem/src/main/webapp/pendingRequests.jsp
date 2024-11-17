<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Access Requests</title>
</head>

<body>

    <div class="welcome-section">
        Welcome Manager
    </div>

    <div class="container">

        <h4>Pending Access Requests</h4>

        <table border="1">
            <thead>
                <tr>
                    <th>Request ID</th>
                    <th>User</th>
                    <th>Software</th>
                    <th>Access Type</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Database connection setup
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        // Database connection
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

                        // Query to fetch all pending requests
                        String sql = "SELECT r.id, u.username, s.name AS software_name, r.access_type, r.reason, r.status " +
                                     "FROM requests r " +
                                     "JOIN users u ON r.user_id = u.user_id " +
                                     "JOIN software s ON r.software_id = s.id " +
                                     "WHERE r.status = 'Pending'";

                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        // Display requests
                        while (rs.next()) {
                            int requestId = rs.getInt("id");
                            String username = rs.getString("username");
                            String softwareName = rs.getString("software_name");
                            String accessType = rs.getString("access_type");
                            String reason = rs.getString("reason");
                            String status = rs.getString("status");
                %>
                <tr>
                    <td><%= requestId %></td>
                    <td><%= username %></td>
                    <td><%= softwareName %></td>
                    <td><%= accessType %></td>
                    <td><%= reason %></td>
                    <td><%= status %></td>
                    <td>
                        <form action="ApproveRejectRequestServlet" method="post">
                            <input type="hidden" name="request_id" value="<%= requestId %>" />
                            <div class="action-buttons">
                                <input type="submit" name="action" value="Approve" class="action-btn approve" />
                                <input type="submit" name="action" value="Reject" class="action-btn reject" />
                            </div>
                        </form>
                    </td>
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

        <div class="logout-container">
            <a href="login.jsp" class="logout-link">L O G O U T</a>
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
        color: #333;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        min-height: 100vh;
        padding: 20px;
    }

    .welcome-section {
        width: 80%;
        max-width: 800px;
        background-color: #20c997;
        color: white;
        text-align: center;
        padding: 15px;
        font-size: 24px;
        font-weight: bold;
        border-radius: 8px 8px 0 0;
        margin-bottom: 30px;
    }

    h4 {
        font-size: 22px;
        color: green;
        text-align: center;
        margin-bottom: 10px;
    }

    table {
        width: 60%;
        max-width: 500px;
        border-collapse: collapse;
        margin-top: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    th,
    td {
        padding: 12px 15px;
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

    input[type="submit"] {
        padding: 6px 12px;
        font-size: 14px;
        color: #fff;
        background-color: #007bff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-right: 10px;
    }

    input[type="submit"]:hover {
        background-color: #0056b3;
    }

    input[type="submit"]:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }

    a:hover {
        text-decoration: underline;
    }

    .container {
        width: 80%;
        max-width: 800px;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .logout-container {
        margin-top: 20px;
        text-align: center;
    }

    .logout-link {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }

    .logout-link:hover {
        text-decoration: underline;
    }

    .action-buttons {
        display: flex;
        justify-content: space-between;
        width: 140px;
    }

    .action-btn {
        flex: 1;
        padding: 6px 10px;
        font-size: 14px;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .approve {
        background-color: #28a745;
    }

    .reject {
        background-color: #dc3545;
    }

    .action-btn:hover {
        opacity: 0.9;
    }

    .approve:hover {
        background-color: #218838;
    }

    .reject:hover {
        background-color: #c82333;
    }

</style>

</html>
