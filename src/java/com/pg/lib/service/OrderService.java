/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import com.pg.lib.model.OUDepartment;
import com.pg.lib.model.OUDocList;
import com.pg.lib.model.OUOrderSortBySize;
import com.pg.lib.model.OUUploadOrder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.pg.lib.utility.ConnectDB;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import javax.naming.NamingException;

/**
 *
 * @author pakutsing
 */
public class OrderService {

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    private String getDate() {
        SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
        Date date = new Date();
        String todey = dt.format(date);
        return todey;
    }

    public Boolean ConfirmBox(String doc_id) throws SQLException {
        Boolean status = null;
        String sql = "UPDATE ounew_transaction SET doc_status = ? WHERE doc_id = ?";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "packingboxsucces");
            ps.setString(2, doc_id);
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

    public Boolean ConfirmBag(String doc_id) throws SQLException {
        Boolean status = null;
        String sql = "UPDATE ounew_transaction SET doc_status = ? WHERE doc_id = ?";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "packingbagsucces");
            ps.setString(2, doc_id);
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

    public List<OUDepartment> getDepartment(String doc_id) throws SQLException {
        List<OUDepartment> listdepartment = new ArrayList();
        String sql = "SELECT doc_name, order_cms_department FROM ounew_orderupload a INNER JOIN ounew_transaction b ON b.doc_id = a.doc_id WHERE b.doc_id = ? GROUP BY order_cms_department";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, doc_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUDepartment department = new OUDepartment();
                department.setDepartment(rs.getString("order_cms_department"));
                department.setDoc_name(rs.getString("doc_name"));
                listdepartment.add(department);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return listdepartment;
    }

