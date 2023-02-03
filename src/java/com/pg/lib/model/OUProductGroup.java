package com.pg.lib.model;

public class OUProductGroup {

    private String product_group_id;
    private String mat_no;
    private String mat_barcode;
    private String mat_name_th;
    private String mat_group;
    private String color_id;
    private String size_id;
    private String sale_price;
    private String plant;

    public String getColor_id() {
        return color_id;
    }

    public void setColor_id(String color_id) {
        this.color_id = color_id;
    }

    public String getMat_barcode() {
        return mat_barcode;
    }

    public void setMat_barcode(String mat_barcode) {
        this.mat_barcode = mat_barcode;
    }

    public String getMat_group() {
        return mat_group;
    }

    public void setMat_group(String mat_group) {
        this.mat_group = mat_group;
    }

    public String getMat_name_th() {
        return mat_name_th;
    }

    public void setMat_name_th(String mat_name_th) {
        this.mat_name_th = mat_name_th;
    }

    public String getMat_no() {
        return mat_no;
    }

    public void setMat_no(String mat_no) {
        this.mat_no = mat_no;
    }

    public String getPlant() {
        return plant;
    }

    public void setPlant(String plant) {
        this.plant = plant;
    }

    public String getProduct_group_id() {
        return product_group_id;
    }

    public void setProduct_group_id(String product_group_id) {
        this.product_group_id = product_group_id;
    }

    public String getSale_price() {
        return sale_price;
    }

    public void setSale_price(String sale_price) {
        this.sale_price = sale_price;
    }

    public String getSize_id() {
        return size_id;
    }

    public void setSize_id(String size_id) {
        this.size_id = size_id;
    }

 
    public OUProductGroup() {
        super();
    }
}
