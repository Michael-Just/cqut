<%--
  Created by IntelliJ IDEA.
  User: 杨明举
  Date: 2024/6/3
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="static/plugins/jquery-easyui-1.10.19/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/plugins/jquery-easyui-1.10.19/themes/icon.css">
    <script type="text/javascript" src="static/plugins/jquery-easyui-1.10.19/jquery.min.js"></script>
    <script type="text/javascript" src="static/plugins/jquery-easyui-1.10.19/jquery.easyui.min.js"></script>
    <SCRIPT src="static/login/js/jquery-1.9.1.min.js" type="text/javascript"></SCRIPT>
</head>

<style>
    body {
        background: url(static/login/images/background.jpg), no-repeat;
        background-size: cover;
        background-attachment: fixed;
    }

    body a {
        transition: 0.5s all;
        -webkit-transition: 0.5s all;
        -moz-transition: 0.5s all;
        -o-transition: 0.5s all;
        -ms-transition: 0.5s all;
        font-weight: 400;
    }

    input[type="button"], input[type="button"] {
        transition: 0.5s all;
        -webkit-transition: 0.5s all;
        -moz-transition: 0.5s all;
        -o-transition: 0.5s all;
        -ms-transition: 0.5s all;
    }

    h1, h2, h3, h4, h5, h6 {
        margin: 0;
        font-weight: 400;
        transition: 0.5s all;
        -webkit-transition: 0.5s all;
        -moz-transition: 0.5s all;
        -o-transition: 0.5s all;
        -ms-transition: 0.5s all;

    }

    .clear {
        clear: both;
    }

    p {
        margin: 0;
    }

    ul {
        margin: 0;
        padding: 0;
    }

    label {
        margin: 0;
    }

    img {
        width: 100%;
    }

    @font-face {
        font-family: 'Lobster-Regular';
        src: url('static/login/fonts/Lobster-Regular.ttf') format('truetype');
    }

    @font-face {
        font-family: 'Righteous-Regular';
        src: url('static/login/fonts/Righteous-Regular.ttf') format('truetype');
    }

    /*--/Reset code--*/
    .wthree-form {
        text-align: center;
        background-color: #131315;
        width: 40%;
        margin: 0 auto;
        padding: 3em;
        box-shadow: 4px 4px 0px rgb(77, 78, 80);
        opacity: 0.7;
        box-sizing: border-box;
    }

    h1 {
        font-size: 45px;
        font-weight: 400;
        text-align: center;
        text-transform: capitalize;
        letter-spacing: 9px;
        word-spacing: 4px;
        margin: 40px 0;
        color: #fff;
        font-family: 'Lobster', cursive;
    }

    span {
        color: red;
    }

    h2 {
        font-size: 20px;
        font-weight: 400;
        text-align: center;
        text-transform: lowercase;
        letter-spacing: 0.1em;
        padding: 0.5em;
        color: #fff;
        border-bottom: 2px solid red;
        font-family: 'Righteous', cursive;
    }


    input[type="text"], input[type="password"] {
        font-size: 1em;
        font-weight: 500;
        text-align: center;
        text-transform: capitalize;
        letter-spacing: 1px;
        margin: 10px;
        padding: 8px 0;
        border: 2px solid #fff;
        outline: none;
        box-sizing: border-box;
        font-family: 'Righteous', cursive;
    }

    input[type="button"] {
        font-size: 1em;
        font-weight: 500;
        text-align: center;
        text-transform: capitalize;
        letter-spacing: 3px;
        margin: 20px 0 20px;
        padding: 8px 0;
        border: 2px solid #fff;
        outline: none;
        cursor: pointer;
        width: 30%;
        box-sizing: border-box;
        font-family: 'Righteous', cursive;
        -webkit-transition: 0.5s all;
        -moz-transition: 0.5s all;
        -o-transition: 0.5s all;
        -ms-transition: 0.5s all;
        transition: 0.5s all;
    }

    input[type="button"]:hover {
        font-size: 1em;
        font-weight: 500;
        text-transform: none;
        text-align: center;
        border-radius: 2em;
        border: 2px solid #fff;
        padding: 8px 0;
        outline: none;
        cursor: pointer;
        background-color: transparent;
        color: #fff;
        font-family: 'Righteous', cursive;
        -webkit-transition: 0.5s all;
        -moz-transition: 0.5s all;
        -o-transition: 0.5s all;
        -ms-transition: 0.5s all;
        transition: 0.5s all;
    }

    input.checkbox {
        margin-left: 2px;
    }

    .anim span {
        width: 23%;
    }

    .anim span {
        text-align: center;
        color: #fff;
        letter-spacing: 1px;
        font-family: 'Righteous', cursive;
    }

    a {
        color: #fffcfc;
        text-decoration: none;
        letter-spacing: 1px;
        font-family: 'Righteous', cursive;
    }

    .footer-agileits {
        text-align: center;
        margin-top: 5em;
        color: #fff;
        font-family: 'Lobster', cursive;
        letter-spacing: 3px;
    }

    .footer-agileits a {
        color: yellow;
        font-family: 'Lobster', cursive;
    }

    .footer-agileits a:hover {
        color: #75eb6f;
    }

    /*--responsive--*/
    @media (max-width: 1920px) {
        input[type="text"], input[type="password"] {
            width: 60%;
        }
    }

    @media (max-width: 1680px) {

    }

    @media (max-width: 1600px) {
        input[type="text"], input[type="password"] {
            width: 70%;
        }
    }

    @media (max-width: 1440px) {
        .wthree-form {
            background-color: #131315;
            width: 50%;
        }
    }

    @media (max-width: 1366px) {

    }

    @media (max-width: 1280px) {

    }

    @media (max-width: 1024px) {

    }

    @media (max-width: 1080px) {
        .wthree-form {
            background-color: #131315;
            width: 60%;
        }
    }

    @media (max-width: 1050px) {

    }

    @media (max-width: 1024px) {
        .footer-agileits {
            margin-top: 3em;
        }
    }

    @media (max-width: 991px) {

    }

    @media (max-width: 900px) {

    }

    @media (max-width: 800px) {
        .wthree-form {
            background-color: rgb(19, 19, 21);
            width: 70%;
        }

        .footer-agileits {
            margin-top: 1em;
        }
    }

    @media (max-width: 768px) {
        .wthree-form {
            background-color: rgb(19, 19, 21);
            width: 75%;
        }

        .footer-agileits {
            margin-top: 5em;
        }
    }

    @media (max-width: 736px) {

    }

    @media (max-width: 667px) {
        h2 {
            font-size: 19px;
        }

        .footer-agileits {
            margin-top: 1em;
        }
    }

    @media (max-width: 640px) {
        .wthree-form {
            background-color: rgb(19, 19, 21);
            width: 75%;
        }
    }

    @media (max-width: 600px) {
        h1 {
            font-size: 35px;
            letter-spacing: 8px;
        }

        h2 {
            font-size: 18px;
        }
    }

    @media (max-width: 568px) {
        h2 {
            font-size: 15px;
        }

        .wthree-form {
            width: 78%;
        }
    }

    @media (max-width: 480px) {
        h1 {
            font-size: 30px;
            letter-spacing: 6px;
        }

        h2 {
            font-size: 14px;
        }

        .wthree-form {
            width: 85%;
        }
    }

    @media (max-width: 414px) {
        h1 {
            font-size: 25px;
        }

        h2 {
            font-size: 15px;
        }

        .footer-agileits {
            margin-top: 2.5em;
        }

        .wthree-form {
            padding: 2em 2em;
        }
    }

    @media (max-width: 384px) {
        h1 {
            font-size: 22px;
        }

        .wthree-form {
            width: 90%;
        }

        .wthree-form {
            padding: 2em 1em;
        }

        h2 {
            font-size: 16px;
        }
    }

    @media (max-width: 375px) {
        h1 {
            font-size: 25px;

        }

        h2 {
            font-size: 14px;
        }

        .wthree-form {
            width: 95%;
        }

        .wthree-form {
            padding: 2em 1em;
        }
    }

    @media (max-width: 320px) {
        h1 {
            font-size: 24px;
            letter-spacing: 2px;
            margin: 35px 0;
        }

        h2 {
            font-size: 14px;
        }

        .footer-agileits p {
            font-size: 13px;
            line-height: 1.8;
        }

        .wthree-form {
            width: 100%;
        }

        input[type="button"] {
            width: 40%;
        }

        .wthree-form {
            padding: 1em;
        }

        input[type="text"], input[type="password"] {
            width: 90%;
        }
    }

    /*--/responsive--*/

