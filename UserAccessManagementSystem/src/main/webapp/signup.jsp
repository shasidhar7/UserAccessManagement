<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
</head>
<body>
    <h2>Sign Up</h2>
    <form action="SignUpServlet" method="POST">
        <label>Username: </label><input type="text" name="username" required /><br/> <br>
                
        <label>Password: </label><input type="password" name="password" required /><br/><br>
        
        <input type="hidden" name="role_id" value="1" /> <!-- Default role for Employee -->
        
        <input type="submit" value="Register"/>
    </form>
    <p>Already have an account <a href="login.jsp">Login</a></p>
</body>
</html>
