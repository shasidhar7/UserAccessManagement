package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CreateSoftwareServlet")
public class CreateSoftwareServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String accessLevels = request.getParameter("access_levels");

        // Insert the new software into the database
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root")) {
            String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setString(3, accessLevels);
            int result = stmt.executeUpdate();

            if (result > 0) {
                // If the insertion was successful, redirect to a confirmation page or back to the software list
                response.sendRedirect("softwareList.jsp");
            } else {
                response.getWriter().println("Error creating software.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
