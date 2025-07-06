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
    $(document).ready(function () {
        $('#win').window('close');
    });
    $(function () {
        $('#dg').datagrid({
            url: '../TeamServlet?action=getdglist',
            toolbar: '#tb',
            fit: true,
            pagination: true,
            singleSelect: true,
            remoteSort: false,
            sortName: 'tname',
            sortOrder: 'desc',
            columns: [[
                {field: 'tname', title: '球队名称', width: 200, sortable: true},
                {field: 'cno', title: '教练号', width: 200, sortable: true},
                {field: 'cname', title: '教练名', width: 200, sortable: true},
                {field: 'tcity', title: '代表地区', width: 200, sortable: true},
                {field: 'ttime', title: '成立时间', width: 200, sortable: true}
            ]]
        });

        //新增
        $('#btnAdd').click(function () {
            $('#dd').dialog({
                title: '球队新增',
                width: 400,
                height: 400,
                closed: false,
                cache: false,
                href: 'teamform.jsp?action=add&r=' + Math.random(),
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
                            url: "../TeamServlet?action=delete",
                            data: {tname: row.tname},
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
                    title: '球队修改',
                    width: 400,
                    height: 400,
                    closed: false,
                    cache: false,
                    href: 'teamform.jsp?action=edit&r=' + Math.random(),
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
                    url: '../TeamServlet?action=search',
                    toolbar: '#tb',
                    fit: true,
                    pagination: true,
                    singleSelect: true,
                    queryParams: {
                        value: value
                    },
                    remoteSort: false,
                    sortName: 'tname',
                    sortOrder: 'desc',
                    columns: [[
                        {field: 'tname', title: '球队名称', width: 200, sortable: true},
                        {field: 'cno', title: '教练号', width: 200, sortable: true},
                        {field: 'cname', title: '教练名', width: 200, sortable: true},
                        {field: 'tcity', title: '代表地区', width: 200, sortable: true},
                        {field: 'ttime', title: '成立时间', width: 200, sortable: true}
                    ]]
                });
            }
        });
    });

    let l;
    //查看
    $(function () {
        $('#btnLook').click(function () {
            let row = $('#dg').datagrid('getSelected');
            if (row == null) {
                $.messager.alert('提示', '请选择要查看的球队！', 'warning');
                return;
            } else {
                l = row.tname;
                $.messager.confirm('确认', '是否要查看？', function (r) {
                    if (r) {
                        $('#win').window('open');  // open a window
                        $('#win').window({
                            title: row.tname
                        });
                        $('#dg2').datagrid({
                            url: '../TeamServlet?action=getteam',
                            queryParams: {tname: row.tname},
                            toolbar: '#tb2',
                            fit: true,
                            pagination: true,
                            singleSelect: true,
                            remoteSort: false,
                            sortName: 'pno',
                            sortOrder: 'desc',
                            columns: [[
                                {field: 'pno', title: '球员号', width: 200, sortable: true},
                                {field: 'pname', title: '球员姓名', width: 200, sortable: true},
                                {field: 'page', title: '球员年龄', width: 200, sortable: true},
                                {field: 'pheight', title: '球员身高', width: 200, sortable: true},
                                {field: 'pweight', title: '球员体重', width: 200, sortable: true}
                            ]]
                        });
                    }

                })
            }

        });
    });

    $(function () {
        //新增2
        $('#btnAdd2').click(function () {
            $('#dd').dialog({
                title: '球员新增',
                width: 400,
                height: 400,
                closed: false,
                cache: false,
                href: 'playerform.jsp?action=add&r=' + Math.random(),
                modal: true,
                buttons: [{
                    text: '保存',
                    iconCls: 'icon-save',
                    handler: function () {
                        let isOk = $('#ff').form('validate');
                        if (isOk) {
                            $.messager.confirm('确认', '是否确认添加？', function (r) {
                                if (r) {
                                    SaveData2('add');
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
    });

    $(function () {
        //删除2
        $('#btnDelete2').click(function () {
            if ($('#dg2').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要删除的数据！', 'warning');
                return;
            } else {
                $.messager.confirm('确认', '是否要删除数据？', function (r) {
                    if (r) {
                        let row = $('#dg2').datagrid('getSelected');
                        $.ajax({
                            type: "get",
                            url: "../PlayerServlet?action=delete",
                            data: {pno: row.pno,pteam:l},
                            success: function (ret) {
                                let result = eval("(" + ret + ")");
                                if (result.code === "200") {
                                    $.messager.show({
                                        title: '提示',
                                        msg: result.msg,
                                        showType: 'slide',
                                        timeout: 2000,
                                    });
                                    $('#dg2').datagrid('reload');
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

        //编辑2
        $('#btnEdit2').click(function () {
            if ($('#dg2').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要编辑的数据！', 'warning');
                return;
            } else {
                $('#dd').dialog({
                    title: '球员修改',
                    width: 400,
                    height: 400,
                    closed: false,
                    cache: false,
                    href: 'playerform.jsp?action=edit&r=' + Math.random(),
                    modal: true,
                    buttons: [{
                        text: '保存',
                        iconCls: 'icon-save',
                        handler: function () {
                            let isOk = $('#ff').form('validate');
                            if (isOk) {
                                $.messager.confirm('确认', '是否确认修改？', function (r) {
                                    if (r) {
                                        SaveData2('update');
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

        //搜索2
        $('#searchbox2').searchbox({
            searcher: function (value) {
                $('#dg2').datagrid({
                    url: '../PlayerServlet?action=search',
                    toolbar: '#tb2',
                    fit: true,
                    pagination: true,
                    singleSelect: true,
                    queryParams: {
                        value: value,
                        pteam:l,
                    },
                    remoteSort: false,
                    sortName: 'pno',
                    sortOrder: 'desc',
                    columns: [[
                        {field: 'pno', title: '球员号', width: 200, sortable: true},
                        {field: 'pname', title: '球员姓名', width: 200, sortable: true},
                        {field: 'page', title: '球员年龄', width: 200, sortable: true},
                        {field: 'pheight', title: '球员身高', width: 200, sortable: true},
                        {field: 'pweight', title: '球员体重', width: 200, sortable: true}
                    ]]
                });
            }
        });

    });

    function SaveData(action) {
        $.messager.progress();  // 显示进度条
        $('#ff').form('submit', {
            url: '../TeamServlet?action=' + action,
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

    function SaveData2(action) {
        $.messager.progress();  // 显示进度条
        $('#ff').form('submit', {
            queryParams: {
                pteam: l
            },
            url: '../PlayerServlet?action=' + action,
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
                    $('#dg2').datagrid('reload');
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
<div id="win" class="easyui-window" style="width:1000px;height:400px"
     data-options="iconCls:'icon-save',modal:true">
    <table id="dg2"></table>
    <div id="tb2" style="height: auto">
        <table>
            <tr>
                <td><a id="btnAdd2" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-add'">新增</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
                <td><a id="btnEdit2" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-edit'">修改</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
                <td><a id="btnDelete2" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-cancel'">删除</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
                <td><input id="searchbox2" class="easyui-searchbox" data-options="prompt:'搜索'"></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
            </tr>
        </table>
    </div>
</div>
<div id="tb" style="height: auto">
    <table>
        <tr>
            <td><a id="btnLook" href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="plain:true,iconCls:'icon-add'">查看</a></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
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