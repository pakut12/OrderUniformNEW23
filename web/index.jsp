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
        <img src="img/logo.png" class="img-fluid">
        <div class="container">
            <form action="Chklogin" method="POST"> 
                <div class="card mt-5 col-sm-12 col-md-5 mx-auto ">
                    <div class="card-header ">
                        Login
                    </div>
                    <div class="card-body" style="color: green;">
                        <label for="username" class="">Username : </label>
                        <input class="form-control form-control-sm " type="text" id="username" name="username"></input>
                        <label for="password" class="">Password : </label>
                        <input class="form-control form-control-sm " type="password" id="password" name="password"></input>
                        
                        <button class="btn-sm btn btn-success w-100 mt-3" type="submit">Login</button>
                    </div>
                </div>
            </form>
        </div>
        <footer>
            <%@ include file="share/footer.jsp" %>
        </footer>
        <script>
            $(document).ready(function() {
                //alert('asd');
            });
        </script>
    </body>
</html>
