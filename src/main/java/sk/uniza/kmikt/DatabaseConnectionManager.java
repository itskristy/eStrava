package sk.uniza.kmikt;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnectionManager {

    public static Connection getConnection() throws NamingException, SQLException {
        DataSource ds;
        Context initContext;
        Connection con = null;

        initContext = new InitialContext();
        Context env = (Context) initContext.lookup("java:/comp/env");
        ds = (DataSource) env.lookup("mysqlpool");

        con = ds.getConnection();
        return con;
    }
}
