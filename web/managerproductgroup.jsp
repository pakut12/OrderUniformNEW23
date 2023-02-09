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
        <div class="modal fade " id="modal_master" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Download Master</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-success">
                            <h5 class="card-title fw-bold">คู่มือ</h5>
                            <p class="card-text">
                            <ol>
                                <li>กดปุ่ม Excel</li>
                                <li>เปิดไฟล์ Excel ที่โหลดขึ้นมา</li>
                                <li>กรอก material_group เเละ material_name ให้เรียบร้อย</li>
                                <li>หลังจากนั้นกดปุ่ม Save ไฟล์ Excel</li>
                            </ol>
                        </div>
                        <hr class="text-success">
                        <div class="text-end">
                            <button class="btn btn-md btn-primary" id="printbarcode" onclick="printbarcode()">PrintBarcode</button>
                        </div>
                        <div class="table-responsive">
                            <div id="table_master">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="card text-start mt-5">
                <div class="card-header">
                    DownloadMasterProductGroup
                </div>
                <div class="card-body">
                    <div class="text-success">
                        <h5 class="card-title fw-bold">คู่มือ</h5>
                        <p class="card-text">
                        <ol>
                            <li>ใส่ ProductGroup ที่ช่อง ProductGroup : เเละกดปุ่ม Add </li>
                            <li>ตรวจสอบจำนวน ProductGroup ที่เพิ่มให้ครบ</li>
                            <li>กดปุ่ม Download</li>
                        </ol>
                    </div>
                    <hr class="text-success">
                    <div class="d-flex justify-content-center">
                        <div id="myform">
                            <div class="row g-3 align-items-center ">
                                <div class="col-auto">
                                    <label for="product_group" class="col-form-label">Product Group : </label>
                                </div>
                                <div class="col-auto">
                                    <input type="text" id="product_group" class="form-control form-control-sm" minlength="10" maxlength="10" pattern=".{10}" required >
                                </div>
                                <div class="col-auto">
                                    <button class="btn btn-sm btn-success" type="button" onclick="AddProductGroup()">Add</button>
                                </div>
                                <div class="col-auto">
                                    <button class="btn btn-sm btn-primary" type="button" id="bt_submit" onclick="senddata()"  disabled>Download</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div id="mytable">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script language="javascript">
            var product_group = [];
            function AddProductGroup(){
                $("#myform").addClass("was-validated");
                var id = $("#product_group").val();
             
                if(id ){
                    $("#bt_submit").attr("disabled", false);
                    if(product_group.indexOf(id) === -1){ // check if value does not exist in array
                        product_group.push(id);
                    }
                    else {
                        Swal.fire({
                            title:"ผิดพลาด",
                            icon:"error",
                            text: "ID : " + id + " มีอยู่เเล้ว"
                        });
                    } 
                    getdata();
                }else{
                    Swal.fire({
                        title:"ผิดพลาด",
                        icon:"error",
                        text: "กรุณากรอกข้อมูลให้ถูกต้อง"
                    });
                }
              
            }
        
            function DelProductGroup(index){
                product_group.splice(index, 1); 
                getdata();
            }
        
            function senddata(){
                $.ajax({
                    type:"post",
                    url:"DownloadMasterPos",
                    data:{
                        type:"getproductgroup",
                        productgroup:product_group,
                        product_plant:$("#product_plant").val()
                    },
                    success:function(msg){
                        var now = new Date();
                        var filename = "List Master " + now.getDate() + "/"+(now.getMonth()+1)+"/"+now.getFullYear();
                  
                        $("#modal_master").modal("show");
                        $("#table_master").empty();
                        $("#table_master").html(msg);
                        $("#list-masterpos").DataTable({
                            dom: 'Bfrtip',
                            buttons: [{
                                    extend: 'excel',
                                    title:null,
                                    filename: filename
                                }
                            ]
                        });
                    }
                })
            }
        
            function getdata(){
                var html = "";
                html += "<table class='table table-sm w-100' id='table_groupid'>"
                html += "<thead>"
                html += "<tr>"
                html += "<th>No</th>"
                html += "<th>GroupID</th>"
                html += "<th>Del</th>"
                html += "</tr>"
                html += "</thead>"
                html += "<tbody id='data_groupid' class='text-center'>";    
         
                $.each(product_group,function(k,v){
                    html += "<tr>";
                    html += "<td>"+(k+1)+"</td>";
                    html += "<td>"+v+"</td>";
                    html += "<td><button class='btn btn-sm btn-danger' type='button' onclick='DelProductGroup("+k+")'>Del</button></td>";
                    html += "</tr>";
                });
                html += "</tbody>";
                html += "</table>";
            
                $("#mytable").empty();
                $("#mytable").html(html);
                $("#table_groupid").DataTable({
                    "pageLength": 4
                });
            }
        
            function printbarcode(){
                window.open("DownloadMasterPos?type=printproductgroup&productgroup="+product_group,"_blank", "height=600,width=800,left=200,top=200");
            }

            $(document).ready(function(){
                $("#managerproductgroup").addClass("active");
            })
        </script>
    </body>
</html>
