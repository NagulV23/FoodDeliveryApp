package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

  private static final String INSERT_MENU_QUERY =
            "INSERT INTO menu(restaurantId, itemName, description, price, isAvailable, imagePath) VALUES(?,?,?,?,?,?)";

    private static final String GET_MENU_QUERY =
            "SELECT * FROM menu WHERE menuId = ?";

    private static final String UPDATE_MENU_QUERY =
            "UPDATE menu SET restaurantId=?, itemName=?, description=?, price=?, isAvailable=?, imagePath=? WHERE menuId=?";

    private static final String DELETE_MENU_QUERY =
            "DELETE FROM menu WHERE menuId = ?";
    
	private static final String GET_ALL_MENUS_QUERY =
	        "SELECT * FROM menu";

    private static final String GET_MENUS_BY_RESTAURANT_QUERY =
            "SELECT * FROM menu WHERE restaurantId = ?";

    @Override
    public void addMenu(Menu menu) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(INSERT_MENU_QUERY)) {

            preparedStatement.setInt(1, menu.getRestaurantId());
            preparedStatement.setString(2, menu.getItemName());
            preparedStatement.setString(3, menu.getDescription());
            preparedStatement.setDouble(4, menu.getPrice());
            preparedStatement.setBoolean(5, menu.isAvailable());
            preparedStatement.setString(6, menu.getImagePath());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {

        Menu menu = null;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_MENU_QUERY)) {

            preparedStatement.setInt(1, menuId);

            ResultSet res = preparedStatement.executeQuery();

            if (res.next()) {
                menu = extractMenu(res);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }

    @Override
    public void updateMenu(Menu menu) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(UPDATE_MENU_QUERY)) {

            preparedStatement.setInt(1, menu.getRestaurantId());
            preparedStatement.setString(2, menu.getItemName());
            preparedStatement.setString(3, menu.getDescription());
            preparedStatement.setDouble(4, menu.getPrice());
            preparedStatement.setBoolean(5, menu.isAvailable());
            preparedStatement.setString(6, menu.getImagePath());
            preparedStatement.setInt(7, menu.getMenuId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(DELETE_MENU_QUERY)) {

            preparedStatement.setInt(1, menuId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

  
    public List<Menu> getAllMenus() {

        List<Menu> menuList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet res = statement.executeQuery(GET_ALL_MENUS_QUERY)) {

            while (res.next()) {
                Menu menu = extractMenu(res);
                menuList.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    /**
     * Helper method to create a Menu object from ResultSet
     */
    private Menu extractMenu(ResultSet res) throws SQLException {

        int menuId = res.getInt("menuId");
        int restaurantId = res.getInt("restaurantId");
        String itemName = res.getString("itemName");
        String description = res.getString("description");
        double price = res.getDouble("price");
        boolean isAvailable = res.getBoolean("isAvailable");
        String imagePath = res.getString("imagePath");

        return new Menu(
                menuId,
                restaurantId,
                itemName,
                description,
                price,
                isAvailable,
                imagePath
        );
    }

    @Override
    public List<Menu> getAllMenusByRestaurant(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(GET_MENUS_BY_RESTAURANT_QUERY)) {

            preparedStatement.setInt(1, restaurantId);

            ResultSet res = preparedStatement.executeQuery();

            while (res.next()) {
                Menu menu = extractMenu(res);
                menuList.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }
}