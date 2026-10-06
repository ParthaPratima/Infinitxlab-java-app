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

public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String enteredOtp = request.getParameter("otp");
        String newPassword = request.getParameter("password");

        PrintWriter out = response.getWriter();

        /*
         * Validate input
         */
        if (enteredOtp == null ||
                enteredOtp.trim().isEmpty() ||
                newPassword == null ||
                newPassword.trim().isEmpty()) {

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "OTP and new password are required."
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='otp.jsp'>Go Back</a>"
                    + "</p>"
            );

            return;
        }

        /*
         * Do not create a new session if one does not exist.
         */
        HttpSession session =
                request.getSession(false);

        if (session == null) {

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "Password reset session expired."
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='forgot.jsp'>"
                    + "Request New OTP"
                    + "</a>"
                    + "</p>"
            );

            return;
        }

        String originalOtp =
                (String) session.getAttribute("otp");

        String email =
                (String) session.getAttribute("email");

        /*
         * Check whether OTP session data exists.
         */
        if (originalOtp == null ||
                email == null ||
                email.trim().isEmpty()) {

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "OTP session expired or is invalid."
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='forgot.jsp'>"
                    + "Request New OTP"
                    + "</a>"
                    + "</p>"
            );

            return;
        }

        /*
         * Verify OTP
         */
        if (!originalOtp.equals(enteredOtp.trim())) {

            out.println(
                    "<h1 style='color:red;text-align:center;'>"
                    + "Invalid OTP"
                    + "</h1>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='otp.jsp'>Try Again</a>"
                    + "</p>"
            );

            return;
        }

        /*
         * Update password in database.
         */
        String sql =
                "UPDATE users "
                + "SET password = ? "
                + "WHERE email = ?";

        try (Connection con =
                     DBConnection.getConnection()) {

            if (con == null) {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Database connection failed."
                );

                return;
            }

            try (PreparedStatement ps =
                         con.prepareStatement(sql)) {

                ps.setString(
                        1,
                        newPassword
                );

                ps.setString(
                        2,
                        email
                );

                int rowsUpdated =
                        ps.executeUpdate();

                if (rowsUpdated > 0) {

                    /*
                     * Remove OTP after successful reset
                     * so it cannot be reused.
                     */
                    session.removeAttribute("otp");
                    session.removeAttribute("email");

                    out.println(
                            "<h1 style='color:green;"
                            + "text-align:center;'>"
                            + "Password Updated Successfully"
                            + "</h1>"
                    );

                    out.println(
                            "<p style='text-align:center;'>"
                            + "<a href='index.jsp'>"
                            + "Login Now"
                            + "</a>"
                            + "</p>"
                    );

                } else {

                    out.println(
                            "<h1 style='color:red;"
                            + "text-align:center;'>"
                            + "No account found for this email."
                            + "</h1>"
                    );

                    out.println(
                            "<p style='text-align:center;'>"
                            + "<a href='forgot.jsp'>"
                            + "Try Again"
                            + "</a>"
                            + "</p>"
                    );
                }
            }

        } catch (Exception e) {

            System.err.println(
                    "Password reset failed due to database error."
            );

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to reset password."
            );
        }
    }
}
