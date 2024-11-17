<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
</head>

<body>

    <div class="container">
        <h2>Request Successful</h2>
        <a href="login.jsp">L O G O U T</a>
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
        justify-content: center;
        height: 100vh;
        padding: 20px;
    }

    h2 {
        font-size: 28px;
        color: #28a745;
        margin-bottom: 20px;
    }

    a {
        font-size: 16px;
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
        padding: 8px 16px;
        border: 2px solid #007bff;
        border-radius: 4px;
        transition: background-color 0.3s, color 0.3s;
    }

    a:hover {
        background-color: #007bff;
        color: white;
    }

    .container {
        text-align: center;
    }
    
</style>

</html>
