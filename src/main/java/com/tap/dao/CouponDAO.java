package com.tap.dao;

import java.util.List;
import com.tap.model.Coupon;

public interface CouponDAO {

    void addCoupon(Coupon coupon);
    Coupon getCoupon(int couponId);
    Coupon getCouponByCode(String code);
    List<Coupon> getAllCoupons();
    void updateCoupon(Coupon coupon);
    void incrementUsedCount(int couponId);
    void deleteCoupon(int couponId);
}
