<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../SupplierServlet?action=getone",
            data: {supplierno: row.supplierno},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#supplierno').textbox({
                        readonly: true,
                        request: true,
                        validType: '',
                    });
                    $('#ff').form('load', result.data);
                } else {
                    $.messager.alert("提示", result.msg, 'waining');
                }
            }
        })
    } else {

    }
</script>
<div style="width:100%;max-width:400px;padding:20px 30px;">
    <form id="ff" method="post">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="supplierno" name="supplierno" style="width:100%"
                   data-options="label:'供应商编码:',required:true,
                   validType:{remote:['../SupplierServlet?action=exists','supplierno']},invalidMessage:'供应商编码已经存在'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="suppliername" name="suppliername" style="width:100%"
                   data-options="label:'供应商名称:',required:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="address" name="address" style="width:100%" data-options="label:'地址:'">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="number" name="number" style="width:100%"
                   data-options="label:'电话:'">
        </div>
    </form>
</div>