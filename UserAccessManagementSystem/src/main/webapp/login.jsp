<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
</head>

<body>

    <div class="login-container">
        <h2 class="heading">Login</h2>

        <form action="LoginServlet" method="POST">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required><br>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required><br>

            <input id="submit" type="submit" value="LOGIN">
        </form>

        <p id="para"> Don't have an account? <a href="signup.jsp">Register</a> </p>
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

    .login-container {
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

    p#para {
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
