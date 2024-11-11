package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int requestId = Integer.parseInt(request.getParameter("requestId"));

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

            // Update the status based on the action
            String status = action.equals("Approve") ? "Approved" : "Rejected";
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, requestId);
            statement.executeUpdate();

            // Redirect back to the pending requests page
            response.sendRedirect("pendingRequests.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
