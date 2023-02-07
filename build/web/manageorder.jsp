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
                    <form id="form_oreder">
                        <div class="text-danger">
                            <h5 class="card-title fw-bold">คำเเนะนำ</h5>
                            <p class="card-text">
                            <ol>
                                <li>ต้องอัพโหลดไฟล์ที่โหลดออกจากโปรเเกรม POS เท่านั้น</li>
                                <li>หากเกิดปัญหากรุณาติดต่อ Support</li>
                            </ol>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-12 col-md-6">
                                <div class="mb-3">
                                    <label for="formFile" class="form-label">Doc Name : </label>
                                    <input class="form-control form-control-sm" type="text" id="doc_name" >
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-6">
                                <div class="mb-3">
                                    <label for="formFile" class="form-label">File : </label>
                                    <input class="form-control form-control-sm" type="file" id="fileexcel" accept=".xls">
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <button class="btn btn-success btn-sm w-100" type="button" onclick="uploadfile()" >Upload</button>
                        </div>
                    </form>
                    <div id="mytable">
                    </div>
                </div>
            </div>
            
        </div>
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            
            function uploadfile(){
                var docname = $("#doc_name").val();     
                var file = document.getElementById('fileexcel').files[0];
                var formdata = new FormData(); 
                formdata.append('doc_name', docname);
                formdata.append('uploadorder', file);
                formdata.append('type', "uploadfile");
                
                $.ajax({
                    type: "POST",
                    encType: "multipart/form-data",
                    url: "UploadFile",
                    cache: false,
                    processData: false,
                    contentType: false,
                    data: formdata,
                    success: function(data){
                        
                        if(!data){
                            Swal.fire({
                                title:"ผิดพลาด",
                                text:"ไม่สามรถ Upload File ได้",
                                icon:"error"
                            })
                        }else{ 
                            $("#mytable").html(data);
                            $("#table_upload").DataTable({
                                scrollX: true
                            });
                        }
                         
                    },
                    error: function(msg){
                        console.log(msg);
                    }
                });
            }
            
            $(document).ready(function() {
                $("#manageorder").addClass("active");
            });
        </script>
    </body>
</html>
