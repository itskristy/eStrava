package sk.uniza.kmikt.meals;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.allergens.Allergen;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MealController {

    public List<Meal> selectAllMeals() {
        List<Meal> meals = new ArrayList<>();
        String sql = "SELECT * FROM meals";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Meal meal = new Meal(
                        rs.getInt("meal_id"),
                        rs.getInt("category"),
                        rs.getString("meal_name"),
                        rs.getDouble("price")
                );

                meals.add(meal);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return meals;
    }

    public int deleteMeal(Meal meal) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM meals WHERE meal_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, meal.getId());
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public int updateMeal(Meal meal) {
        int numOfUpdated = 0;
        String sql = "UPDATE meals SET meal_name=?, price=? WHERE meal_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, meal.getMeal());
            ps.setDouble(2, meal.getPrice());
            ps.setInt(3, meal.getId());
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }

    public int insertMeal(Meal meal) {
        int numOfInserted = 0;
        String sql = "INSERT INTO meals (meal_name, category, price) VALUES (?, ?, ?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, meal.getMeal());
            ps.setInt(2, meal.getCategory());
            ps.setDouble(3, meal.getPrice());

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public List<Integer> selectAllAllergens(int id) {
        List<Integer> allergens = new ArrayList<>();
        String sql = "SELECT * FROM meal_allergens WHERE meal_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                allergens.add(rs.getInt("allergen_id"));
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return allergens;
    }

    public int deleteMealAllergens(int mealId) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM meal_allergens WHERE meal_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, mealId);
            numOfDeleted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfDeleted;
    }

    public int insertMealAllergen(int mealId, int allergenId) {
        int numOfInserted = 0;
        String sql = "INSERT INTO meal_allergens (meal_id, allergen_id) VALUES (?, ?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, mealId);
            ps.setInt(2, allergenId);

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public List<Meal> selectAllPrices(int id) {
        List<Meal> meals = new ArrayList<>();
        String sql = "SELECT * FROM meals WHERE meal_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Meal meal = new Meal(
                        rs.getString("meal_name"),
                        rs.getDouble("subsidized_price_civilian_employee"),
                        rs.getDouble("subsidized_price_policeman"),
                        rs.getDouble("subsidized_price_pensioner")
                );

                meals.add(meal);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return meals;
    }

    public int updateMealPrices(int id, Meal meal) {
        int numOfUpdated = 0;
        String sql = "UPDATE meals SET subsidized_price_civilian_employee=?, subsidized_price_policeman=?, subsidized_price_pensioner=? WHERE meal_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setDouble(1, meal.getSubsidizedPriceCE());
            ps.setDouble(2, meal.getSubsidizedPricePoliceman());
            ps.setDouble(3, meal.getSubsidizedPricePensioner());
            ps.setInt(4, id);
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }

    public Meal selectMealById(int mealId) {
        Meal meal = new Meal();
        String sql = "SELECT * FROM meals WHERE meal_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, mealId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                meal = new Meal(
                        rs.getInt("meal_id"),
                        rs.getInt("category"),
                        rs.getString("meal_name"),
                        rs.getDouble("subsidized_price_civilian_employee"),
                        rs.getDouble("subsidized_price_policeman"),
                        rs.getDouble("subsidized_price_pensioner"),
                        rs.getDouble("price")

                );
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return meal;
    }
}
