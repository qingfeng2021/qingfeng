<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../system/admin/top.jsp"%>

<form class="layui-form" action="" id="form">
    <table width="95%" style="margin: 0 auto">
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">任务名称：<span style="color: red">*</span></label></td>
            <td colspan="3"><input type="text" name="jobName" id="jobName" value="${pd.jobname}" lay-verify="required|field_len50" autocomplete="off" placeholder="任务名称" class="layui-input"></td>
        </tr>
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">任务分组：<span style="color: red">*</span></label></td>
            <td colspan="3"><input type="text" name="jobGroup" id="jobGroup" value="${pd.jobgroup}" lay-verify="required|field_len50" autocomplete="off" placeholder="任务分组" class="layui-input"></td>
        </tr>
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">执行类：<span style="color: red">*</span></label></td>
            <td colspan="3"><input type="text" name="jobClassName" id="jobClassName" value="${pd.jobclassname}" lay-verify="required|field_len120" autocomplete="off" placeholder="执行类" class="layui-input"></td>
        </tr>
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">执行时间：<span style="color: red">*</span></label></td>
            <td colspan="3"><input type="text" name="cronExpression" id="cronExpression" value="${pd.cronexpression}" lay-verify="required|field_len50" autocomplete="off" placeholder="执行时间" class="layui-input"></td>
        </tr>
        <tr>
            <td align="right"><label class="layui-form-label">任务描述：</label></td>
            <td colspan="3"><textarea name="description" placeholder="请输入任务描述" class="layui-textarea">${pd.description}</textarea></td>
        </tr>
        <tr>
            <td style="text-align: center; padding-top: 10px;" colspan="4">
                <div class="layui-form-item">
                    <input type="hidden" id="oldJobName" name="oldJobName" value="${pd.jobname}">
                    <input type="hidden" id="oldJobGroup" name="oldJobGroup" value="${pd.jobgroup}">
                    <button type="button" class="layui-btn layui-btn-sm" id="submit_button" lay-submit="" lay-filter="submit_form">保存</button>
                    <button type="button" class="layui-btn layui-btn-danger layui-btn-sm" id="cancel">取消</button>
                </div>
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/xadmin/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/qfverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/qfAjaxReq.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form,layer,layedit,laydate;
    layui.use(['form', 'layedit', 'laydate'], function(){
        form = layui.form;
        layer = layui.layer;
        layedit = layui.layedit;
        laydate = layui.laydate;

        $('#cancel').on('click',function (){
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        })

        //自定义验证规则
        form.verify(form_verify);

        //监听提交
        form.on('submit(submit_form)', function(data){
            layer.msg('正在提交数据。');
            $("#submit_button").attr('disabled',true);
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath}/quartz/timTask/update" ,//url
                data: $('#form').serialize(),
                success: function (res) {
                    if (res.success) {
                        layer.msg("数据更新成功。", {time: 2000},function(){
                            setOpenCloseParam("reload");
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        });
                    }else{
                        $("#submit_button").attr('disabled',false);
                        if(res.loseSession=='loseSession'){
                            loseSession(res.msg,res.url)
                        }else{
                            layer.msg(res.msg, {time: 2000});
                        }
                    }
                },
                error : function() {
                    $("#submit_button").attr('disabled',false);
                    layer.msg("异常！");
                }
            });
            return false;
        });

    });
</script>

<%@include file="../../system/admin/bottom.jsp"%>