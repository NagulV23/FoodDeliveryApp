package com.tap.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.tap.daoimplementation.CouponDAOImpl;
import com.tap.model.Coupon;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/coupons")
public class AdminCouponServlet extends HttpServlet {

    private static final SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Admin authentication check
        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        CouponDAOImpl dao = new CouponDAOImpl();

        if ("edit".equals(action)) {
            // Show edit form for a single coupon
            int couponId = Integer.parseInt(request.getParameter("id"));
            Coupon coupon = dao.getCoupon(couponId);
            if (coupon == null) {
                response.sendRedirect("coupons");
                return;
            }
            request.setAttribute("editCoupon", coupon);
        } else if ("toggle".equals(action)) {
            // Toggle active/inactive
            int couponId = Integer.parseInt(request.getParameter("id"));
            Coupon coupon = dao.getCoupon(couponId);
            if (coupon != null) {
                coupon.setActive(!coupon.isActive());
                dao.updateCoupon(coupon);
            }
            response.sendRedirect("coupons");
            return;
        } else if ("delete".equals(action)) {
            // Delete a coupon
            int couponId = Integer.parseInt(request.getParameter("id"));
            dao.deleteCoupon(couponId);
            response.sendRedirect("coupons");
            return;
        }

        // Load all coupons
        List<Coupon> couponList = dao.getAllCoupons();
        request.setAttribute("couponList", couponList);

        RequestDispatcher rd = request.getRequestDispatcher("/admin-coupons.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Admin authentication check
        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        CouponDAOImpl dao = new CouponDAOImpl();

        try {
            if ("add".equals(action)) {
                // Create new coupon
                Coupon coupon = extractCouponFromRequest(request);
                dao.addCoupon(coupon);
                session.setAttribute("adminMessage", "✅ Coupon '" + coupon.getCode() + "' created successfully!");

            } else if ("edit".equals(action)) {
                // Update existing coupon
                int couponId = Integer.parseInt(request.getParameter("couponId"));
                Coupon coupon = extractCouponFromRequest(request);
                coupon.setCouponId(couponId);
                // Preserve the usedCount and createdAt from DB
                Coupon existing = dao.getCoupon(couponId);
                if (existing != null) {
                    coupon.setUsedCount(existing.getUsedCount());
                    coupon.setCreatedAt(existing.getCreatedAt());
                }
                dao.updateCoupon(coupon);
                session.setAttribute("adminMessage", "✅ Coupon '" + coupon.getCode() + "' updated successfully!");
            }
        } catch (Exception e) {
            session.setAttribute("adminError", "❌ Error: " + e.getMessage());
        }

        response.sendRedirect("coupons");
    }

    /**
     * Extracts coupon fields from an HTTP request (used for both add and edit).
     */
    private Coupon extractCouponFromRequest(HttpServletRequest request) {
        Coupon coupon = new Coupon();

        coupon.setCode(request.getParameter("code").trim().toUpperCase());
        coupon.setDescription(request.getParameter("description"));
        coupon.setDiscountType(request.getParameter("discountType"));
        coupon.setDiscountValue(Double.parseDouble(request.getParameter("discountValue")));

        String minOrderStr = request.getParameter("minOrderAmount");
        coupon.setMinOrderAmount(minOrderStr != null && !minOrderStr.isEmpty() ? Double.parseDouble(minOrderStr) : 0);

        String maxDiscStr = request.getParameter("maxDiscount");
        coupon.setMaxDiscount(maxDiscStr != null && !maxDiscStr.isEmpty() ? Double.parseDouble(maxDiscStr) : 0);

        String usageLimitStr = request.getParameter("usageLimit");
        coupon.setUsageLimit(usageLimitStr != null && !usageLimitStr.isEmpty() ? Integer.parseInt(usageLimitStr) : 0);

        coupon.setUsedCount(0);
        coupon.setActive("on".equals(request.getParameter("isActive")) || "true".equals(request.getParameter("isActive")));

        try {
            String validFromStr = request.getParameter("validFrom");
            if (validFromStr != null && !validFromStr.isEmpty()) {
                coupon.setValidFrom(DATE_FMT.parse(validFromStr));
            }
            String validUntilStr = request.getParameter("validUntil");
            if (validUntilStr != null && !validUntilStr.isEmpty()) {
                coupon.setValidUntil(DATE_FMT.parse(validUntilStr));
            }
        } catch (Exception e) {
            // Default dates if parsing fails
            if (coupon.getValidFrom() == null) coupon.setValidFrom(new Date());
            if (coupon.getValidUntil() == null) coupon.setValidUntil(new Date(System.currentTimeMillis() + 365L * 24 * 60 * 60 * 1000));
        }

        return coupon;
    }
}
