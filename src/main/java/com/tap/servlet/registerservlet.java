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

@WebServlet("/callregisterservlet")
public class registerservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(12));

        User user = new User();

        user.setName(name);
        user.setUsername(username);
        user.setPassword(hashpw);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("customer");

        UserDAOImpl dao = new UserDAOImpl();

        dao.addUser(user);

        response.sendRedirect("login.jsp");
    }
}