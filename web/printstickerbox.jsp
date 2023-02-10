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
        table {
            font-size: 2pt;
        }
        
        .page-break
        {  
            page-break-after:always;
        }
        
    </style>
    <body>
        <%
            try {
                String doc_id = (String) request.getAttribute("doc_id");
                String customer_num = (String) request.getAttribute("customer_num");

                OrderService order = new OrderService();
                //List<OUUploadOrder> listorder = order.getorderlistbydocidandcustomerid(doc_id, customer_id);
                List<OUUploadOrder> listcm = order.getorderlistbydocidsortbycustomer(doc_id);
                Double box_num = Math.ceil(listcm.size() / Double.parseDouble(customer_num));
                int a = 0;
                for (int x = 0; x < box_num; x++) {
                    String html = "";
                    html += "<table class='table text-nowrap table-bordered  table-sm text-center w-100 page-break' id='table_order'>";
                    html += "<thead>";
                    html += "<tr>";
                    html += "<th class='p-0 h5 text-center' colspan='2'></th>";
                    html += "<th class='p-0 h5 text-center' colspan='2'>Box : " + (x+1) + "/" + Math.round(box_num) + "</th>";
                    html += "</tr>";
                    html += "<tr>";
                    html += "<th class='p-0 text-center'>ลำดับ</th>";
                    html += "<th class='p-0 text-center'>ชื่อ</th>";
                    html += "<th class='p-0 text-center'>บริษัท</th>";
                    html += "<th class='p-0 text-center'>เเผนก</th>";
                    html += "</tr>";
                    html += "</thead>";
                    html += "<tbody>";
                    for (int row = 0; row < Integer.parseInt(customer_num); row++) {
                        if (a != listcm.size()) {
                            html += "<tr>";
                            html += "<td class='p-0'>" + (a + 1) + "</td>";
                            html += "<td class='p-0'>" + listcm.get(a).getOrder_cms_fullname() + "</td>";
                            html += "<td class='p-0'>" + listcm.get(a).getOrder_cms_company() + "</td>";
                            html += "<td class='p-0'>" + listcm.get(a).getOrder_cms_department() + "</td>";
                            html += "</tr>";
                        }
                        a++;
                    }
                    html += "</tbody>";
                    html += "</table>";
                    out.print(html);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        
        <script>
            
            function setTableOrder(){
                var groupColumn = 1;
                var table = $('#table_order').DataTable({
                    searching: false,
                    ordering: false,
                    paging: false,
                    ordering: false,
                    info: false
                    
                });
                window.print();
            }
            
            $(document).ready(function() {
                setTableOrder();
            });
        </script>
        
    </body>
</html>

