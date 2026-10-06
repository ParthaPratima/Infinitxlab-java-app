package com.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class SendOTPServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Email address is required."
            );
            return;
        }

        /*
         * Generate secure 6-digit OTP.
         * Examples:
         * 004521
         * 583921
         */
        SecureRandom random = new SecureRandom();

        String otp = String.format(
                "%06d",
                random.nextInt(1000000)
        );

        /*
         * Store OTP and email in user's HTTP session.
         */
        HttpSession session = request.getSession();

        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        /*
         * Read Gmail credentials from environment variables.
         *
         * Docker/Kubernetes will provide:
         *
         * MAIL_USERNAME
         * MAIL_PASSWORD
         */
        final String senderEmail =
                System.getenv("MAIL_USERNAME");

        final String senderPassword =
                System.getenv("MAIL_PASSWORD");

        /*
         * Make sure credentials exist.
         */
        if (senderEmail == null ||
                senderEmail.trim().isEmpty() ||
                senderPassword == null ||
                senderPassword.trim().isEmpty()) {

            System.err.println(
                    "MAIL_USERNAME or MAIL_PASSWORD environment variable is missing."
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Email service is not configured."
            );

            return;
        }

        /*
         * Gmail SMTP configuration
         */
        Properties props = new Properties();

        props.put(
                "mail.smtp.host",
                "smtp.gmail.com"
        );

        props.put(
                "mail.smtp.port",
                "587"
        );

        props.put(
                "mail.smtp.auth",
                "true"
        );

        props.put(
                "mail.smtp.starttls.enable",
                "true"
        );

        props.put(
                "mail.smtp.starttls.required",
                "true"
        );

        /*
         * Create authenticated mail session
         */
        Session mailSession =
                Session.getInstance(
                        props,
                        new Authenticator() {

                            @Override
                            protected PasswordAuthentication
                            getPasswordAuthentication() {

                                return new PasswordAuthentication(
                                        senderEmail,
                                        senderPassword
                                );
                            }
                        }
                );

        try {

            /*
             * Create email message
             */
            Message message =
                    new MimeMessage(mailSession);

            message.setFrom(
                    new InternetAddress(senderEmail)
            );

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(email)
            );

            message.setSubject(
                    "InfinitX Lab - Password Reset OTP"
            );

            message.setText(
                    "Your OTP for password reset is: "
                            + otp
                            + "\n\n"
                            + "Please do not share this OTP with anyone."
            );

            /*
             * Send email
             */
            Transport.send(message);

            System.out.println(
                    "OTP email successfully sent."
            );

            /*
             * Redirect user to OTP page
             */
            response.sendRedirect("otp.jsp");

        } catch (Exception e) {

            System.err.println(
                    "Failed to send OTP email."
            );

            e.printStackTrace();

            PrintWriter out =
                    response.getWriter();

            out.println(
                    "<h2 style='color:red;text-align:center;'>"
                    + "Unable to send OTP email."
                    + "</h2>"
            );

            out.println(
                    "<p style='text-align:center;'>"
                    + "<a href='forgot.jsp'>Try Again</a>"
                    + "</p>"
            );
        }
    }
}
