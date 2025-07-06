<%--
  Created by IntelliJ IDEA.
  User: 杨明举
  Date: 2024/5/26
  Time: 0:57
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
    <script type="text/javascript" src="static/plugins/jquery-easyui-1.10.19/locale/easyui-lang-zh_CN.js"></script>
    <script>
        $(function () {
            $("#divform").dialog({
                title: '注册用户',
                width: 400,
                height: 300,
                closed: false,
                cache: false,
                modal: true,
                buttons: [{
                    text: '保存',
                    iconCls: 'icon-save',
                    handler: function () {
                        $.messager.progress();  // 显示进度条
                        $('#ff').form('submit', {
                            url: 'LoginServlet?action=register',
                            onSubmit: function () {
                                var isValid = $(this).form('validate');
                                if (!isValid) {
                                    $.messager.progress('close');   // 如果表单是无效的则隐藏进度条
                                }
                                return isValid;    // 返回false终止表单提交
                            },
                            success: function (data) {
                                var data = eval('(' + data + ')');  // change the JSON string to javascript object
                                if (data.code === '200') {
                                    $.messager.alert('提示',data.msg + '返回登录','info',function () {
                                        location.href = 'login.jsp';
                                    });
                                }
                                else{
                                    $.messager.alert('提示',data.msg,'warning');
                                }
                                $.messager.progress('close');   // 如果提交成功则隐藏进度条
                            }
                        });
                    }
                }, {
                    text: '退出',
                    iconCls: 'icon-back',
                    handler: function () {
                        location.href = "login.jsp";
                    }
                }]
            })
        })
    </script>
</head>
<body>
<div id="divform">
    <form id="ff" method="post">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="username" style="width:80%"
                   data-options="label:'用户名:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="password" style="width:80%"
                   data-options="label:'密码:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="passwordcopy" style="width:80%"
                   data-options="label:'密码确认:',required:true">  
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="phonenumber" style="width:80%" data-options="label:'电话:',multiline:true">
        </div>
    </form>
</div>
</body>
</html>
