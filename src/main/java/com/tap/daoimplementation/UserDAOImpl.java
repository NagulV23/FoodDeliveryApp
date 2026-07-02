package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

public class UserDAOImpl implements UserDAO {
	private static final String INSERT_USER_QUERY ="INSERT into 'user'('name', 'username', 'password', 'email', 'phone', 'address', 'role',) values(?,?,?,?,?,?,?) ";
	private static final String GET_USER_QUERY= "SELECT * FROM 'user' WHERE 'userId' = ?";
	private static final String UPDATE_USER_QUERY = "UPDATE 'user' SET 'name' = ? 'password' = ? 'phone' = ? 'address' = ? 'role' = ?";
	private static final String DELETE_USER_QUERY  = "DELETE FROM 'user' WHERE 'userId' = ? ";
	private static final String GET_ALL_USERS_QUERY = "SELECT * FROM 'user'";
	private static final String GET_USER_BY_EMAIL =
	        "SELECT * FROM users WHERE email=?";
	
	@Override
	public void addUser(User user){
		
		//String INSERT_USER_QUERY ="INSERT into 'user'('name', 'username', 'password', 'email', 'phone', 'address', 'role',) values(?,?,?,?,?,?,?) ";
		
	try(Connection connection = DBConnection.getConnection();
			PreparedStatement prepareStatement= connection.prepareStatement(INSERT_USER_QUERY)) {
		
		
		prepareStatement.setString(1, user.getName() );
		prepareStatement.setString(2, user.getUsername() );
		prepareStatement.setString(3, user.getPassword() );
		prepareStatement.setString(4, user.getEmail() );
		prepareStatement.setString(5, user.getPhone() );
		prepareStatement.setString(6, user.getAddress() );
		prepareStatement.setString(7, user.getRole() );
		
		int executeUpdate = prepareStatement.executeUpdate();
		
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
		
	}
	
	@Override
	public User getUser(int userId) {
	
		User user = null;
		
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement prepareStatement = connection.prepareStatement(GET_USER_QUERY);) {
			
			prepareStatement.setInt(1, userId);
			ResultSet res = prepareStatement.executeQuery();
			
			 user = extractUser(res);
			}catch(SQLException e) {
					e.printStackTrace();
				}
		return user;
	}

	@Override
	public void updateUser(User user) {
		
		
		Connection connection = null;
		PreparedStatement preparedStatement;
		
		try {
			connection = DBConnection.getConnection();	
			preparedStatement = connection.prepareStatement(UPDATE_USER_QUERY);
			
		preparedStatement.setString(1, user.getName() );
		preparedStatement.setString(2, user.getPassword() );
		preparedStatement.setString(3, user.getPhone() );
		preparedStatement.setString(4, user.getAddress() );
		preparedStatement.setString(5, user.getRole() );
		
		preparedStatement.executeUpdate();
		
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
@Override
	public void deleteUser(int userId) {
	
	
	Connection connection = null;
	try {
	 connection = DBConnection.getConnection();
	PreparedStatement preparestatement = connection.prepareStatement(DELETE_USER_QUERY);
	
	preparestatement.setInt(1, userId);
	preparestatement.executeUpdate();
	} catch(SQLException e ) {
		e.printStackTrace();
	}
		
		
	}

	@Override
	public List<User> getAllUsers() {
		
		
		ArrayList<User> userslist = new ArrayList<User>();
		try {
		Connection connection = DBConnection.getConnection();
		Statement statement = connection.createStatement();
		
		ResultSet res = statement.executeQuery(GET_ALL_USERS_QUERY);
		
		while(res.next()) {
			 User user = extractUser(res);
			userslist.add(user);
			
		}
		
		
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return userslist;
	}
	User extractUser(ResultSet res) throws SQLException{
		int userId = res.getInt("userId");
		String name = res.getString("name");
		String username = res.getString("username");
		String password = res.getString("password");
		String email = res.getString("email");
		String phone = res.getString("phone");
		String address = res.getString("address");
		String role = res.getString("role");
		
		User user = new User(userId, name, username, password, email, phone, address, role, null, null);
		
		return user;
	}
	@Override
	public User getUserByEmail(String email) {

	    User user = null;

	    try(Connection connection = DBConnection.getConnection();
	        PreparedStatement ps =
	                connection.prepareStatement(GET_USER_BY_EMAIL)) {

	        ps.setString(1, email);

	        ResultSet rs = ps.executeQuery();

	        if(rs.next()) {

	            user = new User();

	            user.setUserId(rs.getInt("userId"));
	            user.setName(rs.getString("name"));
	            user.setUsername(rs.getString("username"));
	            user.setPassword(rs.getString("password"));
	            user.setEmail(rs.getString("email"));
	            user.setPhone(rs.getString("phone"));
	            user.setAddress(rs.getString("address"));
	            user.setRole(rs.getString("role"));
	        }

	    } catch(Exception e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	

}
