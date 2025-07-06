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
                    content: '<iframe src="' + url + '" frameborder="0" scrolling="true" style="width:100%;height:100%;"></iframe>',
                    closable: true,
                });
            }
        });
    });

</script>

<body>
<div class="easyui-layout" style="width:100%;height:100%;">

    <div data-options="region:'north'" style="height:70px;">
        <img src="static/login/images/logo.jpg" alt="" style="width: 40%;height: 100%">
        <div style="float: right;margin: 30px;">
            <div>欢迎您！用户 <%=session.getAttribute("username")%>
                <a href="LoginServlet?action=logout" class="easyui-linkbutton"
                   data-options="iconCls:'icon-back'">注销</a>
            </div>
        </div>

    </div>

    <div data-options="region:'south',split:true" style="height:30px;text-align: center;">
        &copy; 比赛管理系统 | 版权来自素质baby
    </div>

    <div data-options="region:'west',split:true" title="用户" style="width:200px;">
        <div id="menu" class="easyui-accordion" data-options="fit:true">
            <div title="篮球比赛" data-options="iconCls:'icon-ok'" style="overflow:auto">
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/teamlist.jsp" data-options="iconCls:'icon-add'">球队安排</a>
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/trainlist.jsp" data-options="iconCls:'icon-add'">训练安排</a>
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/gamelist.jsp" data-options="iconCls:'icon-add'">比赛安排</a>
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/sitelist.jsp" data-options="iconCls:'icon-add'">场地管理</a>
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/coachlist.jsp" data-options="iconCls:'icon-add'">教练管理</a>
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/refereelist.jsp" data-options="iconCls:'icon-add'">裁判管理</a>
            </div>
            <div title="个人信息" data-options="iconCls:'icon-ok'" style="overflow:auto">
                <a class="easyui-linkbutton" style="margin: 5px;width: 180px;height: 30px"
                   data-url="user/mylist.jsp" data-options="iconCls:'icon-add'">我的信息</a>
            </div>
        </div>
    </div>

    <div data-options="region:'center',iconCls:'icon-ok',border:false">
        <div id="tt" class="easyui-tabs" data-options="fit:true">
            <div title="首页" style="padding:10px">
                <p style="font-size:14px">篮球（basketball），是以手为中心的身体对抗性体育运动，是奥运会核心比赛项目
                    [1]。</p>
                <p>1891年12月21日，由美国马萨诸塞州斯普林菲尔德基督教青年会训练学校体育教师詹姆士·奈史密斯发明
                [2]。1896年，篮球运动传入中国天津。1904年，圣路易斯奥运会上第1次进行了篮球表演赛。1932年，国际篮球联合会成立。1936年，篮球在柏林奥运会中被列为正式比赛项目
                [1]，中国也首次派出篮球队参加奥运会篮球项目。1956年10月，中国篮球协会成立。 [3]
                [14]1992年，巴塞罗那奥运会开始，职业选手可以参加奥运会篮球比赛 [1-2]。</p>
            </div>
        </div>
    </div>

</div>
</body>
</html>