<%-- 
    Document   : index
    Created on : 25 ม.ค. 2566, 14:11:18
    Author     : pakutsing
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.pg.lib.model.OUUploadOrder" %>
<%@ page import="com.pg.lib.model.OUOrderSortBySize" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <%@ include file="share/header.jsp" %>
    </head>
    <body>
        <%

            String status = (String) request.getSession().getAttribute("statuslogin");
            if (status == null || status.equals("0")) {
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }

            String doc_id = (String) request.getAttribute("doc_id");
            String doc_name = (String) request.getAttribute("doc_name");
            String doc_status = (String) request.getAttribute("doc_status");

        %>
        <%@ include file="share/navbar.jsp" %>
        <div class="container">
            <div class="card mt-5 col-sm-12 col-md-12 mx-auto ">
                <div class="card-header">
                    TransactionOrder
                </div>
                <div class="card-body" style="color: green;">
                    <div class="card mt-3">
                        <div class="card-body h4 ">
                            <div class="row  ">
                                <div class="col-sm-12 col-md-12 ">
                                    <div class="row mx-2 justify-content-center">
                                        เลขที่เอกสาร : <%=doc_id%>
                                    </div>
                                    <div class="row mt-3 mx-2 justify-content-center">
                                        ชื่อเอกสาร :  <%=doc_name%>
                                    </div>
                                    <div class="row mt-3 mx-2 justify-content-center">
                                        สถานะ :  <%=doc_status%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-end">
                        <button class="btn btn-success mt-4" type="button" onclick="packingbag()">PackingBag</button>
                        <button class="btn btn-primary mt-4" type="button" onclick="packingbox()">PackingBox</button>
                    </div>
                    <nav class="">
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">รายละเอียด</button>
                            <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">สรุปเรียงตามรายชื่อ</button>
                            <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">สรุปเรียงตามไซร์</button>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <div id="transactionorder" class="mt-3">
                                <%
            List<OUUploadOrder> listorder = (List<OUUploadOrder>) request.getAttribute("listorder");

            String html = "";
            html += "<table class='table text-nowrap table-bordered table-striped table-sm text-center w-100' id='table_order'>";
            html += "<thead>";
            html += "<tr>";
            html += "<th class='text-center'>ลำดับ</th>";
            html += "<th class='text-center'>เลขที่คำสั้งซื้อ</th>";
            html += "<th class='text-center'>รหัสสินค้า</th>";
            html += "<th class='text-center'>รหัสบาร์โค้ต</th>";
            html += "<th class='text-center'>ชื่อสินค้า</th>";
            html += "<th class='text-center'>Mat_Group</th>";
            html += "<th class='text-center'>Mat_Name</th>";
            html += "<th class='text-center'>จำนวนที่ขาย</th>";
            html += "<th class='text-center'>ราคาต้นทุน</th>";
            html += "<th class='text-center'>ราคาขาย</th>";
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
                                %>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                            <div id="transactionordersortbycustomer" class="mt-3">
                                <%
            List<OUUploadOrder> listordercustomer = (List<OUUploadOrder>) request.getAttribute("listordercustomer");

            String html1 = "";
            html1 += "<table class='table text-nowrap table-bordered table-striped table-sm text-center w-100' id='table_ordersortbycustomer'>";
            html1 += "<thead>";
            html1 += "<tr>";
            html1 += "<th class='text-center'>ลำดับ</th>";
            html1 += "<th class='text-center'>รหัสพนักงาน</th>";
            html1 += "<th class='text-center'>ชื่อพนักงาน</th>";
            html1 += "<th class='text-center'>บริษัท</th>";
            html1 += "<th class='text-center'>เเผนก</th>";
            html1 += "<th class='text-center'>จำนวนที่ขาย</th>";
            html1 += "</tr>";
            html1 += "</thead>";
            html1 += "<tbody>";
            int n1 = 1;
            for (OUUploadOrder orderdetail : listordercustomer) {
                html1 += "<tr>";
                html1 += "<td>" + n1 + "</td>";
                html1 += "<td>" + orderdetail.getOrder_cms_id() + "</td>";
                html1 += "<td>" + orderdetail.getOrder_cms_fullname() + "</td>";
                html1 += "<td>" + orderdetail.getOrder_cms_company() + "</td>";
                html1 += "<td>" + orderdetail.getOrder_cms_department() + "</td>";
                html1 += "<td>" + Math.round(Double.parseDouble(orderdetail.getOrder_sum())) + "</td>";
                html1 += "</tr>";
                n1++;
            }
            html1 += "</tbody>";
            html1 += "</table>";

            out.print(html1);
                                %>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                            <div id="transactionorderssortbysize" class="mt-3">
                                <%
            String html2 = "";
            html2 += "<table class='table text-nowrap table-bordered table-striped table-sm text-center w-100' id='table_ordersortbysize'>";
            html2 += "<thead>";
            html2 += "<tr>";
            html2 += "<th class='text-center'>ลำดับ</th>";
            html2 += "<th class='text-center'>รหัสบาร์โค้ด</th>";
            html2 += "<th class='text-center'>รหัสบาร์โค้ด</th>";
            html2 += "<th class='text-center'>ชื่นสินค้า</th>";
            html2 += "<th class='text-center'>ไซร์</th>";
            html2 += "<th class='text-center'>mat_group</th>";
            html2 += "<th class='text-center'>mat_name</th>";
            html2 += "<th class='text-center'>จำนวนที่ขาย</th>";
            html2 += "</tr>";
            html2 += "</thead>";
            html2 += "<tbody>";
            List<OUOrderSortBySize> listordersize = (List<OUOrderSortBySize>) request.getAttribute("listordersize");
            int n3 = 1;
            for (OUOrderSortBySize orderdetail : listordersize) {
                String color = orderdetail.getOrder_prduct_id().substring(10, 12);
                String size = orderdetail.getOrder_prduct_id().substring(12, 18);

                html2 += "<tr>";
                html2 += "<td>" + n3 + "</td>";
                html2 += "<td><b>รหัสสินค้า : </b>" + orderdetail.getOrder_productgroup().substring(0, 10) + "<br><b>สี : </b>" + color + "</td>";
                html2 += "<td>" + orderdetail.getOrder_prduct_barcode() + "</td>";
                html2 += "<td>" + orderdetail.getOrder_prduct_name() + "</td>";
                html2 += "<td>" + size + "</td>";

                html2 += "<td>" + orderdetail.getOrder_mat_group() + "</td>";
                html2 += "<td>" + orderdetail.getOrder_mat_name() + "</td>";
                html2 += "<td>" + Math.round(Double.parseDouble(orderdetail.getOrder_total())) + "</td>";
                html2 += "</tr>";
                n3++;
            }
            html2 += " </tbody>";
            html2 += "</table>";

            out.print(html2);

                                %>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            function packingbag(){
                var url  = 'packingbag.jsp?doc_id=<%=request.getParameter("id")%>';
                window.location.href = url ;
            }
          
            function packingbox(){
                var url  = 'packingbox.jsp?doc_id=<%=request.getParameter("id")%>';
                window.location.href = url ;
            }
            
            function setTabalTransactionbydetail(){     
                var groupColumn = 1;
                var table = $('#table_order').DataTable({
                    scrollY: "50vh",
                    scrollCollapse: true,
                        
                    columnDefs: [{ visible: false, targets: groupColumn }],
                    order: [[groupColumn, 'asc']],
                    displayLength: 25,
                    drawCallback: function (settings) {
                        var api = this.api();
                        var rows = api.rows({ page: 'current' }).nodes();
                        var last = null;
 
                        api
                        .column(groupColumn, { page: 'current' })
                        .data()
                        .each(function (group, i) {
                            if (last !== group) {
                                $(rows)
                                .eq(i)
                                .before('<tr class="group"><td colspan="13" class="text-start p-2" style="background-color:#ddd">' + group + '</td></tr>');
 
                                last = group;
                            }
                        });
                    }
                });
 
                // Order by the grouping
                $('#table_order tbody').on('click', 'tr.group', function () {
                    var currentOrder = table.order()[0];
                    if (currentOrder[0] === groupColumn && currentOrder[1] === 'asc') {
                        table.order([groupColumn, 'desc']).draw();
                    } else {
                        table.order([groupColumn, 'asc']).draw();
                    }
                });
                    
            }
            
            function setTabalTransactionsortbycustomer(){
                $('#table_ordersortbycustomer').DataTable({
                    scrollY: "50vh",
                    scrollCollapse: true
                    
                })
            }
            
            function setTabalTransactionsortbysize(){
                var groupColumn = 1;
                var table = $('#table_ordersortbysize').DataTable({
                    scrollY: "50vh",
                    scrollCollapse: true,
                        
                    columnDefs: [{ visible: false, targets: groupColumn }],
                    order: [[groupColumn, 'asc']],
                    displayLength: 25,
                    drawCallback: function (settings) {
                        var api = this.api();
                        var rows = api.rows({ page: 'current' }).nodes();
                        var last = null;
 
                        api
                        .column(groupColumn, { page: 'current' })
                        .data()
                        .each(function (group, i) {
                            if (last !== group) {
                                $(rows)
                                .eq(i)
                                .before('<tr class="group"><td colspan="13" class="text-start p-2" style="background-color:#ddd">' + group + '</td></tr>');
                                last = group;
                            }
                        });
                    }
                });
                
        
                $('#table_ordersortbysize tbody').on('click', 'tr.group', function () {
                    var currentOrder = table.order()[0];
                    if (currentOrder[0] === groupColumn && currentOrder[1] === 'asc') {
                        table.order([groupColumn, 'desc']).draw();
                    } else {
                        table.order([groupColumn, 'asc']).draw();
                    }
                });
            }
           
            $(document).ready(function() {
                setTabalTransactionbydetail();
                setTabalTransactionsortbycustomer();
                setTabalTransactionsortbysize();
                
                $("#manageorder").addClass("active");
            });
        </script>
    </body>
</html>
