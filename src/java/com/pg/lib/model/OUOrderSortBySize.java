/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.model;

/**
 *
 * @author pakutsing
 */
public class OUOrderSortBySize {

    private String order_productgroup;
    private String order_prduct_id;
    private String order_prduct_barcode;
    private String order_prduct_name;
    private String order_mat_group;
    private String order_mat_name;
    private String order_total;

    public String getOrder_mat_group() {
        return order_mat_group;
    }

    public void setOrder_mat_group(String order_mat_group) {
        this.order_mat_group = order_mat_group;
    }

    public String getOrder_mat_name() {
        return order_mat_name;
    }

    public void setOrder_mat_name(String order_mat_name) {
        this.order_mat_name = order_mat_name;
    }

    public String getOrder_prduct_barcode() {
        return order_prduct_barcode;
    }

    public void setOrder_prduct_barcode(String order_prduct_barcode) {
        this.order_prduct_barcode = order_prduct_barcode;
    }

    public String getOrder_prduct_id() {
        return order_prduct_id;
    }

    public void setOrder_prduct_id(String order_prduct_id) {
        this.order_prduct_id = order_prduct_id;
    }

    public String getOrder_prduct_name() {
        return order_prduct_name;
    }

    public void setOrder_prduct_name(String order_prduct_name) {
        this.order_prduct_name = order_prduct_name;
    }

    public String getOrder_productgroup() {
        return order_productgroup;
    }

    public void setOrder_productgroup(String order_productgroup) {
        this.order_productgroup = order_productgroup;
    }

    public String getOrder_total() {
        return order_total;
    }

    public void setOrder_total(String order_total) {
        this.order_total = order_total;
    }
    

    public OUOrderSortBySize() {
        super();
    }
}
