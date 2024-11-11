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
<a href="createSoftware.jsp">Back</a>

</body>
</html>
