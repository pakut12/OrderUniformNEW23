/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.Servlet;

import com.pg.lib.model.OUDocList;
import com.pg.lib.model.OUOrderSortBySize;
import com.pg.lib.model.OUUploadOrder;
import com.pg.lib.service.OrderService;
import java.io.*;
import java.net.*;

import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author pakutsing
 */
public class Order extends HttpServlet {

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
            String type = request.getParameter("type");
            try {
                if (type.equals("getorderlist")) {
                    //ดึงข้อมูลหัวข้อ order
                    OrderService order = new OrderService();
                    List<OUDocList> listdoc = order.getDocList();

                    //สร้างตาราง doc_list
                    String html = "";
                    html += "<table class='table text-nowrap table-bordered table-striped table-sm text-center w-100' id='table_listdoc'>";
                    html += "<thead>";
                    html += "<tr>";
                    html += "<th>ลำดับ</th>";
                    html += "<th>เลขที่เอกสาร</th>";
                    html += "<th>ชื่อเอกสาร</th>";
                    html += "<th>วันที่สร้าง</th>";

                    html += "</tr>";
                    html += "</thead>";
                    html += "<tbody>";
                    int n = 1;
                    for (OUDocList orderdetail : listdoc) {
                        html += "<tr>";
                        html += "<td>" + n + "</td>";
                        html += "<td><a href='Order?id=" + orderdetail.getDoc_id() + "&name=" + orderdetail.getDoc_name() + "&type=transactionorder'>" + orderdetail.getDoc_id() + "</a></td>";
                        html += "<td>" + orderdetail.getDoc_name() + "</td>";
                        html += "<td>" + orderdetail.getDate_create() + "</td>";
                        html += "</tr>";
                        n++;
                    }
                    html += "</tbody>";
                    html += "</table>";

                    //เเสดงตาราง 
                    out.print(html);
                } else if (type.equals("transactionorder")) {
                    String id = request.getParameter("id").trim();

                    OrderService order = new OrderService();
                    List<OUUploadOrder> listorder = order.getorderlistbydocid(id);
                    List<OUUploadOrder> listordercustomer = order.getorderlistbydocidsortbycustomer(id);
                    List<OUOrderSortBySize> listordersize = order.getorderlistbydocidsortbysize(id);

                    request.setAttribute("listorder", listorder);
                    request.setAttribute("listordercustomer", listordercustomer);
                    request.setAttribute("listordersize", listordersize);

                    getServletContext().getRequestDispatcher("/displayorder.jsp").forward(request, response);
                } else if (type.equals("printorder")) {
                    String id = request.getParameter("id").trim();
                    String name = request.getParameter("name").trim();

                    OrderService order = new OrderService();
                    List<OUUploadOrder> listorder = order.getorderlistbydocid(id);
                    List<OUUploadOrder> listordercustomer = order.getorderlistbydocidsortbycustomer(id);
                    List<OUOrderSortBySize> listordersize = order.getorderlistbydocidsortbysize(id);

                    request.setAttribute("doc_id", id);
                    request.setAttribute("doc_name", name);
                    request.setAttribute("listorder", listorder);
                    request.setAttribute("listordercustomer", listordercustomer);
                    request.setAttribute("listordersize", listordersize);

                    getServletContext().getRequestDispatcher("/printbarcode.jsp").forward(request, response);
                } else if (type.equals("getorderbycustomerid")) {
                    String doc_id = request.getParameter("doc_id");
                    String customer_id = request.getParameter("customer_id");

                    OrderService order = new OrderService();
                    List<OUUploadOrder> listorder = order.getorderlistbydocidandcustomerid(doc_id, customer_id);


                    String html = "";
                    html += "<table class='table text-nowrap table-bordered table-striped table-sm text-center w-100' id='table_order'>";
                    html += "<thead>";
                    html += "<tr>";
                    html += "<th>ลำดับ</th>";
                    html += "<th>เลขที่คำสั้งซื้อ</th>";
                    html += "<th>รหัสสินค้า</th>";
                    html += "<th>รหัสบาร์โค้ต</th>";
                    html += "<th>ชื่อสินค้า</th>";
                    html += "<th>Mat_Group</th>";
                    html += "<th>Mat_Name</th>";
                    html += "<th>จำนวนที่ขาย</th>";
                    html += "<th>ราคาต้นทุน</th>";
                    html += "<th>ราคาขาย</th>";
                    html += "</tr>";
                    html += "</thead>";
                    html += "<tbody>";
                    int n = 1;
                    for (OUUploadOrder orderdetail : listorder) {
                        html += "<tr>";
                        html += "<td>" + n + "</td>";
                        html += "<td><b>เลขที่คำสั้งซื้อ : </b>" + orderdetail.getReceipt_id() + "<br><b>รหัสพนักงาน : </b>" + orderdetail.getOrder_cms_id() + "<br><b>ชื่อนามสกุล : </b>" + orderdetail.getOrder_cms_fullname() + "<br><b>บริษัท : </b>" + orderdetail.getOrder_cms_company() + "<br><b>เเผนก : </b>" + orderdetail.getOrder_cms_department() + "</td>";

                        html += "<td>" + orderdetail.getOrder_product_id() + "</td>";
                        html += "<td>" + orderdetail.getOrder_product_barcode() + "</td>";
                        html += "<td>" + orderdetail.getOrder_product_name() + "</td>";
                        html += "<td>" + orderdetail.getOrder_mat_group() + "</td>";
                        html += "<td>" + orderdetail.getOrder_mat_name() + "</td>";
                        html += "<td>" + orderdetail.getOrder_product_qty() + "</td>";
                        html += "<td>" + orderdetail.getOrder_price_exc_vat() + "</td>";
                        html += "<td>" + orderdetail.getOrder_price_inc_vat() + "</td>";
                        html += "</tr>";
                        n++;
                    }
                    html += "</tbody>";
                    html += "</table>";

                    out.print(html);

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
