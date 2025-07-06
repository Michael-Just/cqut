<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../RefereeServlet?action=getone",
            data: {rno: row.rno, rage: row.rage, rgrade: row.rgrade, rname: row.rname},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#rno').textbox({
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
            <input class="easyui-textbox" id="rno" name="rno" style="width:100%" labelPosition="top"
                   data-options="label:'裁判号:',required:true,value:'R',
                   validType:{remote:['../RefereeServlet?action=exists','rno']},invalidMessage:'裁判号已经存在'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-numberspinner" id="rage" name="rage" style="width:100%" labelPosition="top"
                   data-options="label:'年龄:',required:true,value:30,min:0,precision:0,editable:true">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="rgrade" name="rgrade" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'级别:',required:true">
                <option>国家级</option><option>一级</option><option>二级</option><option>三级</option></select>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="rname" name="rname" style="width:100%" labelPosition="top"
                   data-options="label:'裁判名:',required:true,">
        </div>
    </form>
</div>