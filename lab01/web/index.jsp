<%--
  Created by IntelliJ IDEA.
  User: 杨明举
  Date: 2024/4/11
  Time: 20:29
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
</head>
<style>
    body {
        margin: 0;
    }

</style>
<%
    if (session.getAttribute("username") == null) response.sendRedirect("login.jsp");
%>

<script>
    $(function () {
        $('#menu .easyui-linkbutton').click(function () {
            if ($('#tt').tabs('exists', this.innerText)) {
                $('#tt').tabs('select', this.innerText);
            } else {
                let url = $(this).data('url');
                // add a new tab panel
                $('#tt').tabs('add', {
                    title: this.innerText,
                    content: '<iframe src="'+url+'" frameborder="0" scrolling="true" style="width:100%;height:100%;"></iframe>',
                    closable: true,
                });
            }
        })
    })
</script>

<body>
<div class="easyui-layout" style="width:100%;height:100%;">

    <div data-options="region:'north'" style="height:80px;">
        <img src="static/login/images/logo.png" alt="" style="width: 40%;height: 100%">
        <div style="float: right;margin: 30px;">
            <div>欢迎您！<%=session.getAttribute("username")%>
                <a href="LoginServlet?action=logout" class="easyui-linkbutton"
                   data-options="iconCls:'icon-back'">注销</a>
            </div>
        </div>

    </div>

    <div data-options="region:'south',split:true" style="height:50px;"></div>

    <div data-options="region:'west',split:true" title="系统功能" style="width:200px;">
        <div id="menu" class="easyui-accordion" data-options="fit:true">
            <div title="商品管理" data-options="iconCls:'icon-ok'" style="overflow:auto">
                <a href="#" class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px" data-url="product/goodslist.jsp" data-options="iconCls:'icon-add'">商品管理</a>
                <a href="#" class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px" data-url="product/categorylist.jsp" data-options="iconCls:'icon-add'">商品类别</a>
                <a href="#" class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px" data-url="product/supplierlist.jsp" data-options="iconCls:'icon-add'">供应商管理</a>
            </div>
<%--            <div title="会员管理" data-options="iconCls:'icon-help'" style="padding:10px;">--%>

<%--            </div>--%>
<%--            <div title="供应管理" data-options="iconCls:'icon-help'" style="padding:10px;">--%>

<%--            </div>--%>
<%--            <div title="个人中心" data-options="iconCls:'icon-help'" style="padding:10px;">--%>

<%--            </div>--%>
        </div>
    </div>

    <div data-options="region:'center',iconCls:'icon-ok',border:false">
        <div id="tt" class="easyui-tabs" data-options="fit:true">
            <div title="首页" style="padding:10px">
                <p style="font-size:14px">jQuery EasyUI框架帮助您轻松构建web页面。</p>
                <ul>
                    <li>easyui是一个基于jQuery的用户界面插件集合。</li>
                    <li>easyui提供了构建调制解调器、交互式javascript应用程序的基本功能。</li>
                    <li>使用easyui，您不需要编写很多javascript代码，通常通过编写一些HTML标记来定义用户界面。</li>
                    <li>完整的HTML5网页框架。</li>
                    <li>easyui在开发您的产品时可以节省您的时间和规模。</li>
                    <li>easyui很简单但是很强大。</li>
                </ul>
            </div>
            <%--            <div title="商品维护" style="padding:10px">--%>
            <%--                <ul class="easyui-tree"--%>
            <%--                    data-options="url:'tree_data1.json',method:'get',animate:true"></ul>--%>
            <%--            </div>--%>
            <%--            <div title="销售管理" data-options="iconCls:'icon-help',closable:true" style="padding:10px">--%>
            <%--                这是帮助内容.--%>
            <%--            </div>--%>
        </div>
    </div>

</div>
</body>
</html>