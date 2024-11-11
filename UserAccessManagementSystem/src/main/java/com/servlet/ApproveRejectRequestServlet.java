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

@WebServlet("/ApproveRejectRequestServlet")
public class ApproveRejectRequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("request_id"));
        String action = request.getParameter("action");  // Either "Approve" or "Reject"

        // Determine the new status based on the action
        String newStatus = "";
        if ("Approve".equals(action)) {
            newStatus = "Approved";
        } else if ("Reject".equals(action)) {
            newStatus = "Rejected";
        }

        // Update the request status in the database
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root")) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newStatus);
            stmt.setInt(2, requestId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Redirect to the pending requests page after processing
        response.sendRedirect("pendingRequests.jsp");
    }
}
