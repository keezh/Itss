<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html>

<html>

<head>
    <title>ITSS 登录页面</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Mobile support -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%@include file="/WEB-INF/common/static.jsp" %>

    <script>
        var ctx = '${ctx}';
    </script>


</head>

<body class="gray-bg">

<div class="middle-box text-center loginscreen  animated fadeInDown">
    <div>
        <div>

            <h1 class="logo-name">ITSS</h1>

        </div>
        <h3>欢迎使用 管理后台</h3>

        <form class="m-t" role="form" action="${ctx}/admin/login" method="post">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="用户名" name="username" id="username" required="" autofocus="autofocus">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="密码" name="password" id="password"
                       required="">
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">登 录</button>


        </form>
    </div>
</div>

</body>
</html>
