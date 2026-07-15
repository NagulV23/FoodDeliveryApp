package com.tap.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.daoimplementation.OrderItemDAOImpl;
import com.tap.daoimplementation.OrderTableDAOImpl;
import com.tap.daoimplementation.UserDAOImpl;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.User;
import com.tap.model.cart;
import com.tap.model.cartItem;
import com.tap.daoimplementation.CouponDAOImpl;
import com.tap.model.Coupon;
import com.tap.utility.EmailService;

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
        String email = request.getParameter("email");
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

        // ================= USER (Logged-in or Guest) =================

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        int userId;

        if (loggedInUser == null) {
            // Guest checkout — create a minimal user record
            String guestSuffix = System.currentTimeMillis() + "_" + (int)(Math.random() * 10000);
            User guestUser = new User();
            guestUser.setName(customerName);
            guestUser.setUsername("guest_" + guestSuffix);
            guestUser.setPassword("");
            guestUser.setEmail(email != null ? email : "guest_" + guestSuffix + "@foodie.app");
            guestUser.setPhone(phone);
            guestUser.setAddress(address);
            guestUser.setRole("guest");

            UserDAOImpl userDAO = new UserDAOImpl();
            userDAO.addUser(guestUser);

            // Fetch the newly created user to get the auto-generated ID
            User createdGuest = userDAO.getUserByEmail(guestUser.getEmail());
            if (createdGuest == null) {
                // Guest account creation failed — redirect to login with error
                response.sendRedirect("login.jsp?error=checkout_failed");
                return;
            }
            userId = createdGuest.getUserId();

            // Store guest info in session for the success page
            session.setAttribute("isGuest", true);
        } else {
            userId = loggedInUser.getUserId();
            session.setAttribute("isGuest", false);
            if (email == null || email.isEmpty()) {
                email = loggedInUser.getEmail();
            }
        }

        // ================= CALCULATE TOTAL =================

        double totalAmount = 0;

        int restaurantId = 0;

        for (cartItem item : cartObj.getItems().values()) {

            totalAmount += item.getPrice() * item.getQuantity();

            restaurantId = item.getRestaurantId();

        }

        // ================= APPLY COUPON DISCOUNT (Server-side validation) =================

        String couponCode = request.getParameter("couponCode");
        double couponDiscount = 0;

        if (couponCode != null && !couponCode.trim().isEmpty()) {
            try {
                CouponDAOImpl couponDAO = new CouponDAOImpl();
                Coupon coupon = couponDAO.getCouponByCode(couponCode);
                if (coupon != null && coupon.isActive()) {
                    // Server-side date validation
                    Date now = new Date();
                    boolean validDate = true;
                    if (coupon.getValidFrom() != null && now.before(coupon.getValidFrom())) {
                        validDate = false;
                    }
                    if (coupon.getValidUntil() != null && now.after(coupon.getValidUntil())) {
                        validDate = false;
                    }

                    // Check min order amount
                    if (totalAmount < coupon.getMinOrderAmount()) {
                        validDate = false;
                    }
                    // Check usage limit
                    if (coupon.getUsageLimit() > 0 && coupon.getUsedCount() >= coupon.getUsageLimit()) {
                        validDate = false;
                    }

                    if (validDate) {
                        // Re-validate and calculate discount server-side (don't trust client)
                        couponDiscount = coupon.calculateDiscount(totalAmount);
                        // Store coupon for post-order increment
                        session.setAttribute("orderCouponId", coupon.getCouponId());
                    }
                }
            } catch (Exception e) {
                System.err.println("Error applying coupon: " + e.getMessage());
            }
        }

        // Apply discount to total amount
        double discountedAmount = totalAmount - couponDiscount;
        if (discountedAmount < 0) discountedAmount = 0;

        // ================= SAVE ORDER =================

        OrderTable order = new OrderTable();

        order.setUserId(userId);

        order.setOrderDate(new Date());

        order.setTotalAmount(discountedAmount);

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

        // ================= INCREMENT COUPON USAGE =================

        if (orderId > 0) {
            Integer couponId = (Integer) session.getAttribute("orderCouponId");
            if (couponId != null && couponId > 0) {
                try {
                    CouponDAOImpl couponDAO = new CouponDAOImpl();
                    couponDAO.incrementUsedCount(couponId);
                } catch (Exception e) {
                    System.err.println("Failed to increment coupon usage: " + e.getMessage());
                }
            }
            session.removeAttribute("orderCouponId");
        }

        // ================= PRINT DETAILS =================

        System.out.println("========== ORDER PLACED ==========");

        System.out.println("Order ID : " + orderId);

        System.out.println("Customer : " + customerName);

        System.out.println("Phone : " + phone);

        System.out.println("Address : " + address);

        System.out.println("Payment : " + paymentMode);

        System.out.println("Total : " + discountedAmount);
        System.out.println("Coupon : " + (couponCode != null ? couponCode : "None"));
        System.out.println("Discount : " + couponDiscount);

        System.out.println("==================================");

        // ================= STORE FULL ORDER DETAILS IN SESSION =================

        session.setAttribute("lastOrderId", orderId);
        session.setAttribute("orderCustomerName", customerName);
        session.setAttribute("orderEmail", email);
        session.setAttribute("orderPhone", phone);
        session.setAttribute("orderAddress", address);
        session.setAttribute("orderPaymentMode", paymentMode);
        session.setAttribute("orderTotalAmount", discountedAmount);
        session.setAttribute("orderSubtotal", totalAmount);
        session.setAttribute("orderCouponCode", couponCode);
        session.setAttribute("orderCouponDiscount", couponDiscount);
        session.setAttribute("orderRestaurantId", restaurantId);
        session.setAttribute("orderDate", new Date());

        // Build ordered items list for confirmation page
        List<Map<String, Object>> orderItems = new ArrayList<>();
        int idx = 0;
        for (cartItem citem : items.values()) {
            Map<String, Object> itemMap = new HashMap<>();
            itemMap.put("name", citem.getName());
            itemMap.put("quantity", citem.getQuantity());
            itemMap.put("price", citem.getPrice());
            itemMap.put("itemTotal", citem.getPrice() * citem.getQuantity());
            itemMap.put("imagePath", citem.getImagePath());
            itemMap.put("menuId", citem.getMenuId());
            orderItems.add(itemMap);
        }
        session.setAttribute("orderItems", orderItems);

        // ================= SEND CONFIRMATION EMAIL =================

        try {
            StringBuilder itemsHtml = new StringBuilder();
            for (cartItem citem : items.values()) {
                itemsHtml.append("<tr style='border-bottom:1px solid #eee;'>")
                    .append("<td style='padding:10px 0;color:#333;'>").append(citem.getName()).append("</td>")
                    .append("<td style='padding:10px 0;text-align:center;color:#888;'>x").append(citem.getQuantity()).append("</td>")
                    .append("<td style='padding:10px 0;text-align:right;color:#27ae60;font-weight:bold;'>₹").append(String.format("%.0f", citem.getPrice() * citem.getQuantity())).append("</td>")
                    .append("</tr>");
            }
            String emailBody = EmailService.buildOrderConfirmationEmail(
                customerName, orderId, totalAmount, paymentMode, address, itemsHtml.toString()
            );
            EmailService.sendEmail(email, "Order Confirmed - Foodie #ORD-" + String.format("%05d", orderId), emailBody);
        } catch (Exception e) {
            System.err.println("Failed to send confirmation email: " + e.getMessage());
        }

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