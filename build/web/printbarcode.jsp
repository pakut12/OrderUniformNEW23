<%-- 
    Document   : printproductgroup
    Created on : 6 ก.พ. 2566, 8:31:16
    Author     : pakutsing
--%>
<%@page import="java.util.List" %>
<%@page import="com.pg.lib.model.*" %>
<%@page import="com.pg.lib.service.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="js/pdfmake.min.js"></script>
        <script type="text/javascript" src="js/vfs_fonts.js"></script>
        <script src="https://cdn.jsdelivr.net/jsbarcode/3.6.0/JsBarcode.all.min.js"></script>
        <style>
            .pagebreak{
                page-break-after: always;
            }
            .typebarcode{
                width:100%;
                height:50px;
            }
        </style>
    </head>
    <body>
        
    </body>
    <script>
        
        function textToBase64Barcode(text){
            var canvas = document.createElement("canvas");
            JsBarcode(canvas, text, {format: "CODE39"});
            return canvas.toDataURL("image/png");
        }
        pdfMake.fonts = {
            THSarabunNew: {
                normal: 'THSarabunNew.ttf',
                bold: 'THSarabunNew-Bold.ttf',
                italics: 'THSarabunNew-Italic.ttf',
                bolditalics: 'THSarabunNew-BoldItalic.ttf'
            }
           
        }
        var dd = {
            pageSize: "A4",
            pageMargins: [ 40, 100,35, 35 ],
            footer: function(currentPage, pageCount) { 
                return []
            },
            header: function(currentPage, pageCount, pageSize) {           
                return [
                   
                    {
                        columns: [
                            
                            {
                                // star-sized columns fill the remaining space
                                // if there's more than one star-column, available width is divided equally
                                width: '*',
                                text: [{text:"Barcode",bold: true}],
                                alignment: "center",
                                margin:[20,0,0,0]
                            },
                            {
                                // fixed width
                                width: 'auto',
                                text: [{text:" หน้า : ",bold: true},{text:currentPage,bold: false}],
                                margin:[0,0,30,0],
                                fontSize:20
                            }
                        ],
                        fontSize:30,
                        margin:[40,20,20,0 ]
                    },
                    {
                        columns: [
                            {
                                // star-sized columns fill the remaining space
                                // if there's more than one star-column, available width is divided equally
                                width: '*',
                                text: [{text:" เลขที่เอกสาร : ",bold: true},{text:"<%=request.getAttribute("doc_id")%>",bold: false}],
                                
                                    },
                                    {
                                        // auto-sized columns have their widths based on their content
                                        width: '*',
                                        text: [{text:"ชื่อเอกสาร : ",bold: true},{text:"<%=request.getAttribute("doc_name")%>",bold: false}],
                               
                                            },
                                            {
                                                // fixed width
                                                width: '*',
                                                text: [{text:" วันที่ : ",bold: true},{text:"<%=request.getAttribute("date")%>",bold: false}],
                                
                                                    }
                                                ],
                                                fontSize:18,
                                                margin:[50,0,20,0 ]
                                            }
                   
                                        ]
                                    },
                                    content: [
                                        {
                                            table: {
                                                // headers are automatically repeated if the table spans over multiple pages
                                                // you can declare how many rows should be treated as headers
                                                headerRows: 1,
                                                widths: [ 'auto', '*', '*', 'auto' ],
                                                body: [
                                                    [{text:"ลำดับ",bold: true,alignment: 'center'},{text:"ชื่อพนักงาน",bold: true,alignment: 'center'},{text:"บริษัท",bold: true,alignment: 'center'},{text:"เเผนก",bold: true,alignment: 'center'} ],
                            <%
            List<OUUploadOrder> listorder = (List<OUUploadOrder>) request.getAttribute("listordercustomer");
            int n = 1;
            for (OUUploadOrder orderdetail : listorder) {
                out.print("['" + String.valueOf(n) + "','" + orderdetail.getOrder_cms_fullname() + "','" + orderdetail.getOrder_cms_company() + "','" + orderdetail.getOrder_cms_department() + "'],");
                n++;
                
            }
        %> 
                                                    ]
                                                }
                                            }
                                        ],
                                        background: [
                                            {
                                                canvas: [
                                                    {
                                                        type: 'rect',
                                                        x: 40,
                                                        y: 15,
                                                        w: 520,
                                                        h: 780,
                                                        r: 0,
                                                        lineWidth: 1,
                                                        lineColor: '#000000'
                                                    }
                                                ]
                                            }
                
                                        ],
                                        styles: {
                
                                        },
                                        defaultStyle: {
                                            font: 'THSarabunNew'
                                        }
           
                                    }
                                    pdfMake.createPdf(dd).open({}, window);
        
    </script>
    
</html>
