package com.tap.model;

import java.util.HashMap;
import java.util.Map;

public class cart {

    private Map<Integer, cartItem> items;

    public cart() {
        items = new HashMap<>();
    }

    public Map<Integer, cartItem> getItems() {
        return items;
    }

    // Add Item
    public void addItem(cartItem cartItem) {

        int menuId = cartItem.getMenuId();

        if(items.containsKey(menuId)) {

            cartItem existingItem = items.get(menuId);

            existingItem.setQuantity(
                    existingItem.getQuantity() + cartItem.getQuantity());

        } else {

            items.put(menuId, cartItem);
        }
    }

    // Update Quantity
    public void updateItem(int menuId, int quantity) {

        if(items.containsKey(menuId)) {

            if(quantity <= 0) {
                items.remove(menuId);
            } else {
                items.get(menuId).setQuantity(quantity);
            }
        }
    }

    // Remove Item
    public void removeItem(int menuId) {

        items.remove(menuId);
    }

    // Clear Cart
    public void clearCart() {

        items.clear();
    }

    // Get Total Amount
    public double getTotalAmount() {

        double total = 0;

        for(cartItem item : items.values()) {

            total += item.getPrice() * item.getQuantity();
        }

        return total;
    }
}