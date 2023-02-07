/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.Servlet;

import com.pg.lib.model.OUUploadOrder;
import com.pg.lib.service.OrderService;
import com.pg.lib.service.ReadExcelService;
import java.io.*;
import java.net.*;
import com.pg.lib.service.UploadFileService;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

/**
 *
 * @author pakutsing
 */
public class UploadFile extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            try {
                // Upload File 
                UploadFileService file = new UploadFileService();
                HashMap<String, String> list = file.checkMultiContent(request, "uploadorder");
                // ReadFileExcel
                ReadExcelService readfile = new ReadExcelService();
                Boolean ChkExcel = readfile.ChkOrder(list);
                if (ChkExcel) {
                    List<OUUploadOrder> listorder = readfile.ReadOrder(list);
                    // InsertData
                    OrderService ordersv = new OrderService();
                    Boolean docid = ordersv.addorderdoc(list.get("docname"));
                    if (docid) {
                        Boolean statusuploadfile = ordersv.addorderlist(listorder);
                        String html = "";
                        if (statusuploadfile) {
                            html += "<div class='text-center'>" + list.get("docname") + "</div>";
                            html += "<div class='text-center'>OrderListUpload</div>";
                            html += "<table class='table text-nowrap table-bordered table-striped table-sm text-center w-100' id='table_upload'>";
                            html += "<thead>";
                            html += "<tr>";
                            html += "<th>ลำดับ</th>";
                            html += "<th>เลขที่เอกสาร</th>";
                            html += "<th>รหัสพนักงาน</th>";
                            html += "<th>ชื่อนามสกุล</th>";
                            html += "<th>บริษัท</th>";
                            html += "<th>เเผนก</th>";
                            html += "<th>รหัสสินค้า</th>";
                            html += "<th>รหัสบาร์โค้ด</th>";
                            html += "<th>ชื่อสินค้า</th>";
                            html += "<th>material group</th>";
                            html += "<th>ชื่อ material group</th>";
                            html += "<th>จำนวนที่ขาย</th>";
                            html += "<th>ต้นทุน</th>";
                            html += "<th>ราคาขาย</th>";
                            html += "</tr>";
                            html += "</thead>";
                            html += "<tbody id='data_exportexcel'>";
                            int n = 1;
                            for (OUUploadOrder orderdetail : listorder) {
                                html += "<tr>";
                                html += "<td>" + n + "</td>";
                                html += "<td>" + orderdetail.getReceipt_id() + "</td>";
                                html += "<td>" + orderdetail.getOrder_cms_id() + "</td>";
                                html += "<td>" + orderdetail.getOrder_cms_fullname() + "</td>";
                                html += "<td>" + orderdetail.getOrder_cms_company() + "</td>";
                                html += "<td>" + orderdetail.getOrder_cms_department() + "</td>";
                                html += "<td>" + orderdetail.getOrder_product_id() + "</td>";
                                html += "<td>" + orderdetail.getOrder_product_barcode() + "</td>";
                                html += "<td>" + orderdetail.getOrder_product_name() + "</td>";
                                html += "<td>" + orderdetail.getOrder_mat_group() + "</td>";
                                html += "<td>" + orderdetail.getOrder_mat_name() + "</td>";
                                html += "<td>" + orderdetail.getOrder_product_qty() + "</td>";
                                html += "<td>" + orderdetail.getOrder_price_inc_vat() + "</td>";
                                html += "<td>" + orderdetail.getOrder_price_inc_vat() + "</td>";
                                html += "</tr>";
                                n++;
                            }
                            html += "</tbody>";
                            html += "</table>";
                        } else {
                            html = "";
                        }
                        out.print(html);
                    }
                }

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
            } catch (Exception e) {
                e.printStackTrace();
            }


        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}
