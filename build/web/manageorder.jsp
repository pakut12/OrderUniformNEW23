<%-- 
    Document   : index
    Created on : 25 ม.ค. 2566, 14:11:18
    Author     : pakutsing
--%>

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
        %>
        <%@ include file="share/navbar.jsp" %>
        <div class="container">
            <div class="card mt-5  ">
                <div class="card-header ">
                    UploadOrder
                </div>
                <div class="card-body" style="color: green;">
                    
                    <div class="text-danger">
                        <h5 class="card-title fw-bold">คำเเนะนำ</h5>
                        <p class="card-text">
                        <ol>
                            <li>ต้องอัพโหดลไฟล์ที่โหลดออกจากโปรเเกรม POS เท่านั้น</li>
                            <li>หากเกิดปัญหาติดต่อ Support</li>
                        </ol>
                    </div>
                    <div class="mb-3">
                        <label for="formFile" class="form-label">File</label>
                        <input class="form-control form-control-sm" type="file" id="formFile">
                    </div>
                </div>
            </div>
            <div class="card mt-3  ">
                <div class="card-header ">
                    ListOrder
                </div>
                <div class="card-body" style="color: green;">
                    
                </div>
            </div>
        </div>
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            $(document).ready(function() {
                $("#manageorder").addClass("active");
            });
        </script>
    </body>
</html>
