package com.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();

        /*
         * Validate request parameters
         */
        if (username == null ||
                username.trim().isEmpty() ||
                email == null ||
                email.trim().isEmpty() ||
                password == null ||
                password.trim().isEmpty()) {

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "Username, Email and Password are required."
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='signup.jsp'>Go Back</a>"
                    + "</p>"
            );

            return;
        }

        username = username.trim();
        email = email.trim().toLowerCase();

        /*
         * Basic password validation
         */
        if (password.length() < 8) {

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "Password must be at least 8 characters."
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='signup.jsp'>Go Back</a>"
                    + "</p>"
            );

            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Database connection failed."
                );

                return;
            }

            /*
             * Check whether username or email already exists
             */
            String checkSql =
                    "SELECT username "
                    + "FROM users "
                    + "WHERE username = ? "
                    + "OR email = ?";

            try (PreparedStatement checkPs =
                         con.prepareStatement(checkSql)) {

                checkPs.setString(1, username);
                checkPs.setString(2, email);

                try (ResultSet rs = checkPs.executeQuery()) {

                    if (rs.next()) {

                        out.println(
                                "<h1 style='color:red;text-align:center;'>"
                                + "Username or Email already exists."
                                + "</h1>"
                        );

                        out.println(
                                "<p style='text-align:center;'>"
                                + "<a href='signup.jsp'>"
                                + "Try Again"
                                + "</a>"
                                + "</p>"
                        );

                        return;
                    }
                }
            }

            /*
             * Insert new user
             */
            String insertSql =
                    "INSERT INTO users "
                    + "(username, email, password) "
                    + "VALUES (?, ?, ?)";

            try (PreparedStatement ps =
                         con.prepareStatement(insertSql)) {

                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);

                int rowsInserted =
                        ps.executeUpdate();

                if (rowsInserted > 0) {

                    response.sendRedirect(
                            "index.jsp"
                    );

                } else {

                    out.println(
                            "<h1 style='color:red;text-align:center;'>"
                            + "Unable to create account."
                            + "</h1>"
                    );

                    out.println(
                            "<p style='text-align:center;'>"
                            + "<a href='signup.jsp'>"
                            + "Try Again"
                            + "</a>"
                            + "</p>"
                    );
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "Signup failed due to database error."
            );

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to process signup request."
            );
        }
    }
}
