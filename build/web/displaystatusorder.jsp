<%-- 
    Document   : index
    Created on : 25 ม.ค. 2566, 14:11:18
    Author     : pakutsing
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.pg.lib.model.OUDocList" %>
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

            List<OUDocList> listdoc = (List<OUDocList>) request.getAttribute("listdoc");
            Object ordertotal = request.getAttribute("listordercustomertotal");
            Object orderpackingbagsuccess = request.getAttribute("listpackingbagsuccess");
            Object orderpackingbagerror = request.getAttribute("listpackingbagerror");

        %>
        <%@ include file="share/navbar.jsp" %>
        <div class="container">
            <div class="card mt-5 col-sm-12 col-md-12 mx-auto ">
                <div class="card-header">
                    StatusOrder
                </div>
                <div class="card-body" style="color: green;">
                    <div class="row mb-3">
                        <div class="col">
                            <div class="card">
                                <div class="card-header text-center">
                                    OrderDetail
                                </div>
                                <div class="card-body text-center" style="color: green;">
                                    <div class="row justify-content-center">
                                        <div class="col-sm-12 col-md-4">
                                            <div class="row">
                                                <div class="col">เลขที่เอกสาร : </div>
                                                <div class="col"><%=listdoc.get(0).getDoc_id()%></div>
                                            </div>
                                            <div class="row">
                                                <div class="col">ชื่อเอกสาร : </div>
                                                <div class="col"><%=listdoc.get(0).getDoc_name()%></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="card">
                                <div class="card-header text-center">
                                    OrderTotal
                                </div>
                                <div class="card-body text-center h3 p-0 text-primary" >
                                    <%=ordertotal%>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="card">
                                <div class="card-header text-center">
                                    PackingBagSuccess
                                </div>
                                <div class="card-body text-center h3 p-0">
                                    <%=orderpackingbagsuccess%>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="card">
                                <div class="card-header text-center">
                                    PackingBagError
                                </div>
                                <div class="card-body text-center h3 p-0 text-danger">
                                    <%=orderpackingbagerror%>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <br>
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
            html1 += "<th class='text-center'>สถานะ</th>";
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
                html1 += "<td>" + orderdetail.getOrder_status() + "</td>";
                html1 += "</tr>";
                n1++;
            }
            html1 += "</tbody>";
            html1 += "</table>";

            out.print(html1);
                    %>
                </div>
            </div>
        </div>
        
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
           
            function settable_ordersortbycustomer(){
                var table = $('#table_ordersortbycustomer').DataTable({
                    scrollY: "50vh",
                    scrollCollapse: true
                });
            }
           
            $(document).ready(function() {
                settable_ordersortbycustomer();
            });
        </script>
    </body>
</html>
