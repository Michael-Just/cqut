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
<script>
    $(function () {
        $('#dg').datagrid({
            url: '../CoachServlet?action=getdglist',
            toolbar: '#tb',
            fit: true,
            pagination: true,
            singleSelect: true,
            remoteSort:false,
            sortName:'cno',
            sortOrder:'desc',
            columns: [[
                {field: 'cno', title: '教练号', width: 200,sortable:true},
                {field: 'cname', title: '教练名', width: 200,sortable:true},
                {field: 'cage', title: '年龄', width: 200,sortable:true},
            ]]
        });

        //新增
        $('#btnAdd').click(function () {
            $('#dd').dialog({
                title: '教练新增',
                width: 400,
                height: 400,
                closed: false,
                cache: false,
                href: 'coachform.jsp?action=add&r=' + Math.random(),
                modal: true,
                buttons: [{
                    text: '保存',
                    iconCls: 'icon-save',
                    handler: function () {
                        let isOk = $('#ff').form('validate');
                        if (isOk) {
                            $.messager.confirm('确认', '是否确认添加？', function (r) {
                                if (r) {
                                    SaveData('add');
                                }
                            });
                        }
                    }
                }, {
                    text: '退出',
                    iconCls: 'icon-back',
                    handler: function () {
                        $('#dd').dialog('close');
                    }
                }]
            });
        });

        //删除
        $('#btnDelete').click(function () {
            if ($('#dg').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要删除的数据！', 'warning');
                return;
            } else {
                $.messager.confirm('确认', '是否要删除数据？', function (r) {
                    if (r) {
                        let row = $('#dg').datagrid('getSelected');
                        $.ajax({
                            type: "get",
                            url: "../CoachServlet?action=delete",
                            data: {cno: row.cno},
                            success: function (ret) {
                                let result = eval("(" + ret + ")");
                                if (result.code === "200") {
                                    $.messager.show({
                                        title: '提示',
                                        msg: result.msg,
                                        showType: 'slide',
                                        timeout: 2000,
                                    });
                                    $('#dg').datagrid('reload');
                                    $('#dd').dialog('close');
                                } else {
                                    $.messager.alert("提示", result.msg, 'waining');
                                }
                            }
                        })
                    }

                })
            }

        });

        //编辑
        $('#btnEdit').click(function () {
            if ($('#dg').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要编辑的数据！', 'warning');
                return;
            } else {
                $('#dd').dialog({
                    title: '训练安排修改',
                    width: 400,
                    height: 400,
                    closed: false,
                    cache: false,
                    href: 'coachform.jsp?action=edit&r=' + Math.random(),
                    modal: true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-save',
                        handler: function () {
                            let isOk = $('#ff').form('validate');
                            if (isOk) {
                                $.messager.confirm('确认', '是否确认修改？', function (r) {
                                    if (r) {
                                        SaveData('update');
                                    }
                                });
                            }
                        }
                    }, {
                        text: '退出',
                        iconCls: 'icon-back',
                        handler: function () {
                            $('#dd').dialog('close');
                        }
                    }]
                });
            }
        });

        //搜索
        $('#searchbox').searchbox({
            searcher: function (value) {
                $('#dg').datagrid({
                    url: '../CoachServlet?action=search',
                    toolbar: '#tb',
                    fit: true,
                    pagination: true,
                    singleSelect: true,
                    queryParams: {
                        value: value
                    },
                    remoteSort:false,
                    sortName:'cno',
                    sortOrder:'desc',
                    columns: [[
                        {field: 'cno', title: '教练号', width: 200,sortable:true},
                        {field: 'cname', title: '教练名', width: 200,sortable:true},
                        {field: 'cage', title: '年龄', width: 200,sortable:true},
                    ]]
                });
            }
        });

    });

    function SaveData(action) {
        $.messager.progress();  // 显示进度条
        $('#ff').form('submit', {
            url: '../CoachServlet?action=' + action,
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
                    $('#dg').datagrid('reload');
                    $('#dd').dialog('close');
                } else {
                    $.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
    }
</script>
<body class="easyui-layout">
<div data-options="region:'center',iconCls:'icon-ok',border:false">
    <table id="dg"></table>
</div>
<div id="dd"></div>
<div id="tb" style="height: auto">
    <table>
        <tr>
            <td><a id="btnAdd" href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="plain:true,iconCls:'icon-add'">新增</a></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
            <td><a id="btnEdit" href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="plain:true,iconCls:'icon-edit'">修改</a></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
            <td><a id="btnDelete" href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="plain:true,iconCls:'icon-cancel'">删除</a></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
            <td><input id="searchbox" class="easyui-searchbox" data-options="prompt:'搜索'"></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>