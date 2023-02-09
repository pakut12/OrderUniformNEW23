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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
        <%
            String[] productgroup = (String[]) request.getAttribute("productgroup");
            String datenow = (String) request.getAttribute("datenow");

            for (String pdg : productgroup) {
                ProductGroupService pd = new ProductGroupService();
                List<OUProductGroup> list = pd.getProductGroupBymat_group(pdg);

                int n = 0;
                String HTMLtag = "";
                HTMLtag += "<div class='pagebreak'>";
                HTMLtag += "<div class='fw-bold h4'>List ProductGroup : " + pdg + "             Date : " + datenow + "</div>";
                HTMLtag += "<table id=\"list-masterpos\" class='table table-bordered text-center text-nowrap w-100 mt-3' >";
                HTMLtag += "<thead>";
                HTMLtag += "<tr>";
                HTMLtag += "<th>MatNo</th>";
                HTMLtag += "<th>Barcode</th>";
                HTMLtag += "<th>Name</th>";
                // HTMLtag += "<th>MatGroup</th>";
                HTMLtag += "<th>Color</th>";
                HTMLtag += "<th>Size</th>";
                HTMLtag += "<th>Plant</th>";
                HTMLtag += "</tr>";
                HTMLtag += "</thead>";
                HTMLtag += "<tbody>";
                for (OUProductGroup x : list) {
                    String price = x.getSale_price();
                    String pricesumvat = "";
                    if (price == null) {
                        price = "";
                        pricesumvat = "";
                    } else {
                        pricesumvat = String.valueOf(Math.round((Float.parseFloat(x.getSale_price()) * (100 + 7)) / 100));
                    }
                    HTMLtag += "<tr>";
                    HTMLtag += "<td>" + x.getMat_no() + "</td>";
                    HTMLtag += "<td><img class='barcode typebarcode' jsbarcode-value='" + x.getMat_barcode() + "'/></td>";
                    HTMLtag += "<td>" + x.getMat_name_th() + "</td>";
                    //HTMLtag += "<td>" + x.getMat_group() + "</td>";
                    HTMLtag += "<td>" + x.getColor_id() + "</td>";
                    HTMLtag += "<td>" + x.getSize_id() + "</td>";
                    HTMLtag += "<td>" + x.getPlant() + "</td>";
                    //HTMLtag += "<td>" + Math.round((Float.parseFloat(x.getSale_price()) * (100 + 7)) / 100) + "</td>";
                    HTMLtag += "</tr>";
                    n++;
                }
                HTMLtag += "</tbody>";
                HTMLtag += "</table>";
                HTMLtag += "</div>";
                out.print(HTMLtag);
            }
        %>
        
    </body>
    <script>
        window.print();
        JsBarcode(".barcode").init();
    </script>
    
</html>
