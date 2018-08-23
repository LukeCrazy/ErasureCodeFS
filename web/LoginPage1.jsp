<%--
  Created by IntelliJ IDEA.
  User: luke
  Date: 18-2-27
  Time: 下午7:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LOGIN</title>
</head>
<script type="text/javascript" src="jquery/jquery-3.2.1.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="bootstrap-3.3.7-dist/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet"
      href="bootstrap-3.3.7-dist/css/bootstrap-theme.min.css">
<script type="text/javascript">
    $(document).ready(function () {
        $("#1").hide();
        $("#show").click(function () {
            $("#1").show(300);
        });
        $("#x").click(function () {
            $("#1").hide(300);
        });
    });
</script>
<style>
    body {
        background-image: url("image/bg.png");
        background-size: cover;
    }

    .login {
        margin-left: 50px;
        margin-top: -450px;
        border-radius: 5px;
        width: 400px;
        height: 260px;
        background: rgba(40, 40, 40, 0.36);
    }

    .login table {
        margin-top: -10px;
        width: 380px;
        height: 180px;
    }

    .tit {
        border: 0;
        background: rgba(34, 34, 34, 0.39);
    }

    #la1 {
        margin-left: 15px;
        margin-top: 5px;
        font-size: 160%;
    }

    #count {
        width: 320px;
    }

    #key {
        width: 320px;
    }

    #tn_lo {
        margin-top: 5px;
    }

    .sign {
        margin-top: auto;
    }

    .sign img {
        width: 90px;
        height: 100px;
    }

    .sign table {
        text-align: center;
    }

    .p1 {
        margin: auto;
        width: 250px;
        height: 90px;
        border: 3px solid #000000;
        border-width: 3px 0 3px 0;
    }

    #la0 {
        font-size: 150%;
        margin-top: 20px;
    }

    .sign p {
        margin-top: 15px;
    }

    .h1 {
        margin: auto;
        height: 150px;
        background: black;
        width: 3px;
    }

    .h2 {
        margin: auto;
        height: 3px;
        background: black;
        width: 300px;
    }

    .h3 {
        margin: auto;
        height: 3px;
        background: black;
        width: 150px;
    }

    .h4 button {
        margin-top: 10px;
        background: rgba(210, 210, 210, 0.12);
    }

    #x {
        background: rgba(216, 216, 216, 0.09);
        border: 0;
        color: black;
        margin-left: 350px;
        margin-top: 10px;
    }</style>
<body>
<div class="all">
    <div class="sign">
        <br>
        <table align="center">
            <tr>
                <td><img src="image/sign.png"></td>
            </tr>
            <tr>
                <td>
                    <br>
                    <div class="p1">
                        <label id="la0">纠删码性能测试平台</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="h1"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="h2"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <br>
                    <label>这是一个基于HDFS的纠删码性能测试平台</label><br>
                    <label>同时可以用于对文件的保存</label>
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <div class="h3"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="h4">
                        <button type="button" class="btn btn-default" id="show">登录</button>
                    </div>

                </td>
            </tr>
        </table>
    </div>

    <div class="login" id="1">
        <nav class="navbar navbar-default tit">
            <button type="button" class="btn btn-default" id="x">X</button>
        </nav>
        <form class="navbar-form navbar-left" id="login" role="search" action="/login">
            <table>
                <tr>

                    <td><label>用户名</label></td>
                </tr>
                <tr>
                    <td>
                        <input type="text" name="count" class="form-control" id="count" placeholder="count"/></td>
                </tr>
                <tr>
                    <td>
                <tr>
                    <td><label>密码</label></td>
                </tr>
                <td>
                    <input type="password" name="key" class="form-control" id="key" placeholder="key"></td>
                </tr>
                </tr>
                <td>
                    &nbsp;</td>
                </tr>
                <tr>
                    <td><input type="submit" class="btn btn-default" id="tn_lo" value="登录"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>