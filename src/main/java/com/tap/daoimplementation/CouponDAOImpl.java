package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tap.dao.CouponDAO;
import com.tap.model.Coupon;
import com.tap.utility.DBConnection;

public class CouponDAOImpl implements CouponDAO {

    private static final String INSERT_COUPON_QUERY =
            "INSERT INTO coupons(code, description, discountType, discountValue, minOrderAmount, maxDiscount, usageLimit, usedCount, isActive, validFrom, validUntil) VALUES(?,?,?,?,?,?,?,?,?,?,?)";

    private static final String GET_COUPON_QUERY =
            "SELECT * FROM coupons WHERE couponId = ?";

    private static final String GET_COUPON_BY_CODE_QUERY =
            "SELECT * FROM coupons WHERE code = ?";

    private static final String GET_ALL_COUPONS_QUERY =
            "SELECT * FROM coupons ORDER BY createdAt DESC";

    private static final String UPDATE_COUPON_QUERY =
            "UPDATE coupons SET code=?, description=?, discountType=?, discountValue=?, minOrderAmount=?, maxDiscount=?, usageLimit=?, usedCount=?, isActive=?, validFrom=?, validUntil=? WHERE couponId=?";

    private static final String INCREMENT_USED_COUNT_QUERY =
            "UPDATE coupons SET usedCount = usedCount + 1 WHERE couponId = ?";

    private static final String DELETE_COUPON_QUERY =
            "DELETE FROM coupons WHERE couponId = ?";

