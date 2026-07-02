package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderTableDAO;
import com.tap.model.OrderTable;
import com.tap.utility.DBConnection;

public class OrderTableDAOImpl implements OrderTableDAO {

    private static final String INSERT_ORDER_QUERY =
            "INSERT INTO ordertable(userId, orderDate, totalAmount, status, paymentMethod, restaurantId) VALUES(?,?,?,?,?,?)";

    private static final String GET_ORDER_QUERY =
            "SELECT * FROM ordertable WHERE orderId=?";

    private static final String UPDATE_ORDER_QUERY =
            "UPDATE ordertable SET userId=?, orderDate=?, totalAmount=?, status=?, paymentMethod=?, restaurantId=? WHERE orderId=?";

    private static final String DELETE_ORDER_QUERY =
            "DELETE FROM ordertable WHERE orderId=?";

    private static final String GET_ALL_ORDERS_QUERY =
            "SELECT * FROM ordertable";
    
    private static final String GET_ORDER_BY_USER_QUERY =
            "SELECT * FROM ordertable WHERE userId=? ORDER BY orderDate DESC";

    private static final String GET_LATEST_ORDER_QUERY =
            "SELECT * FROM ordertable WHERE userId=? ORDER BY orderId DESC LIMIT 1";

    @Override
    public int addOrder(OrderTable order) {

        int generatedOrderId = 0;

        try (Connection connection = DBConnection.getConnection();

             PreparedStatement ps =
                     connection.prepareStatement(
                             INSERT_ORDER_QUERY,
                             Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());

            ps.setTimestamp(2,
                    new Timestamp(order.getOrderDate().getTime()));

            ps.setDouble(3, order.getTotalAmount());

            ps.setString(4, order.getStatus());

            ps.setString(5, order.getPaymentMethod());

            ps.setInt(6, order.getRestaurantId());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if(rs.next()) {

                generatedOrderId = rs.getInt(1);

            }

        }
        catch(SQLException e) {

            e.printStackTrace();

        }

        return generatedOrderId;
    }

    @Override
    public OrderTable getOrder(int orderId) {

        OrderTable order = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_ORDER_QUERY)) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                order = extractOrder(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }
    @Override
    public List<OrderTable> getOrdersByUserId(int userId) {

        List<OrderTable> orderList = new ArrayList<>();

        try(Connection connection = DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(GET_ORDER_BY_USER_QUERY)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                orderList.add(extractOrder(rs));

            }

        }
        catch(SQLException e) {

            e.printStackTrace();

        }

        return orderList;
    }
    @Override
    public OrderTable getLatestOrder(int userId) {

        OrderTable order = null;

        try(Connection connection = DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(GET_LATEST_ORDER_QUERY)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                order = extractOrder(rs);

            }

        }
        catch(SQLException e) {

            e.printStackTrace();

        }

        return order;
    }

    @Override
    public void updateOrder(OrderTable order) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_ORDER_QUERY)) {

            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, new Timestamp(order.getOrderDate().getTime()));
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getPaymentMethod());
            ps.setInt(6, order.getRestaurantId());
            ps.setInt(7, order.getOrderId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_ORDER_QUERY)) {

            ps.setInt(1, orderId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderTable> getAllOrders() {

        List<OrderTable> orderList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet rs = statement.executeQuery(GET_ALL_ORDERS_QUERY)) {

            while (rs.next()) {
                orderList.add(extractOrder(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }
    

    private OrderTable extractOrder(ResultSet rs) throws SQLException {

        int orderId = rs.getInt("orderId");
        int userId = rs.getInt("userId");
        java.util.Date orderDate = rs.getTimestamp("orderDate");
        double totalAmount = rs.getDouble("totalAmount");
        String status = rs.getString("status");
        String paymentMethod = rs.getString("paymentMethod");
        int restaurantId = rs.getInt("restaurantId");

        return new OrderTable(orderId, userId, orderDate,
                totalAmount, status, paymentMethod, restaurantId);
    }
}