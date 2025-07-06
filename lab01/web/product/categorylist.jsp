<%--
  Created by IntelliJ IDEA.
  User: 杨明举
  Date: 2024/5/26
  Time: 12:32
  To change this template use File | Settings | File Templates.
--%>
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
            url: '#',
            toolbar: '#tb',
            fit: true,
            pagination: true,
            columns: [[
                {field: 'supplierno', title: '供应商编码', width: 100},
                {field: 'suppliername', title: '供应商', width: 100},
                {field: 'address', title: '地址', width: 100, align: 'right'},
                {field: 'contacts', title: '联络人', width: 100, align: 'right'},
                {field: 'telephone', title: '电话', width: 100, align: 'right'}
            ]]
        });

        $('#btnAdd').click(function (){
            $('#dlg').dialog({
                title: '供应商新增',
                width: 400,
                height: 450,
                closed: false,
                cache: false,
                href: 'supplierform.jsp',
                modal: true,
                buttons:[{
                    text:'保存',
                    handler:function(){
                        $('#ff').form({
                            url:'',
                            onSubmit: function(){
                                // do some check
                                // return false to prevent submit;
                            },
                            success:function(data){
                                alert(data)
                            }
                        });
                        $('#ff').submit();
                    }
                },{
                    text:'退出',
                    handler:function(){}
                }]
            });
        })

    })
</script>
<body>

<div id="tb">
    <a id="btnAdd" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">新增</a>
    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'">修改</a>
    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cancel'">删除</a>
</div>
<div id="dlg"></div>

<div data-options="region:'center',iconCls:'icon-ok',border:false">
    <table id="dg"></table>
</div>
</body>
</html>