    @Override
    public void addCoupon(Coupon coupon) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_COUPON_QUERY)) {

            ps.setString(1, coupon.getCode());
            ps.setString(2, coupon.getDescription());
            ps.setString(3, coupon.getDiscountType());
            ps.setDouble(4, coupon.getDiscountValue());
            ps.setDouble(5, coupon.getMinOrderAmount());
            ps.setDouble(6, coupon.getMaxDiscount());
            ps.setInt(7, coupon.getUsageLimit());
            ps.setInt(8, coupon.getUsedCount());
            ps.setBoolean(9, coupon.isActive());
            if (coupon.getValidFrom() != null) {
                ps.setTimestamp(10, new java.sql.Timestamp(coupon.getValidFrom().getTime()));
            } else {
                ps.setNull(10, java.sql.Types.TIMESTAMP);
            }
            if (coupon.getValidUntil() != null) {
                ps.setTimestamp(11, new java.sql.Timestamp(coupon.getValidUntil().getTime()));
            } else {
                ps.setNull(11, java.sql.Types.TIMESTAMP);
            }

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Coupon getCoupon(int couponId) {
        Coupon coupon = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_COUPON_QUERY)) {

            ps.setInt(1, couponId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                coupon = extractCoupon(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupon;
    }

    @Override
    public Coupon getCouponByCode(String code) {
        Coupon coupon = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_COUPON_BY_CODE_QUERY)) {

            ps.setString(1, code.trim().toUpperCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                coupon = extractCoupon(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coupon;
    }

    @Override
    public List<Coupon> getAllCoupons() {
        List<Coupon> couponList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(GET_ALL_COUPONS_QUERY)) {

            while (rs.next()) {
                couponList.add(extractCoupon(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return couponList;
    }

    @Override
    public void updateCoupon(Coupon coupon) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_COUPON_QUERY)) {

            ps.setString(1, coupon.getCode());
            ps.setString(2, coupon.getDescription());
            ps.setString(3, coupon.getDiscountType());
            ps.setDouble(4, coupon.getDiscountValue());
            ps.setDouble(5, coupon.getMinOrderAmount());
            ps.setDouble(6, coupon.getMaxDiscount());
            ps.setInt(7, coupon.getUsageLimit());
            ps.setInt(8, coupon.getUsedCount());
            ps.setBoolean(9, coupon.isActive());
            if (coupon.getValidFrom() != null) {
                ps.setTimestamp(10, new java.sql.Timestamp(coupon.getValidFrom().getTime()));
            } else {
                ps.setNull(10, java.sql.Types.TIMESTAMP);
            }
            if (coupon.getValidUntil() != null) {
                ps.setTimestamp(11, new java.sql.Timestamp(coupon.getValidUntil().getTime()));
            } else {
                ps.setNull(11, java.sql.Types.TIMESTAMP);
            }
            ps.setInt(12, coupon.getCouponId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void incrementUsedCount(int couponId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INCREMENT_USED_COUNT_QUERY)) {

            ps.setInt(1, couponId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteCoupon(int couponId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_COUPON_QUERY)) {

            ps.setInt(1, couponId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Validates a coupon code and returns a result map.
     * Checks: exists, active, within date range, min order, usage limit.
     */
    public CouponValidationResult validateCoupon(String code, double subtotal) {
        CouponValidationResult result = new CouponValidationResult();
        result.setValid(false);

        if (code == null || code.trim().isEmpty()) {
            result.setMessage("Please enter a coupon code.");
            return result;
        }

        Coupon coupon = getCouponByCode(code.trim());

        if (coupon == null) {
            result.setMessage("Invalid coupon code. Please try again.");
            return result;
        }

        // Check if active
        if (!coupon.isActive()) {
            result.setMessage("This coupon is no longer active.");
            return result;
        }

        // Check date range
        Date now = new Date();
        if (coupon.getValidFrom() != null && now.before(coupon.getValidFrom())) {
            result.setMessage("This coupon is not yet valid. Check back later!");
            return result;
        }
        if (coupon.getValidUntil() != null && now.after(coupon.getValidUntil())) {
            result.setMessage("This coupon has expired.");
            return result;
        }

        // Check min order amount
        if (subtotal < coupon.getMinOrderAmount()) {
            result.setMessage("Minimum order amount of ₹" + String.format("%.0f", coupon.getMinOrderAmount())
                    + " required for this coupon. Add more items!");
            return result;
        }

        // Check usage limit
        if (coupon.getUsageLimit() > 0 && coupon.getUsedCount() >= coupon.getUsageLimit()) {
            result.setMessage("This coupon has reached its usage limit.");
            return result;
        }

        // All checks passed — calculate discount
        result.setValid(true);
        result.setCoupon(coupon);
        result.setDiscountAmount(coupon.calculateDiscount(subtotal));
        result.setMessage("🎉 Coupon applied! You saved ₹" + String.format("%.0f", result.getDiscountAmount()));
        return result;
    }

    /**
     * Inner class to hold validation result.
     */
    public static class CouponValidationResult {
        private boolean valid;
        private Coupon coupon;
        private double discountAmount;
        private String message;

        public boolean isValid() { return valid; }
        public void setValid(boolean valid) { this.valid = valid; }

        public Coupon getCoupon() { return coupon; }
        public void setCoupon(Coupon coupon) { this.coupon = coupon; }

        public double getDiscountAmount() { return discountAmount; }
        public void setDiscountAmount(double discountAmount) { this.discountAmount = discountAmount; }

        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }

    private Coupon extractCoupon(ResultSet rs) throws SQLException {
        Coupon coupon = new Coupon();
        coupon.setCouponId(rs.getInt("couponId"));
        coupon.setCode(rs.getString("code"));
        coupon.setDescription(rs.getString("description"));
        coupon.setDiscountType(rs.getString("discountType"));
        coupon.setDiscountValue(rs.getDouble("discountValue"));
        coupon.setMinOrderAmount(rs.getDouble("minOrderAmount"));
        coupon.setMaxDiscount(rs.getDouble("maxDiscount"));
        coupon.setUsageLimit(rs.getInt("usageLimit"));
        coupon.setUsedCount(rs.getInt("usedCount"));
        coupon.setActive(rs.getBoolean("isActive"));
        coupon.setValidFrom(rs.getTimestamp("validFrom"));
        coupon.setValidUntil(rs.getTimestamp("validUntil"));
        coupon.setCreatedAt(rs.getTimestamp("createdAt"));
        return coupon;
    }
}
