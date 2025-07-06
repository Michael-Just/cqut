<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../static/plugins/jquery-easyui-1.10.19/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../static/plugins/jquery-easyui-1.10.19/themes/icon.css">
    <script type="text/javascript" src="../static/plugins/jquery-easyui-1.10.19/jquery.min.js"></script>
    <script type="text/javascript" src="../static/plugins/jquery-easyui-1.10.19/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../static/plugins/jquery-easyui-1.10.19/locale/easyui-lang-zh_CN.js"></script>
</head>
<%String username = (String) session.getAttribute("username");%>
<script>
    $(function () {
        let username = '<%=username%>';
        $.ajax({
            type: "get",
            url: "../MyServlet?action=getuser",
            data: {username: username},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#username').textbox({
                        readonly: true,
                        request: true,
                    });
                    $('#ff').form('load', result.data);
                } else {
                    $.messager.alert("提示", result.msg, 'waining');
                }
            }
        });
    });

    function submitForm(){
        $.messager.progress();  // 显示进度条
        $('#ff').form('submit', {
            url: '../MyServlet?action=updateuser',
            queryParams:{
                oldusername:'<%=username%>'
            },
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid) {
                    $.messager.progress('close');   // 如果表单是无效的则隐藏进度条
                }
                return isValid;    // 返回false终止表单提交
            },
            success: function (data) {
                $.messager.progress('close');   // 如果提交成功则隐藏进度条
                let result = eval("(" + data + ")");
                if (result.code === "200") {
                    $.messager.show({
                        title: '提示',
                        msg: result.msg,
                        showType: 'slide',
                        timeout: 2000,
                    });
                    $('#ff').form('reload');
                } else {
                    $.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
    };

</script>
<body>
<div class="easyui-panel" title="编辑信息" style="width:100%;max-width:400px;padding:30px 60px;">
    <form id="ff" method="post">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="username" name="username" style="width:100%" labelPosition="top"
                   data-options="label:'用户名:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="password" name="password" style="width:100%" labelPosition="top"
                   data-options="label:'密码:',required:true,">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="phonenumber" name="phonenumber" style="width:100%" labelPosition="top"
                   data-options="label:'电话:',required:true,validType:['length[11,11]'],invalidMessage:'电话必须是11位数'">
        </div>
    </form>
    <div style="text-align:center;padding:5px 0">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()" style="width:80px">保存</a>
</div>
</div>

</body>
</html>
