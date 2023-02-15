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
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="myform">
            <div class="container" >
                <div class="card mt-5  ">
                    <div class="card-header ">
                        PackingBag
                    </div>
                    <div class="card-body" style="color: green;">
                        
                        <div class="row justify-content-center">
                            <div class="col-sm-12 col-md-auto">
                                <div class="input-group input-group-sm mb-3">
                                    <span class="input-group-text" >DocID</span>
                                    <%
            String doc_id = (String) request.getParameter("doc_id");
            if (doc_id == null) {
                doc_id = "";
            }
                                    %>
                                    <input type="text" class="form-control text-center" id="Barcode" value="<%=doc_id%>" required>
                                </div>
                            </div>
                            
                            <div class="col-sm-12 col-md-auto">
                                <button class="btn btn-sm btn-primary" type="button" id="bt_printsticker" disabled >PrintSticker</button> 
                                <button class="btn btn-sm btn-success" type="button" id="bt_confirm" disabled >Confirm</button> 
                            </div>
                        </div>
                        <div id="list_table">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            
            function getorderbycustomerid(){
                var barcode = $("#Barcode").val().trim().split("/");
                var doc_id = barcode[0];
                var customer_id = barcode[1];
              
                if(doc_id){
                    $.ajax({
                        type:"post",
                        url:"Order",
                        data:{
                            type:"getorderbycustomerid",
                            customer_id:customer_id,
                            doc_id:doc_id
                        },
                        success:function(msg){
                            if(msg == ""){
                                Swal.fire({
                                    title:"ผิดพลาด",
                                    icon:"error",
                                    text:"ไม่พบข้อมูล"
                                })
                            }else{
                                $("#bt_printsticker").attr("disabled",false);
                                $("#bt_confirm").attr("disabled",false);
                                $("#list_table").html(msg);
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
                            
                        }
                    })  
                }
                
                
                
            }
            
            $(document).ready(function() {
                getorderbycustomerid();
                $("#manageorder").addClass("active");
                $("#Barcode").on('input', function() {
                    getorderbycustomerid();
                });
                
                $("#bt_printsticker").click(function(){
                    var barcode = $("#Barcode").val().split("/");
                    var doc_id = barcode[0];
                    var customer_id = barcode[1];
                    $("#myform").addClass("was-validated");
                    if(!doc_id){
                        Swal.fire({
                            title:"ผิดพลาด",
                            text:"กรุณากรอกข้อมูลให้ถูกต้อง",
                            icon:"error"
                        })
                    }else{
                        window.open("Order?type=printstickerbag&doc_id="+doc_id+"&customer_id="+customer_id, '_blank','height=400,width=800,left=200,top=200');
                    }
                });
                
                $("#bt_confirm").click(function(){
                    var barcode = $("#Barcode").val().split("/");
                    var doc_id = barcode[0];
                    var customer_id = barcode[1];
                    $("#myform").addClass("was-validated");
                    if(doc_id){
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
                                        type:"confirmbag",
                                        doc_id:doc_id,
                                        customer_id:customer_id
                                    },
                                    success:function(msg){
                                        var decode = JSON.parse(msg);
                                        if(decode.status == "true"){
                                            Swal.fire({
                                                title:"ยืนยัน",
                                                icon:"success",
                                                text:"ยืนยันสำเร็จ"
                                            })
                                          
                                        }else if(decode.status == "false"){
                                            Swal.fire({
                                                title:"ยืนยัน",
                                                icon:"error",
                                                text:"ยืนยันไม่สำเร็จ"
                                            })
                                        }
                                        setTimeout(function(){
                                            location.reload();
                                        },1500)
                                        
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
                    
                })
               
            });
        </script>
    </body>
</html>
