/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import com.pg.lib.model.OUUploadOrder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.pg.lib.utility.ConnectDB;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author pakutsing
 */
public class OrderService {

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    public Boolean addorderlist(List<OUUploadOrder> listorder) throws ClassNotFoundException, SQLException, NamingException {
        Boolean status = null;
        String sql = createSqlText(listorder);
        try {
            conn = ConnectDB.getConnectionMysql();
            ps = conn.prepareStatement(sql);
            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }
        return status;
    }

    public String createSqlText(List<OUUploadOrder> listorder) throws ClassNotFoundException, SQLException, NamingException {
        String sql = "INSERT INTO ou_orderupload(order_id, doc_id, receipt_id, order_cms_id, order_cms_fullname, order_cms_company, order_cms_department, order_product_id, order_product_barcode, order_product_name, order_mat_group, order_mat_name, order_product_qty, order_price_exc_vat, order_price_inc_vat) VALUES ";
        int docid = getdocid() + 1;
        int primarykey = getlastprimarykey() + 1;
        /*
        for (OUUploadOrder orderdetail : listorder) {
        System.out.println(orderdetail.getReceipt_id());
        System.out.println(orderdetail.getOrder_cms_id());
        System.out.println(orderdetail.getOrder_cms_fullname());
        System.out.println(orderdetail.getOrder_cms_company());
        System.out.println(orderdetail.getOrder_cms_department());
        System.out.println(orderdetail.getOrder_product_id());
        System.out.println(orderdetail.getOrder_product_barcode());
        System.out.println(orderdetail.getOrder_product_name());
        System.out.println(orderdetail.getOrder_mat_group());
        System.out.println(orderdetail.getOrder_mat_name());
        System.out.println(orderdetail.getOrder_product_qty());
        System.out.println(orderdetail.getOrder_price_inc_vat());
        System.out.println(orderdetail.getOrder_price_exc_vat());
        System.out.println("------------------------------------------------------------------------------------------------------");
        }
         */
        for (int n = 0; n < listorder.size(); n++) {
            if (n != listorder.size() - 1) {
                sql += "('" + primarykey + "',";
                sql += "'" + docid + "',";
                sql += "'" + listorder.get(n).getReceipt_id() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_id() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_fullname() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_company() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_department() + "',";
                sql += "'" + listorder.get(n).getOrder_product_id() + "',";
                sql += "'" + listorder.get(n).getOrder_product_barcode() + "',";
                sql += "'" + listorder.get(n).getOrder_product_name() + "',";
                sql += "'" + listorder.get(n).getOrder_mat_group() + "',";
                sql += "'" + listorder.get(n).getOrder_mat_name() + "',";
                sql += "'" + listorder.get(n).getOrder_product_id() + "',";
                sql += "'" + listorder.get(n).getOrder_price_inc_vat() + "',";
                sql += "'" + listorder.get(n).getOrder_price_exc_vat() + "'),";
            } else {
                sql += "('" + n + "',";
                sql += "'" + n + "',";
                sql += "'" + listorder.get(n).getReceipt_id() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_id() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_fullname() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_company() + "',";
                sql += "'" + listorder.get(n).getOrder_cms_department() + "',";
                sql += "'" + listorder.get(n).getOrder_product_id() + "',";
                sql += "'" + listorder.get(n).getOrder_product_barcode() + "',";
                sql += "'" + listorder.get(n).getOrder_product_name() + "',";
                sql += "'" + listorder.get(n).getOrder_mat_group() + "',";
                sql += "'" + listorder.get(n).getOrder_mat_name() + "',";
                sql += "'" + listorder.get(n).getOrder_product_id() + "',";
                sql += "'" + listorder.get(n).getOrder_price_inc_vat() + "',";
                sql += "'" + listorder.get(n).getOrder_price_exc_vat() + "')";
            }
            primarykey++;
        }

        return sql;
    }

    private int getlastprimarykey() throws ClassNotFoundException, SQLException, NamingException {
        int primarykey = 0;
        String sql = "SELECT MAX(order_id) as lastprimarykey FROM ou_orderupload";
        try {
            conn = ConnectDB.getConnectionMysql();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                primarykey = rs.getInt("lastprimarykey");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return primarykey;
    }

    private int getdocid() throws ClassNotFoundException, SQLException, NamingException {
        int docid = 0;
        String sql = "SELECT MAX(doc_id) as lastdocid FROM ou_doc";
        try {
            conn = ConnectDB.getConnectionMysql();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                docid = rs.getInt("lastdocid");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return docid;
    }
}
