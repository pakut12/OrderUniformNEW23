<%-- 
    Document   : ReportBag
    Created on : 15 พ.ย. 2565, 9:45:37
    Author     : pakutsing
--%>
<%@page import="java.util.List" %>
<%@page import="com.pg.lib.model.*" %>
<%@page import="com.pg.lib.service.*" %>
<%@page import="java.util.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ReportBag</title>
        
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
        
        <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Krub:wght@500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.1/af-2.5.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/b-print-2.3.3/cr-1.6.1/date-1.2.0/fc-4.2.1/fh-3.3.1/kt-2.8.0/r-2.4.0/rg-1.3.0/rr-1.3.1/sc-2.0.7/sb-1.4.0/sp-2.1.0/sl-1.5.0/sr-1.2.0/datatables.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/bs5/jszip-2.5.0/dt-1.13.1/af-2.5.1/b-2.3.3/b-colvis-2.3.3/b-html5-2.3.3/b-print-2.3.3/cr-1.6.1/date-1.2.0/fc-4.2.1/fh-3.3.1/kt-2.8.0/r-2.4.0/rg-1.3.0/rr-1.3.1/sc-2.0.7/sb-1.4.0/sp-2.1.0/sl-1.5.0/sr-1.2.0/datatables.min.js"></script>
        
    </head>
    <style>
        @media print {
            html, body {
                width: 5in;
                height: 2in;
                font-size: 0.9em;
            }
            
            table {
                border-spacing: 0;
                border-collapse: collapse;
            }
        }
        .page-break
        {  
            page-break-after:always;
        }
        
    </style>
    <body>
        <%
            /* print all
            try {
            String doc_id = (String) request.getAttribute("doc_id");
            String customer_id = (String) request.getAttribute("customer_id");
            
            OrderService order = new OrderService();
            List<OUUploadOrder> orderid = order.getorderlistbydocidsortbycustomer(doc_id);
            
            for (OUUploadOrder id : orderid) {
            List<OUUploadOrder> listorder = order.getorderlistbydocidandcustomerid(doc_id, id.getOrder_cms_id());
            String html = "";
            html += "<table class='table text-nowrap table-bordered  table-sm text-center border border-dark w-100 page-break' id='table_order'>";
            html += "<thead>";
            html += "<tr>";
            html += "<th class='p-0' colspan='7'><b>รหัสพนักงาน : </b>" + listorder.get(0).getOrder_cms_id() + "      ||    <b>ชื่อนามสกุล : </b>" + listorder.get(0).getOrder_cms_fullname() + "<br><b>บริษัท : </b>" + listorder.get(0).getOrder_cms_company() + "   ||  <b>เเผนก : </b>" + listorder.get(0).getOrder_cms_department() + "</th>";
            html += "</tr>";
            html += "<tr>";
            html += "<th class='p-0'>ลำดับ</th>";
            html += "<th class='p-0'>รหัสสินค้า</th>";
            // html += "<th class='p-0'>รหัสบาร์โค้ต</th>";
            html += "<th class='p-0'>ชื่อสินค้า</th>";
            html += "<th class='p-0'>สี</th>";
            html += "<th class='p-0'>ไซร์</th>";
            html += "<th class='p-0'>จำนวนที่ขาย</th>";
            html += "</tr>";
            html += "</thead>";
            html += "<tbody>";
            int n = 1;
            int sum = 0;
            for (OUUploadOrder orderdetail : listorder) {
            String color = orderdetail.getOrder_product_id().substring(10, 12);
            String size = orderdetail.getOrder_product_id().substring(12, 18);
            
            html += "<tr>";
            html += "<td class='p-0'>" + n + "</td>";
            html += "<td class='p-0'>" + orderdetail.getOrder_product_id() + "</td>";
            //  html += "<td class='p-0'>" + orderdetail.getOrder_product_barcode() + "</td>";
            html += "<td class='p-0'>" + orderdetail.getOrder_product_name() + "</td>";
            html += "<td class='p-0'>" + color + "</td>";
            html += "<td class='p-0'>" + size + "</td>";
            html += "<td class='p-0'>" + orderdetail.getOrder_product_qty() + "</td>";
            html += "</tr>";
            
            sum += Integer.parseInt(orderdetail.getOrder_product_qty());
            n++;
            }
            html += "</tbody>";
            html += "<tfoot>";
            html += "<tr>";
            html += "<td colspan='5' class='p-0 text-center'><b>รวม</b></td>";
            html += "<td class='p-0 text-center'>" + sum + "</td>";
            html += "</tr>";
            html += "</tfoot>";
            html += "</table>";
            
            out.print(html);
            
            }
            } catch (Exception e) {
            e.printStackTrace();
            }
             */

            try {
                String doc_id = (String) request.getAttribute("doc_id");
                String customer_id = (String) request.getAttribute("customer_id");

                OrderService order = new OrderService();
                List<OUUploadOrder> listorder = order.getorderlistbydocidandcustomerid(doc_id, customer_id);
                String html = "";
                html += "<table class='table text-nowrap table-bordered  table-sm text-center border border-dark w-100 page-break' id='table_order'>";
                html += "<thead>";
                html += "<tr>";
                html += "<th class='p-0' colspan='7'><b>รหัสพนักงาน : </b>" + listorder.get(0).getOrder_cms_id() + "      ||    <b>ชื่อนามสกุล : </b>" + listorder.get(0).getOrder_cms_fullname() + "<br><b>บริษัท : </b>" + listorder.get(0).getOrder_cms_company() + "   ||  <b>เเผนก : </b>" + listorder.get(0).getOrder_cms_department() + "</th>";
                html += "</tr>";
                html += "<tr>";
                html += "<th class='p-0'>ลำดับ</th>";
                html += "<th class='p-0'>รหัสสินค้า</th>";
                // html += "<th class='p-0'>รหัสบาร์โค้ต</th>";
                html += "<th class='p-0'>ชื่อสินค้า</th>";
                html += "<th class='p-0'>สี</th>";
                html += "<th class='p-0'>ไซร์</th>";
                html += "<th class='p-0'>จำนวนที่ขาย</th>";
                html += "</tr>";
                html += "</thead>";
                html += "<tbody>";
                int n = 1;
                int sum = 0;
                for (OUUploadOrder orderdetail : listorder) {
                    String color = orderdetail.getOrder_product_id().substring(10, 12);
                    String size = orderdetail.getOrder_product_id().substring(12, 18);

                    html += "<tr>";
                    html += "<td class='p-0'>" + n + "</td>";
                    html += "<td class='p-0'>" + orderdetail.getOrder_product_id() + "</td>";
                    //  html += "<td class='p-0'>" + orderdetail.getOrder_product_barcode() + "</td>";
                    html += "<td class='p-0'>" + orderdetail.getOrder_product_name() + "</td>";
                    html += "<td class='p-0'>" + color + "</td>";
                    html += "<td class='p-0'>" + size + "</td>";
                    html += "<td class='p-0'>" + orderdetail.getOrder_product_qty() + "</td>";
                    html += "</tr>";

                    sum += Integer.parseInt(orderdetail.getOrder_product_qty());
                    n++;
                }
                html += "</tbody>";
                html += "<tfoot>";
                html += "<tr>";
                html += "<td colspan='5' class='p-0 text-center'><b>รวม</b></td>";
                html += "<td class='p-0 text-center'>" + sum + "</td>";
                html += "</tr>";
                html += "</tfoot>";
                html += "</table>";

                out.print(html);

            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        
        <script>
            $(document).ready(function() {
                window.print();
            });
        </script>
        
    </body>
</html>

