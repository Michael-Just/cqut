<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../TeamServlet?action=getone",
            data: {tname: row.tname},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#tname').textbox({
                        readonly: true,
                        request: true,
                        validType: '',
                    });
                    $('#ff').form('load', result.data);
                } else {
                    $.messager.alert("提示", result.msg, 'waining');
                }
            }
        });
    }
</script>
<div style="width:100%;max-width:400px;padding:20px 30px;">
    <form id="ff" method="post">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="tname" name="tname" style="width:100%" labelPosition="top"
                   data-options="label:'球队名称:',required:true,
                   validType:{remote:['../TeamServlet?action=exists','tname']},invalidMessage:'球队名称已经存在'">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="cno" name="cno" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'教练号:',required:true,url:'../GetServlet?action=getcno',method:'get',textField:'cno',valueField:'cno'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="tcity" name="tcity" style="width:100%" labelPosition="top"
                   data-options="label:'代表地区:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-datetimebox" id="ttime" name="ttime" style="width:100%" labelPosition="top"
                   data-options="label:'成立时间:',required:true" value="3/4/2010 2:3">
        </div>
    </form>
</div>