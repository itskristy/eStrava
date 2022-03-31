package sk.uniza.kmikt.orders;

import sk.uniza.kmikt.meals.Meal;

import java.util.List;

public class Order {
    private int id;
    private int userId;
    private int menuId;
    private String orderDate;

    public Order(int id, int userId, String orderDate, int menuId) {
        this.id = id;
        this.userId = userId;
        this.orderDate = orderDate;
        this.menuId = menuId;
    }

    public Order(int userId, String orderDate, int menuId) {
        this.userId = userId;
        this.orderDate = orderDate;
        this.menuId = menuId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }
}
