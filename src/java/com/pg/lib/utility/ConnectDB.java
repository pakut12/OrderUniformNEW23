/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.utility;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author pakutsing
 */
public class ConnectDB {

    public static Connection getConnection() throws ClassNotFoundException, SQLException, NamingException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@10.0.62.18:1521:stock", "comp", "pmoc4");
        return con;
    }

    public static Connection getConnectionPGCA() throws ClassNotFoundException, SQLException, NamingException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = (Connection) DriverManager.getConnection("jdbc:oracle:thin:@10.0.62.18:1521:stock", "pgca", "acgpg");
        return con;
    }

    public static void closeConnection(Connection conn) throws SQLException {
        conn.close();
        conn = null;
    }
}