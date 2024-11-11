package com.servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/SignUpServlet")
public class SignupServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("role_id")); // Default role is 1 (Employee)

        // Hash the password before storing
//        String hashedPassword = hashPassword(password);

        // Database connection and query
        
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");
            String sql = "INSERT INTO users (username, password, role_id) VALUES (?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setInt(3, roleId);

            int result = statement.executeUpdate();
            
            if (result > 0) {
                // Redirect to login page after successful registration
                response.sendRedirect("login.jsp");
            } else {
                response.getWriter().println("Registration failed.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

//    static String hashPassword(String password) {
//        try {
//            MessageDigest md = MessageDigest.getInstance("SHA-256");
//            byte[] hash = md.digest(password.getBytes());
//            StringBuilder hexString = new StringBuilder();
//            for (byte b : hash) {
//                hexString.append(Integer.toHexString(0xFF & b));
//            }
//            return hexString.toString();
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//            return null;
//        }
//    }
}
