package sk.uniza.kmikt.menus;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.meals.Meal;

import javax.naming.NamingException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuController {

    java.text.DateFormat df = new java.text.SimpleDateFormat("dd. MM. yyyy");

    public List<DailyMenu> selectAllMenus() {
        List<DailyMenu> menus = new ArrayList<>();
        String sql = "SELECT * FROM daily_menu_list";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                String date = df.format(rs.getDate("dateof_menu"));
                DailyMenu menu = new DailyMenu(
                        rs.getInt("menu_id"),
                        date,
                        rs.getString("dateof_menu")
                );

                menus.add(menu);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return menus;
    }

    public int deleteMenu(int menuId) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM daily_menu_list WHERE menu_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public int insertMenu(DailyMenu menu) {
        int numOfInserted = 0;
        String sql = "INSERT INTO daily_menu_list (dateof_menu) VALUES (?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setDate(1, Date.valueOf(menu.getDate()));

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public List<Integer> selectAllMenuItems(int id) {
        List<Integer> items = new ArrayList<>();
        String sql = "SELECT * FROM daily_menu_items WHERE menu_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                items.add(rs.getInt("meal_id"));
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return items;
    }

    public int selectMenuItemByMealId(int id) {
        int numOfSelected = 0;
        String sql = "SELECT  COUNT(*) as count FROM daily_menu_items WHERE meal_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                numOfSelected = rs.getInt("count");
            }


        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfSelected;
    }

    public int deleteMenuItemsByMenuIdAndCategory(int menuId, int category) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM daily_menu_items WHERE menu_id = ? AND meal_category_id=?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            ps.setInt(2, category);
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public int insertMenuItem(int mealId, int menuId, int category) {
        int numOfInserted = 0;
        String sql = "INSERT INTO daily_menu_items (menu_id, meal_id, meal_category_id) VALUES (?, ?, ?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            ps.setInt(2, mealId);
            ps.setInt(3, category);

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public int deleteMenuItems(int menuId) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM daily_menu_items WHERE menu_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public int selectMenuByDate(String toDate) {
        int id = 0;
        String sql = "SELECT menu_id FROM daily_menu_list WHERE dateof_menu=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setDate(1, Date.valueOf(toDate));
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                id = rs.getInt("menu_id");
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return id;
    }

    public List<DailyMenu> selectMenuById(int menuId) {
        List<DailyMenu> menus = new ArrayList<>();
        String sql = "SELECT * FROM daily_menu_list WHERE menu_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, menuId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                String date = df.format(rs.getDate("dateof_menu"));
                DailyMenu menu = new DailyMenu(
                        rs.getInt("menu_id"),
                        date,
                        rs.getString("dateof_menu")
                );

                menus.add(menu);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return menus;
    }
}
