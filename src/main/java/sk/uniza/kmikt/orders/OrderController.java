package sk.uniza.kmikt.orders;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.menus.DailyMenu;
import sk.uniza.kmikt.users.User;

import javax.naming.NamingException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderController {

    public List<Order> selectOrdersByMenuIdForUser(int menuId, int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE menu_id=? AND user_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("date_of_order"),
                        rs.getInt("menu_id")
                );

                orders.add(order);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public int insertOrder(Order order) {
        int numOfInserted = 0;
        String sql = "INSERT INTO orders (user_id, date_of_order, menu_id) VALUES (?, ?, ?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, order.getUserId());
            ps.setDate(2, Date.valueOf(order.getOrderDate()));
            ps.setInt(3, order.getMenuId());

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public int insertOrderItems(int orderId, int itemId, double price, boolean isPacked, boolean isMarketed) {
        int numOfInserted = 0;
        String sql = "INSERT INTO order_items (order_id, item_id, price, is_packed, is_marketed) VALUES (?, ?, ?, ?, ?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);
            ps.setInt(2, itemId);
            ps.setDouble(3, price);
            ps.setBoolean(4, isPacked);
            ps.setBoolean(5, isMarketed);

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public int selectLastAddedOrder() {
        int orderId = 0;
        String sql = "SELECT * FROM orders WHERE order_id=(SELECT max(order_id) FROM orders)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                orderId = rs.getInt("order_id");
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return orderId;
    }

    public List<Order> selectOrdersByMonthForUser(String dateFrom, String dateTo, int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE date_of_order BETWEEN ? AND ? AND user_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, dateFrom);
            ps.setString(2, dateTo);
            ps.setInt(3, userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("date_of_order"),
                        rs.getInt("menu_id")
                );

                orders.add(order);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<OrderItem> selectOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                OrderItem item = new OrderItem(
                        rs.getInt("order_item_id"),
                        rs.getInt("item_id"),
                        rs.getInt("order_id"),
                        rs.getDouble("price"),
                        rs.getBoolean("is_packed"),
                        rs.getBoolean("is_marketed")
                );

                items.add(item);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return items;
    }

    public int deleteOrderItem(int itemId) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM order_items WHERE order_item_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, itemId);
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public int deleteOrder(int orderId) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM orders WHERE order_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public List<Order> selectOrdersByMonth(String dateFrom, String dateTo) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE date_of_order BETWEEN ? AND ?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, dateFrom);
            ps.setString(2, dateTo);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("date_of_order"),
                        rs.getInt("menu_id")
                );

                orders.add(order);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> selectOrdersByMenu(int menuId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE menu_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("date_of_order"),
                        rs.getInt("menu_id")
                );

                orders.add(order);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public int copyOrderItemToMarket(int itemId) {
        int numOfInserted = 0;
        String sql = "INSERT INTO market (item_id) VALUES (?)";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, itemId);
            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public int updateOrderItem(int itemId, boolean isMarketed) {
        int numOfUpdated = 0;
        String sql = "UPDATE order_items SET is_marketed=? WHERE order_item_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setBoolean(1, isMarketed);
            ps.setInt(2, itemId);
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }

    public OrderItem selectOrderItemById(int itemId) {
        OrderItem item = new OrderItem();
        String sql = "SELECT * FROM order_items WHERE order_item_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                item = new OrderItem(
                        rs.getInt("order_item_id"),
                        rs.getInt("item_id"),
                        rs.getInt("order_id"),
                        rs.getDouble("price"),
                        rs.getBoolean("is_packed"),
                        rs.getBoolean("is_marketed")
                );
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return item;
    }
}
