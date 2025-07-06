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
            url: '../TrainServlet?action=getdglist',
            toolbar: '#tb',
            fit: true,
            pagination: true,
            singleSelect: true,
            remoteSort:false,
            sortName:'tstarttime',
            sortOrder:'desc',
            columns: [[
                {field: 'sname', title: '场地名称', width: 200,sortable:true},
                {field: 'tname', title: '训练球队', width: 200,sortable:true},
                {field: 'tstarttime', title: '训练开始时间', width: 200,sortable:true},
                {field: 'tendtime', title: '训练结束时间', width: 200,sortable:true}
            ]]
        });

        //搜索
        $('#searchbox').searchbox({
            searcher: function (value) {
                $('#dg').datagrid({
                    url: '../TrainServlet?action=search',
                    toolbar: '#tb',
                    fit: true,
                    pagination: true,
                    singleSelect: true,
                    queryParams: {
                        value: value
                    },
                    remoteSort:false,
                    sortName:'tstarttime',
                    sortOrder:'desc',
                    columns: [[
                        {field: 'sname', title: '场地名称', width: 200,sortable:true},
                        {field: 'tname', title: '训练球队', width: 200,sortable:true},
                        {field: 'tstarttime', title: '训练开始时间', width: 200,sortable:true},
                        {field: 'tendtime', title: '训练结束时间', width: 200,sortable:true}
                    ]]
                });
            }
        });

    });
</script>
<body class="easyui-layout">
<div data-options="region:'center',iconCls:'icon-ok',border:false">
    <table id="dg"></table>
</div>
<div id="dd"></div>
<div id="tb" style="height: auto">
    <table>
        <tr>
            <td><input id="searchbox" class="easyui-searchbox" data-options="prompt:'搜索'"></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>