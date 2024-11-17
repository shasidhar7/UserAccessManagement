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

<div class="page-container">
    
    <div class="welcome-section">
        <h2>Welcome Admin</h2>
    </div>
    
    <div class="container">

        <h4>Create New Software</h4>

        <form action="CreateSoftwareServlet" method="POST">
            <label for="name">Software Name</label>
            <input type="text" id="name" name="name" required>

            <label for="description">Description</label>
            <textarea id="description" name="description" required></textarea><br>

            <label for="access_levels">Access Levels</label>
            <select id="access_levels" name="access_levels" required>
                <option value="Read">Read</option>
                <option value="Write">Write</option>
                <option value="Admin">Admin</option>
            </select>

            <input type="submit" value="Create Software">
        </form>

        <div class="links">
            <a href="softwareList.jsp">Software List</a>&nbsp;&nbsp;
            <a href="login.jsp">L O G O U T</a>
        </div>
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
        max-width: 450px;
    }

    .welcome-section {
        width: 100%;
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
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border: 1px solid #e0e0e0;
    }

    h4 {
        color: green;
        font-size: 22px;
        margin-bottom: 15px;
        text-align: center;
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

    input[type="text"],
    textarea,
    select {
        width: 100%;
        padding: 6px;
        margin-top: 5px;
        margin-bottom: 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        transition: border-color 0.3s;
    }

    input[type="text"]:focus,
    textarea:focus,
    select:focus {
        border-color: #007bff;
        outline: none;
    }

    textarea {
        resize: vertical;
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

    a {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }

    .button-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .links {
        margin-top: 15px;
        text-align: center;
    }

    .links a {
        font-size: 14px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
        margin-right: 20px;
    }

    .links a:hover {
        text-decoration: underline;
    }
    
</style>

</html>
