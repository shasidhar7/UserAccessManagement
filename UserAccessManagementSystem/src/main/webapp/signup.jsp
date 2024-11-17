<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title> 
</head>

<body>
    <div class="signup-container">
        <h2 class="heading">Register</h2>
        
        <form action="SignUpServlet" method="POST">
            <label>Username </label>
            <input type="text" name="username" required /><br/>

            <label>Password </label>
            <input type="password" name="password" required /><br/>
        
            <input type="hidden" name="role_id" value="1" /> <!-- Default role for Employee -->
        
            <input id="submit" type="submit" value="REGISTER"/>
        </form>
        <p class="para">Already have an account? <a href="login.jsp">Login</a></p>
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
        background-color: #f7f7f7;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        padding: 20px;
        color: #333;
        flex-direction: column;
    }

    .signup-container {
        background-color: #ffffff;
        width: 100%;
        max-width: 400px;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        border: 1px solid #e0e0e0;
    }

    h2.heading {
        color: #333;
        margin-bottom: 20px;
        font-size: 28px;
        text-align: center;
        letter-spacing: 2px;
    }

    form {
        width: 100%;
    }

    label {
        font-size: 14px;
        font-weight: 600;
        color: #555;
        margin-bottom: 8px;
        display: block;
        text-align: left;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 12px;
        margin-top: 5px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        transition: border-color 0.3s;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
        border-color: #007bff;
        outline: none;
    }

    #submit {
        width: 100%;
        padding: 15px;
        background-color: #28a745;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
        letter-spacing: 5px;
        font-size: 16px;
    }

    #submit:hover {
        background-color: #218838;
    }

    .para {
        margin-top: 20px;
        font-size: 14px;
        color: #666;
        text-align: center; 
    }

    a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }
    
</style>

</html>
