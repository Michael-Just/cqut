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

    });

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
            <td>A组</td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
            <td><a id="btnLook" href="javascript:void(0)" class="easyui-linkbutton"
                   data-options="plain:true,iconCls:'icon-add'">查看</a></td>
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
</div>
</body>
</html>