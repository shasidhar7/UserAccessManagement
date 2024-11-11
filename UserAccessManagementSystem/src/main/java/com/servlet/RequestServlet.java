package com.servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {
    
    // To handle GET requests (displaying the request access form)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch software list from database to show in the dropdown on the form
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Establish database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");
            
            // Fetch all software entries for the dropdown
            String sql = "SELECT id, name FROM software";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            // Set the software list as a request attribute to be accessed in the JSP
            request.setAttribute("softwareList", rs);
            
            // Forward the request to the requestAccess.jsp page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/requestAccess.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error fetching software list.");
        } finally {
            // Clean up resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // To handle POST requests (submitting the request access form)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user_id from session or form (preferably session)
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            System.out.println("User ID is not found in the session.");
            response.getWriter().println("User is not logged in.");
            return;
        } else {
            System.out.println("User ID from session: " + userId);
        }

        // Get other parameters from the form
        int softwareId = Integer.parseInt(request.getParameter("software_id"));
        String accessType = request.getParameter("access_type");
        String reason = request.getParameter("reason");

        // Insert the access request into the database
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        try {
            // Establish database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

            // SQL query to insert the request into the database
            String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, softwareId);
            stmt.setString(3, accessType);
            stmt.setString(4, reason);

            int result = stmt.executeUpdate();

            if (result > 0) {
                // Redirect to a success page or confirmation page after successful request submission
                response.sendRedirect("requestSuccess.jsp");
            } else {
                response.getWriter().println("Error submitting the request.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            // Clean up resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
