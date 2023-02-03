/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.Servlet;

import com.pg.lib.model.OUProductGroup;
import com.pg.lib.service.ProductGroupService;
import java.io.*;
import java.net.*;

import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author pakutsing
 */
public class DownloadMasterPos extends HttpServlet {

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
            if (type.equals("getproductgroup")) {
                try {
                    //รับค่า ProductGroup เป็น Array มา
                    String[] listproductgroup = request.getParameterValues("productgroup[]");
                    String product_plant = request.getParameter("product_plant");
                    ProductGroupService pd = new ProductGroupService();
                    //เอาค่า Array มาค้นหาใน Database
                    List<OUProductGroup> list = pd.getProductGroup(listproductgroup);

                    //เอาค่าที่ได้จาก Databese มาเเสดงในตาราง
                    int n = 0;
                    String HTMLtag = "";
                    HTMLtag += "<table id=\"list-masterpos\" class='table table-bordered text-nowrap w-100 mt-3' >";
                    HTMLtag += "<thead>";
                    HTMLtag += "<tr>";
                    HTMLtag += "<th>MatNo</th>";
                    HTMLtag += "<th>Barcode</th>";
                    HTMLtag += "<th>Name</th>";
                    // HTMLtag += "<th>MatGroup</th>";
                    HTMLtag += "<th>Price(Exc Vat)</th>";
                    HTMLtag += "<th>Price(Inc Vat)</th>";
                    HTMLtag += "<th>Plant</th>";
                    HTMLtag += "</tr>";
                    HTMLtag += "</thead>";
                    HTMLtag += "<tbody>";
                    for (OUProductGroup x : list) {
                        String price = x.getSale_price();
                        String pricesumvat = "";
                        if (price == null) {
                            price = "";
                            pricesumvat = "";
                        } else {
                            pricesumvat = String.valueOf(Math.round((Float.parseFloat(x.getSale_price()) * (100 + 7)) / 100));
                        }

                        HTMLtag += "<tr>";
                        HTMLtag += "<td>" + x.getMat_no() + "</td>";
                        HTMLtag += "<td>" + x.getMat_barcode() + "</td>";
                        HTMLtag += "<td>" + x.getMat_name_th() + "</td>";
                        //HTMLtag += "<td>" + x.getMat_group() + "</td>";
                        HTMLtag += "<td>" + price + "</td>";
                        HTMLtag += "<td>" + pricesumvat + "</td>";
                        HTMLtag += "<td>" + x.getPlant() + "</td>";
                        //HTMLtag += "<td>" + Math.round((Float.parseFloat(x.getSale_price()) * (100 + 7)) / 100) + "</td>";
                        HTMLtag += "</tr>";
                        n++;
                    }
                    HTMLtag += "</tbody>";
                    HTMLtag += "</table>";

                    out.print(HTMLtag);
                } catch (Exception e) {
                    e.printStackTrace();
                }
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
