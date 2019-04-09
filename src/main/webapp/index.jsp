<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:forward page="/emps"></jsp:forward>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>员工列表</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--web路径:
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306);需要加上项目名
                  http://localhost:3306/crud
    -->

    <!--Bootstrap和jQuery的引入-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap依赖jQuery,所以要把jQuery放前面,以免Bootstrap在jQuery使用时没法使用，很操蛋，模态框一直没法调用就是因为这个破问题-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--员工修改的模态框-->

</body>
</html>