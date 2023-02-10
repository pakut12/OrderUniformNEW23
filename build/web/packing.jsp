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
                    Packing
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
                            
                            <button class="btn btn-sm btn-primary" type="button" id="bt_printsticker" >PrintSticker</button> 
                            
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
            
            function getorderbycustomerid(){
                var barcode = $("#Barcode").val().split("/");
                var doc_id = barcode[0];
                var customer_id = barcode[1];
                
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
                    
                    window.open("Order?type=printsticker&doc_id="+doc_id+"&customer_id="+customer_id, '_blank','height=400,width=800,left=200,top=200');
                    
                });

            }
            
            $(document).ready(function() {
                $("#Barcode").on('input', function() {
                    getorderbycustomerid();
                   
                });
                $("#packing").addClass("active");
            });
        </script>
    </body>
</html>
