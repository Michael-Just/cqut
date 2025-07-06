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

<body>
<div data-options="region:'north'" style="height:50px;padding: 10px">
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">Add</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">Remove</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">Save</a>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cut',disabled:true">Cut</a>
    <a href="#" class="easyui-linkbutton">文本按钮</a>
</div>

<div data-options="region:'center',iconCls:'icon-ok',border:false">
    <table class="easyui-datagrid" data-options="pagination:true,singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'">
        <thead>
        <tr>
            <th data-options="field:'itemid',width:80">Item ID</th>
            <th data-options="field:'productid',width:100">Product</th>
            <th data-options="field:'listprice',width:80,align:'right'">List Price</th>
            <th data-options="field:'unitcost',width:80,align:'right'">Unit Cost</th>
            <th data-options="field:'attr1',width:250">Attribute</th>
            <th data-options="field:'status',width:60,align:'center'">Status</th>
        </tr>
        </thead>
    </table>
</div>
</body>
</html>
