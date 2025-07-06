<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../SiteServlet?action=getone",
            data: {sname: row.sname},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#sname').textbox({
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
            <input class="easyui-textbox" id="sname" name="sname" style="width:100%" labelPosition="top"
                   data-options="label:'场地名称:',required:true,
                   validType:{remote:['../SiteServlet?action=exists','sname']},invalidMessage:'场地名称已经存在'">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="sscale" name="sscale" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'场地规模:',required:true">
                <option>室内</option><option>室外</option></select>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="sposition" name="sposition" style="width:100%" labelPosition="top"
                   data-options="label:'位置:',required:true">
        </div>
    </form>
</div>