</style>

<script type="text/javascript">
    $(function () {
        $("#btnlogin").click(function () {
            let username = $("#username").val();
            let password = $("#password").val();
            let passwordcopy = $("#passwordcopy").val();
            let phonenumber = $("#phonenumber").val();
            if(password===passwordcopy){
                $.ajax({
                    type: "post",
                    url: "LoginServlet?action=register",
                    data: {username: username, password: password,phonenumber:phonenumber},
                    success: function (ret) {
                        let result = eval("(" + ret + ")");
                        if (result.code === "200") {
                            location.href = "login.jsp";
                        } else {
                            alert(result.msg);
                        }
                    }
                })
            }else{
                alert("两次输入的密码不一致，请重新输入！");
            }
        })
    });
</script>

<body>
<div class="wthree-form">
    <h2>请您完成注册</h2>
    <div class="w3l-login form">
        <form id="ff" method="post">
            <div style="margin: 20px 0">
                <input class="easyui-textbox" id="username" name="username" style="width: 70%;height: 40px" prompt="请输入用户名" />
            </div>
            <div style="margin: 20px 0">
                <input class="easyui-passwordbox" id="password" name="password" style="width: 70%;height: 40px" prompt="请输入密码" />
            </div>
            <div style="margin: 20px 0">
                <input class="easyui-passwordbox" id="passwordcopy" name="passwordcopy" style="width: 70%;height: 40px" prompt="请确认密码" />
            </div>
            <div style="margin: 20px 0">
                <input class="easyui-textbox" id="phonenumber" name="phonenumber" style="width: 70%;height: 40px" prompt="请输入电话" />
            </div>
            <a style="color: red">注：只能输入大小写字母或数字</a>
            <div class="submit-agileits" id="btnlogin">
                <input type="button" value="确定">
            </div>
            <a href="login.jsp">返回</a>
        </form>
    </div>
</div>
<div class="footer-agileits">
    <p>&copy; 比赛管理系统 | 版权来自<a>素质baby</a></p>
</div>
</body>
</html>