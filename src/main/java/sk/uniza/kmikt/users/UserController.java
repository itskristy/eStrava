package sk.uniza.kmikt.users;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.orders.OrderItem;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserController {
    public int insertUser(User user) {
        int numOfInserted = 0;
        String sql = "INSERT INTO users (identification_number, username, email, password, role) VALUES (?, ?, ?, ?, ?)";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, user.getIdentificationNumber());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());

            numOfInserted = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfInserted;
    }

    public User selectUser(String username) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("identification_number"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("username")
                );
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return user;
    }

    public User selectUserById(int id) {
        User user = null;
        String sql = "SELECT * FROM users WHERE user_id=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("identification_number"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("username")
                );
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return user;
    }

    public int countByEmail(String email) {
        int numOfSelected = 0;
        String sql = "SELECT COUNT(*) as count FROM users WHERE email=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                numOfSelected = rs.getInt("count");
            }


        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfSelected;
    }

    public int countById(String id) {
        int numOfSelected = 0;
        String sql = "SELECT COUNT(*) as count FROM users WHERE identification_number=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                numOfSelected = rs.getInt("count");
            }


        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfSelected;
    }

    public int updateUser(User user) {
        int numOfUpdated = 0;
        String sql = "UPDATE users SET email=? WHERE user_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, user.getEmail());
            ps.setInt(2, user.getId());
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }

    public int updateUserPassword(User user) {
        int numOfUpdated = 0;
        String sql = "UPDATE users SET password=? WHERE user_id = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, user.getPassword());
            ps.setInt(2, user.getId());
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }

    public int updateUserPasswordByEmail(String password, String email) {
        int numOfUpdated = 0;
        String sql = "UPDATE users SET password=? WHERE email = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, password);
            ps.setString(2, email);
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }

    public List<User> selectAllActiveUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE NOT role='admin'";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("identification_number"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("username")
                );

                users.add(user);
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return users;
    }
}
