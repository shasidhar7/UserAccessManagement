<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Software</title>
</head>
<body>

<h2>Welcome Admin</h2>

<h4>Create New Software</h4>

<form action="CreateSoftwareServlet" method="POST">
    <label for="name">Software Name:</label><br>
    <input type="text" id="name" name="name" required><br><br>

    <label for="description">Description:</label><br>
    <textarea id="description" name="description" required></textarea><br><br>

    <label for="access_levels">Access Levels:</label><br>
    <select id="access_levels" name="access_levels" required>
        <option value="Read">Read</option>
        <option value="Write">Write</option>
        <option value="Admin">Admin</option>
    </select><br><br>

    <input type="submit" value="Create Software">
</form>
<br>
<a href="softwareList.jsp">Software List</a>
&nbsp &nbsp
<a href="login.jsp">L O G O U T</a>

</body>
</html>
