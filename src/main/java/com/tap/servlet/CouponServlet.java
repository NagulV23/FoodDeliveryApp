package com.tap.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.tap.daoimplementation.CouponDAOImpl;
import com.tap.daoimplementation.CouponDAOImpl.CouponValidationResult;
import com.tap.model.Coupon;
import com.tap.model.cart;
import com.tap.model.cartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/applycoupon")
public class CouponServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();

        String action = request.getParameter("action");
        String code = request.getParameter("code");

        // Calculate current subtotal from cart
        cart cartObj = (cart) session.getAttribute("cart");
        double subtotal = 0;
        if (cartObj != null) {
            for (cartItem item : cartObj.getItems().values()) {
                subtotal += item.getPrice() * item.getQuantity();
            }
        }

        if ("validate".equals(action)) {
            CouponDAOImpl dao = new CouponDAOImpl();
            CouponValidationResult result = dao.validateCoupon(code, subtotal);

            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"valid\":").append(result.isValid()).append(",");
            json.append("\"message\":\"").append(escapeJson(result.getMessage())).append("\"");
            json.append(",\"discountAmount\":").append(result.getDiscountAmount());

            if (result.isValid() && result.getCoupon() != null) {
                Coupon coupon = result.getCoupon();
                json.append(",\"couponId\":").append(coupon.getCouponId());
                json.append(",\"code\":\"").append(escapeJson(coupon.getCode())).append("\"");
                json.append(",\"discountType\":\"").append(escapeJson(coupon.getDiscountType())).append("\"");
                json.append(",\"discountValue\":").append(coupon.getDiscountValue());
                json.append(",\"description\":\"").append(escapeJson(coupon.getDescription())).append("\"");

                // Store coupon in session for OrderServlet
                session.setAttribute("appliedCouponId", coupon.getCouponId());
                session.setAttribute("appliedCouponCode", coupon.getCode());
                session.setAttribute("appliedCouponDiscount", result.getDiscountAmount());
            }

            json.append("}");
            out.write(json.toString());

        } else if ("remove".equals(action)) {
            // Remove applied coupon
            session.removeAttribute("appliedCouponId");
            session.removeAttribute("appliedCouponCode");
            session.removeAttribute("appliedCouponDiscount");

            out.write("{\"valid\":true,\"message\":\"Coupon removed.\",\"discountAmount\":0}");

        } else {
            out.write("{\"valid\":false,\"message\":\"Invalid action.\",\"discountAmount\":0}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
