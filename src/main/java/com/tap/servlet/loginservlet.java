package com.tap.servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.daoimplementation.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callloginservlet")
public class loginservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAOImpl dao = new UserDAOImpl();

        User user = dao.getUserByEmail(email);

        if (user != null &&
            BCrypt.checkpw(password, user.getPassword())) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);

            response.sendRedirect("callRestaurantServlet");

        } else {

            request.setAttribute("errorMessage",
                    "Invalid Email or Password");

            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }
}