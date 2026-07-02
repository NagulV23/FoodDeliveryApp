package com.tap.dao;

import java.util.List;
import com.tap.model.OrderTable;

public interface OrderTableDAO {

    int addOrder(OrderTable order);

    OrderTable getOrder(int orderId);

    void updateOrder(OrderTable order);

    void deleteOrder(int orderId);

    List<OrderTable> getAllOrders();

    List<OrderTable> getOrdersByUserId(int userId);

    OrderTable getLatestOrder(int userId);
}