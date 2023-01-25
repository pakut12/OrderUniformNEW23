package com.pg.lib.service;

import com.pg.lib.utility.ConnectDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthenticationService {

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    public static boolean checkStatusWorking(String user) {
        boolean statusWorking = false;
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement("SELECT pwstatwork FROM v_pwemployee WHERE pwemployee = ?");
            ps.setString(1, user);
            rs = ps.executeQuery();

            if (rs.next()) {
                if (!rs.getString("pwstatwork").trim().equals("Y")) {
                    statusWorking = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                ps.close();
                ConnectDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return statusWorking;
    }

    public static boolean Checklogin(String username, String digestpass) {

        boolean statusLogin = false;
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement("SELECT count(passwd) as statuslogin from pgusertab where userid = ? and passwd = ? ");
            ps.setString(1, username);
            ps.setString(2, digestpass);
            rs = ps.executeQuery();

            if (rs.next()) {
                statusLogin = rs.getBoolean("statuslogin") ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                ps.close();
                ConnectDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return statusLogin;
    }

    public static String GetEmployee(String userid) {
        String name = "";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement("" +
                    "SELECT prefixdesc, pwfname, pwlname " +
                    "FROM v_pwemployee " +
                    "WHERE pwemployee = ? ");
            ps.setString(1, userid);
            rs = ps.executeQuery();
            while (rs.next()) {
                name = rs.getString("prefixdesc") + " " + rs.getString("pwfname") + " " + rs.getString("pwlname");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                ps.close();
                ConnectDB.closeConnection(conn);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return name;
    }
}
