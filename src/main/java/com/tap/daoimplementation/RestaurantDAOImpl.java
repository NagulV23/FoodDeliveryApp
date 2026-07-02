package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    private static final String INSERT_RESTAURANT_QUERY =
            "INSERT INTO restaurant(name, cuisineType, deliveryTime, address, rating, isActive, imagePath) VALUES(?,?,?,?,?,?,?)";

    private static final String GET_RESTAURANT_QUERY =
            "SELECT * FROM restaurant WHERE restaurantId = ?";

    private static final String UPDATE_RESTAURANT_QUERY =
            "UPDATE restaurant SET name=?, cuisineType=?, deliveryTime=?, address=?, rating=?, isActive=?, imagePath=? WHERE restaurantId=?";

    private static final String DELETE_RESTAURANT_QUERY =
            "DELETE FROM restaurant WHERE restaurantId = ?";

    private static final String GET_ALL_RESTAURANTS_QUERY =
            "SELECT * FROM restaurant";

    @Override
    public void addRestaurant(Restaurant restaurant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(INSERT_RESTAURANT_QUERY)) {

            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getCuisineType());
            preparedStatement.setInt(3, restaurant.getDeliveryTime());
            preparedStatement.setString(4, restaurant.getAddress());
            preparedStatement.setDouble(5, restaurant.getRating());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setString(7, restaurant.getImagePath());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {

        Restaurant restaurant = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_RESTAURANT_QUERY)) {

            preparedStatement.setInt(1, restaurantId);

            ResultSet res = preparedStatement.executeQuery();

            if (res.next()) {
                restaurant = extractRestaurant(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(UPDATE_RESTAURANT_QUERY)) {

            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getCuisineType());
            preparedStatement.setInt(3, restaurant.getDeliveryTime());
            preparedStatement.setString(4, restaurant.getAddress());
            preparedStatement.setDouble(5, restaurant.getRating());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setString(7, restaurant.getImagePath());
            preparedStatement.setInt(8, restaurant.getRestaurantId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(DELETE_RESTAURANT_QUERY)) {

            preparedStatement.setInt(1, restaurantId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {

        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet res = statement.executeQuery(GET_ALL_RESTAURANTS_QUERY)) {

            while (res.next()) {
                Restaurant restaurant = extractRestaurant(res);
                restaurantList.add(restaurant);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurantList;
    }

    private Restaurant extractRestaurant(ResultSet res) throws SQLException {

        int restaurantId = res.getInt("restaurantId");
        String name = res.getString("name");
        String cuisineType = res.getString("cuisineType");
        int deliveryTime = res.getInt("deliveryTime");
        String address = res.getString("address");
        double rating = res.getDouble("rating");
        boolean isActive = res.getBoolean("isActive");
        String imagePath = res.getString("imagePath");

        return new Restaurant(
                restaurantId,
                name,
                cuisineType,
                deliveryTime,
                address,
                rating,
                isActive,
                imagePath
        );
    }

    @Override
    public Restaurant getRestaurantById(int restaurantId) {
        Restaurant restaurant = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = 
                     connection.prepareStatement("SELECT * FROM restaurant WHERE restaurantId = ?")) {
            
            preparedStatement.setInt(1, restaurantId);
            ResultSet res = preparedStatement.executeQuery();
            
            if (res.next()) {
                restaurant = extractRestaurant(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurant;
    }
}