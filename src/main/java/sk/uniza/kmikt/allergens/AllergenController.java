package sk.uniza.kmikt.allergens;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.users.User;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AllergenController {

    public List<Allergen> selectAllAllergens() {
        List<Allergen> allergens = new ArrayList<>();
        String sql = "SELECT * FROM allergens";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Allergen allergen = new Allergen(
                        rs.getInt("allergen_id"),
                        rs.getString("allergen_name")
                );

                allergens.add(allergen);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return allergens;
    }
}
