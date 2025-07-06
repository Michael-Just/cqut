<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg2').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../PlayerServlet?action=getone",
            data: {pno:row.pno,pteam:l},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#pno').textbox({
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
            <input class="easyui-textbox" id="pno" name="pno" style="width:100%" labelPosition="top"
                   data-options="label:'球员号:',required:true,">
<%--                   validType:{remote:['../PlayerServlet?action=exists','pno']},invalidMessage:'球员号已经存在'--%>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="pname" name="pname" style="width:100%" labelPosition="top"
                   data-options="label:'球员姓名:',required:true,">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-numberspinner" id="page" name="page" style="width:100%" labelPosition="top"
                   data-options="label:'球员年龄:',required:true,value:30,min:0,precision:0,editable:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="pheight" name="pheight" style="width:100%" labelPosition="top"
                   data-options="label:'球员身高:',required:true,">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="pweight" name="pweight" style="width:100%" labelPosition="top"
            data-options="label:'球员体重:',required:true,">
        </div>
    </form>
</div>