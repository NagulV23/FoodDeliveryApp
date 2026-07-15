package com.tap.model;

import java.util.Date;

public class Coupon {

    private int couponId;
    private String code;
    private String description;
    private String discountType;   // "PERCENTAGE" or "FLAT"
    private double discountValue;
    private double minOrderAmount;
    private double maxDiscount;     // 0 means no cap
    private int usageLimit;         // max number of times this coupon can be used
    private int usedCount;          // how many times it has been used
    private boolean isActive;
    private Date validFrom;
    private Date validUntil;
    private Date createdAt;

    public Coupon() {}

    public Coupon(int couponId, String code, String description,
                  String discountType, double discountValue,
                  double minOrderAmount, double maxDiscount,
                  int usageLimit, int usedCount, boolean isActive,
                  Date validFrom, Date validUntil, Date createdAt) {
        this.couponId = couponId;
        this.code = code;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderAmount = minOrderAmount;
        this.maxDiscount = maxDiscount;
        this.usageLimit = usageLimit;
        this.usedCount = usedCount;
        this.isActive = isActive;
        this.validFrom = validFrom;
        this.validUntil = validUntil;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getCouponId() { return couponId; }
    public void setCouponId(int couponId) { this.couponId = couponId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public double getMinOrderAmount() { return minOrderAmount; }
    public void setMinOrderAmount(double minOrderAmount) { this.minOrderAmount = minOrderAmount; }

    public double getMaxDiscount() { return maxDiscount; }
    public void setMaxDiscount(double maxDiscount) { this.maxDiscount = maxDiscount; }

    public int getUsageLimit() { return usageLimit; }
    public void setUsageLimit(int usageLimit) { this.usageLimit = usageLimit; }

    public int getUsedCount() { return usedCount; }
    public void setUsedCount(int usedCount) { this.usedCount = usedCount; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }

    public Date getValidFrom() { return validFrom; }
    public void setValidFrom(Date validFrom) { this.validFrom = validFrom; }

    public Date getValidUntil() { return validUntil; }
    public void setValidUntil(Date validUntil) { this.validUntil = validUntil; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    /**
     * Calculates the actual discount amount for a given subtotal.
     * Respects maxDiscount cap and percentage/flat type.
     */
    public double calculateDiscount(double subtotal) {
        double discount;
        if ("PERCENTAGE".equalsIgnoreCase(discountType)) {
            discount = subtotal * (discountValue / 100.0);
        } else {
            discount = discountValue;
        }
        // Cap at maxDiscount if set
        if (maxDiscount > 0 && discount > maxDiscount) {
            discount = maxDiscount;
        }
        return discount;
    }
}
