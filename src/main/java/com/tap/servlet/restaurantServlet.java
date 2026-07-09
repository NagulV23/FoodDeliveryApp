package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import com.tap.daoimplementation.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/callRestaurantServlet")
public class restaurantServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
throws ServletException, IOException {

//System.out.println("Restaurant Servlet Called");

		RestaurantDAOImpl dao = new RestaurantDAOImpl();

		List<Restaurant> allRestaurants = dao.getAllRestaurants();

		System.out.println("Restaurant Size = " + allRestaurants.size());

		for (Restaurant r : allRestaurants) {
		    System.out.println(r);
		}

		req.setAttribute("allRestaurants", allRestaurants);

		RequestDispatcher rd = req.getRequestDispatcher("restaurant.jsp");
		rd.forward(req, resp);
}
}