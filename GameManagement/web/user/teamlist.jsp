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
                        pteam: l,
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
</script>
<body class="easyui-layout">
<div data-options="region:'center',iconCls:'icon-ok',border:false">
    <table id="dg"></table>
</div>
<div id="dd"></div>
<div id="win" class="easyui-window" title="My Window" style="width:1000px;height:400px"
     data-options="iconCls:'icon-save',modal:true">
    <table id="dg2"></table>
    <div id="tb2" style="height: auto">
        <table>
            <tr>
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
            <td><input id="searchbox" class="easyui-searchbox" data-options="prompt:'搜索'"></td>
            <td>
                <div class="datagrid-btn-separator"></div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>