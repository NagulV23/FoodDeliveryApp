package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import com.tap.daoimplementation.MenuDAOImpl;
import com.tap.daoimplementation.OrderItemDAOImpl;
import com.tap.daoimplementation.OrderTableDAOImpl;
import com.tap.daoimplementation.RestaurantDAOImpl;
import com.tap.model.OrderTable;

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

        /*
         * Replace this with your logged-in user's ID.
         * Example:
         *
         * User user = (User) session.getAttribute("loggedInUser");
         * int userId = user.getUserId();
         */

        int userId = 1;   // Temporary until login integration

        OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();

        List<OrderTable> orderList =
                orderDAO.getOrdersByUserId(userId);

        request.setAttribute("orderList", orderList);

        RequestDispatcher rd =
                request.getRequestDispatcher("myOrders.jsp");

        rd.forward(request, response);
        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
        MenuDAOImpl menuDAO = new MenuDAOImpl();
        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();

        request.setAttribute("restaurantDAO", restaurantDAO);
        request.setAttribute("menuDAO", menuDAO);
        request.setAttribute("orderItemDAO", orderItemDAO);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }

}