package com.servlet;


import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user credentials
        if (validateUser(username, password)) {
            // Retrieve the user's details (user_id and role_id)
            int userId = getUserId(username); // Get user ID
            int roleId = getUserRole(username); // Get user role

            if (userId != 0 && roleId != 0) {
                // Set the user session
                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);  // Store user_id in session
                session.setAttribute("username", username);
                session.setAttribute("roleId", roleId);

                // Debugging output
                System.out.println("Login successful. Username: " + username);
                System.out.println("Role ID: " + roleId);
                System.out.println("User ID: " + userId);

                // Redirect based on the user's role
                try {
                    if (roleId == 1) { // Employee
                        System.out.println("Redirecting to requestAccess.jsp");
                        response.sendRedirect("requestAccess.jsp");
                    } else if (roleId == 2) { // Manager
                        System.out.println("Redirecting to pendingRequests.jsp");
                        response.sendRedirect("pendingRequests.jsp");
                    } else if (roleId == 3) { // Admin
                        System.out.println("Redirecting to createSoftware.jsp");
                        response.sendRedirect("createSoftware.jsp");
                    } else {
                        System.out.println("Invalid role. Redirecting to login.jsp with error.");
                        request.setAttribute("errorMessage", "Invalid role. Please contact the administrator.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                // If user details retrieval failed
                System.out.println("Login failed. Invalid credentials.");
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            // If login failed, show error message
            System.out.println("Login failed. Invalid credentials.");
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Validate the user credentials against the database
    private boolean validateUser(String username, String password) {
        boolean isValid = false;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

            // Query to check the user credentials
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password); // Ensure this is the plain password

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                isValid = true; // User found with matching credentials
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isValid;
    }

    // Retrieve the user's ID based on their username
    private int getUserId(String username) {
        int userId = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

            // SQL query to retrieve user_id
            String sql = "SELECT user_id FROM users WHERE username = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                userId = resultSet.getInt("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return userId;
    }

    // Retrieve the user's role based on their username
    private int getUserRole(String username) {
        int roleId = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

            // SQL query to retrieve role_id
            String sql = "SELECT role_id FROM users WHERE username = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                roleId = resultSet.getInt("role_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return roleId;
    }
}

