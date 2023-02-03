/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import com.pg.lib.model.OUProductGroup;
import com.pg.lib.utility.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author pakutsing
 */
public class ProductGroupService {

    private static Connection conn;
    private static ResultSet rs;
    private static PreparedStatement ps;

    public List<OUProductGroup> getProductGroup(String[] listproductgroup) throws ClassNotFoundException, SQLException, NamingException {
        conn = ConnectDB.getConnectionPGCA();
        String sql = generatesqlProductGroup(listproductgroup);
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        List<OUProductGroup> list = new ArrayList<OUProductGroup>();
        while (rs.next()) {
            OUProductGroup productdetails = new OUProductGroup();
            productdetails.setProduct_group_id(rs.getString("product_group_id"));
            productdetails.setMat_no(rs.getString("mat_no"));
            productdetails.setMat_barcode(rs.getString("mat_barcode"));
            productdetails.setMat_name_th(rs.getString("mat_name_th"));
            productdetails.setColor_id(rs.getString("color_id"));
            productdetails.setSize_id(rs.getString("size_id"));
            productdetails.setSale_price(rs.getString("sale_price"));
            productdetails.setMat_group(rs.getString("mat_group"));
            productdetails.setPlant(rs.getString("plant"));
            list.add(productdetails);
        }

        return list;
    }

    private String generatesqlProductGroup(String[] listproductgroup) throws ClassNotFoundException, SQLException, NamingException {
        String sql = "select a.*,b.mat_group from bm_product_class a  inner join sap_mara_mat_all b on a.MAT_NO = b.MAT_NO where a.SIZE_ID !=  '----' and a.PRODUCT_GROUP_ID  in (";
        for (int n = 0; n < listproductgroup.length; n++) {
            if (n != listproductgroup.length - 1) {
                sql += "'" + listproductgroup[n] + "',";
            } else {
                sql += "'" + listproductgroup[n] + "')";
            }
        }

        return sql;
    }
}
