<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    if ('edit' == '<%=request.getParameter("action")%>') {
        let row = $('#dg').datagrid('getSelected');
        $.ajax({
            type: "get",
            url: "../GameServlet?action=getone",
            data: {gno: row.gno,},
            success: function (ret) {
                let result = eval("(" + ret + ")");
                if (result.code === "200") {
                    $('#gno').textbox({
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
            <input class="easyui-textbox" id="gno" name="gno" style="width:100%" labelPosition="top"
                   data-options="label:'gno:'">
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="tname" name="tname" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'比赛球队甲队:',required:true,url:'../GetServlet?action=gettnamea',method:'get',textField:'tname',valueField:'tname'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="tname2" name="tname2" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'比赛球队乙队:',required:true,url:'../GetServlet?action=gettnamea',method:'get',textField:'tname',valueField:'tname'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="sname" name="sname" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'比赛球场:',required:true,url:'../GetServlet?action=getsname',method:'get',textField:'sname',valueField:'sname'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <select class="easyui-combobox" id="rno" name="rno" style="width:100%" labelPosition="top" limitToList="true"
                    data-options="label:'裁判号:',required:true,url:'../GetServlet?action=getrno',method:'get',textField:'rno',valueField:'rno'">
            </select>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-datetimebox" id="gtime" name="gtime" style="width:100%" labelPosition="top"
                   data-options="label:'比赛时间:',required:true" value="3/4/2010 2:3">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="gscores" name="gscores" style="width:100%" labelPosition="top"
                   data-options="label:'比分:'">
        </div>
    </form>
</div>