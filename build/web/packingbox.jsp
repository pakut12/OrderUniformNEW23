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
        <div id="myform">
            <div class="container" >
                <div class="card mt-5  col-sm-12 col-md-6 mx-auto ">
                    <div class="card-header ">
                        PackingBox
                    </div>
                    <div class="card-body" style="color: green;">
                        <div class="row justify-content-center">
                            <div class="col-sm-12 col-md-12">
                                <div class="input-group input-group-sm mb-3">
                                    <span class="input-group-text " >DocID</span>
                                    <%
            String doc_id = request.getParameter("doc_id");
            if (doc_id == null) {
                doc_id = "";
            }
                                    %>
                                    <input type="text" class="form-control text-center" id="Barcode" value="<%=doc_id%>" required>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-12">
                                <div class="input-group input-group-sm mb-3">
                                    <span class="input-group-text" >ชื่อเอกสาร</span>
                                    <input type="text" class="form-control text-center" id="doc_name" value="" disabled required>
                                </div>
                            </div>
                            
                            <div class="col-sm-12 col-md-12">
                                <div class="input-group input-group-sm mb-3">
                                    <span class="input-group-text" >จำนวนคน (กล่อง)</span>
                                    <input type="number" class="form-control text-center" id="customer_num" value="1" required>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-12">
                                <button class="btn btn-sm btn-primary w-100" type="button" id="bt_printsticker">PrintSticker</button> 
                                <button class="btn btn-sm btn-success w-100 mt-2" type="button" id="bt_confirm">Confirm</button> 
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
            function getDepartmaet(doc_id){
                var barcode = $("#Barcode").val().split("/");
                var doc_id = barcode[0];
                var customer_id = barcode[1];
                var customer_num = $("#customer_num").val();
                
                if(doc_id){
                    $.ajax({
                        method: "POST",
                        url: "Order",
                        data: {
                            type: "getdepartment",
                            doc_id:doc_id
                        },
                        success:function(msg){
                            var decode = JSON.parse(msg);
                            console.log(decode);
                            $("#doc_name").val(decode.doc_name);
                       
                        }
                    }) 
                }
               
            }
            
            function getdata(){
                var barcode = $("#Barcode").val().split("/");
                var doc_id = barcode[0];
                var customer_id = barcode[1];
                var customer_num = $("#customer_num").val();
                
                getDepartmaet(doc_id);
        
            }
            
            
            $(document).ready(function() {
                getdata();
                $("#Barcode").on('input', function() {
                    getdata();
                });
                $("#manageorder").addClass("active");
                
                $("#bt_printsticker").click(function(){
                    var barcode = $("#Barcode").val().split("/");
                    var doc_id = barcode[0];
                    var customer_id = barcode[1];
                    var customer_num = $("#customer_num").val();
                    var doc_name = $("#doc_name").val();
                    var department= $("#department").val();
                    
                    $("#myform").addClass("was-validated");
                    if(doc_id && customer_num){
                        var url = "Order?type=printstickerbox&doc_id="+doc_id+"&customer_id="+customer_id+"&customer_num="+customer_num+"&doc_name="+doc_name+"&department="+department; 
                        window.open(url, '_blank','height=400,width=800,left=200,top=200');
                    }else{
                        Swal.fire({
                            title:"ผิดพลาด",
                            icon:"error",
                            text:"กรุณากรอกข้อมูลให้ถูกต้อง"
                        })
                    }
                    
                });
                
                $("#bt_confirm").click(function(){
                    var barcode = $("#Barcode").val().split("/");
                    var doc_id = barcode[0];
                    var customer_id = barcode[1];
                    $("#myform").addClass("was-validated");
                    if(doc_id && customer_num){
                        Swal.fire({
                            title: 'ยืนยัน',
                            text: "คุณต้องการยืนยันใช่หรือไม่",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'ใช่',
                            cancelButtonText: 'ไม่ใช่'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $.ajax({
                                    type:"post",
                                    url:"Order",
                                    data:{
                                        type:"confirmbox",
                                        doc_id:doc_id
                                    },
                                    success:function(msg){
                                        var decode = JSON.parse(msg);
                                        if(decode.status == "true"){
                                            Swal.fire({
                                                title:"ยืนยัน",
                                                icon:"success",
                                                text:"ยืนยันสำเร็จ"
                                            })
                                            setTimeout(function(){
                                                window.location.href = "manageorder.jsp";
                                            },1000);
                                        }else if(decode.status == "false"){
                                            Swal.fire({
                                                title:"ยืนยัน",
                                                icon:"error",
                                                text:"ยืนยันไม่สำเร็จ"
                                            })
                                        }
                                    }
                                })
                            }
                        })
                    }else{
                        Swal.fire({
                            title:"ผิดพลาด",
                            text:"กรุณากรอกข้อมูลให้ถูกต้อง",
                            icon:"error"
                        })
                    }
                    
                });
            });
        </script>
    </body>
</html>
