package sk.uniza.kmikt.market;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.meals.Meal;
import sk.uniza.kmikt.orders.Order;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MarketController {

    public List<MarketedItem> selectAllMarketedItem() {
        List<MarketedItem> items = new ArrayList<>();
        String sql = "SELECT * FROM market";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                MarketedItem item = new MarketedItem(
                        rs.getInt("market_item_id"),
                        rs.getInt("item_id")
                );

                items.add(item);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return items;
    }

    public int deleteMarketedItem(int itemId) {
        int numOfDeleted = 0;
        String sql = "DELETE FROM market WHERE item_id = ?";

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
}
