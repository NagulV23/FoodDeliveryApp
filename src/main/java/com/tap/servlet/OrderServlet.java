package com.tap.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import com.tap.daoimplementation.OrderItemDAOImpl;
import com.tap.daoimplementation.OrderTableDAOImpl;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.cart;
import com.tap.model.cartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orderservlet")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        cart cartObj = (cart) session.getAttribute("cart");

        if (cartObj == null || cartObj.getItems().isEmpty()) {

            response.sendRedirect("cart.jsp");
            return;

        }

        // ================= CUSTOMER DETAILS =================

        String customerName = request.getParameter("customerName");
        String phone = request.getParameter("phone");

        String house = request.getParameter("house");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        String paymentMode = request.getParameter("paymentMode");

        String address = house + ", "
                + street + ", "
                + city + ", "
                + state + " - "
                + pincode;

        // ================= USER =================

        // Replace with session user after login is implemented
        int userId = 1;

        // ================= CALCULATE TOTAL =================

        double totalAmount = 0;

        int restaurantId = 0;

        for (cartItem item : cartObj.getItems().values()) {

            totalAmount += item.getPrice() * item.getQuantity();

            restaurantId = item.getRestaurantId();

        }

        // ================= SAVE ORDER =================

        OrderTable order = new OrderTable();

        order.setUserId(userId);

        order.setOrderDate(new Date());

        order.setTotalAmount(totalAmount);

        order.setStatus("PLACED");

        order.setPaymentMethod(paymentMode);

        order.setRestaurantId(restaurantId);

        OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();

        int orderId = orderDAO.addOrder(order);

        // ================= SAVE ORDER ITEMS =================

        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();

        Map<Integer, cartItem> items = cartObj.getItems();

        for (cartItem item : items.values()) {

            OrderItem orderItem = new OrderItem();

            orderItem.setOrderId(orderId);

            orderItem.setMenuId(item.getMenuId());

            orderItem.setQuantity(item.getQuantity());

            orderItem.setItemTotal(
                    item.getPrice() * item.getQuantity());

            orderItemDAO.addOrderItem(orderItem);

        }

        // ================= PRINT DETAILS =================

        System.out.println("========== ORDER PLACED ==========");

        System.out.println("Order ID : " + orderId);

        System.out.println("Customer : " + customerName);

        System.out.println("Phone : " + phone);

        System.out.println("Address : " + address);

        System.out.println("Payment : " + paymentMode);

        System.out.println("Total : " + totalAmount);

        System.out.println("==================================");

        // ================= CLEAR CART =================

        cartObj.getItems().clear();

        session.setAttribute("cart", cartObj);

        response.sendRedirect("orderSuccess.jsp");

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);

    }

}