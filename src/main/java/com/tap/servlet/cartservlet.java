package com.tap.servlet;

import java.io.IOException;

import com.tap.daoimplementation.MenuDAOImpl;
import com.tap.model.Menu;
import com.tap.model.cart;
import com.tap.model.cartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cartservlet")
public class cartservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        cart cartObj = (cart) session.getAttribute("cart");

        if(cartObj == null) {

            cartObj = new cart();
            session.setAttribute("cart", cartObj);
        }

        String action = request.getParameter("action");

        int menuId =
                Integer.parseInt(request.getParameter("menuId"));

        // ADD ITEM
        if("add".equals(action)) {

            MenuDAOImpl dao = new MenuDAOImpl();

            Menu menu = dao.getMenu(menuId);
            System.out.println("Menu Name  : " + menu.getItemName());
            System.out.println("Image Path : " + menu.getImagePath());

            cartItem item = new cartItem(
                    menu.getMenuId(),
                    menu.getRestaurantId(),
                    menu.getItemName(),
                    menu.getPrice(),
                    1,
                    menu.getImagePath()
            );
            System.out.println("Cart Image : " + item.getImagePath());

            cartObj.addItem(item);
        }

        // UPDATE QUANTITY
        else if("update".equals(action)) {

            int quantity =
                    Integer.parseInt(request.getParameter("quantity"));

            cartObj.updateItem(menuId, quantity);
        }

        // REMOVE ITEM
        else if("remove".equals(action)) {

            cartObj.removeItem(menuId);
        }

        session.setAttribute("cart", cartObj);

        response.sendRedirect("cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }
}