    public Boolean addorderdoc(String docname) throws ClassNotFoundException, SQLException, NamingException {
        Boolean status = null;
        int primarykey = getdocid() + 1;
        String sql = "INSERT INTO ounew_transaction (doc_id, doc_name, doc_status, date_create) VALUES (?, ?, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS'))";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, primarykey);
            ps.setString(2, docname);
            ps.setString(3, "new");
            ps.setString(4, getDate());

            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            status = false;
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }

        return status;
    }

    public Boolean addorderlist(List<OUUploadOrder> listorder) throws ClassNotFoundException, SQLException, NamingException {
        Boolean status = null;
        String sql = createSqlText(listorder);

        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            status = false;
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }
        return status;
    }

    public String createSqlText(List<OUUploadOrder> listorder) throws ClassNotFoundException, SQLException, NamingException {
        String sql = "INSERT ALL ";
        int primarykey = getlastprimarykey() + 1;
        int docid = getdocid() + 1;
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
                sql += " INTO ounew_orderupload(order_id, doc_id, receipt_id, order_cms_id, order_cms_fullname, order_cms_company, order_cms_department, order_product_id, order_product_barcode, order_product_name, order_mat_group, order_mat_name, order_product_qty, order_price_exc_vat, order_price_inc_vat,order_status,date_create) VALUES  ('" + primarykey + "',";
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
                sql += "'" + listorder.get(n).getOrder_product_qty() + "',";
                sql += "'" + listorder.get(n).getOrder_price_inc_vat() + "',";
                sql += "'" + listorder.get(n).getOrder_price_exc_vat() + "',";
                sql += "'new',";
                sql += "TO_DATE('" + getDate() + "', 'YYYY-MM-DD HH24:MI:SS'))";
            } else {
                sql += " INTO ounew_orderupload(order_id, doc_id, receipt_id, order_cms_id, order_cms_fullname, order_cms_company, order_cms_department, order_product_id, order_product_barcode, order_product_name, order_mat_group, order_mat_name, order_product_qty, order_price_exc_vat, order_price_inc_vat,order_status,date_create) VALUES ('" + primarykey + "',";
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
                sql += "'" + listorder.get(n).getOrder_product_qty() + "',";
                sql += "'" + listorder.get(n).getOrder_price_inc_vat() + "',";
                sql += "'" + listorder.get(n).getOrder_price_exc_vat() + "',";
                sql += "'new',";
                sql += "TO_DATE('" + getDate() + "', 'YYYY-MM-DD HH24:MI:SS'))";
            }
            primarykey++;
        }
        sql += " SELECT * FROM dual";
        return sql;
    }

    private int getlastprimarykey() throws ClassNotFoundException, SQLException, NamingException {
        int primarykey = 0;
        String sql = "SELECT MAX(order_id) as lastprimarykey FROM ounew_orderupload";
        try {
            conn = ConnectDB.getConnection();
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
        String sql = "SELECT MAX(doc_id) as lastdocid FROM ounew_transaction";
        try {
            conn = ConnectDB.getConnection();
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

    public List<OUDocList> getDocList() throws SQLException {
        List<OUDocList> listorder = new ArrayList();
        String sql = "SELECT * FROM ounew_transaction WHERE doc_id != 99 ORDER BY doc_id DESC";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUDocList doc = new OUDocList();
                doc.setDoc_id(rs.getString("doc_id"));
                doc.setDoc_name(rs.getString("doc_name"));
                doc.setDoc_status(rs.getString("doc_status"));
                doc.setDate_create(rs.getString("date_create"));
                listorder.add(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return listorder;
    }

    public List<OUUploadOrder> getorderlistbydocidandcustomerid(String docid, String customerid) throws ClassNotFoundException, SQLException, NamingException {
        List<OUUploadOrder> listorder = new ArrayList<OUUploadOrder>();
        String sql = "SELECT * FROM ounew_orderupload WHERE doc_id = ? AND order_cms_id = ?";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, docid);
            ps.setString(2, customerid);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUUploadOrder order = new OUUploadOrder();
                order.setOrder_id(rs.getString("order_id"));
                order.setDoc_id(rs.getString("doc_id"));
                order.setReceipt_id(rs.getString("receipt_id"));
                order.setOrder_cms_id(rs.getString("order_cms_id"));
                order.setOrder_cms_fullname(rs.getString("order_cms_fullname"));
                order.setOrder_cms_company(rs.getString("order_cms_company"));
                order.setOrder_cms_department(rs.getString("order_cms_department"));
                order.setOrder_product_id(rs.getString("order_product_id"));
                order.setOrder_product_barcode(rs.getString("order_product_barcode"));
                order.setOrder_product_name(rs.getString("order_product_name"));
                order.setOrder_mat_group(rs.getString("order_mat_group"));
                order.setOrder_mat_name(rs.getString("order_mat_name"));
                order.setOrder_product_qty(rs.getString("order_product_qty"));
                order.setOrder_price_exc_vat(rs.getString("order_price_exc_vat"));
                order.setOrder_price_inc_vat(rs.getString("order_price_inc_vat"));
                listorder.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return listorder;
    }

    public List<OUUploadOrder> getorderlistbydocidwithdepartment(String id, String department) throws ClassNotFoundException, SQLException, NamingException {
        List<OUUploadOrder> listorder = new ArrayList<OUUploadOrder>();
        String sql = "SELECT * FROM ounew_orderupload WHERE doc_id = ? AND order_cms_department = ? GROUP BY order_cms_id,order_cms_fullname,order_cms_company,order_cms_department";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, department);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUUploadOrder order = new OUUploadOrder();
                order.setOrder_id(rs.getString("order_id"));
                order.setDoc_id(rs.getString("doc_id"));
                order.setReceipt_id(rs.getString("receipt_id"));
                order.setOrder_cms_id(rs.getString("order_cms_id"));
                order.setOrder_cms_fullname(rs.getString("order_cms_fullname"));
                order.setOrder_cms_company(rs.getString("order_cms_company"));
                order.setOrder_cms_department(rs.getString("order_cms_department"));
                order.setOrder_product_id(rs.getString("order_product_id"));
                order.setOrder_product_barcode(rs.getString("order_product_barcode"));
                order.setOrder_product_name(rs.getString("order_product_name"));
                order.setOrder_mat_group(rs.getString("order_mat_group"));
                order.setOrder_mat_name(rs.getString("order_mat_name"));
                order.setOrder_product_qty(rs.getString("order_product_qty"));
                order.setOrder_price_exc_vat(rs.getString("order_price_exc_vat"));
                order.setOrder_price_inc_vat(rs.getString("order_price_inc_vat"));
                listorder.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return listorder;
    }

    public List<OUUploadOrder> getorderlistbydocid(String id) throws ClassNotFoundException, SQLException, NamingException {
        List<OUUploadOrder> listorder = new ArrayList<OUUploadOrder>();
        String sql = "SELECT * FROM ounew_orderupload WHERE doc_id = ? ORDER BY order_cms_department";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUUploadOrder order = new OUUploadOrder();
                order.setOrder_id(rs.getString("order_id"));
                order.setDoc_id(rs.getString("doc_id"));
                order.setReceipt_id(rs.getString("receipt_id"));
                order.setOrder_cms_id(rs.getString("order_cms_id"));
                order.setOrder_cms_fullname(rs.getString("order_cms_fullname"));
                order.setOrder_cms_company(rs.getString("order_cms_company"));
                order.setOrder_cms_department(rs.getString("order_cms_department"));
                order.setOrder_product_id(rs.getString("order_product_id"));
                order.setOrder_product_barcode(rs.getString("order_product_barcode"));
                order.setOrder_product_name(rs.getString("order_product_name"));
                order.setOrder_mat_group(rs.getString("order_mat_group"));
                order.setOrder_mat_name(rs.getString("order_mat_name"));
                order.setOrder_product_qty(rs.getString("order_product_qty"));
                order.setOrder_price_exc_vat(rs.getString("order_price_exc_vat"));
                order.setOrder_price_inc_vat(rs.getString("order_price_inc_vat"));
                listorder.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return listorder;
    }

    public List<OUUploadOrder> getorderlistbydocidsortbycustomer(String id) throws ClassNotFoundException, SQLException, NamingException {
        List<OUUploadOrder> listorder = new ArrayList<OUUploadOrder>();
        String sql = "SELECT order_cms_id,order_cms_fullname,order_cms_company,order_cms_department,SUM(order_product_qty) as total  FROM ounew_orderupload WHERE doc_id = ? GROUP BY order_cms_id,order_cms_fullname,order_cms_company,order_cms_department ORDER BY order_cms_department";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUUploadOrder order = new OUUploadOrder();
                order.setOrder_cms_id(rs.getString("order_cms_id"));
                order.setOrder_cms_fullname(rs.getString("order_cms_fullname"));
                order.setOrder_cms_company(rs.getString("order_cms_company"));
                order.setOrder_cms_department(rs.getString("order_cms_department"));
                order.setOrder_sum(rs.getString("total"));
                listorder.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return listorder;
    }

    public List<OUOrderSortBySize> getorderlistbydocidsortbysize(String id) throws ClassNotFoundException, SQLException, NamingException {
        List<OUOrderSortBySize> listorder = new ArrayList<OUOrderSortBySize>();
        String sql = "SELECT SUBSTR(order_product_id,1,12) as order_productgroup,order_product_id,order_product_barcode,order_product_name,order_mat_group,order_mat_name,SUM(order_product_qty) as order_total FROM ounew_orderupload WHERE doc_id = ? GROUP BY SUBSTR(order_product_id,1,12), order_product_id, order_product_barcode, order_product_name, order_mat_group, order_mat_name";
        try {
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                OUOrderSortBySize order = new OUOrderSortBySize();
                order.setOrder_productgroup(rs.getString("order_productgroup"));
                order.setOrder_prduct_id(rs.getString("order_product_id"));
                order.setOrder_prduct_barcode(rs.getString("order_product_barcode"));
                order.setOrder_prduct_name(rs.getString("order_product_name"));
                order.setOrder_mat_group(rs.getString("order_mat_group"));
                order.setOrder_mat_name(rs.getString("order_mat_name"));
                order.setOrder_total(rs.getString("order_total"));
                listorder.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return listorder;
    }
}
