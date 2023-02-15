<%-- 
    Document   : index
    Created on : 25 ม.ค. 2566, 14:11:18
    Author     : pakutsing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">



<html >
    <head>
        <%@ include file="share/header.jsp" %>
    </head>
    <body>
        <%
            String status = (String) request.getSession().getAttribute("statuslogin");
            if (status == null || status.equals("0")) {
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }
        %>
        <%@ include file="share/navbar.jsp" %>
        <div class="container" >
            <div class="card mt-5  ">
                <div class="card-header ">
                    คู่มือการใช้งาน
                </div>
                <div class="card-body" style="color: green;">
                    <h5 class="card-title fw-bold">ขั้นตอนการจัดสินค้าใส่ถุง</h5>
                    <p class="card-text">
                        <ol>
                            <li>ไปที่หน้า ListOrder [<a href="manageorder.jsp">ListOrder </a>]</li>
                            <li>เลือกเอกสารที่ต้องการหลังจากกดไปที่เลขที่เอกสารที่เลือก</li>
                            <li>กดปุ่ม PrintBarcodeBag เเละ printbarcode เพื่อที่จะยิงในระบบ</li>
                            <li>ยิงกดปุ่ม PackingBag</li>
                            <li>กดปุ่ม PrintSticker เเละจัดสินค้าให้เสร็จทั้งหมด</li>
                            <li>กดปุ่ม Confirm <b class="text-danger"># คำเเนะนำ ต้องกดหลังจากจัดสินค้าใส่ถุงครบทั้งหมดเเล้วเท่านั้น</b> </li>
                        </ol>
                    </p>
                    <hr>
                    <h5 class="card-title fw-bold">ขั้นตอนการจัดสินค้าใส่กล่อง</h5>
                    <p class="card-text">
                        <ol>
                            <li>ไปที่หน้า ListOrder [<a href="manageorder.jsp">ListOrder </a>]</li>
                            <li>เลือกเอกสารที่ต้องการหลังจากกดไปที่เลขที่เอกสารที่เลือก</li>
                            <li>กดปุ่ม PackingBox</li>
                            <li>กดปุ่ม PrintSticker เเละจัดสินค้าให้เสร็จทั้งหมด</li>
                            <li>กดปุ่ม Confirm <b class="text-danger"># คำเเนะนำ ต้องกดหลังจากจัดสินค้าใส่กล่องครบทั้งหมดเเล้วเท่านั้น</b> </li>
                        </ol>
                    </p>
                    
                </div>
            </div>
        </div>
        
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            $(document).ready(function() {
                $("#home").addClass("active");
            });
        </script>
    </body>
</html>
