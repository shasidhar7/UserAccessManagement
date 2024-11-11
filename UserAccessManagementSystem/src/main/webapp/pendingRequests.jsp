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

<h2>Welcome Manager</h2>

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
                    <input type="hidden" name="request_id" value="<%= requestId %>"/>
                    <input type="submit" name="action" value="Approve" />
                    <input type="submit" name="action" value="Reject" />
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

<br> &nbsp
<a href="login.jsp">L O G O U T</a>

</body>
</html>
