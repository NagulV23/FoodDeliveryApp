package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private static final String INSERT_ORDERITEM_QUERY =
            "INSERT INTO orderitem(orderId, menuId, quantity, itemTotal) VALUES(?,?,?,?)";

    private static final String GET_ORDERITEM_QUERY =
            "SELECT * FROM orderitem WHERE orderItemId=?";

    private static final String UPDATE_ORDERITEM_QUERY =
            "UPDATE orderitem SET orderId=?, menuId=?, quantity=?, itemTotal=? WHERE orderItemId=?";

    private static final String DELETE_ORDERITEM_QUERY =
            "DELETE FROM orderitem WHERE orderItemId=?";

    private static final String GET_ALL_ORDERITEMS_QUERY =
            "SELECT * FROM orderitem";
    private static final String GET_ORDER_ITEMS_BY_ORDERID =
            "SELECT * FROM orderitem WHERE orderId=?";

    @Override
    public void addOrderItem(OrderItem orderItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_ORDERITEM_QUERY)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getMenuId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getItemTotal());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {

        OrderItem orderItem = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_ORDERITEM_QUERY)) {

            ps.setInt(1, orderItemId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                orderItem = extractOrderItem(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }
    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        List<OrderItem> itemList = new ArrayList<>();

        try(Connection connection = DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(
                            GET_ORDER_ITEMS_BY_ORDERID)) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                itemList.add(extractOrderItem(rs));

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return itemList;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_ORDERITEM_QUERY)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getMenuId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getItemTotal());
            ps.setInt(5, orderItem.getOrderItemId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_ORDERITEM_QUERY)) {

            ps.setInt(1, orderItemId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> orderItemList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet rs = statement.executeQuery(GET_ALL_ORDERITEMS_QUERY)) {

            while (rs.next()) {
                orderItemList.add(extractOrderItem(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItemList;
    }

    private OrderItem extractOrderItem(ResultSet rs) throws SQLException {

        int orderItemId = rs.getInt("orderItemId");
        int orderId = rs.getInt("orderId");
        int menuId = rs.getInt("menuId");
        int quantity = rs.getInt("quantity");
        double itemTotal = rs.getDouble("itemTotal");

        return new OrderItem(orderItemId, orderId, menuId, quantity, itemTotal);
    }
}