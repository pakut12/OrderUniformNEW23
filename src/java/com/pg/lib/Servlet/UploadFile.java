/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.Servlet;

import com.pg.lib.model.OUUploadOrder;
import com.pg.lib.service.ReadExcelService;
import java.io.*;
import java.net.*;
import com.pg.lib.service.UploadFileService;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
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
            String type = request.getParameter("");
            try {
                UploadFileService file = new UploadFileService();
                HashMap<String, String> list = file.checkMultiContent(request, "uploadorder");

                ReadExcelService readfile = new ReadExcelService();
                List<OUUploadOrder> listorder = readfile.ReadOrder(list);

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
