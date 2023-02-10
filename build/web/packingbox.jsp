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
                    PackingBox
                </div>
                <div class="card-body" style="color: green;">
                    <div class="row justify-content-center">
                        <div class="col-sm-12 col-md-auto">
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" >Barcode</span>
                                <input type="text" class="form-control" id="Barcode">
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-auto">
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" >ชื่อเอกสาร</span>
                                <input type="text" class="form-control text-center" id="doc_name" value="" disabled>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-auto">
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" >เเผนก</span>
                                <select class="form-select" id="inputGroupSelect01">
                                    <option selected>Choose...</option>
                                    
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-auto">
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" >จำนวนคน (กล่อง)</span>
                                <input type="number" class="form-control" id="customer_num">
                            </div>
                        </div>
                        
                        
                        <div class="col-sm-12 col-md-auto">
                            <button class="btn btn-sm btn-primary" type="button" id="bt_printsticker">PrintSticker</button> 
                        </div>
                    </div>
                    <div id="list_table">
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            
            function getDepartmaet(doc_id){
                $.ajax({
                    method: "POST",
                    url: "Order",
                    data: {
                        type: "getdepartment",
                        doc_id:doc_id
                    },
                    success:function(msg){
                        var decode = JSON.parse(msg);
                        $("#doc_name").val(decode.doc_name);
                        $("#inputGroupSelect01").append(decode.html);
        
        
                    }
                }) 
            }
            
            function getorderbycustomerid(){
               
                var barcode = $("#Barcode").val().split("/");
                var doc_id = barcode[0];
                var customer_id = barcode[1];
                
                getDepartmaet(doc_id);
                $.ajax({
                    type:"post",
                    url:"Order",
                    data:{
                        type:"getorderbycustomerid",
                        customer_id:customer_id,
                        doc_id:doc_id
                    },
                    success:function(msg){
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
                })
             
                $("#bt_printsticker").click(function(){
                    var barcode = $("#Barcode").val().split("/");
                    var doc_id = barcode[0];
                    var customer_id = barcode[1];
                    var customer_num = $("#customer_num").val();
                    
                    window.open("Order?type=printstickerbox&doc_id="+doc_id+"&customer_id="+customer_id+"&customer_num="+customer_num, '_blank','height=400,width=800,left=200,top=200');
                    
                });

            }
            
            $(document).ready(function() {
                $("#Barcode").on('input', function() {
                    getorderbycustomerid();
                   
                });
                $("#packingbox").addClass("active");
            });
        </script>
    </body>
</html>
