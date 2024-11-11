package com.servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/SoftwareServlet")
public class SoftwareServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String softwareName = request.getParameter("softwareName");
        String description = request.getParameter("description");
        String[] accessLevels = request.getParameterValues("accessLevels");

        if (softwareName == null || description == null || accessLevels == null) {
            response.sendRedirect("createSoftware.jsp");
            return;
        }

        // Database connection
        Connection connection = null;
        PreparedStatement pst = null;

        try {
            // Connect to the database
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/useraccess", "root", "root");

            // Insert software data into database
            String sql = "INSERT INTO software (software_name, description) VALUES (?, ?)";
            pst = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, softwareName);
            pst.setString(2, description);

            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated software ID
                ResultSet generatedKeys = pst.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int softwareId = generatedKeys.getInt(1);

                    // Insert access levels into the access_levels table
                    for (String level : accessLevels) {
                        String accessSql = "INSERT INTO access_levels (software_id, level) VALUES (?, ?)";
                        try (PreparedStatement accessPst = connection.prepareStatement(accessSql)) {
                            accessPst.setInt(1, softwareId);
                            accessPst.setString(2, level);
                            accessPst.executeUpdate();
                        }
                    }
                }
            }

            // Redirect to a confirmation or software list page
            response.sendRedirect("softwareList.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("createSoftware.jsp?error=1"); // Redirect to form if error occurs
        } finally {
            try {
                if (pst != null) pst.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
