package com.tap.dao;

import java.util.List;
import com.tap.model.OrderItem;

public interface OrderItemDAO {

    // Insert Order Item
    void addOrderItem(OrderItem orderItem);

    // Get Single Order Item
    OrderItem getOrderItem(int orderItemId);

    // Get all items of a particular order
    List<OrderItem> getOrderItemsByOrderId(int orderId);

    // Update Order Item
    void updateOrderItem(OrderItem orderItem);

    // Delete Order Item
    void deleteOrderItem(int orderItemId);

    // Admin
    List<OrderItem> getAllOrderItems();
}