package sk.uniza.kmikt;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectionManager {

    public static Connection getConnection() throws NamingException, SQLException {
        /*DataSource ds;
        Context initContext;
        Connection con = null;

        initContext = new InitialContext();
        Context env = (Context) initContext.lookup("java:/comp/env");
        ds = (DataSource) env.lookup("mysqlpool");

        con = ds.getConnection();
        return con;*/

        Connection con = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con= DriverManager.getConnection("jdbc:mysql://azuremysql-estrava.mysql.database.azure.com:3306/estrava","mysqladmin","estrava160.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return con;
    }
}
