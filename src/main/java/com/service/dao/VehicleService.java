package com.service.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.owasp.encoder.Encode;

public class VehicleService {
    private String jdbcUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
    private String dbUsername = "isec";
    private String dbPassword = "EUHHaYAmtzbv";

    public ResultSet selectData(String username) {
        Connection conn = null;
        PreparedStatement selectStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            if (conn != null) {
                // SELECT query
                String selectQuery = "SELECT * FROM vehicle_service WHERE username=?";
                selectStmt = conn.prepareStatement(selectQuery);
                selectStmt.setString(1, username);
                rs = selectStmt.executeQuery();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Do not close resources here; the ResultSet should be closed by the caller.
        }

        return rs;
    }

    public void insertData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection conn = null;
        PreparedStatement insertStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            if (conn != null) {
                String vehicleNo = Encode.forHtml(request.getParameter("vehicleNo"));
                String mileageString = Encode.forHtml(request.getParameter("mileage"));
                String location = Encode.forHtml(request.getParameter("location"));
                String message = Encode.forHtml(request.getParameter("message"));
                String username = Encode.forHtml(request.getParameter("nameField"));
                String timeString = Encode.forHtml(request.getParameter("time"));
                String dateInput = Encode.forHtml(request.getParameter("date"));

                java.util.Date userDate = null;
                Time time = null;

                try {
                    SimpleDateFormat timeFormat = new SimpleDateFormat("hh a");
                    java.util.Date parsedTime = timeFormat.parse(timeString);
                    time = new Time(parsedTime.getTime());
                } catch (java.text.ParseException e) {
                    // Handle parsing error if the input is not in the expected format
                    e.printStackTrace();
                }

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                int mileage = 0; // Default value if mileageString is empty or invalid

                if (mileageString != null && !mileageString.isEmpty()) {
                    try {
                        try {
                            userDate = dateFormat.parse(dateInput);
                        } catch (ParseException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                        mileage = Integer.parseInt(mileageString);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
                // INSERT query
                String insertQuery = "INSERT INTO vehicle_service (date, time, location, vehicle_no, mileage, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";
                insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setDate(1, new java.sql.Date(userDate.getTime()));
                insertStmt.setTime(2, time);
                insertStmt.setString(3, location);
                insertStmt.setString(4, vehicleNo);
                insertStmt.setInt(5, mileage);
                insertStmt.setString(6, message);
                insertStmt.setString(7, username);

                int rowsAffected = insertStmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Mark that data has been submitted in this session
                    request.getSession().setAttribute("dataSubmitted", true);

                    // After successfully adding data, perform a redirect
                    response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources (Connection, Statements, ResultSet) here
        }
    }

    public void deleteData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection conn = null;
        PreparedStatement deleteStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            if (conn != null) {
                String deleteBookingId = Encode.forHtml(request.getParameter("deleteBookingId"));

                if (deleteBookingId != null && !deleteBookingId.isEmpty()) {
                    int bookingIdToDelete = Integer.parseInt(deleteBookingId);
                    System.out.println("Deleting bookingId: " + bookingIdToDelete);

                    // DELETE query
                    String deleteQuery = "DELETE FROM vehicle_service WHERE booking_id=?";
                    deleteStmt = conn.prepareStatement(deleteQuery);
                    deleteStmt.setInt(1, bookingIdToDelete);

                    int rowsDeleted = deleteStmt.executeUpdate();

                    if (rowsDeleted > 0) {
                        // Set a flag in session to indicate successful deletion
                        request.getSession().setAttribute("deleteSuccess", true);

                        // Redirect to the same page to avoid resubmission
                        response.sendRedirect(request.getRequestURI());
                    } else {
                        // Handle deletion failure
                        // You can set an attribute or flag to show an error message in your JSP
                        request.getSession().setAttribute("deleteFailed", true);
                        response.sendRedirect(request.getRequestURI());
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions here
        } finally {
            // Close resources (Connection, Statements, ResultSet) here
        }
    }
}
