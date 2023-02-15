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
            <div class="card mt-5">
                <div class="card-header ">
                    ListOrder
                </div>
                <div class="card-body" style="color: green;">
                    <div id="listdoc">
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            
            function getlistdoc(){
                $.ajax({
                    type:"post",
                    url:"Order",
                    data:{
                        type:"getorderlist"        
                    },
                    success:function(msg){
                        $("#listdoc").html(msg);
                        $("#table_listdoc").DataTable({
                            scrollY: "50vh",
                            scrollX:true,
                            scrollCollapse: true
                        });
                        console.log(msg);
                    }
                })
            }
            
            $(document).ready(function() {
                $("#manageorder").addClass("active");
                getlistdoc();
                
            });
        </script>
    </body>
</html>
