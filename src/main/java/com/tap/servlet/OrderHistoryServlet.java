package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import com.tap.daoimplementation.MenuDAOImpl;
import com.tap.daoimplementation.OrderItemDAOImpl;
import com.tap.daoimplementation.OrderTableDAOImpl;
import com.tap.daoimplementation.RestaurantDAOImpl;
import com.tap.model.OrderTable;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orderhistory")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get the actual logged-in user from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        int userId = (loggedInUser != null) ? loggedInUser.getUserId() : -1;

        OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();

        List<OrderTable> orderList =
                orderDAO.getOrdersByUserId(userId);

        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
        MenuDAOImpl menuDAO = new MenuDAOImpl();
        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();

        request.setAttribute("orderList", orderList);
        request.setAttribute("restaurantDAO", restaurantDAO);
        request.setAttribute("menuDAO", menuDAO);
        request.setAttribute("orderItemDAO", orderItemDAO);

        RequestDispatcher rd =
                request.getRequestDispatcher("myOrders.jsp");

        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }

}