package sk.uniza.kmikt.employees;

import sk.uniza.kmikt.DatabaseConnectionManager;
import sk.uniza.kmikt.users.User;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeeController {
    public int selectEmployeeId(String id) {
        int numOfSelected = 0;
        String sql = "SELECT COUNT(*) as count FROM employees WHERE identific_number=?";
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

    public Employee selectEmployee(String identificNumber) {
        Employee employee = null;
        String sql = "SELECT * FROM employees WHERE identific_number=?";
        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, identificNumber);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                employee = new Employee(
                        rs.getInt("id"),
                        rs.getInt("phone_number"),
                        rs.getString("identific_number"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("role")
                        );
            }

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return employee;
    }

    public int updateEmployee(Employee employee) {
        int numOfUpdated = 0;
        String sql = "UPDATE employees SET phone_number=? WHERE identific_number = ?";

        try (
                Connection con = DatabaseConnectionManager.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, employee.getPhoneNumber());
            ps.setString(2, employee.getIdentificationNumber());
            numOfUpdated = ps.executeUpdate();

        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }

        return numOfUpdated;
    }
}
