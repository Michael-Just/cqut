<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../TrainServlet?action=getone",
            data: {tno:row.tno,sname: row.sname, tname: row.tname},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#tno').textbox({
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
        <div style="margin-bottom:20px;display: none">
            <input class="easyui-textbox" id="tno" name="tno" style="width:100%" labelPosition="top"
                   data-options="label:'tno:'">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="sname" name="sname" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'场地名称:',required:true,url:'../GetServlet?action=getsname',method:'get',textField:'sname',valueField:'sname'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="tname" name="tname" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'训练球队:',required:true,url:'../GetServlet?action=gettname',method:'get',textField:'tname',valueField:'tname'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-datetimebox" id="tstarttime" name="tstarttime" style="width:100%" labelPosition="top"
                   data-options="label:'训练开始时间:',required:true" value="3/4/2010 2:3">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-datetimebox" id="tendtime" name="tendtime" style="width:100%" labelPosition="top"
                   data-options="label:'训练结束时间:',required:true" value="3/4/2010 2:3">
        </div>
    </form>
</div>