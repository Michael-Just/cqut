<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../CoachServlet?action=getone",
            data: {cno: row.cno, cname: row.cname, cage: row.cage},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#cno').textbox({
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
            <input class="easyui-textbox" id="cno" name="cno" style="width:100%" labelPosition="top"
                   data-options="label:'教练号:',required:true,value:'C',
                   validType:{remote:['../CoachServlet?action=exists','cno']},invalidMessage:'教练号已经存在'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="cname" name="cname" style="width:100%" labelPosition="top"
                   data-options="label:'教练名:',required:true,">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-numberspinner" id="cage" name="cage" style="width:100%" labelPosition="top"
                   data-options="label:'年龄:',required:true,value:30,min:0,precision:0,editable:true">
        </div>
    </form>
</div>