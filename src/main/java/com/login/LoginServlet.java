package com.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        /*
         * Validate request parameters
         */
        if (username == null ||
                username.trim().isEmpty() ||
                password == null ||
                password.trim().isEmpty()) {

            PrintWriter out = response.getWriter();

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "Username and Password are required"
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='index.jsp'>Go Back</a>"
                    + "</p>"
            );

            return;
        }

        username = username.trim();

        /*
         * Get database connection
         */
        try (Connection con = DBConnection.getConnection()) {

            /*
             * Make sure connection was created successfully
             */
            if (con == null) {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Database connection failed."
                );

                return;
            }

            /*
             * PreparedStatement protects against SQL injection
             */
            String sql =
                    "SELECT username "
                    + "FROM users "
                    + "WHERE username = ? "
                    + "AND password = ?";

            try (PreparedStatement ps =
                         con.prepareStatement(sql)) {

                ps.setString(1, username);
                ps.setString(2, password);

                try (ResultSet rs =
                             ps.executeQuery()) {

                    if (rs.next()) {

                        /*
                         * Create HTTP session after successful login
                         */
                        HttpSession session =
                                request.getSession();

                        session.setAttribute(
                                "username",
                                username
                        );

                        /*
                         * Optional session timeout:
                         * 30 minutes
                         */
                        session.setMaxInactiveInterval(
                                30 * 60
                        );

                        /*
                         * Redirect to dashboard
                         */
                        response.sendRedirect(
                                "success.jsp"
                        );

                    } else {

                        /*
                         * Invalid credentials
                         */
                        PrintWriter out =
                                response.getWriter();

                        out.println(
                                "<h1 style='color:red;"
                                + "text-align:center;'>"
                                + "Invalid Username or Password"
                                + "</h1>"
                        );

                        out.println(
                                "<p style='text-align:center;'>"
                                + "<a href='index.jsp'>"
                                + "Go Back"
                                + "</a>"
                                + "</p>"
                        );
                    }
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "Login failed due to database error."
            );

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to process login request."
            );
        }
    }
}
