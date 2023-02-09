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
                        text:[{text:"หน้าที่ : ",bold: true},{text:currentPage,bold: false}],
                        fontSize:18,
                        alignment: 'right',
                        margin:[ 0, 30,50, 0 ]                           
                    },
                    {
                        text:[{text:"ชื่อเอกสาร : ",bold: true},{text:"<%=request.getAttribute("doc_name")%>",bold: false},{text:" เลขที่เอกสาร : ",bold: true},{text:"<%=request.getAttribute("doc_id")%>",bold: false}],
                                fontSize:20,
                                alignment: 'center'                           
                            },
                        ]
                    },
                    content: [
                        {
                            table: {
                                // headers are automatically repeated if the table spans over multiple pages
                                // you can declare how many rows should be treated as headers
                                headerRows: 1,
                                widths: [ '*', '*', '*', 'auto' ],
                                body: [
                                    [{text:"ชื่อพนักงาน",bold: true,alignment: 'center'},{text:"บริษัท",bold: true,alignment: 'center'},{text:"เเผนก",bold: true,alignment: 'center'} ,{text:"Barcode",bold: true,alignment: 'center'}],
                            <%
            List<OUUploadOrder> listorder = (List<OUUploadOrder>) request.getAttribute("listordercustomer");
            for (OUUploadOrder orderdetail : listorder) {
                out.print("['" + orderdetail.getOrder_cms_fullname() + "','" + orderdetail.getOrder_cms_company() + "','" + orderdetail.getOrder_cms_department() + "',{image: textToBase64Barcode('" + request.getAttribute("doc_id").toString() + "/" + orderdetail.getOrder_cms_id() + "'),width: 150, height: 40}],");
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
