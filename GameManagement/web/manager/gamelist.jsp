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
        $('#win2').window('close');
    });
    $(function () {
        $('#dg').datagrid({
            url: '../GameServlet?action=getdglista',
            toolbar: '#tb',
            fit: true,
            pagination: true,
            singleSelect: true,
            remoteSort: false,
            sortName: 'gtime',
            sortOrder: 'desc',
            columns: [[
                {field: 'tname', title: '比赛球队甲队', width: 180, sortable: true},
                {field: 'tname2', title: '比赛球队乙队', width: 180, sortable: true},
                {field: 'sname', title: '比赛球场', width: 180, sortable: true},
                {field: 'rno', title: '裁判号', width: 100, sortable: true},
                {field: 'rname', title: '裁判名', width: 180, sortable: true},
                {field: 'gtime', title: '比赛时间', width: 180, sortable: true},
                {field: 'gscores', title: '比分', width: 180, sortable: true},
            ]]
        });

        //新增
        $('#btnAdd').click(function () {
            $('#dd').dialog({
                title: '比赛安排新增',
                width: 400,
                height: 400,
                closed: false,
                cache: false,
                href: 'gameforma.jsp?action=add&r=' + Math.random(),
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
                            url: "../GameServlet?action=delete",
                            data: {gno: row.gno},
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
                    title: '比赛安排修改',
                    width: 400,
                    height: 400,
                    closed: false,
                    cache: false,
                    href: 'gameforma.jsp?action=edit&r=' + Math.random(),
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
                    url: '../GameServlet?action=search',
                    toolbar: '#tb',
                    fit: true,
                    pagination: true,
                    singleSelect: true,
                    queryParams: {
                        value: value
                    },
                    remoteSort: false,
                    sortName: 'gtime',
                    sortOrder: 'desc',
                    columns: [[
                        {field: 'tname', title: '比赛球队甲队', width: 180, sortable: true},
                        {field: 'tname2', title: '比赛球队乙队', width: 180, sortable: true},
                        {field: 'sname', title: '比赛球场', width: 180, sortable: true},
                        {field: 'rno', title: '裁判号', width: 100, sortable: true},
                        {field: 'rname', title: '裁判名', width: 180, sortable: true},
                        {field: 'gtime', title: '比赛时间', width: 180, sortable: true},
                        {field: 'gscores', title: '比分', width: 180, sortable: true},
                    ]]
                });
            }
        });

        //查看
        $('#btnLook').click(function () {
            $.messager.confirm('确认', '是否要查看？', function (r) {
                if (r) {
                    $('#win').window('open');  // open a window
                    $('#win').window({
                        title: 'A组'
                    });
                    $('#dg3').datagrid({
                        url: '../GameServlet?action=getgradea',
                        toolbar: '#tb3',
                        fit: true,
                        pagination: true,
                        singleSelect: true,
                        remoteSort: false,
                        sortName: 'tname',
                        sortOrder: 'desc',
                        columns: [[
                            {field: 'tname', title: '球队名称', width: 200, sortable: true},
                        ]]
                    });
                }

            })

        });

        //新增3
        $('#btnAdd3').click(function () {
            let tname = $('#gradeateam').combobox('getValue');
            if(tname!=''){
                $.ajax({
                    url: '../GameServlet?action=addgradea',
                    type: 'get',
                    data: {tname: tname},
                    success: function (data) {
                        $.messager.progress('close');   // 如果提交成功则隐藏进度条
                        let result = eval("(" + data + ")");
                        if (result.code === "200") {
                            window.location.reload();
                        } else {
                            $.messager.alert('提示', result.msg, 'warning');
                        }
                    },
                });
            }else{
                $.messager.alert('提示', '请选择球队', 'warning');
            }

        });

        //删除3
        $('#btnDelete3').click(function () {
            if ($('#dg3').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要删除的数据！', 'warning');
                return;
            } else {
                $.messager.confirm('确认', '是否要删除数据？', function (r) {
                    if (r) {
                        let row = $('#dg3').datagrid('getSelected');
                        $.ajax({
                            type: "get",
                            url: "../GameServlet?action=deletegradea",
                            data: {tname: row.tname},
                            success: function (ret) {
                                let result = eval("(" + ret + ")");
                                if (result.code === "200") {
                                    window.location.reload();
                                } else {
                                    $.messager.alert("提示", result.msg, 'waining');
                                }
                            }
                        })
                    }

                })
            }

        });


    });

    function SaveData(action) {
        $.messager.progress();  // 显示进度条
        $('#ff').form('submit', {
            url: '../GameServlet?action=' + action,
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

    $(function () {
        $('#dg2').datagrid({
            url: '../GameServlet?action=getdglistb',
            toolbar: '#tb2',
            fit: true,
            pagination: true,
            singleSelect: true,
            remoteSort: false,
            sortName: 'gtime',
            sortOrder: 'desc',
            columns: [[
                {field: 'tname', title: '比赛球队甲队', width: 180, sortable: true},
                {field: 'tname2', title: '比赛球队乙队', width: 180, sortable: true},
                {field: 'sname', title: '比赛球场', width: 180, sortable: true},
                {field: 'rno', title: '裁判号', width: 100, sortable: true},
                {field: 'rname', title: '裁判名', width: 180, sortable: true},
                {field: 'gtime', title: '比赛时间', width: 180, sortable: true},
                {field: 'gscores', title: '比分', width: 180, sortable: true},
            ]]
        });

        //新增2
        $('#btnAdd2').click(function () {
            $('#dd').dialog({
                title: '比赛安排新增',
                width: 400,
                height: 400,
                closed: false,
                cache: false,
                href: 'gameformb.jsp?action=add&r=' + Math.random(),
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

        //删除2
        $('#btnDelete2').click(function () {
            if ($('#dg').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要删除的数据！', 'warning');
                return;
            } else {
                $.messager.confirm('确认', '是否要删除数据？', function (r) {
                    if (r) {
                        let row = $('#dg2').datagrid('getSelected');
                        $.ajax({
                            type: "get",
                            url: "../GameServlet?action=delete",
                            data: {gno: row.gno},
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
                    title: '比赛安排修改',
                    width: 400,
                    height: 400,
                    closed: false,
                    cache: false,
                    href: 'gameformb.jsp?action=edit&r=' + Math.random(),
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
                    url: '../GameServlet?action=search',
                    toolbar: '#tb2',
                    fit: true,
                    pagination: true,
                    singleSelect: true,
                    queryParams: {
                        value: value
                    },
                    remoteSort: false,
                    sortName: 'gtime',
                    sortOrder: 'desc',
                    columns: [[
                        {field: 'tname', title: '比赛球队甲队', width: 180, sortable: true},
                        {field: 'tname2', title: '比赛球队乙队', width: 180, sortable: true},
                        {field: 'sname', title: '比赛球场', width: 180, sortable: true},
                        {field: 'rno', title: '裁判号', width: 100, sortable: true},
                        {field: 'rname', title: '裁判名', width: 180, sortable: true},
                        {field: 'gtime', title: '比赛时间', width: 180, sortable: true},
                        {field: 'gscores', title: '比分', width: 180, sortable: true},
                    ]]
                });
            }
        });

        //查看2
        $('#btnLook2').click(function () {
            $.messager.confirm('确认', '是否要查看？', function (r) {
                if (r) {
                    $('#win2').window('open');  // open a window
                    $('#win2').window({
                        title: 'B组'
                    });
                    $('#dg4').datagrid({
                        url: '../GameServlet?action=getgradeb',
                        toolbar: '#tb4',
                        fit: true,
                        pagination: true,
                        singleSelect: true,
                        remoteSort: false,
                        sortName: 'tname',
                        sortOrder: 'desc',
                        columns: [[
                            {field: 'tname', title: '球队名称', width: 200, sortable: true},
                        ]]
                    });
                }

            })

        });

        //新增4
        $('#btnAdd4').click(function () {
            let tname = $('#gradebteam').combobox('getValue');
            if(tname!=''){
                $.ajax({
                    url: '../GameServlet?action=addgradeb',
                    type: 'get',
                    data: {tname: tname},
                    success: function (data) {
                        $.messager.progress('close');   // 如果提交成功则隐藏进度条
                        let result = eval("(" + data + ")");
                        if (result.code === "200") {
                            window.location.reload();
                        } else {
                            $.messager.alert('提示', result.msg, 'warning');
                        }
                    },
                });
            }else {
                $.messager.alert('提示','请选择球队', 'warning');
            }

        });

        //删除3
        $('#btnDelete4').click(function () {
            if ($('#dg4').datagrid('getSelected') == null) {
                $.messager.alert('提示', '请选择要删除的数据！', 'warning');
                return;
            } else {
                $.messager.confirm('确认', '是否要删除数据？', function (r) {
                    if (r) {
                        let row = $('#dg4').datagrid('getSelected');
                        $.ajax({
                            type: "get",
                            url: "../GameServlet?action=deletegradeb",
                            data: {tname: row.tname},
                            success: function (ret) {
                                let result = eval("(" + ret + ")");
                                if (result.code === "200") {
                                    window.location.reload();
                                } else {
                                    $.messager.alert("提示", result.msg, 'waining');
                                }
                            }
                        })
                    }

                })
            }

        });


    });

    function SaveData2(action) {
        $.messager.progress();  // 显示进度条
        $('#ff').form('submit', {
            url: '../GameServlet?action=' + action,
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
<div id="tb" style="height: auto">
    <table>
        <tr>
            <td>A组</td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
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

<div id="win" class="easyui-window" style="width:500px;height:400px"
     data-options="iconCls:'icon-save',modal:true">
    <table id="dg3"></table>
    <div id="tb3" style="height: auto">
        <table>
            <tr>
                <td><select class="easyui-combobox" id="gradeateam" name="gradeateam" style="width:150px"
                            limitToList="true"
                            data-options="required:true,url:'../GetServlet?action=getteam',method:'get',textField:'tname',valueField:'tname'">
                </select></td>
                <td><a id="btnAdd3" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-add'">添加</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
                <td><a id="btnDelete3" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-edit'">删除</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
            </tr>
        </table>
    </div>
</div>

<div data-options="region:'south',split:true" style="height:50%;text-align: center;">
    <table id="dg2"></table>
    <div id="tb2" style="height: auto">
        <table>
            <tr>
                <td>B组</td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
                <td><a id="btnLook2" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-add'">查看</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
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

<div id="win2" class="easyui-window" style="width:500px;height:400px"
     data-options="iconCls:'icon-save',modal:true">
    <table id="dg4"></table>
    <div id="tb4" style="height: auto">
        <table>
            <tr>
                <td><select class="easyui-combobox" id="gradebteam" name="gradebteam" style="width:150px"
                            limitToList="true"
                            data-options="required:true,url:'../GetServlet?action=getteam',method:'get',textField:'tname',valueField:'tname'">
                </select></td>
                <td><a id="btnAdd4" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-add'">添加</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
                <td><a id="btnDelete4" href="javascript:void(0)" class="easyui-linkbutton"
                       data-options="plain:true,iconCls:'icon-edit'">删除</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>