/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.model;

/**
 *
 * @author pakutsing
 */
public class OUUploadOrder {

    private String order_id;
    private String doc_id;
    private String receipt_id;
    private String order_cms_id;
    private String order_cms_fullname;
    private String order_cms_company;
    private String order_cms_department;
    private String order_product_id;
    private String order_product_barcode;
    private String order_product_name;
    private String order_mat_group;
    private String order_mat_name;
    private String order_product_qty;
    private String order_price_exc_vat;
    private String order_price_inc_vat;

    public String getDoc_id() {
        return doc_id;
    }

    public void setDoc_id(String doc_id) {
        this.doc_id = doc_id;
    }

    public String getOrder_cms_company() {
        return order_cms_company;
    }

    public void setOrder_cms_company(String order_cms_company) {
        this.order_cms_company = order_cms_company;
    }

    public String getOrder_cms_department() {
        return order_cms_department;
    }

    public void setOrder_cms_department(String order_cms_department) {
        this.order_cms_department = order_cms_department;
    }

    public String getOrder_cms_fullname() {
        return order_cms_fullname;
    }

    public void setOrder_cms_fullname(String order_cms_fullname) {
        this.order_cms_fullname = order_cms_fullname;
    }

    public String getOrder_cms_id() {
        return order_cms_id;
    }

    public void setOrder_cms_id(String order_cms_id) {
        this.order_cms_id = order_cms_id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

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

    public String getOrder_price_exc_vat() {
        return order_price_exc_vat;
    }

    public void setOrder_price_exc_vat(String order_price_exc_vat) {
        this.order_price_exc_vat = order_price_exc_vat;
    }

    public String getOrder_price_inc_vat() {
        return order_price_inc_vat;
    }

    public void setOrder_price_inc_vat(String order_price_inc_vat) {
        this.order_price_inc_vat = order_price_inc_vat;
    }

    public String getOrder_product_barcode() {
        return order_product_barcode;
    }

    public void setOrder_product_barcode(String order_product_barcode) {
        this.order_product_barcode = order_product_barcode;
    }

    public String getOrder_product_id() {
        return order_product_id;
    }

    public void setOrder_product_id(String order_product_id) {
        this.order_product_id = order_product_id;
    }

    public String getOrder_product_name() {
        return order_product_name;
    }

    public void setOrder_product_name(String order_product_name) {
        this.order_product_name = order_product_name;
    }

    public String getOrder_product_qty() {
        return order_product_qty;
    }

    public void setOrder_product_qty(String order_product_qty) {
        this.order_product_qty = order_product_qty;
    }

    public String getReceipt_id() {
        return receipt_id;
    }

    public void setReceipt_id(String receipt_id) {
        this.receipt_id = receipt_id;
    }

    public OUUploadOrder(String order_id, String doc_id, String receipt_id, String order_cms_id, String order_cms_fullname, String order_cms_company, String order_cms_department, String order_product_id, String order_product_barcode, String order_product_name, String order_mat_group, String order_mat_name, String order_product_qty, String order_price_exc_vat, String order_price_inc_vat) {
        this.order_id = order_id;
        this.doc_id = doc_id;
        this.receipt_id = receipt_id;
        this.order_cms_id = order_cms_id;
        this.order_cms_fullname = order_cms_fullname;
        this.order_cms_company = order_cms_company;
        this.order_cms_department = order_cms_department;
        this.order_product_id = order_product_id;
        this.order_product_barcode = order_product_barcode;
        this.order_product_name = order_product_name;
        this.order_mat_group = order_mat_group;
        this.order_mat_name = order_mat_name;
        this.order_product_qty = order_product_qty;
        this.order_price_exc_vat = order_price_exc_vat;
        this.order_price_inc_vat = order_price_inc_vat;
    }

    public OUUploadOrder() {
        super();
    }
}
